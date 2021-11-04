import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hearing_aid/Myconstant.dart';
import 'package:hearing_aid/Page/bottomappbar.dart';
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
      body: Container(
        height: 120,
        width: MediaQuery.of(context).size.width,
        color: Myconstant.blackground,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 60, left: 5),
              child: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return BottomAppBarbar();
                    }));
                  },
                  icon: Icon(
                    LineIcons.times,
                    color: Myconstant.light,
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(top: 60, left: 100),
              child: Text(
                "Hearing Aids",
                style: TextStyle(
                    color: Myconstant.light,
                    fontSize: 20,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
