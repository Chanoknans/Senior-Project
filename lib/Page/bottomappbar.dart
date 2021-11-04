import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hearing_aid/Myconstant.dart';
import 'package:hearing_aid/Page/aids_home.dart';
import 'package:hearing_aid/Page/historypage.dart';
import 'package:hearing_aid/Page/homepage.dart';
import 'package:hearing_aid/Page/modepage.dart';
import 'package:hearing_aid/Page/recordingpage.dart';
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
  Widget _buildBody() => MaterialApp(
      navigatorKey: navigatorKey,
      onGenerateRoute: (settings) {
        Widget pages = Homepage();
        if (settings.name == 'Page 2') pages = HearingAidss();
        return MaterialPageRoute(builder: (_) => pages);
      });

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
        selectedItemColor: Myconstant.som,
        selectedIconTheme: IconThemeData(color: Myconstant.som),
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
        ));
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
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 60,
      height: 60,
      padding: EdgeInsets.only(top: 5),
      child: FloatingActionButton(
          elevation: 5,
          heroTag: "btn1",
          backgroundColor: Myconstant.dgreen,
          child: Icon(
            LineIcons.plus,
            color: Myconstant.light,
            size: 30,
          ),
          onPressed: () {}),
    );
  }
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
      selectedItemColor: Myconstant.som,
      selectedIconTheme: IconThemeData(color: Myconstant.som),
      type: BottomNavigationBarType.fixed,
      onTap: _onItemTapped,
    );
  }
}*/      
