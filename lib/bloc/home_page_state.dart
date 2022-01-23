class HomePageState {
  final String? currentDoc;
  final List leftEar;
  final List rightEar;
  final List? lpfCoeff;
  final List? bpfCoeff;
  final List? hpfCoeff;

  HomePageState({
    this.currentDoc,
    this.leftEar = const [0, 0, 0, 0, 0, 0],
    this.rightEar = const [0, 0, 0, 0, 0, 0],
    this.lpfCoeff,
    this.bpfCoeff,
    this.hpfCoeff,
  });

  HomePageState copyWith({
    String? currentDoc,
    List? leftEar,
    List? rightEar,
    List? lpfCoeff,
    List? bpfCoeff,
    List? hpfCoeff,
  }) {
    return HomePageState(
      currentDoc: currentDoc ?? this.currentDoc,
      leftEar: leftEar ?? this.leftEar,
      rightEar: rightEar ?? this.rightEar,
      lpfCoeff: lpfCoeff ?? this.lpfCoeff,
      bpfCoeff: bpfCoeff ?? this.bpfCoeff,
      hpfCoeff: hpfCoeff ?? this.hpfCoeff,
    );
  }
}
