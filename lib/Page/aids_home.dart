import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hearing_aid/Myconstant.dart';
import 'package:hearing_aid/Page/bottomappbar.dart';

class HearingAidss extends StatefulWidget {
  HearingAidss({Key? key}) : super(key: key);

  @override
  _HearingAidssState createState() => _HearingAidssState();
}

class _HearingAidssState extends State<HearingAidss> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //bottomNavigationBar: BottomAppBarbar(),
        backgroundColor: Myconstant.blackground);
  }
}
