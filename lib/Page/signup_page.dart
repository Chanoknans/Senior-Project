import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hearing_aid/Myconstant.dart';
import 'package:hearing_aid/Myconstant.dart'; // ignore: duplicate_import
import 'package:hearing_aid/Page/Page2.dart';
import 'create_page.dart';
import 'package:hearing_aid/Page/Profile.dart'; // ignore: unused_import

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool statusEye = true;
  bool statusEye2 = true;
  Profile profile = Profile(
    email: '',
    password: '',
    confirmpassword: '',
    name: '',
    gen: '',
    date: '',
    Imageurl: '',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 50, 70, 1),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
        child: SingleChildScrollView(
          child: Column(children: [
            Stack(alignment: AlignmentDirectional.topCenter, children: [
              Container(),
              Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: Image.asset(
                    'assets/image/avatar.png',
                    width: 150,
                  )),
              Container(
                margin: const EdgeInsets.only(top: 165),
                child: const Text(
                  'Sign up.',
                  style: TextStyle(
                      color: Color.fromRGBO(245, 240, 246, 1),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito'),
                ),
              ),
              Column(
                children: [
                  Container(
                    width: 250,
                    margin: const EdgeInsets.only(top: 220),
                    child: TextFormField(
                      style: const TextStyle(
                          color: Color.fromRGBO(245, 240, 246, 1),
                          fontSize: 15,
                          fontFamily: 'Nunito'),
                      decoration: const InputDecoration(
                          labelText: 'E-mail',
                          labelStyle: TextStyle(
                              color: Color.fromRGBO(245, 240, 246, 1),
                              fontSize: 15,
                              fontFamily: 'Nunito'),
                          hintText: 'E-mail',
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
                    margin: const EdgeInsets.only(top: 20),
                    child: TextFormField(
                      validator:
                          RequiredValidator(errorText: 'Please enter password'),
                      onSaved: (String? password) {
                        profile.password = password!;
                      },
                      obscureText: statusEye,
                      style: const TextStyle(
                          color: Color.fromRGBO(245, 240, 246, 1),
                          fontSize: 15,
                          fontFamily: 'Nunito'),
                      decoration: InputDecoration(
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    statusEye = !statusEye;
                                  });
                                },
                                icon: statusEye
                                    ? Icon(
                                        Icons.remove_red_eye,
                                        color: Myconstant.dark,
                                      )
                                    : Icon(
                                        Icons.remove_red_eye_outlined,
                                        color: Myconstant.dark,
                                      )),
                          ),
                          labelText: 'Password',
                          labelStyle: const TextStyle(
                              color: Color.fromRGBO(245, 240, 246, 1),
                              fontSize: 15,
                              fontFamily: 'Nunito'),
                          hintText: 'password',
                          hintStyle: const TextStyle(
                              color: Color.fromRGBO(245, 240, 246, 0.5),
                              fontSize: 12,
                              fontFamily: 'Nunito'),
                          enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(245, 240, 246, 1))),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(245, 240, 246, 1)))),
                    ),
                  ),
                  Container(
                    width: 250,
                    margin: const EdgeInsets.only(top: 20),
                    child: TextFormField(
                      validator:
                          RequiredValidator(errorText: 'Please enter password'),
                      onSaved: (String? password) {
                        profile.password = password!;
                      },
                      obscureText: statusEye2,
                      style: const TextStyle(
                          color: Color.fromRGBO(245, 240, 246, 1),
                          fontSize: 15,
                          fontFamily: 'Nunito'),
                      decoration: InputDecoration(
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    statusEye2 = !statusEye2;
                                  });
                                },
                                icon: statusEye2
                                    ? Icon(
                                        Icons.remove_red_eye,
                                        color: Myconstant.dark,
                                      )
                                    : Icon(
                                        Icons.remove_red_eye_outlined,
                                        color: Myconstant.dark,
                                      )),
                          ),
                          labelText: 'Confirm Password',
                          labelStyle: const TextStyle(
                              color: Color.fromRGBO(245, 240, 246, 1),
                              fontSize: 15,
                              fontFamily: 'Nunito'),
                          hintText: 'confirm password',
                          hintStyle: const TextStyle(
                              color: Color.fromRGBO(245, 240, 246, 0.5),
                              fontSize: 12,
                              fontFamily: 'Nunito'),
                          enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(245, 240, 246, 1))),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(245, 240, 246, 1)))),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 450),
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
                          return const Login();
                        }));
                      },
                      child: const Text("Sign up",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(245, 240, 246, 1),
                              fontFamily: 'Nunito')),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 30),
                    width: 200,
                    child: Row(
                      children: [
                        const Text(
                          'Have an account?',
                          style: TextStyle(
                              color: Color.fromRGBO(245, 240, 246, 1),
                              fontSize: 15,
                              fontFamily: 'Nunito'),
                        ),
                        TextButton(
                            onPressed: () => Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Page2();
                                })),
                            child: const Text(
                              'Sign in',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromRGBO(252, 245, 148, 1),
                                  fontFamily: 'Nunito'),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ]),
          ]),
        ),
      ),
    );
  }
}
