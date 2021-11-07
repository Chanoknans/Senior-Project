import 'package:flutter/material.dart';

// class  {
//Route
const String routnsignup = 'signup';
const String routnlogin = 'login';
const String routnpath = 'Path';
//color

const Color light = Color.fromRGBO(245, 240, 246, 1);
const Color white = Color.fromRGBO(245, 245, 245, 1);
const Color gray = Color.fromRGBO(229, 229, 229, 1);
const Color darkgray = Color.fromRGBO(196, 196, 196, 1);
const Color transgray = Color.fromRGBO(196, 196, 196, 0.8);
const Color blackground = Color.fromRGBO(0, 50, 70, 1);
const Color blacktrans = Color.fromRGBO(0, 50, 70, 0.8);
const Color blue = Color.fromRGBO(3, 135, 177, 1);
const Color neonblue = Color.fromRGBO(0, 138, 216, 1);
const Color grayy = Color.fromRGBO(57, 57, 57, 1);
const Color grayy2 = Color.fromRGBO(57, 57, 57, 0.65);
const Color orange = Color.fromRGBO(228, 73, 28, 1);
const Color pink = Color.fromRGBO(224, 62, 82, 1);
const Color redtext = Color.fromRGBO(206, 43, 55, 1);
const Color bluee = Color.fromRGBO(66, 103, 178, 1);
const Color yellow = Color.fromRGBO(252, 245, 148, 1);
const Color dark = const Color.fromRGBO(43, 65, 98, 1);
const Color primary = const Color.fromRGBO(56, 95, 113, 1);
const Color green = const Color.fromRGBO(98, 148, 96, 1);
const Color dgreen = const Color.fromRGBO(0, 152, 116, 1);

TextStyle a1Style() =>
    TextStyle(fontSize: 20, color: Color.fromRGBO(43, 65, 98, 1));
TextStyle a2Style() =>
    TextStyle(color: Color.fromRGBO(245, 240, 246, 1), fontSize: 20);
TextStyle a3Style() =>
    TextStyle(color: Color.fromRGBO(245, 240, 246, 1), fontSize: 17);
TextStyle a4Style() =>
    TextStyle(color: Color.fromRGBO(43, 65, 98, 1), fontSize: 18);

ButtonStyle myButtonstyle({
  required Color primary,
  required num boarderRadius,
}) =>
    ElevatedButton.styleFrom(
      primary: primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(boarderRadius.toDouble()),
      ),
      shadowColor: Color.fromRGBO(50, 0, 180, 0.2),
    );

// ButtonStyle myButtonstyle2() => ElevatedButton.styleFrom(
//       primary: orange,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       shadowColor: Color.fromRGBO(50, 0, 180, 0.2),
//     );

// myButtonstyle => blue 20

// myButtonstyle => orange 12