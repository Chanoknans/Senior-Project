class HomePageState {
  final List leftEar;
  final List rightEar;

  HomePageState({
    this.leftEar = const [0, 0, 0, 0, 0, 0],
    this.rightEar = const [0, 0, 0, 0, 0, 0],
  });

  HomePageState copyWith({
    List? leftEar,
    List? rightEar,
  }) {
    return HomePageState(
      leftEar: leftEar ?? this.leftEar,
      rightEar: rightEar ?? this.rightEar,
    );
  }
}
