// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hearing_aid/Myconstant.dart';
import 'package:hearing_aid/Page/Profile.dart';
import 'package:hearing_aid/Page/bottomappbar.dart';
import 'package:hearing_aid/Page/homepage.dart';
import 'package:hearing_aid/Page/signup_page.dart';

import 'Page1.dart';

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  final formKey = GlobalKey<FormState>();
  bool statusEye = true;
  Profile profile = Profile(
    email: '',
    password: '',
    confirmpassword: '',
    name: '',
    gen: '',
    date: '',
    Imageurl: '',
  );
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    //double size = MediaQuery.of(context).size.width;
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
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: Form(
                key: formKey,
                child: Stack(
                  children: [
                    Align(
                        child: Image.asset("assets/image/BG2.png",
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover)),
                    Align(
                      alignment: Alignment(-0.65, -0.35),
                      child: Text(
                        'Login.',
                        style: TextStyle(
                            color: Myconstant.light,
                            fontSize: 42,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Nunito'),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0, 0.35),
                      child: Container(
                        width: 296,
                        height: 330,
                        decoration: BoxDecoration(
                            color: Myconstant.light,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    Align(
                      alignment: Alignment(-0.6, -0.15),
                      child: Text(
                        'E-mail',
                        style: TextStyle(
                            color: Myconstant.blackground,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Nunito'),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0, -0.07),
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        width: 260,
                        height: 40,
                        child: TextFormField(
                          validator: MultiValidator([
                            RequiredValidator(errorText: 'Please Enter email'),
                            EmailValidator(
                                errorText:
                                    'Please enter a valid email address'),
                          ]),
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (String? email) {
                            profile.email = email!;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Myconstant.gray,
                            labelStyle: TextStyle(
                                fontSize: 15, color: Myconstant.blackground),
                            labelText: "Email :",
                            prefixIcon: Icon(Icons.lock_outline,
                                color: Myconstant.blackground),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Myconstant.gray),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Myconstant.gray),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment(-0.55, 0.05),
                      child: Text(
                        'Password',
                        style: TextStyle(
                            color: Myconstant.blackground,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Nunito'),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0, 0.15),
                      child: Container(
                        width: 260,
                        height: 40,
                        child: TextFormField(
                          obscureText: statusEye, //พาสเวิสดอกจัน
                          validator: RequiredValidator(
                              errorText: 'Please enter password'),
                          onSaved: (String? password) {
                            profile.password = password!;
                          }, //add comment meenfonpluem
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Myconstant.gray,
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    statusEye = !statusEye;
                                  });
                                },
                                icon: statusEye
                                    ? Icon(
                                        Icons.visibility_off,
                                        color: Myconstant.blackground,
                                      )
                                    : Icon(
                                        Icons.remove_red_eye_outlined,
                                        color: Myconstant.blackground,
                                      )),
                            labelStyle: TextStyle(
                                fontSize: 15, color: Myconstant.blackground),
                            labelText: "Password :",
                            prefixIcon: Icon(Icons.vpn_key_outlined,
                                color: Myconstant.blackground),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Myconstant.gray),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Myconstant.gray),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(-0.47, 0.24),
                      child: Text('Forgot password?',
                          style: TextStyle(
                              color: Myconstant.grayy2,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Nunito')),
                    ),
                    Align(
                      alignment: Alignment(0, 0.34),
                      child: SizedBox(
                        width: 100,
                        height: 40,
                        child: ElevatedButton(
                          style: Myconstant().myButtonstyle2(),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              try {
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: profile.email,
                                        password: profile.password)
                                    .then((value) {
                                  formKey.currentState!.reset();
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return BottomAppBarbar();
                                  }));
                                });
                              } on FirebaseAuthException catch (e) {
                                print(e.message);
                                Fluttertoast.showToast(
                                    msg: e.code, gravity: ToastGravity.CENTER);
                              }
                            }
                          },
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                                color: Myconstant.light,
                                fontSize: 20,
                                fontWeight: FontWeight.w200,
                                fontFamily: 'Nunito'),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0, 0.45),
                      child: Text(
                        'or',
                        style: TextStyle(
                            color: Myconstant.grayy2,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Nunito'),
                      ),
                    ),
                    Align(
                        alignment: Alignment(0.8, 0.55),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.facebook),
                                color: Myconstant.bluee,
                                iconSize: 40,
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Login with facebook',
                                  style: TextStyle(
                                      color: Myconstant.bluee,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Nunito'),
                                ),
                              )
                            ])),
                    Align(
                      alignment: Alignment(0, 0.75),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don’t have an account?',
                              style: TextStyle(
                                  color: Myconstant.light,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Nunito')),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Signup()));
                              },
                              child: Text('Sign Up',
                                  style: TextStyle(
                                      color: Myconstant.yellow,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Nunito')))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              backgroundColor: Myconstant.blackground,
            );
          }
          return Scaffold(
              body: Center(
            child: CircularProgressIndicator(),
          ));
        });
  }
}
