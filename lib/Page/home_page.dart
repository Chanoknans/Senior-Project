import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hearing_aid/Page/aids_home.dart';
import 'package:hearing_aid/Page/bottom_app_bar.dart';
import 'package:hearing_aid/Page/history_page.dart';
import 'package:hearing_aid/Page/profile_page.dart';
import 'package:hearing_aid/constant.dart';
import 'package:hearing_aid/fade_route.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/widgets.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

List<int> _countR = [0, 0, 0, 0, 0, 0];
List<int> _countL = [0, 0, 0, 0, 0, 0];

class Homepage extends StatefulWidget {
  final List<int>? result; //left
  final List<int>? result2; //right
  final int? sumall;
  const Homepage({Key? key, this.result, this.result2, this.sumall})
      : super(key: key);
  static const appTitle = 'Drawer Demo';

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late TooltipBehavior _tooltipBehavior;
  final FirebaseAuth auth = FirebaseAuth.instance;
  int i = 0;
  String _uid = '';
  List<String> today = [];
  List<int> history = [0, 0, 0, 0, 0, 0];
  List<int> history2 = [0, 0, 0, 0, 0, 0];
  String? meen;
  //ScrollController? _scrollController;
  void initState() {
    getdata();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();

    //_scrollController = ScrollController(initialScrollOffset: 50.0);
    //todaySlider(context);
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

  var nows = DateTime.now().toString();
  //final Future<FirebaseApp> firebase = Firebase.initializeApp();

  Future getdata2(int value) async {
    User? user = auth.currentUser;
    _uid = user!.uid;
    final DocumentSnapshot userDoc2 = await FirebaseFirestore.instance
        .collection('users')
        .doc(_uid)
        .collection('history')
        .doc(today[value])
        .get();
    setState(() {
      history = List.from(userDoc2.get('Left'));
      history2 = List.from(userDoc2.get('Right'));
      print('my Left ${history}');
      print('my Right ${history2}');
    });
  }

  List<int> text = [0, 0, 0, 0, 0, 0];
  bool _showtext = false;
  bool _audiogram = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackground,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(3, 135, 177, 1),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          //ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            const Text(
              "Home",
              style: TextStyle(
                color: Color.fromRGBO(245, 245, 245, 1),
                fontSize: 25,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.info_outline_rounded,
              size: 30,
            ),
            color: const Color.fromRGBO(245, 245, 245, 1),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Text("Information");
              }));
            },
          ),
        ],
      ),
      drawer: MyProfile(),
      body: Container(
        child: SingleChildScrollView(
          reverse: true,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 20),
                child: Container(
                  height: 40,
                  width: 320,
                  decoration: BoxDecoration(color: blackground),
                  child: Text(
                    "For new users or those who want to use the value elsewhere, "
                    "please fill in your hearing level before using.",
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 12,
                      color: transgray,
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 25, left: 330),
                  child: CircleButton()),
              Padding(
                padding: EdgeInsets.only(top: 80),
                child: Container(
                  constraints: BoxConstraints.expand(height: 200),
                  child: todaySlider(context),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 280, left: 0),
                child: Container(
                  child: Visibility(
                    visible: _audiogram,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Column(
                          children: [
                            Container(
                              height: 290,
                              width: 290,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(0, 0, 0, 0.3),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, left: 150, right: 1),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 130,
                                          decoration: BoxDecoration(
                                              color: green,
                                              borderRadius:
                                                  BorderRadius.circular(11)),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 2, left: 12, right: 2),
                                              ),
                                              Text(
                                                "Audiogram",
                                                style: TextStyle(
                                                    color: light,
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                textAlign: TextAlign.center,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12, left: 9, right: 12),
                                    child: Container(
                                        height: 230,
                                        width: 300,
                                        decoration: BoxDecoration(
                                            color: Color.fromRGBO(0, 0, 0, 0.1),
                                            borderRadius:
                                                BorderRadius.circular(11)),
                                        child: SfCartesianChart(
                                          /*legend: Legend(isVisible: true),*/
                                          tooltipBehavior: _tooltipBehavior,
                                          plotAreaBorderWidth: 0,
                                          primaryXAxis: CategoryAxis(
                                            labelStyle: TextStyle(color: light),
                                            title: AxisTitle(
                                                text: 'Frequency (Hz)',
                                                textStyle: TextStyle(
                                                    color: light,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            majorGridLines:
                                                MajorGridLines(width: 0),
                                            axisLine: AxisLine(
                                                width: 3, color: light),
                                          ),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12, left: 9, right: 12),
                                    child: Container(
                                      height: 230,
                                      width: 300,
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(0, 0, 0, 0.1),
                                          borderRadius:
                                              BorderRadius.circular(11)),
                                      child: SfCartesianChart(
                                        /*legend: Legend(isVisible: true),*/
                                        tooltipBehavior: _tooltipBehavior,
                                        plotAreaBorderWidth: 0,
                                        primaryXAxis: CategoryAxis(
                                          labelStyle: TextStyle(color: light),
                                          title: AxisTitle(
                                              text: 'Frequency (Hz)',
                                              textStyle: TextStyle(
                                                  color: light,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold)),
                                          majorGridLines:
                                              MajorGridLines(width: 0),
                                          axisLine:
                                              AxisLine(width: 3, color: light),
                                        ),
                                        primaryYAxis: NumericAxis(
                                          labelStyle: TextStyle(color: light),
                                          isInversed: true,
                                          title: AxisTitle(
                                              text: 'Hearing Level (dB HL)',
                                              textStyle: TextStyle(
                                                  color: light,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold)),
                                          majorGridLines: MajorGridLines(
                                              width: 0.5,
                                              color: light.withOpacity(0.5)),
                                          axisLine:
                                              AxisLine(width: 3, color: light),
                                          minimum: -10,
                                          maximum: 100,
                                          interval: 10,
                                        ),
                                        //Data from Hearing Test
                                        series: <ChartSeries>[
                                          LineSeries<AudiogramData, String>(
                                            enableTooltip: true,
                                            dataSource: [
                                              AudiogramData('250', history2[0]),
                                              AudiogramData('500', history2[1]),
                                              AudiogramData(
                                                  '1000', history2[2]),
                                              AudiogramData(
                                                  '2000', history2[3]),
                                              AudiogramData(
                                                  '4000', history2[4]),
                                              AudiogramData(
                                                  '8000', history2[5]),
                                            ],
                                            color: pink,
                                            width: 4,
                                            xValueMapper:
                                                (AudiogramData freq, _) =>
                                                    freq.freq,
                                            yValueMapper:
                                                (AudiogramData freq, _) =>
                                                    freq.hear,
                                            markerSettings:
                                                MarkerSettings(isVisible: true),
                                          ),
                                          LineSeries<AudiogramData2, String>(
                                            enableTooltip: true,
                                            dataSource: [
                                              AudiogramData2('250', history[0]),
                                              AudiogramData2('500', history[1]),
                                              AudiogramData2(
                                                  '1000', history[2]),
                                              AudiogramData2(
                                                  '2000', history[3]),
                                              AudiogramData2(
                                                  '4000', history[4]),
                                              AudiogramData2(
                                                  '8000', history[5]),
                                            ],
                                            color: neonblue,
                                            width: 4,
                                            xValueMapper:
                                                (AudiogramData2 freq2, _) =>
                                                    freq2.freqs,
                                            yValueMapper:
                                                (AudiogramData2 freq2, _) =>
                                                    freq2.hears,
                                            markerSettings:
                                                MarkerSettings(isVisible: true),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 100),
                          child: Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    FadeRoute(
                                      page: HearingAidss(),
                                    ),
                                  );
                                },
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(white),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(redtext),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                ),
                                child: Text("generate"),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    FadeRoute(
                                      page: HistoryPage(),
                                    ),
                                  );
                                },
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(white),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(blue),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                ),
                                child: Text(" more details"),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 80,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Swiper todaySlider(context) {
    return Swiper(
      autoplay: false,
      key: UniqueKey(),
      loop: true,
      itemBuilder: (BuildContext context, int index) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            width: 150,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: white,
            ),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),

              //color: white,
              onPressed: () async {
                setState(() {
                  _audiogram = !_audiogram;
                  getdata2(index);
                });
              },
              child: RichText(
                text: TextSpan(
                  text: 'การทดสอบวันที่ \n' '${today[index].split(" ")[0]}\n',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Prompt',
                    fontWeight: FontWeight.bold,
                    color: blackground,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '${today[index].split(" ")[1]}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      itemCount: today.length,
      viewportFraction: 0.4,
      scale: 0.5,

      pagination: SwiperPagination(
        margin: EdgeInsets.only(top: 120),
        builder: const DotSwiperPaginationBuilder(
          activeColor: yellow,
          size: 6.0,
          activeSize: 10.0,
          space: 5,
        ),
      ),
      //control: new SwiperControl(),
    );
  }
}

class AudiogramData {
  final String? freq;
  final int? hear;

  AudiogramData(
    this.freq,
    this.hear,
  );
}

class AudiogramData2 {
  final String? freqs;
  final int? hears;

  AudiogramData2(
    this.freqs,
    this.hears,
  );
}
