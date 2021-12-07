import 'package:firebase_auth/firebase_auth.dart';
import 'package:hearing_aid/models/profile.dart';

class ApplicationState {
  final User? currentUser;
  final bool toggleLoading;
  final Profile? userProfile;

  ApplicationState({
    this.currentUser,
    this.toggleLoading = false,
    this.userProfile,
  });

  ApplicationState copyWith({
    User? currentUser,
    bool? toggleLoading,
    Profile? userProfile,
  }) {
    return ApplicationState(
      currentUser: currentUser ?? this.currentUser,
      toggleLoading: toggleLoading ?? this.toggleLoading,
      userProfile: userProfile ?? this.userProfile,
    );
  }
}
