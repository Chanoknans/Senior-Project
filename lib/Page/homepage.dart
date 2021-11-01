import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hearing_aid/Myconstant.dart'; // ignore: unused_import
import 'package:hearing_aid/Page/Page2.dart'; // ignore: unused_import
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
        body: Container(
          child: Text(
            "Homepage Testing",
            style: TextStyle(color: Myconstant.light),
            textAlign: TextAlign.center,
          ),
        )
        //bottomNavigationBar: BottomAppBarbar(),
        /*floatingActionButton: CircleButton(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,*/
        );
  }
}
