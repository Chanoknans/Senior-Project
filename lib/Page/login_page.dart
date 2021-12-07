import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hearing_aid/bloc/application_cubit.dart';
import 'package:hearing_aid/constant.dart';
import 'package:hearing_aid/models/profile.dart';
import 'package:hearing_aid/page/components/bottom_app_bar.dart';
import 'package:hearing_aid/page/register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _controller = TextEditingController();
  FocusNode myFocusNode = FocusNode();
  FocusNode myFocusNode2 = FocusNode();
  final formKey = GlobalKey<FormState>();
  bool statusEye = true;
  Profile profile = Profile();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appCubit = BlocProvider.of<ApplicationCubit>(context);
    appCubit.init().then((value) {
      if (value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Dashboard();
            },
          ),
        );
      }
    });
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: formKey,
        child: Stack(
          children: [
            Align(
              child: Image.asset(
                "assets/image/BG2.png",
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment(-0.65, -0.35),
              child: Text(
                'Login.',
                style: TextStyle(
                  color: light,
                  fontSize: 42,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Nunito',
                ),
              ),
            ),
            Align(
              alignment: Alignment(0, 0.35),
              child: Container(
                width: 296,
                height: 330,
                decoration: BoxDecoration(
                  color: light,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Align(
              alignment: Alignment(-0.6, -0.15),
              child: Text(
                'E-mail',
                style: TextStyle(
                  color: blackground,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Nunito',
                ),
              ),
            ),
            Align(
              alignment: Alignment(0, -0.07),
              child: Container(
                margin: EdgeInsets.only(top: 15),
                width: 260,
                height: 40,
                child: TextFormField(
                  focusNode: myFocusNode,
                  style: TextStyle(fontSize: 15),
                  validator: MultiValidator(
                    [
                      RequiredValidator(errorText: 'Please Enter Email'),
                      EmailValidator(
                        errorText: 'Please enter a valid email address',
                      ),
                    ],
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (String? email) {
                    profile.email = email!;
                  },
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                      height: 0.2,
                      wordSpacing: 0.1,
                      fontSize: 11,
                    ),
                    filled: true,
                    fillColor: gray,
                    hintText: "Email : ",
                    hintStyle: TextStyle(fontSize: 12),
                    prefixIcon: Icon(Icons.lock_outline, color: blackground),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: gray),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: gray),
                      borderRadius: BorderRadius.circular(10),
                    ),
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
                  color: blackground,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Nunito',
                ),
              ),
            ),
            Align(
              alignment: Alignment(0, 0.15),
              child: Container(
                width: 260,
                height: 40,
                child: TextFormField(
                  focusNode: myFocusNode2,
                  style: TextStyle(fontSize: 15),
                  //controller: _controller,
                  obscureText: statusEye, //พาสเวิสดอกจัน
                  validator:
                      RequiredValidator(errorText: 'Please Enter Password'),
                  onSaved: (String? password) {
                    profile.password = password!;
                  },
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                      height: 0.2,
                      wordSpacing: 1.0,
                      fontSize: 11,
                    ),
                    filled: true,
                    fillColor: gray,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          statusEye = !statusEye;
                        });
                      },
                      icon: Icon(
                        statusEye
                            ? Icons.visibility_off
                            : Icons.remove_red_eye_outlined,
                        color: blackground,
                      ),
                    ),
                    hintText: "Password :",
                    hintStyle: TextStyle(fontSize: 12),
                    prefixIcon:
                        Icon(Icons.vpn_key_outlined, color: blackground),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: gray),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: gray),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment(-0.47, 0.24),
              child: Text(
                'Forgot password?',
                style: TextStyle(
                  color: grayy2,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Nunito',
                ),
              ),
            ),
            Align(
              alignment: Alignment(0, 0.34),
              child: SizedBox(
                width: 100,
                height: 40,
                child: ElevatedButton(
                  style: myButtonstyle(primary: orange, boarderRadius: 12),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      await appCubit
                          .loginWithEmail(profile.email!, profile.password!)
                          .then((value) {
                        formKey.currentState!.reset();
                        if (value['complete']) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Dashboard();
                              },
                            ),
                          );
                        } else {
                          Fluttertoast.showToast(
                            msg: value['message'],
                            gravity: ToastGravity.CENTER,
                          );
                        }
                      });
                    }
                  },
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      color: light,
                      fontSize: 20,
                      fontWeight: FontWeight.w200,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment(0, 0.45),
              child: Text(
                'or',
                style: TextStyle(
                  color: grayy2,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Nunito',
                ),
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
                    color: bluee,
                    iconSize: 40,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Login with facebook',
                      style: TextStyle(
                        color: bluee,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment(0, 0.75),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don’t have an account?',
                    style: TextStyle(
                      color: light,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Nunito',
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: yellow,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      backgroundColor: blackground,
    );
  }
}
