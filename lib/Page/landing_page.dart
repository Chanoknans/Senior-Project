import 'package:flutter/material.dart';
import 'package:hearing_aid/constant.dart';
import 'package:hearing_aid/page/login_page.dart';

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            child: Image.asset(
              "assets/image/BG.png",
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment(-0.63, -0.27),
            child: Text(
              'Welcome to',
              style: TextStyle(
                color: light,
                fontSize: 25,
                fontWeight: FontWeight.w500,
                fontFamily: 'Nunito',
              ),
            ),
          ),
          Align(
            alignment: Alignment(-0.5, -0.19),
            child: Text(
              'Hearing Aids',
              style: TextStyle(
                color: light,
                fontSize: 33,
                fontWeight: FontWeight.w900,
                fontFamily: 'Nunito',
              ),
            ),
          ),
          Align(
            alignment: Alignment(-0.68, -0.11),
            child: Text(
              'Created by',
              style: TextStyle(
                color: light,
                fontSize: 17,
                fontWeight: FontWeight.w400,
                fontFamily: 'Nunito',
              ),
            ),
          ),
          Align(
            alignment: Alignment(-0.50, -0.05),
            child: Text(
              'Telecom. Student, KMITL',
              style: TextStyle(
                color: light,
                fontSize: 17,
                fontWeight: FontWeight.w400,
                fontFamily: 'Nunito',
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, 0.15),
            child: SizedBox(
              width: 190,
              height: 40,
              child: ElevatedButton(
                style: myButtonstyle(
                  primary: blue,
                  boarderRadius: 20.0,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginPage();
                      },
                    ),
                  );
                },
                child: Text(
                  'Join with us',
                  style: TextStyle(
                    color: light,
                    fontSize: 20,
                    fontWeight: FontWeight.w200,
                    fontFamily: 'Nunito',
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      backgroundColor: blackground,
    );
  }
}
