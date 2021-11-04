import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hearing_aid/Faderoute.dart';
import 'package:hearing_aid/Myconstant.dart';
import 'package:hearing_aid/Page/bottomappbar.dart';
import 'package:hearing_aid/Page/homepage.dart';
import 'package:line_icons/line_icons.dart';

class HearingAidss extends StatefulWidget {
  HearingAidss({Key? key}) : super(key: key);

  @override
  _HearingAidssState createState() => _HearingAidssState();
}

class _HearingAidssState extends State<HearingAidss> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Myconstant.blackground,
        body: Stack(
          children: [
            Expanded(
              child: CustomAppBar1(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 145, left: 18),
              child: Container(
                height: 40,
                width: 300,
                decoration: BoxDecoration(color: Myconstant.blackground),
                child: Text(
                  "For new users or those who want to use the value elsewhere, "
                  "please fill in your hearing level before using.",
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 12,
                      color: Myconstant.transgray),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 130, left: 320),
              child: CircleButton(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 200, left: 18),
              child: Container(width: 2, height: 54, color: Myconstant.light),
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
                        color: Myconstant.gray),
                    children: <TextSpan>[
                      TextSpan(
                          text: '00:36:21224236',
                          style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ) /*Text(
                "การทดสอบวันที่ 2-11-2021\n" "00:36:21224236",
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Prompt',
                    fontWeight: FontWeight.bold,
                    color: Myconstant.light),
              ),*/
                )
          ],
        ));
  }
}
