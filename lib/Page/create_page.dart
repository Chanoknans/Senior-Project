import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hearing_aid/constant.dart';

import 'package:hearing_aid/models/profile.dart';
import 'package:hearing_aid/page/components/bottom_app_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_time_patterns.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  String? url;

  File? _Image;
  final picker = ImagePicker();

  _picimagecamera() async {
    // ignore: deprecated_member_use
    final pickedimage = await picker.getImage(source: ImageSource.camera);
    final pickegeimagefile = File(pickedimage!.path);
    setState(() {
      _Image = pickegeimagefile;
    });

    Navigator.pop(this.context);
  }

  _picimagegallery() async {
    // ignore: deprecated_member_use
    final pickedimage = await picker.getImage(source: ImageSource.gallery);
    final pickegeimagefile = File(pickedimage!.path);
    setState(() {
      //_Image!.add(File(pickedimage.path));
      _Image = pickegeimagefile;
    });
    //ignore: unnecessary_null_comparison
    //if (pickedimage.path == null) reLostdata();

    Navigator.pop(this.context);
  }

  final auth = FirebaseAuth.instance;
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firebase,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text('Error'),
            ),
            body: Center(
              child: Text('${snapshot.error}'),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Form(
            key: formKey,
            child: Scaffold(
              backgroundColor: const Color.fromRGBO(0, 50, 70, 1),
              body: Padding(
                padding: const EdgeInsets.fromLTRB(0, 140, 0, 0),
                child: SingleChildScrollView(
                  child: Column(children: [
                    Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 470),
                          child: Image.asset('assets/image/vector2.png'),
                        ),
                        Column(
                          children: [
                            Container(
                              width: 270,
                              margin: const EdgeInsets.only(top: 10),
                              child: const Text(
                                'Create',
                                style: TextStyle(
                                  color: Color.fromRGBO(245, 240, 246, 1),
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito',
                                ),
                              ),
                            ),
                            Container(
                              width: 270,
                              child: const Text(
                                'Your Profile.',
                                style: TextStyle(
                                  color: Color.fromRGBO(245, 240, 246, 1),
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito',
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 80),
                          child: Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 20,
                                ),
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundColor: green,
                                  child: CircleAvatar(
                                    radius: 55,
                                    backgroundColor: light,
                                    backgroundImage: _Image == null
                                        ? null
                                        : FileImage(_Image!),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 90,
                                left: 80,
                                child: RawMaterialButton(
                                  elevation: 10,
                                  fillColor: light,
                                  padding: EdgeInsets.all(15),
                                  shape: CircleBorder(),
                                  onPressed: () {
                                    showDialog(
                                      context: this.context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            'Choose option',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: blackground,
                                            ),
                                          ),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: [
                                                InkWell(
                                                  onTap: _picimagecamera,
                                                  splashColor: blackground,
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        child: Icon(
                                                          Icons.camera,
                                                          color: blackground,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Camera',
                                                        style: a4Style(),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: _picimagegallery,
                                                  splashColor: blackground,
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        child: Icon(
                                                          Icons.image,
                                                          color: blackground,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Gallery',
                                                        style: a4Style(),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Icon(Icons.add_a_photo),
                                ),
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              width: 250,
                              margin: const EdgeInsets.only(top: 210),
                              child: TextFormField(
                                style: const TextStyle(
                                  color: Color.fromRGBO(245, 240, 246, 1),
                                  fontSize: 15,
                                  fontFamily: 'Nunito',
                                ),
                                decoration: const InputDecoration(
                                  labelText: 'Username',
                                  labelStyle: TextStyle(
                                    color: Color.fromRGBO(245, 240, 246, 1),
                                    fontSize: 15,
                                    fontFamily: 'Nunito',
                                  ),
                                  hintText: 'username',
                                  hintStyle: TextStyle(
                                    color: Color.fromRGBO(245, 240, 246, 0.5),
                                    fontSize: 12,
                                    fontFamily: 'Nunito',
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(245, 240, 246, 1),
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(245, 240, 246, 1),
                                    ),
                                  ),
                                ),
                                onSaved: (String? name) {
                                  profile.name = name!;
                                },
                              ),
                            ),
                            Container(
                              width: 250,
                              margin: const EdgeInsets.only(top: 10),
                              child: TextFormField(
                                style: const TextStyle(
                                  color: Color.fromRGBO(245, 240, 246, 1),
                                  fontSize: 15,
                                  fontFamily: 'Nunito',
                                ),
                                decoration: const InputDecoration(
                                  labelText: 'Date of birth',
                                  labelStyle: TextStyle(
                                    color: Color.fromRGBO(245, 240, 246, 1),
                                    fontSize: 15,
                                    fontFamily: 'Nunito',
                                  ),
                                  hintText: 'date of birth',
                                  hintStyle: TextStyle(
                                    color: Color.fromRGBO(245, 240, 246, 0.5),
                                    fontSize: 12,
                                    fontFamily: 'Nunito',
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(245, 240, 246, 1),
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(245, 240, 246, 1),
                                    ),
                                  ),
                                ),
                                onSaved: (String? date) {
                                  profile.date =
                                      Timestamp.fromDate(DateTime.parse(date!));
                                },
                              ),
                            ),
                            Container(
                              width: 250,
                              margin: const EdgeInsets.only(top: 10),
                              child: TextFormField(
                                style: const TextStyle(
                                  color: Color.fromRGBO(245, 240, 246, 1),
                                  fontSize: 15,
                                  fontFamily: 'Nunito',
                                ),
                                decoration: const InputDecoration(
                                  labelText: 'Gender',
                                  labelStyle: TextStyle(
                                    color: Color.fromRGBO(245, 240, 246, 1),
                                    fontSize: 15,
                                    fontFamily: 'Nunito',
                                  ),
                                  hintText: 'gender',
                                  hintStyle: TextStyle(
                                    color: Color.fromRGBO(245, 240, 246, 0.5),
                                    fontSize: 12,
                                    fontFamily: 'Nunito',
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(245, 240, 246, 1),
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(245, 240, 246, 1),
                                    ),
                                  ),
                                ),
                                onSaved: (String? gen) {
                                  profile.gen = gen!;
                                },
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 420),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                const Color.fromRGBO(228, 73, 28, 1),
                              ),
                              shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();

                                final ref = FirebaseStorage.instance
                                    .ref()
                                    .child('userimage')
                                    .child(profile.name! + '.jpg');
                                await ref.putFile(_Image!);
                                url = await ref.getDownloadURL();
                                final User? user = auth.currentUser;
                                final _uid = user!.uid;
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(_uid)
                                    .set({
                                  'id': _uid,
                                  'name': profile.name,
                                  'gen': profile.gen,
                                  'date': profile.date,
                                  'image': url,
                                  'today': [],
                                });

                                formKey.currentState!.reset();
                                Navigator.pushReplacement(
                                  this.context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Dashboard();
                                    },
                                  ),
                                );
                              }
                            },
                            child: const Text(
                              "Save",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(245, 240, 246, 1),
                                fontFamily: 'Nunito',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ),
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
