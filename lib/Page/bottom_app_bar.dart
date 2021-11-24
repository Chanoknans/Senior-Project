// ignore_for_file: unused_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:hearing_aid/constant.dart';
import 'package:hearing_aid/page/aids_home.dart';
import 'package:hearing_aid/page/history_page.dart';
import 'package:hearing_aid/page/home_page.dart';
import 'package:hearing_aid/page/mode_page.dart';
import 'package:hearing_aid/page/recording_page.dart';
import 'package:line_icons/line_icons.dart';
import 'package:hearing_aid/models/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BottomAppBarbar extends StatefulWidget {
  BottomAppBarbar({Key? key}) : super(key: key);

  @override
  _BottomAppBarbarState createState() => _BottomAppBarbarState();
}

class _BottomAppBarbarState extends State<BottomAppBarbar> {
  /*@override
  Widget build(BuildContext context) {return Container();*/

  final List<Widget> pages = [
    HistoryPage(
      key: PageStorageKey('Page1'),
    ),
    /*AudiogramPage(
      key: PageStorageKey('Page2'),
    ),*/
    Homepage(
      key: PageStorageKey('Page2'),
    ),
    ModePage(
      key: PageStorageKey('Page3'),
    ),
    RecordingPage(
      key: PageStorageKey('Page4'),
    )
  ];
  final FirebaseAuth auth = FirebaseAuth.instance;
  String _uid = '';
  List<String> today = [];
  final PageStorageBucket bucket = PageStorageBucket();
  int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
  // ignore: unused_field
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Index 0: History', style: optionStyle),
    //Text('Index 1: Audiogram', style: optionStyle),
    Text('Index 1: Home', style: optionStyle),
    Text('Index 2: Mode', style: optionStyle),
    Text('Index 3: Recording', style: optionStyle),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void getdata() async {
    User? user = auth.currentUser;

    _uid = user!.uid;
    print('user.email ${user.email}');
    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    setState(() {
      today = List.from(userDoc.get('today'));
    });
    // meen = today![1];
  }

  Future getdata2(int value) async {
    User? user = auth.currentUser;
    _uid = user!.uid;
    final DocumentSnapshot userDoc2 = await FirebaseFirestore.instance
        .collection('users')
        .doc(_uid)
        .collection('history')
        .doc()
        .get();
    setState(() {});
  }

  final navigatorKey = GlobalKey<NavigatorState>();
  // ignore: unused_element
  Widget _buildBody() => MaterialApp(
        navigatorKey: navigatorKey,
        onGenerateRoute: (settings) {
          Widget pages = Homepage();
          if (settings.name == 'Page 2') pages = HearingAidss();
          return MaterialPageRoute(builder: (_) => pages);
        },
      );

  // ignore: non_constant_identifier_names
  Widget _BottomAppBarBarBar(int selectedIndex) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(LineIcons.history),
          label: 'History',
        ),
        BottomNavigationBarItem(icon: Icon(LineIcons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(LineIcons.headset), label: 'Mode'),
        BottomNavigationBarItem(
          icon: Icon(LineIcons.microphone),
          label: 'Recording',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: orange,
      selectedIconTheme: IconThemeData(color: orange),
      type: BottomNavigationBarType.fixed,
      onTap: _onItemTapped,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _BottomAppBarBarBar(_selectedIndex),
      body: //_buildBody(),
          PageStorage(
        bucket: bucket,
        child: pages[_selectedIndex],
      ),
    );
  }
}

class CircleButton extends StatefulWidget {
  CircleButton({Key? key}) : super(key: key);

  @override
  _CircleButtonState createState() => _CircleButtonState();
}

class _CircleButtonState extends State<CircleButton> {
  List<String> text = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      padding: EdgeInsets.only(top: 5),
      child: FloatingActionButton(
        elevation: 5,
        heroTag: "btn1",
        backgroundColor: dgreen,
        child: Icon(
          LineIcons.plus,
          color: light,
          size: 30,
        ),
        onPressed: () {
          setState(() {
            _showDialog(context);
          });
        },
      ),
    );
  }
}

void _showDialog(BuildContext context) {
  List<int> Lcount = [];
  List<int> Rcount = [];
  var nows = DateTime.now();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
      return AlertDialog(
        title: Text(
          "กรุณากรอกค่าการได้ยินในช่องว่าง",
          style: TextStyle(
              fontFamily: 'Prompt', fontWeight: FontWeight.bold, fontSize: 18),
        ),
        content: Form(
          key: _formKey,
          child: Container(
            width: 200,
            height: 220,
            child: Column(
              children: [
                TextFormField(
                  style: TextStyle(
                      fontFamily: 'Prompt',
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                  decoration: const InputDecoration(
                      icon: Icon(LineIcons.chevronRight),
                      hintText: 'เช่น [10,10,10,10,10,10]',
                      labelText: 'หูขวา*',
                      errorStyle: TextStyle(fontFamily: 'Prompt')),
                  validator: (value) {
                    if (value!.length <= 13 || value.isEmpty) {
                      return 'กรุณากรอกค่าให้ครบค่ะ';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (String? value) {
                    List<String> newvalue = value!.split(",");
                    List<String> New = [];
                    for (int i = 0; i < newvalue.length; i++) {
                      if (i == 0) {
                        New = newvalue[i].split("[");
                        newvalue[i] = New[1];
                      } else if (i == newvalue.length - 1) {
                        New = newvalue[i].split("]");
                        newvalue[i] = New[0];
                      }
                      Rcount.add(int.parse(newvalue[i]));
                      ;
                    }
                  },
                ),
                TextFormField(
                  style: TextStyle(
                      fontFamily: 'Prompt',
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                  decoration: const InputDecoration(
                      icon: Icon(LineIcons.chevronLeft),
                      hintText: 'เช่น [10,10,10,10,10,10]',
                      labelText: 'หูซ้าย*',
                      errorStyle: TextStyle(fontFamily: 'Prompt')),
                  //keyboardType: TextInputType.number,
                  validator: (String? value) {
                    if (value!.length <= 13 || value.isEmpty) {
                      return 'กรุณากรอกค่าให้ครบค่ะ';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (String? value) {
                    List<String> newvalue = value!.split(",");
                    List<String> New = [];
                    for (int i = 0; i < newvalue.length; i++) {
                      if (i == 0) {
                        New = newvalue[i].split("[");
                        newvalue[i] = New[1];
                      } else if (i == newvalue.length - 1) {
                        New = newvalue[i].split("]");
                        newvalue[i] = New[0];
                      }
                      Lcount.add(int.parse(newvalue[i]));
                      ;
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            child: Text(
              "OK",
              style: TextStyle(
                  color: redtext,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w600),
            ),
            onPressed: () async {
              //var formKey;

              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                print(Lcount);
                print(Rcount);
                final auth = FirebaseAuth.instance;
                final User? user = auth.currentUser;
                final _uid = user!.uid;
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(_uid)
                    .collection('history')
                    .doc()
                    .set({
                  'Left': Lcount,
                  'Right': Rcount,
                  'created_date': nows
                });
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return BottomAppBarbar();
                    },
                  ),
                );
              }
            },
          ),
        ],
      );
    },
  );
}
