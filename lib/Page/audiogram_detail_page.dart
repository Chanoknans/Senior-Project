import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hearing_aid/Page/historyhome_page.dart';
import 'package:hearing_aid/Page/profile_page.dart';
import 'package:hearing_aid/constant.dart';
import 'package:line_icons/line_icons.dart';

import 'components/historydetail_page.dart';

class detailPage extends StatelessWidget {
  final List<int>? result; //left
  final List<int>? result2; //right
  final int? sumall;

  detailPage({
    Key? key,
    this.result,
    this.result2,
    this.sumall,
  }) : super(key: key);

  // final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackground,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(3, 135, 177, 1),
        title: Text(
          "Hearing Test Result",
          style: TextStyle(
            color: Color.fromRGBO(245, 245, 245, 1),
            fontSize: 22,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          reverse: true,
          child: Stack(
            children: [
              Audiogram(),
            ],
          ),
        ),
      ),
    );
  }
}
