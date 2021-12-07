import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {
  String? email;
  String? password;
  String? confirmpassword;
  String? name;
  String? gen;
  Timestamp? date;
  String? imageUrl;

  Profile({
    this.email,
    this.password,
    this.confirmpassword,
    this.date,
    this.gen,
    this.name,
    this.imageUrl,
  });
}
