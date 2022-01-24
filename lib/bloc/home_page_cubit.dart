import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hearing_aid/bloc/application_cubit.dart';
import 'package:hearing_aid/bloc/home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  ApplicationCubit appCubit;

  HomePageCubit(this.appCubit) : super(HomePageState()) {
    // streamCurrentCoeff();
  }

  Future<void> init() async {
    print('land');
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

  Future<bool> generateSampleRate() async {
    // TODO: do calculation here!
    List<num> lpfCovolve = await convolve(
      state.lpfCoeff!.getRange(0, 3).toList(),
      state.lpfCoeff!.getRange(3, 6).toList(),
    );
    print(lpfCovolve);
    List<num> bpfCovolve = await convolve(
      state.bpfCoeff!.getRange(0, 3).toList(),
      state.bpfCoeff!.getRange(3, 6).toList(),
    );
    print(bpfCovolve);
    List<num> hpfCovolve = await convolve(
      state.hpfCoeff!.getRange(0, 3).toList(),
      state.hpfCoeff!.getRange(3, 6).toList(),
    );
    print(hpfCovolve);
    return true;
  }

  List<num> convolve(List Num, List Den) {
    List<num> y = List<num>.generate(10, (indexs) => 0);
    List<num> x = List<num>.generate(10, (indexs) => 1);
    for (int n = 3; n < 10; n++) {
      y[n] = Num[0] * x[n] +
          Num[1] * x[n - 1] +
          Num[2] * x[n - 2] -
          Den[1] * y[n - 1] -
          Den[2] * y[n - 2];
    }
    return y;
  }
}
