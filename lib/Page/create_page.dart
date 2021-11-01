// ignore_for_file: unused_local_variable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hearing_aid/Page/bottomappbar.dart';
import 'package:hearing_aid/page/signup_page.dart'; // ignore: unused_import
import 'package:hearing_aid/Page/Profile.dart';
import 'package:form_field_validator/form_field_validator.dart'; // ignore: unused_import
import 'package:image_picker/image_picker.dart';

import 'package:hearing_aid/Myconstant.dart'; // ignore: unused_import

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Profile profile = Profile(
    email: '',
    password: '',
    confirmpassword: '',
    name: '',
    gen: '',
    date: '',
    Imageurl: '',
  );

  // ignore: non_constant_identifier_names
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

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 50, 70, 1),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 130, 0, 0),
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
                            fontFamily: 'Nunito'),
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
                            fontFamily: 'Nunito'),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 80),
                  child: Stack(children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Myconstant.green,
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: Myconstant.light,
                          backgroundImage:
                              _Image == null ? null : FileImage(_Image!),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 90,
                        left: 80,
                        child: RawMaterialButton(
                          elevation: 10,
                          fillColor: Myconstant.light,
                          child: Icon(Icons.add_a_photo),
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
                                            color: Myconstant.primary),
                                      ),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: [
                                            InkWell(
                                              onTap: _picimagecamera,
                                              splashColor: Myconstant.primary,
                                              child: Row(
                                                children: [
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      child: Icon(
                                                        Icons.camera,
                                                        color:
                                                            Myconstant.primary,
                                                      )),
                                                  Text('Camera',
                                                      style: Myconstant()
                                                          .a4Style())
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: _picimagegallery,
                                              splashColor: Myconstant.primary,
                                              child: Row(
                                                children: [
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      child: Icon(
                                                        Icons.image,
                                                        color:
                                                            Myconstant.primary,
                                                      )),
                                                  Text('Gallery',
                                                      style: Myconstant()
                                                          .a4Style())
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ));
                                });
                          },
                        ))
                  ]),
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
                            fontFamily: 'Nunito'),
                        decoration: const InputDecoration(
                            labelText: 'Username',
                            labelStyle: TextStyle(
                                color: Color.fromRGBO(245, 240, 246, 1),
                                fontSize: 15,
                                fontFamily: 'Nunito'),
                            hintText: 'username',
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(245, 240, 246, 0.5),
                                fontSize: 12,
                                fontFamily: 'Nunito'),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(245, 240, 246, 1))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(245, 240, 246, 1)))),
                      ),
                    ),
                    Container(
                      width: 250,
                      margin: const EdgeInsets.only(top: 10),
                      child: TextFormField(
                        style: const TextStyle(
                            color: Color.fromRGBO(245, 240, 246, 1),
                            fontSize: 15,
                            fontFamily: 'Nunito'),
                        decoration: const InputDecoration(
                            labelText: 'Date of birth',
                            labelStyle: TextStyle(
                                color: Color.fromRGBO(245, 240, 246, 1),
                                fontSize: 15,
                                fontFamily: 'Nunito'),
                            hintText: 'date of birth',
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(245, 240, 246, 0.5),
                                fontSize: 12,
                                fontFamily: 'Nunito'),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(245, 240, 246, 1))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(245, 240, 246, 1)))),
                      ),
                    ),
                    Container(
                      width: 250,
                      margin: const EdgeInsets.only(top: 10),
                      child: TextFormField(
                        style: const TextStyle(
                            color: Color.fromRGBO(245, 240, 246, 1),
                            fontSize: 15,
                            fontFamily: 'Nunito'),
                        decoration: const InputDecoration(
                            labelText: 'Gender',
                            labelStyle: TextStyle(
                                color: Color.fromRGBO(245, 240, 246, 1),
                                fontSize: 15,
                                fontFamily: 'Nunito'),
                            hintText: 'gender',
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(245, 240, 246, 0.5),
                                fontSize: 12,
                                fontFamily: 'Nunito'),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(245, 240, 246, 1))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(245, 240, 246, 1)))),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 420),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(228, 73, 28, 1)),
                      shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return BottomAppBarbar();
                      }));
                    },
                    child: const Text("Save",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(245, 240, 246, 1),
                            fontFamily: 'Nunito')),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
