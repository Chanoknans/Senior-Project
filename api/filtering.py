import numpy as np
import math
import logging
import os
import json
import matplotlib.pyplot as plt
from numpy.core.fromnumeric import var
import pandas as pd
import scipy.optimize
from scipy import signal
from scipy import interpolate
from sklearn.metrics import mean_squared_error
from sklearn.metrics import mean_absolute_error
from urllib.parse import urlparse

#google cloud session
from datetime import datetime, timezone
import time
import pytz
import paho.mqtt.client as mqtt
import firebase_admin
from dotenv import load_dotenv
from firebase_admin import credentials, firestore
from pydash import get

load_dotenv()

# recived incoming data ??
cred = credentials.Certificate("hearing-test-2e94b-firebase-adminsdk-6qp9b-5a2383d7ad.json")
firebase_admin.initialize_app(cred)
db = firestore.client()

host = os.getenv('CLOUDMQTT_URL')
url = urlparse(host)
topic = url.path[1:]

def on_connect(self, client, userdata, rc):
    logging.info('connected')
    self.subscribe("/"+topic, 0)


def on_message(client, userdata, msg):
    logging.debug(msg.payload.decode("utf-8", "strict"))
    m_in = json.loads(msg.payload.decode("utf-8", "strict"))
    user_id = get(m_in, 'userID')
    a_id = get(m_in, 'audiogramID')
    leftValue = get(m_in, 'lValue')
    rightValue = get(m_in, 'rValue')

    Data = [leftValue,rightValue]
    Lcoeff=[]
    Bcoeff=[]
    Hcoeff=[]

    # processing data
    #fminserch
    for i in range(2):

        banana = lambda x: ErrorFunction(x[0],x[1],x[2],x[3],x[4],x[5],x[6],x[7],x[8], Data[i])
        opt = scipy.optimize.fmin(func=banana, x0=[1599,0.299,9.5,4000,0.899,10,8000,0.5,10],xtol=1e-4,ftol=1e-4,full_output=True) #,full_output=True to see all outputs [1500,0.3,10,4000,0.9,10,8000,0.5,10]
        print('Current function value: ',opt[1])
        print('Iterations: ',opt[2])
        print('Function evaluations: ',opt[3])

        xopt = opt[0]
        print('Coefficients: ',xopt)
        flpf = abs(xopt[0])
        Qlpf = abs(xopt[1])
        Glpf = abs(xopt[2])
        fbpf = abs(xopt[3])
        Qbpf = abs(xopt[4])
        Gbpf = abs(xopt[5])
        fhpf = abs(xopt[6])
        Qhpf = abs(xopt[7])
        Ghpf = abs(xopt[8])
        q,h_lpf,num_lpf,den_lpf = BiquadLPF(flpf,Qlpf)

        q,h_bpf,num_bpf,den_bpf = BiquadBPF(fbpf,Qbpf)

        q,h_hpf,num_hpf,den_hpf  = BiquadHPF(fhpf,Qhpf)

        LL=np.concatenate((num_lpf,den_lpf,Glpf),axis = None)
        BB=np.concatenate((num_bpf,den_bpf,Gbpf),axis = None)
        HH=np.concatenate((num_hpf,den_hpf,Ghpf),axis = None)

        #sending patient's data back to firebase
        UTC = pytz.utc
        Lcoeff.append((LL).tolist())
        Bcoeff.append((BB).tolist())
        Hcoeff.append((HH).tolist())

    # update back to DB
    doc_result = db.collection(u'users').document(user_id).collection(u'audiogram_history').document(a_id)
    doc_result.update({
        u'LPFcoeff_Left': Lcoeff[0], # array
        u'BPFcoeff_Left': Bcoeff[0],
        u'HPFcoeff_Left':  Hcoeff[0],
        u'LPFcoeff_Right': Lcoeff[1],
        u'BPFcoeff_Right': Bcoeff[1],
        u'HPFcoeff_Right':  Hcoeff[1],
        u'updated_at': datetime.now(UTC),
    })


def BiquadLPF(flpf,Qlpf):
    f_samp = 44100
    ohm0 = np.tan(np.pi*flpf/f_samp)
    A1 = [(ohm0)**2, 0, 0]
    B1 = [(ohm0)**2, ohm0/Qlpf, 1]
    P = [[1,1,1],
        [2,0,-2],
        [1,-1,1]]
    a1 = np.dot(P,np.transpose(A1))
    b1 = np.dot(P,np.transpose(B1))
    num= a1/b1[0]
    den = b1/b1[0]
    q1,h1 = signal.freqz(num,den,worN=1000,fs=20000)#fs=16000
    return q1,h1,num,den

def BiquadBPF(fbpf,Qbpf):
    f_samp = 44100
    ohm0 = np.tan(np.pi*fbpf/f_samp)
    A1 = [0, ohm0/Qbpf, 0]
    B1 = [(ohm0)**2, ohm0/Qbpf, 1]
    P = [[1,1,1],
        [2,0,-2],
        [1,-1,1]]
    a1 = np.dot(P,np.transpose(A1))
    b1 = np.dot(P,np.transpose(B1))
    num= a1/b1[0]
    den = b1/b1[0]
    q1,h1 = signal.freqz(num,den,worN=1000,fs=20000)
    return q1,h1,num,den

def BiquadHPF(fhpf,Qhpf):
    f_samp = 44100
    ohm0 = np.tan(np.pi*fhpf/f_samp)
    A1 = [0, 0, 1]
    B1 = [(ohm0)**2, ohm0/Qhpf, 1]
    P = [[1,1,1],
        [2,0,-2],
        [1,-1,1]]
    a1 = np.dot(P,np.transpose(A1))
    b1 = np.dot(P,np.transpose(B1))
    num= a1/b1[0]
    den = b1/b1[0]
    q1,h1 = signal.freqz(num,den,worN=1000,fs=20000)
    return q1,h1,num,den

def ErrorFunction(fL,QL,GL,fB,QB,GB,fH,QH,GH, newval2):
    q,h_lpf,num_lpf,den_lpf = BiquadLPF(fL,QL)
    HL = h_lpf*GL
    q,h_bpf,num_bpf,den_bpf = BiquadBPF(fB,QB)
    HB = h_bpf*GB
    q,h_hpf,num_hpf,den_hpf = BiquadHPF(fH,QH)
    HH = h_hpf*GH
    desired_flt = abs(HL+HB+HH)
    h_desired = 20*np.log10(desired_flt)
    octave_freq = [250,500,1000,2000,4000,8000]
    threshold_dB = newval2
    spc = np.linspace(250,8000,1000)
    h_ideal = np.interp(spc,octave_freq,threshold_dB)
    err = mean_absolute_error(h_ideal,h_desired)
    return err


def on_subscribe(client, obj, mid, granted_qos):
    logging.debug(f'Subscribed: {str(mid)} {str(granted_qos)}')


def on_disconnect(client, userdata, rc):
    logging.debug(f'disconnecting reason {str(rc)}')
    client.connected_flag = False
    client.disconnect_flag = True       



client = mqtt.Client()
client.on_connect = on_connect
client.on_disconnect = on_disconnect
client.on_message = on_message
client.on_subscribe = on_subscribe
client.username_pw_set(url.username, url.password)
client.connect(url.hostname, url.port)
client.loop_forever()