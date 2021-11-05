import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hearing_aid/Faderoute.dart';
import 'package:hearing_aid/Myconstant.dart'; // ignore: unused_import
import 'package:hearing_aid/Page/Page2.dart'; // ignore: unused_import
import 'package:hearing_aid/Page/aids_home.dart';
import 'package:hearing_aid/Page/profilepage.dart';

import 'package:line_icons/line_icons.dart'; // ignore: unused_import

import 'bottomappbar.dart'; // ignore: unused_import

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);
  static const appTitle = 'Drawer Demo';

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // ignore: prefer_final_fields
  String text = '';
  bool distext = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromRGBO(0, 50, 70, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(3, 135, 177, 1),
          title: Row(mainAxisAlignment: MainAxisAlignment.center,
              //ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                const Text("Home",
                    style: TextStyle(
                        color: Color.fromRGBO(245, 245, 245, 1),
                        fontSize: 25,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
              ]),
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
        body: Stack(children: [
          /*Padding(
            padding: EdgeInsets.only(top: 30, left: 18),
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
            padding: EdgeInsets.only(top: 15, left: 320),
            child: new CircleButton(),
          ),
        ])*/
          Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 60),
                  child: Container(
                    width: 240,
                    height: 40,
                    color: Myconstant.blackground,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          text = value;
                        });
                      },
                      style: TextStyle(
                          color: Myconstant.white, height: 1, fontSize: 14),
                      maxLength: 30,
                      cursorColor: Myconstant.white,
                      decoration: InputDecoration(
                        focusColor: Myconstant.white,
                        counterStyle: TextStyle(color: Myconstant.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Myconstant.white),
                        ),
                      ),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                //padding: EdgeInsets.only(top: 150, left: 50),
                child: Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Myconstant.bluee,
                      borderRadius: BorderRadius.circular(6)),
                  child: FlatButton(
                      onPressed: () {
                        setState(() {
                          distext = !distext;
                          Navigator.push(
                              context, FadeRoute(page: HearingAidss()));
                        });
                      },
                      child: Text("pressed")),
                ),
              ),
              distext ? Text(text) : Spacer(),
            ],
          ),
        ])
        //bottomNavigationBar: BottomAppBarbar(),
        /*floatingActionButton: CircleButton(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,*/
        );
  }
}
