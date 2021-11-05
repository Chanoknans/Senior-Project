import 'package:flutter/material.dart';
import 'package:hearing_aid/Faderoute.dart';
import 'package:hearing_aid/Page/bottomappbar.dart';
import 'package:hearing_aid/Page/hearingtest_home.dart';
import 'package:line_icons/line_icons.dart';

class Myconstant {
  //Route
  static String routnsignup = 'signup';
  static String routnlogin = 'login';
  static String routnpath = 'Path';
  //color

  static Color light = Color.fromRGBO(245, 240, 246, 1);
  static Color white = Color.fromRGBO(245, 245, 245, 1);
  static Color gray = Color.fromRGBO(229, 229, 229, 1);
  static Color lightgray = Color.fromRGBO(229, 229, 229, 0.8);
  static Color darkgray = Color.fromRGBO(196, 196, 196, 1);
  static Color transgray = Color.fromRGBO(196, 196, 196, 0.8);
  static Color blackground = Color.fromRGBO(0, 50, 70, 1);
  static Color blacktrans = Color.fromRGBO(0, 50, 70, 0.8);
  static Color blue = Color.fromRGBO(3, 135, 177, 1);
  static Color grayy = Color.fromRGBO(57, 57, 57, 1);
  static Color grayy2 = Color.fromRGBO(57, 57, 57, 0.65);
  static Color som = Color.fromRGBO(228, 73, 28, 1);
  static Color redtext = Color.fromRGBO(206, 43, 55, 1);
  static Color bluee = Color.fromRGBO(66, 103, 178, 1);
  static Color yellow = Color.fromRGBO(252, 245, 148, 1);
  static Color dark = const Color.fromRGBO(43, 65, 98, 1);
  static Color primary = const Color.fromRGBO(56, 95, 113, 1);
  static Color green = const Color.fromRGBO(98, 148, 96, 1);
  static Color dgreen = const Color.fromRGBO(0, 152, 116, 1);

  TextStyle a1Style() =>
      TextStyle(fontSize: 20, color: Color.fromRGBO(43, 65, 98, 1));
  TextStyle a2Style() =>
      TextStyle(color: Color.fromRGBO(245, 240, 246, 1), fontSize: 20);
  TextStyle a3Style() =>
      TextStyle(color: Color.fromRGBO(245, 240, 246, 1), fontSize: 17);
  TextStyle a4Style() =>
      TextStyle(color: Color.fromRGBO(43, 65, 98, 1), fontSize: 18);

  ButtonStyle myButtonstyle() => ElevatedButton.styleFrom(
        primary: Myconstant.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadowColor: Color.fromRGBO(50, 0, 180, 0.2),
      );
  ButtonStyle myButtonstyle2() => ElevatedButton.styleFrom(
        primary: Myconstant.som,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadowColor: Color.fromRGBO(50, 0, 180, 0.2),
      );
}

class CustomAppBar1 extends StatelessWidget {
  const CustomAppBar1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width,
      color: Myconstant.blackground,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 60, left: 5),
            child: IconButton(
                onPressed: () {
                  Navigator.push(context, FadeRoute(page: BottomAppBarbar()));
                },
                icon: Icon(
                  LineIcons.times,
                  color: Myconstant.white,
                )),
          ),
          Padding(
            padding: EdgeInsets.only(top: 60 /*, left: 80*/),
            child: Text(
              "Hearing Aids",
              style: TextStyle(
                  color: Myconstant.white,
                  fontSize: 20,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 60, left: 158),
            child: IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Page5();
                  }));
                },
                icon: Icon(
                  Icons.info_outline_rounded,
                  color: Myconstant.white,
                )),
          ),
        ],
      ),
    );
  }
}
