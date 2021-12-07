class HomePageState {
  final String? currentDoc;
  final List leftEar;
  final List rightEar;
  final List? coeff;

  HomePageState({
    this.currentDoc,
    this.leftEar = const [0, 0, 0, 0, 0, 0],
    this.rightEar = const [0, 0, 0, 0, 0, 0],
    this.coeff,
  });

  HomePageState copyWith({
    String? currentDoc,
    List? leftEar,
    List? rightEar,
    List? coeff,
  }) {
    return HomePageState(
      currentDoc: currentDoc ?? this.currentDoc,
      leftEar: leftEar ?? this.leftEar,
      rightEar: rightEar ?? this.rightEar,
      coeff: coeff,
    );
  }
}
