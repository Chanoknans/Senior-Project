import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hearing_aid/bloc/application_cubit.dart';
import 'package:hearing_aid/bloc/application_state.dart';
import 'package:hearing_aid/constant.dart';
import 'package:hearing_aid/page/login_page.dart';
import 'package:line_icons/line_icons.dart';

class MyProfile extends StatefulWidget {
  MyProfile({Key? key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplicationCubit, ApplicationState>(
      buildWhen: (prev, curr) => prev != curr,
      builder: (context, state) => Stack(
        children: <Widget>[
          Container(
            width: 200,
            decoration: BoxDecoration(
              color: Color.fromRGBO(245, 245, 245, 1),
            ),
          ),
          Positioned(
            child: Padding(
              padding: EdgeInsets.only(left: 28, top: 100),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  state.userProfile?.imageUrl ??
                      'https://i.ytimg.com/vi/LLYKlQ2nwqQ/maxresdefault.jpg',
                ),
                radius: 70,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, top: 250),
            child: Column(
              children: [
                Container(
                  width: 170,
                  height: 30,
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(245, 245, 245, 1)),
                  child: Padding(
                    padding: EdgeInsets.only(top: 2, left: 5),
                    child: Text(
                      //"meen chanoknan",
                      state.userProfile!.name!,
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: blackground,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          Positioned(
            height: 600,
            child: Row(
              children: [
                SizedBox(width: 12),
                Icon(LineIcons.calendar, color: blue),
                SizedBox(width: 4),
                Text(
                  state.userProfile?.date!.toDate().toString().split(" ")[0] ??
                      '-',
                  style: TextStyle(color: blackground),
                )
              ],
            ),
          ),
          Positioned(
            height: 670,
            child: Row(
              children: [
                SizedBox(width: 12),
                Icon(LineIcons.venusMars, color: blue),
                SizedBox(width: 4),
                Text(
                  state.userProfile?.gen! ?? '-',
                  style: TextStyle(color: blackground),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(left: 50, top: 365),
            child: Column(
              children: [
                ButtonTheme(
                  minWidth: 90,
                  height: 30,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ElevatedButton(
                    style:
                        myButtonstyle(primary: darkgray, boarderRadius: 12.0),
                    onPressed: () {},
                    child: Text(
                      "Edit Profile",
                      style: TextStyle(color: grayy),
                    ),
                  ),
                ),
                ButtonTheme(
                  minWidth: 110,
                  height: 30,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ElevatedButton(
                    style: myButtonstyle(primary: orange, boarderRadius: 12.0),
                    onPressed: () async {
                      await auth.signOut().then((_) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginPage();
                            },
                          ),
                        );
                      });
                    },
                    child: Text(
                      "Logout",
                      style: TextStyle(color: light),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
