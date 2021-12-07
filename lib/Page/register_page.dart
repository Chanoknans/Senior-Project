import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hearing_aid/constant.dart';
import 'package:hearing_aid/models/profile.dart';
import 'package:hearing_aid/page/create_page.dart';
import 'package:hearing_aid/page/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool statusEye = true;
  bool statusEye2 = true;
  final formKey = GlobalKey<FormState>();

  Profile profile = Profile();

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 50, 70, 1),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    Container(),
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: Image.asset(
                        'assets/image/avatar.png',
                        width: 150,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 165),
                      child: const Text(
                        'Sign up.',
                        style: TextStyle(
                          color: Color.fromRGBO(245, 240, 246, 1),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          width: 250,
                          margin: const EdgeInsets.only(top: 220),
                          child: TextFormField(
                            validator: MultiValidator(
                              [
                                RequiredValidator(
                                  errorText: 'Please Enter email',
                                ),
                                EmailValidator(
                                  errorText:
                                      'Please enter a valid email address',
                                ),
                              ],
                            ),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (String? email) {
                              profile.email = email!;
                            },
                            style: const TextStyle(
                              color: Color.fromRGBO(245, 240, 246, 1),
                              fontSize: 15,
                              fontFamily: 'Nunito',
                            ),
                            decoration: const InputDecoration(
                              errorStyle: TextStyle(
                                height: 0.8,
                                wordSpacing: 1.0,
                              ),
                              labelText: 'E-mail',
                              labelStyle: TextStyle(
                                color: Color.fromRGBO(245, 240, 246, 1),
                                fontSize: 15,
                                fontFamily: 'Nunito',
                              ),
                              hintText: 'E-mail',
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
                          ),
                        ),
                        Container(
                          width: 250,
                          margin: const EdgeInsets.only(top: 20),
                          child: TextFormField(
                            validator: RequiredValidator(
                              errorText: 'Please enter password',
                            ),
                            onSaved: (String? password) {
                              profile.password = password!;
                            },
                            obscureText: statusEye,
                            style: const TextStyle(
                              color: Color.fromRGBO(245, 240, 246, 1),
                              fontSize: 15,
                              fontFamily: 'Nunito',
                            ),
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                height: 0.8,
                                wordSpacing: 1.0,
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      statusEye = !statusEye;
                                    });
                                  },
                                  icon: Icon(
                                    statusEye
                                        ? Icons.remove_red_eye
                                        : Icons.remove_red_eye_outlined,
                                    color: grayy,
                                  ),
                                ),
                              ),
                              labelText: 'Password',
                              labelStyle: const TextStyle(
                                color: Color.fromRGBO(245, 240, 246, 1),
                                fontSize: 15,
                                fontFamily: 'Nunito',
                              ),
                              hintText: 'password',
                              hintStyle: const TextStyle(
                                color: Color.fromRGBO(245, 240, 246, 0.5),
                                fontSize: 12,
                                fontFamily: 'Nunito',
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(245, 240, 246, 1),
                                ),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(245, 240, 246, 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 250,
                          margin: const EdgeInsets.only(top: 20),
                          child: TextFormField(
                            validator: RequiredValidator(
                              errorText: 'Please enter password',
                            ),
                            onSaved: (String? password) {
                              profile.password = password!;
                            },
                            obscureText: statusEye2,
                            style: const TextStyle(
                              color: Color.fromRGBO(245, 240, 246, 1),
                              fontSize: 15,
                              fontFamily: 'Nunito',
                            ),
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                height: 0.8,
                                wordSpacing: 1.0,
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      statusEye2 = !statusEye2;
                                    });
                                  },
                                  icon: Icon(
                                    statusEye2
                                        ? Icons.remove_red_eye
                                        : Icons.remove_red_eye_outlined,
                                    color: grayy,
                                  ),
                                ),
                              ),
                              labelText: 'Confirm Password',
                              labelStyle: const TextStyle(
                                color: Color.fromRGBO(245, 240, 246, 1),
                                fontSize: 15,
                                fontFamily: 'Nunito',
                              ),
                              hintText: 'confirm password',
                              hintStyle: const TextStyle(
                                color: Color.fromRGBO(245, 240, 246, 0.5),
                                fontSize: 12,
                                fontFamily: 'Nunito',
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(245, 240, 246, 1),
                                ),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(245, 240, 246, 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 500),
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
                                try {
                                  await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                    email: profile.email!,
                                    password: profile.password!,
                                  )
                                      .then((value) {
                                    formKey.currentState!.reset();
                                    Fluttertoast.showToast(
                                        msg: 'User account has been created.',
                                        gravity: ToastGravity.TOP);

                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return Login();
                                        },
                                      ),
                                    );
                                  });
                                } on FirebaseAuthException catch (e) {
                                  print(e.message);
                                  Fluttertoast.showToast(
                                    msg: 'Wrong Email/Password',
                                    gravity: ToastGravity.CENTER,
                                  );
                                }
                              }
                            },
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(245, 240, 246, 1),
                                fontFamily: 'Nunito',
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 1, left: 30),
                          width: 200,
                          child: Row(
                            children: [
                              const Text(
                                'Have an account?',
                                style: TextStyle(
                                  color: Color.fromRGBO(245, 240, 246, 1),
                                  fontSize: 15,
                                  fontFamily: 'Nunito',
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return LoginPage();
                                      },
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Sign in',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromRGBO(252, 245, 148, 1),
                                    fontFamily: 'Nunito',
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}