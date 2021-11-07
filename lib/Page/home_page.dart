import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hearing_aid/constant.dart';
import 'package:hearing_aid/fade_route.dart';
import 'package:hearing_aid/page/aids_home.dart';
import 'package:hearing_aid/page/profile_page.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/widgets.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  /*String text = '';
  bool distext = false;*/
  /*@override
  void MyValue() {
    List<int>? new_val = widget.result!;
  }*/

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

  String text = '';
  bool _showtext = false;
  bool _audiogram = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackground,
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
      body: Container(
        child: SingleChildScrollView(
            reverse: true,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 320),
                child: FloatingActionButton(
                  backgroundColor: green,
                  onPressed: () {
                    setState(() {
                      _showtext = !_showtext;
                    });
                  },
                  child: Icon(
                    Icons.add,
                    color: white,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 12),
                child: Container(
                  width: 240,
                  height: 40,
                  child: Visibility(
                    visible: _showtext,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          text = value;
                        });
                      },
                      style: TextStyle(color: white, height: 1, fontSize: 14),
                      maxLength: 30,
                      cursorColor: white,
                      decoration: InputDecoration(
                        focusColor: white,
                        counterStyle: TextStyle(color: white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 0),
                child: Container(
                  constraints: BoxConstraints.expand(height: 200),
                  child: todaySlider(context),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Container(
                      child: Visibility(
                          visible: _audiogram,
                          child: Column(children: [
                            SizedBox(
                              height: 25,
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 360,
                                  width: 350,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(0, 0, 0, 0.3),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15, left: 210, right: 1),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 30,
                                              width: 130,
                                              decoration: BoxDecoration(
                                                  color: green,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          11)),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 2,
                                                            left: 12,
                                                            right: 2),
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
                                            top: 12, left: 12, right: 12),
                                        child: Container(
                                          height: 290,
                                          width: 350,
                                          decoration: BoxDecoration(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.1),
                                              borderRadius:
                                                  BorderRadius.circular(11)),
                                          child: SfCartesianChart(
                                            /*legend: Legend(isVisible: true),*/
                                            tooltipBehavior: _tooltipBehavior,
                                            plotAreaBorderWidth: 0,
                                            primaryXAxis: CategoryAxis(
                                              labelStyle:
                                                  TextStyle(color: light),
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
                                            primaryYAxis: NumericAxis(
                                              labelStyle:
                                                  TextStyle(color: light),
                                              isInversed: true,
                                              title: AxisTitle(
                                                  text: 'Hearing Level (dB HL)',
                                                  textStyle: TextStyle(
                                                      color: light,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              majorGridLines: MajorGridLines(
                                                  width: 0.5,
                                                  color:
                                                      light.withOpacity(0.5)),
                                              axisLine: AxisLine(
                                                  width: 3, color: light),
                                              minimum: -10,
                                              maximum: 100,
                                              interval: 10,
                                            ),
                                            //Data from Hearing Test
                                            series: <ChartSeries>[
                                              LineSeries<AudiogramData, String>(
                                                enableTooltip: true,
                                                dataSource: [
                                                  AudiogramData(
                                                      '250', history2[0]),
                                                  AudiogramData(
                                                      '500', history2[1]),
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
                                                markerSettings: MarkerSettings(
                                                    isVisible: true),
                                                /*dataLabelSettings: DataLabelSettings(
                                  isVisible: true,
                                  textStyle: TextStyle(
                                      color: .light, fontSize: 12),
                                  offset: Offset(16, 0),
                                ),*/
                                              ),
                                              LineSeries<AudiogramData2,
                                                  String>(
                                                enableTooltip: true,
                                                dataSource: [
                                                  AudiogramData2(
                                                      '250', history[0]),
                                                  AudiogramData2(
                                                      '500', history[1]),
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
                                                markerSettings: MarkerSettings(
                                                    isVisible: true),
                                                /*dataLabelSettings: DataLabelSettings(
                                    isVisible: true,
                                    textStyle: TextStyle(
                                        color: .light, fontSize: 12),
                                    offset: Offset(16, 0),
                                  )*/
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ]))))
            ])),
      ),
    );
  }

  Swiper todaySlider(context) {
    return Swiper(
      autoplay: true,
      key: UniqueKey(),
      loop: true,
      itemBuilder: (BuildContext context, int index) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            width: 150,
            height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: white),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ))),

              //color: white,
              onPressed: () async {
                setState(() {
                  _audiogram = !_audiogram;
                  getdata2(index);
                  /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Homepage(
                                result: history2,
                                result2: history,
                                sumall: history2[0] +
                                    history2[1] +
                                    history2[2] +
                                    history2[3] +
                                    history2[4] +
                                    history2[5] +
                                    history[0] +
                                    history[1] +
                                    history[2] +
                                    history[3] +
                                    history[4] +
                                    history[5],
                              )));*/
                });
              },
              child: RichText(
                text: TextSpan(
                  text: 'การทดสอบวันที่ \n' '${today[index].split(" ")[0]}\n',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Prompt',
                      fontWeight: FontWeight.bold,
                      color: blackground),
                  children: <TextSpan>[
                    TextSpan(
                        text: '${today[index].split(" ")[1]}',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)),
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
            activeColor: Color.fromRGBO(228, 73, 28, 1),
            size: 10.0,
            activeSize: 12.0,
            space: 10.0),
      ),
      //control: new SwiperControl(),
    );
  }
}

class AudiogramData {
  AudiogramData(this.freq, this.hear);
  final String? freq;
  final int? hear;
}

class AudiogramData2 {
  AudiogramData2(this.freqs, this.hears);
  final String? freqs;
  final int? hears;
}
