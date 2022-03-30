import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hearing_aid/bloc/application_cubit.dart';
import 'package:hearing_aid/bloc/home_page_state.dart';
import 'dart:typed_data';

import '../Page/aids_home.dart';

class HomePageCubit extends Cubit<HomePageState> {
  ApplicationCubit appCubit;

  HomePageCubit(this.appCubit) : super(HomePageState()) {
    // streamCurrentCoeff();
  }

  Future<void> init() async {
    print('land');
  }

  Future<bool> checkdata() async {
    print(state.bpfCoeffL!);
    return state.bpfCoeffL! != null;
  }

  Future<dynamic> chooseData(BuildContext context, String name) async {
    List x;
    List y;
    List z;
    if (name == 'R') {
      x = state.lpfCoeffR!;
      y = state.bpfCoeffR!;
      z = state.hpfCoeffR!;
    } else {
      x = state.lpfCoeffL!;
      y = state.bpfCoeffL!;
      z = state.hpfCoeffL!;
    }
    emit(state.copyWith(lpfCoeff: x));
    emit(state.copyWith(bpfCoeff: y));
    emit(state.copyWith(hpfCoeff: z));
    if (x[6] >= y[6] && x[6] >= z[6]) {
      emit(state.copyWith(maxGain: x[6]));
    } else if (y[6] >= x[6] && y[6] >= z[6]) {
      emit(state.copyWith(maxGain: y[6]));
    } else {
      emit(state.copyWith(maxGain: z[6]));
    }

    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => HearingAidss(),
        ));
  }

  Future<void> getHearingResult(String docID) async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(appCubit.state.currentUser!.uid)
        .collection("audiogram_history")
        .doc(docID)
        .get()
        .then((value) {
      if (value.exists) {
        emit(state.copyWith(currentDoc: docID));
        emit(state.copyWith(Date: value.data()!['created_date']));
        emit(state.copyWith(leftEar: value.data()!['Left']));
        emit(state.copyWith(rightEar: value.data()!['Right']));
        var lpfCoeffL = value.data()!['LPFcoeff_Left'];
        var bpfCoeffL = value.data()!['BPFcoeff_Left'];
        var hpfCoeffL = value.data()!['HPFcoeff_Left'];
        var lpfCoeffR = value.data()!['LPFcoeff_Right'];
        var bpfCoeffR = value.data()!['BPFcoeff_Right'];
        var hpfCoeffR = value.data()!['HPFcoeff_Right'];
        emit(state.copyWith(lpfCoeffL: lpfCoeffL));
        emit(state.copyWith(bpfCoeffL: bpfCoeffL));
        emit(state.copyWith(hpfCoeffL: hpfCoeffL));
        emit(state.copyWith(lpfCoeffR: lpfCoeffR));
        emit(state.copyWith(bpfCoeffR: bpfCoeffR));
        emit(state.copyWith(hpfCoeffR: hpfCoeffR));
      }
    }).whenComplete(() {
      print('success');
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  Future<List<num>> generateSampleRate(List<num> data, int len) async {
    // TODO: do calculation here!
    List<num> lpfConvolve = await convolve(
      data,
      state.lpfCoeff!.getRange(0, 3).toList(),
      state.lpfCoeff!.getRange(3, 6).toList(),
      len,
    );
    List<num> bpfConvolve = await convolve(
      data,
      state.bpfCoeff!.getRange(0, 3).toList(),
      state.bpfCoeff!.getRange(3, 6).toList(),
      len,
    );
    List<num> hpfConvolve = await convolve(
      data,
      state.hpfCoeff!.getRange(0, 3).toList(),
      state.hpfCoeff!.getRange(3, 6).toList(),
      len,
    );
    List<num> x = [];
    for (var i = 0; i < lpfConvolve.length; i++) {
      x.add((lpfConvolve[i] * state.lpfCoeff![6]) +
          (bpfConvolve[i] * state.bpfCoeff![6]) +
          (hpfConvolve[i] * state.hpfCoeff![6]));
    }
    return x;
  }

  List<num> convolve(List<num> data, List Num, List Den, int len) {
    List<num> y = List<num>.generate(len, (indexs) => 0);
    List<num> x = data;
    for (int n = 2; n < len; n++) {
      y[n] = (Num[0] * x[n]) +
          (Num[1] * x[n - 1]) +
          (Num[2] * x[n - 2]) -
          (Den[1] * y[n - 1]) -
          (Den[2] * y[n - 2]);
    }
    return y;
  }

  List<num> conv(List<num> data, int len) {
    List<num> y1 = List<num>.generate(len, (indexs) => 0);
    List<num> x1 = data;
    List<num> h = [
      0.25,
      0.25,
      0.25,
      0.25,
    ];
    for (int n = 3; n < len; n++) {
      y1[n] = (h[0] * x1[n]) +
          (h[1] * x1[n - 1]) +
          (h[2] * x1[n - 2]) +
          (h[3] * x1[n - 3]);
    }
    return y1;
  }
}

// List<num> h = [
    //   0.0354646477883537,
    //   0.240949840390482,
    //   0.447171023642328,
    //   0.240949840390482,
    //   0.0354646477883537
    // ];