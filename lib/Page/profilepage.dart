import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hearing_aid/Myconstant.dart';
import 'package:hearing_aid/Page/Page2.dart';
import 'package:hearing_aid/Page/Profile.dart';
import 'package:line_icons/line_icons.dart';

class MyProfile extends StatefulWidget {
  MyProfile({Key? key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Profile profile = Profile(
      email: '',
      password: '',
      confirmpassword: '',
      date: '',
      gen: '',
      name: '',
      Imageurl: '');
  String? _uid;
  String? _userimage;
  List<String>? date;
  void initState() {
    getdata();
    super.initState();
  }

  void getdata() async {
    // ignore: unused_local_variable
    User? user = auth.currentUser;

    _uid = user!.uid;
    print('user.email ${user.email}');
    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    setState(() {
      profile.name = userDoc.get('name');
      print('name ${profile.name}');
      profile.gen = userDoc.get('gen');
      profile.date = userDoc.get('date');
      _userimage = userDoc.get('image');
      date = profile.date.split("");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
              backgroundImage: NetworkImage(_userimage ??
                  'https://i.ytimg.com/vi/LLYKlQ2nwqQ/maxresdefault.jpg'),
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
                      profile.name,
                      style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Myconstant.blackground),
                      textAlign: TextAlign.center,
                    ),
                  ))
            ],
          ),
        ),
        SizedBox(height: 10),
        Positioned(
            height: 600,
            child: Row(
              children: [
                SizedBox(width: 12),
                Icon(LineIcons.calendar, color: Myconstant.blue),
                SizedBox(width: 4),
                Text(
                  profile.date.split(" ")[0],
                  style: TextStyle(color: Myconstant.blackground),
                )
              ],
            )),
        Positioned(
            height: 670,
            child: Row(
              children: [
                SizedBox(width: 12),
                Icon(LineIcons.venusMars, color: Myconstant.blue),
                SizedBox(width: 4),
                Text(
                  profile.gen,
                  style: TextStyle(color: Myconstant.blackground),
                )
              ],
            )),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.only(left: 50, top: 365),
          child: Column(
            children: [
              ButtonTheme(
                  minWidth: 90,
                  height: 30,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: RaisedButton(
                      color: Myconstant.darkgray,
                      onPressed: () {},
                      child: Text(
                        "Edit Profile",
                        style: TextStyle(color: Myconstant.grayy),
                      ))),
              ButtonTheme(
                  minWidth: 100,
                  height: 30,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: RaisedButton(
                    color: Myconstant.som,
                    onPressed: () async {
                      await auth.signOut().then((value) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return Page2();
                        }));
                      });
                    },
                    child: Text(
                      "Logout",
                      style: TextStyle(color: Myconstant.light),
                    ),
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
