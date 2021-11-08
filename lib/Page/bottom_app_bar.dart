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
  Widget _BottomAppBarBarBar(int selectedIndex) => BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(LineIcons.history), label: 'History'),
          /*BottomNavigationBarItem(
              icon: Icon(LineIcons.areaChart), label: 'Audiogram'),*/
          BottomNavigationBarItem(icon: Icon(LineIcons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(LineIcons.headset), label: 'Mode'),
          BottomNavigationBarItem(
              icon: Icon(LineIcons.microphone), label: 'Recording'),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: orange,
        selectedIconTheme: IconThemeData(color: orange),
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      );

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
    /*  Navigator(onGenerateRoute: (settings) {
          PageStorage(
            bucket: bucket,
            child: pages[_selectedIndex],
          );
          Widget page1 = Homepage();
          if (settings.name == 'Page 2') page1 = HearingAidss();
          return MaterialPageRoute(builder: (_) => page1);
        }));*/
    /*Scaffold(
      bottomNavigationBar: _BottomAppBarBarBar(_selectedIndex),
      body: PageStorage(
        bucket: bucket,
        child: pages[_selectedIndex],
      ),
    );*/
  }
}

class CircleButton extends StatefulWidget {
  CircleButton({Key? key}) : super(key: key);

  @override
  _CircleButtonState createState() => _CircleButtonState();
}

class _CircleButtonState extends State<CircleButton> {
  List<String> text = [];
  bool _showtext = false;
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
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          "กรุณากรอกค่าการได้ยินในช่องว่าง",
          style: TextStyle(
              fontFamily: 'Prompt', fontWeight: FontWeight.bold, fontSize: 18),
        ),
        content: Container(
          width: 200,
          height: 240,
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
                ),
                /*onSaved: (String? value) {},
                validator: (value) {
                 value.isEmpty? 'กรุณากรอกค่าให้ครบ' :null,
                },*/
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
                ),
              ),
              //Image.asset('assets/image/vector2.png')
            ],
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
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


/*Scaffold(
      bottomNavigationBar: _BottomAppBarBarBar(_selectedIndex),
      body: Navigator(onGenerateRoute: (settings) {
        
        Widget pages = Homepage();
        if (settings.name == 'HearingAidss') pages = HearingAidss();
        return MaterialPageRoute(builder: (_) => pages);
      }*/
/*@override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(LineIcons.history), label: 'History'),
        BottomNavigationBarItem(
            icon: Icon(LineIcons.areaChart), label: 'Audiogram'),
        BottomNavigationBarItem(icon: Icon(LineIcons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(LineIcons.headset), label: 'Mode'),
        BottomNavigationBarItem(
            icon: Icon(LineIcons.microphone), label: 'Recording'),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: som,
      selectedIconTheme: IconThemeData(color: som),
      type: BottomNavigationBarType.fixed,
      onTap: _onItemTapped,
    );
  }
}*/      
