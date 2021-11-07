import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hearing_aid/constant.dart';
import 'package:hearing_aid/fade_route.dart';
import 'package:hearing_aid/page/aids_home.dart';
import 'package:hearing_aid/page/profile_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);
  static const appTitle = 'Drawer Demo';

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String text = '';
  bool distext = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(0, 50, 70, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(3, 135, 177, 1),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Home",
              style: TextStyle(
                color: Color.fromRGBO(245, 245, 245, 1),
                fontSize: 25,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.info_outline_rounded,
              size: 30,
            ),
            color: const Color.fromRGBO(245, 245, 245, 1),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const Text("Information");
              }));
            },
          ),
        ],
      ),
      drawer: MyProfile(),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 60),
                child: Container(
                  width: 240,
                  height: 40,
                  color: blackground,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        text = value;
                      });
                    },
                    style: TextStyle(
                      color: white,
                      height: 1,
                      fontSize: 14,
                    ),
                    maxLength: 30,
                    cursorColor: white,
                    decoration: InputDecoration(
                      focusColor: white,
                      counterStyle: TextStyle(color: white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: white),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                    color: bluee,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        distext = !distext;
                        Navigator.push(
                          context,
                          FadeRoute(
                            page: HearingAidss(),
                          ),
                        );
                      });
                    },
                    child: Text("pressed"),
                  ),
                ),
              ),
              distext ? Text(text) : Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
