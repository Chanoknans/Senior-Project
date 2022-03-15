import 'package:cloud_firestore/cloud_firestore.dart';

class HomePageState {
  final String? currentDoc;
  final Timestamp? Date;
  final List leftEar;
  final List rightEar;
  final List? lpfCoeff;
  final List? bpfCoeff;
  final List? hpfCoeff;
  final List? lpfCoeffL;
  final List? bpfCoeffL;
  final List? hpfCoeffL;
  final List? lpfCoeffR;
  final List? bpfCoeffR;
  final List? hpfCoeffR;
  final double? maxGain;

  HomePageState({
    this.currentDoc,
    this.Date,
    this.leftEar = const [0, 0, 0, 0, 0, 0],
    this.rightEar = const [0, 0, 0, 0, 0, 0],
    this.lpfCoeff,
    this.bpfCoeff,
    this.hpfCoeff,
    this.lpfCoeffL,
    this.bpfCoeffL,
    this.hpfCoeffL,
    this.lpfCoeffR,
    this.bpfCoeffR,
    this.hpfCoeffR,
    this.maxGain,
  });

  HomePageState copyWith(
      {String? currentDoc,
      Timestamp? Date,
      List? leftEar,
      List? rightEar,
      List? lpfCoeff,
      List? bpfCoeff,
      List? hpfCoeff,
      List? lpfCoeffL,
      List? bpfCoeffL,
      List? hpfCoeffL,
      List? lpfCoeffR,
      List? bpfCoeffR,
      List? hpfCoeffR,
      double? maxGain}) {
    return HomePageState(
      currentDoc: currentDoc ?? this.currentDoc,
      Date: Date ?? this.Date,
      leftEar: leftEar ?? this.leftEar,
      rightEar: rightEar ?? this.rightEar,
      lpfCoeff: lpfCoeff ?? this.lpfCoeff,
      bpfCoeff: bpfCoeff ?? this.bpfCoeff,
      hpfCoeff: hpfCoeff ?? this.hpfCoeff,
      lpfCoeffL: lpfCoeffL ?? this.lpfCoeffL,
      bpfCoeffL: bpfCoeffL ?? this.bpfCoeffL,
      hpfCoeffL: hpfCoeffL ?? this.hpfCoeffL,
      lpfCoeffR: lpfCoeffR ?? this.lpfCoeffR,
      bpfCoeffR: bpfCoeffR ?? this.bpfCoeffR,
      hpfCoeffR: hpfCoeffR ?? this.hpfCoeffR,
      maxGain: maxGain ?? this.maxGain,
    );
  }
}
