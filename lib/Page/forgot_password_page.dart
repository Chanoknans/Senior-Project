import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:hearing_aid/Page/login_page.dart';

import 'package:hearing_aid/constant.dart';

class Forgot extends StatefulWidget {
  const Forgot({Key? key}) : super(key: key);

  @override
  _ForgotState createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  final formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  String email = " ";

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
              appBar: AppBar(
        backgroundColor: blackground,
        elevation: 0,
      ),
              backgroundColor: const Color.fromRGBO(0, 50, 70, 1),
              body: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: SingleChildScrollView(
                  child: Column(children: [
                    Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: [
                        Container(margin: EdgeInsets.only(top: 520),alignment: Alignment.center,child: Image.asset('assets/image/vector2.png'),),
                        Container(
                          margin: const EdgeInsets.only(top: 100),
                          alignment: Alignment.center,
                          child: Image.asset('assets/image/question.png',fit: BoxFit.fill,height: 200,width: 200,),
                        ),
                        Column(
                          children: [
                            Container(
                              width: 270,
                              margin: const EdgeInsets.only(top: 10),
                              child: const Text(
                                'Forgot',
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
                                'Password.',
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
                        Column(
                          children: [
                            Container(
                              width: 250,
                              margin: const EdgeInsets.only(top: 300),
                              alignment: Alignment.center,
                              child: Text(
                                'Reset Password',
                                style: const TextStyle(
                                  color: Color.fromRGBO(245, 240, 246, 1),
                                  fontSize: 25,
                                  fontFamily: 'Nunito',
                                ),
                              ),
                            ),
                            Container(
                              width: 350,
                              margin: const EdgeInsets.only(top: 10),
                              alignment: Alignment.center,
                              child: Text(
                                'Enter your email address below',
                                style: const TextStyle(
                                  color: Color.fromRGBO(245, 240, 246, 1),
                                  fontSize: 20,
                                  fontFamily: 'Nunito',
                                ),
                              ),
                            ),
                            Container(
                              width: 250,
                              margin: const EdgeInsets.only(top: 10),
                              alignment: Alignment.center,
                              child: Text(
                                'to reset password',
                                style: const TextStyle(
                                  color: Color.fromRGBO(245, 240, 246, 1),
                                  fontSize: 20,
                                  fontFamily: 'Nunito',
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 300,
                          height: 50,
                          margin: const EdgeInsets.only(top: 420),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your email";
                              } else {
                                email = value;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: light,
                              labelStyle: TextStyle(fontSize: 15, color: dark),
                              labelText: "Email :",
                              prefixIcon: Icon(Icons.email, color: dark),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: dark),
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: dark),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 480),
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
                                FirebaseAuth.instance
                                    .sendPasswordResetEmail(email: email)
                                    .then((value) => print("Check your mails"));

                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return LoginPage();
                                }));
                              }
                            },
                            child: const Text(
                              "Send",
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
