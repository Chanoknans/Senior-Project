import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hearing_aid/bloc/application_cubit.dart';
import 'package:hearing_aid/bloc/home_page_state.dart';
import 'dart:typed_data';

class HomePageCubit extends Cubit<HomePageState> {
  ApplicationCubit appCubit;

  HomePageCubit(this.appCubit) : super(HomePageState()) {
    // streamCurrentCoeff();
  }

  Future<void> init() async {
    print('land');
  }

  Future<bool> checkdata() async {
    print(state.bpfCoeff!);
    return state.bpfCoeff! != null;
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
        emit(state.copyWith(leftEar: value.data()!['Left']));
        emit(state.copyWith(rightEar: value.data()!['Right']));
        var lpfCoeff = value.data()!['LPFcoeff_Left'];
        var bpfCoeff = value.data()!['BPFcoeff_Left'];
        var hpfCoeff = value.data()!['HPFcoeff_Left'];
        emit(state.copyWith(lpfCoeff: lpfCoeff));
        emit(state.copyWith(bpfCoeff: bpfCoeff));
        emit(state.copyWith(hpfCoeff: hpfCoeff));

        print(bpfCoeff);
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
      state.lpfCoeff![6],
    );
    //print(lpfCovolve);
    // List<num> bpfConvolve = await convolve(
    //   data,
    //   state.bpfCoeff!.getRange(0, 3).toList(),
    //   state.bpfCoeff!.getRange(3, 6).toList(),
    //   len,
    //   state.bpfCoeff![6],
    // );
    // //print(bpfCovolve);
    // List<num> hpfConvolve = await convolve(
    //   data,
    //   state.hpfCoeff!.getRange(0, 3).toList(),
    //   state.hpfCoeff!.getRange(3, 6).toList(),
    //   len,
    //   state.hpfCoeff![6],
    // );
    print('DONE');
    return lpfConvolve;
  }

  List<num> convolve(List<num> data, List Num, List Den, int len, num g) {
    List<num> y = List<num>.generate(len, (indexs) => 0);
    List<num> x = data;
    print(Num);
    print(Den);
    for (int n = 2; n < len; n++) {
      y[n] = (Num[0] * x[n]) +
          (Num[1] * x[n - 1]) +
          (Num[2] * x[n - 2]) -
          (Den[1] * y[n - 1]) -
          (Den[2] * y[n - 2]);
    }
    return y;
  }
}
