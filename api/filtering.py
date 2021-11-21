# -*- coding: utf-8 -*-
"""filtering.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1s6hCjz1WMnYj3sdS43Bx_uM-WfuAalm_
"""

import numpy as np
import math
import matplotlib.pyplot as plt
import pandas as pd
import scipy.optimize
from scipy import signal
from scipy import interpolate
from sklearn.metrics import mean_squared_error
from sklearn.metrics import mean_absolute_error

#google cloud session
from google.cloud import firestore
from google.cloud.firestore import ArrayUnion
from datetime import datetime, timezone
import time
import pytz
import firebase_admin
from firebase_admin import credentials,firestore

cred = credentials.Certificate("C:/Users/chanoknan/Senior Project/senior_project.json")
firebase_admin.initialize_app(cred)

#retrieve value from firestoregit remote add origin https://github.com/Chanoknans/Hearing-Aid-Server.git
db = firestore.client()
users_ref = db.collection(u'users').document(u'Audiogram')
doc = users_ref.get()
if doc.exists:
    print(f"Document data: {doc.to_dict()}")
else:
    print("No such document!")
result = doc.to_dict();
newval = list(result.values())
newval2 = newval[0]
#print(newval2)

def BiquadLPF(flpf,Qlpf):
    f_samp = 20000
    ohm0 = np.tan(np.pi*flpf/f_samp)
    A1 = [(ohm0)**2, 0, 0]
    B1 = [(ohm0)**2, ohm0/Qlpf, 1]
    P = [[1,1,1],
        [2,0,-2],
        [1,-1,1]]
    a1 = np.dot(P,np.transpose(A1))
    b1 = np.dot(P,np.transpose(B1))
    num1= a1/b1[0]
    den1 = b1/b1[0]
    q1,h1 = signal.freqz(num1,den1,worN=1000,fs=20000)#fs=16000
    #plt.plot(q1,abs(h1));plt.grid()
    return q1,h1
#BiquadLPF(4000,0.707)
def BiquadBPF(fbpf,Qbpf):
    f_samp = 20000
    ohm0 = np.tan(np.pi*fbpf/f_samp)
    A1 = [0, ohm0/Qbpf, 0]
    B1 = [(ohm0)**2, ohm0/Qbpf, 1]
    P = [[1,1,1],
        [2,0,-2],
        [1,-1,1]]
    a1 = np.dot(P,np.transpose(A1))
    b1 = np.dot(P,np.transpose(B1))
    num1= a1/b1[0]
    den1 = b1/b1[0]
    q1,h1 = signal.freqz(num1,den1,worN=1000,fs=20000)
    #plt.plot(q1,abs(h1));plt.grid()
    return q1,h1
#BiquadBPF(4000,0.707)
def BiquadHPF(fhpf,Qhpf):
    f_samp = 20000
    ohm0 = np.tan(np.pi*fhpf/f_samp)
    A1 = [0, 0, 1]
    B1 = [(ohm0)**2, ohm0/Qhpf, 1]
    P = [[1,1,1],
        [2,0,-2],
        [1,-1,1]]
    a1 = np.dot(P,np.transpose(A1))
    b1 = np.dot(P,np.transpose(B1))
    num1= a1/b1[0]
    den1 = b1/b1[0]
    q1,h1 = signal.freqz(num1,den1,worN=1000,fs=20000)
    #plt.plot(q1,abs(h1));plt.grid()
    return q1,h1
#BiquadHPF(4000,0.707)
def ErrorFunction(fL,QL,GL,fB,QB,GB,fH,QH,GH):
    q,h_lpf = BiquadLPF(fL,QL)
    HL = h_lpf*GL
    q,h_bpf = BiquadBPF(fB,QB)
    HB = h_bpf*GB 
    q,h_hpf = BiquadHPF(fH,QH)
    HH = h_hpf*GH
    desired_flt = abs(HL+HB+HH)
    #print(desired_flt);print(np.shape(desired_flt))
    h_desired = 20*np.log10(desired_flt)
    octave_freq = [250,500,1000,2000,4000,8000]
    threshold_dB = newval2 #[20,20,10,10,10,10]my#[0,0,10,20,20,30]
    spc = np.linspace(250,8000,1000)
    h_ideal = np.interp(spc,octave_freq,threshold_dB)
    err = mean_absolute_error(h_ideal,h_desired)

    #print(err)
    return err

#fminserch
banana = lambda x: ErrorFunction(x[0],x[1],x[2],x[3],x[4],x[5],x[6],x[7],x[8])
opt = scipy.optimize.fmin(func=banana, x0=[1599,0.299,9.5,4000,0.899,10,8000,0.5,10],xtol=1e-4,ftol=1e-4,full_output=True) #,full_output=True to see all outputs [1500,0.3,10,4000,0.9,10,8000,0.5,10]
print('Current function value: ',opt[1])
print('Iterations: ',opt[2])
print('Function evaluations: ',opt[3])

xopt = opt[0]
print('Coefficients: ',xopt); #https://stackoverflow.com/questions/28167648/seeking-convergence-with-optimize-fmin-on-scipy
flpf = abs(xopt[0])
Qlpf = abs(xopt[1])
Glpf = abs(xopt[2])
fbpf = abs(xopt[3])
Qbpf = abs(xopt[4])
Gbpf = abs(xopt[5])
fhpf = abs(xopt[6])
Qhpf = abs(xopt[7])
Ghpf = abs(xopt[8])
q,h_lpf = BiquadLPF(flpf,Qlpf)
H_lpf = h_lpf*Glpf
q,h_bpf = BiquadBPF(fbpf,Qbpf)
H_bpf = h_bpf*Gbpf
q,h_hpf = BiquadHPF(fhpf,Qhpf)
H_hpf = h_hpf*Ghpf

desired_flt = abs(H_lpf+H_bpf+H_hpf)
h_desired = 20*np.log10(desired_flt)
octave_freq = [250,500,1000,2000,4000,8000]
threshold_dB = newval2 #[20,20,10,10,10,10] #[0,0,10,20,20,30]
spc = np.linspace(250,8000,1000)
h_ideal = np.interp(spc,octave_freq,threshold_dB)

#sending patient's data back to firebase
UTC = pytz.utc
coeff = xopt.tolist()
#print(coeff)
doc_result = db.collection(u'users').document(u'coefficient')
doc_result.set({
    u'coeff': coeff,
    u'timestamp': datetime.now(UTC),
    u'username': u'Chanoknan'
})

plt.plot(q+250,h_desired,'r')
plt.plot(q+250,h_ideal,'g')
plt.grid();plt.xlabel('Frequency (Hz)');plt.ylabel('Hearing Level (dB HL)')
plt.xlim([100, 8000])
plt.legend(['desired','actual'])
plt.show()