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
                  color: green,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 320),
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 180,
                height: 180,
                padding: EdgeInsets.only(top: 5),
                child: FloatingActionButton(
                  elevation: 5,
                  backgroundColor: green,
                  child: Icon(
                    LineIcons.plus,
                    color: light,
                    size: 30,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
