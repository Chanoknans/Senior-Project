// ignore_for_file: unused_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hearing_aid/page/components/custom_app_bar.dart';
import 'package:hearing_aid/fade_route.dart';
import 'package:hearing_aid/constant.dart';
import 'package:hearing_aid/page/bottom_app_bar.dart';
import 'package:hearing_aid/page/hearing_test_home.dart';
import 'package:hearing_aid/page/home_page.dart';
import 'package:hearing_aid/page/signup_page.dart';
import 'package:line_icons/line_icons.dart';

class HearingAidss extends StatefulWidget {
  HearingAidss({Key? key}) : super(key: key);

  @override
  _HearingAidssState createState() => _HearingAidssState();
}

class _HearingAidssState extends State<HearingAidss> {
  bool started = false;
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blackground,
        body: Stack(
          children: [
            CustomAppBar(),
            Padding(
              padding: EdgeInsets.only(top: 145, left: 18),
              child: Container(
                height: 40,
                width: 300,
                decoration: BoxDecoration(color: blackground),
                child: Text(
                  "For new users or those who want to use the value elsewhere, "
                  "please fill in your hearing level before using.",
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 12,
                    color: transgray,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 130, left: 320),
              child: CircleButton(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 200, left: 18),
              child: Container(width: 2, height: 54, color: light),
            ),
            Padding(
              padding: EdgeInsets.only(top: 200, left: 30),
              child: RichText(
                text: TextSpan(
                  text: 'การทดสอบวันที่ 2-11-2021\n',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Prompt',
                    fontWeight: FontWeight.w600,
                    color: gray,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '00:36:21224236',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 280),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Before you begin, put on your headphones.",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w600,
                    color: started ? green : redtext,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 320),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 185,
                  height: 185,
                  padding: EdgeInsets.only(top: 2),
                  child: FloatingActionButton(
                      elevation: 5,
                      backgroundColor: started ? green : redtext,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Text(
                              started ? "START" : "STOP",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.bold,
                                  color: white),
                            ),
                          ),
                          SizedBox(height: 5),
                          Image.asset(
                            "assets/image/headphones.png",
                            scale: 2.05,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              "pressed here",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w600,
                                  color: white),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () => setState(() {
                            started = !started;
                          })),
                ),
              ),
            ),
            Positioned(
                top: 530,
                left: 105,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      //alignment: Alignment.center,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 2,
                            fixedSize: const Size(180, 35),
                            textStyle: TextStyle(),
                            primary: Color.fromRGBO(240, 238, 233, 0.95),
                          ),
                          onPressed: () {},
                          child: Row(
                            children: [
                              Icon(
                                LineIcons.microphone,
                                color: redtext,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 22),
                                child: Text(
                                  "Recording",
                                  style: TextStyle(
                                    color: blackground,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Nunito',
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          )),
                    ),
                    Center(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 2,
                            fixedSize: const Size(180, 35),
                            textStyle: TextStyle(),
                            primary: Color.fromRGBO(240, 238, 233, 0.95),
                          ),
                          onPressed: () {},
                          child: Row(
                            children: [
                              Icon(
                                LineIcons.cog,
                                color: grayy,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 28),
                                child: Text(
                                  "Settings",
                                  style: TextStyle(
                                    color: blackground,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Nunito',
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          )),
                    )
                  ],
                ))
          ],
        ));
  }
}
