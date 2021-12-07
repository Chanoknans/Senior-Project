import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hearing_aid/bloc/application_state.dart';
import 'package:hearing_aid/models/profile.dart';

class ApplicationCubit extends Cubit<ApplicationState> {
  ApplicationCubit() : super(ApplicationState());

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> init() async {
    bool complete = false;
    auth.authStateChanges().listen((user) async {
      if (user != null) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .get()
            .then((currentUser) {
          if (currentUser.exists) {
            emit(state.copyWith(currentUser: user)); //
            Profile profile = Profile();

            profile.name = currentUser.get('name');
            profile.gen = currentUser.get('gen');
            profile.date = currentUser.get('date');
            profile.imageUrl = currentUser.get('image');

            emit(state.copyWith(userProfile: profile));
          }
        });

        complete = true;
      }
    });
    return complete;
  }

  Future<Map<String, dynamic>> loginWithEmail(
    String email,
    String password,
  ) async {
    Map<String, dynamic> data = {};
    try {
      await auth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        if (value.user != null) {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(value.user!.uid)
              .get()
              .then((currentUser) {
            if (currentUser.exists) {
              emit(state.copyWith(currentUser: value.user));
              Profile profile = Profile();

              profile.name = currentUser.get('name');
              profile.gen = currentUser.get('gen');
              profile.date = currentUser.get('date');
              profile.imageUrl = currentUser.get('image');

              emit(state.copyWith(userProfile: profile));
            }
          });
        }
      }).whenComplete(() {
        data = {
          "complete": true,
          "message": null,
        };
      }).onError((error, stackTrace) {
        data = {
          "complete": false,
          "message": error.toString(),
        };
      });
    } on FirebaseAuthException catch (e) {
      data = {
        "complete": false,
        "message": e.message ?? '-',
      };
    }

    return data;
  }
}
