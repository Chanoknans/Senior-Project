import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hearing_aid/page/aids_home.dart';
import 'package:hearing_aid/page/components/bottom_app_bar.dart';

import 'package:hearing_aid/page/history_page.dart';
import 'package:hearing_aid/page/profile_page.dart';
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
  const Homepage({
    Key? key,
    this.result,
    this.result2,
    this.sumall,
  }) : super(key: key);
  static const appTitle = 'Drawer Demo';

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late TooltipBehavior _tooltipBehavior;
  final FirebaseAuth auth = FirebaseAuth.instance;
  int i = 0;
  String _uid = '';
  List<int> leftEar = [0, 0, 0, 0, 0, 0];
  List<int> rightEar = [0, 0, 0, 0, 0, 0];
  String? meen;
  late Timestamp today;
  late DateTime date;
  List<DateTime> time = [];

  void initState() {
    // getData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  // void getData() async {
  //   User? user =;
  //   _uid = user!.uid;

  // }

  // var nows = DateTime.now().toString();

  // Future getdata2(DateTime pickedDate) async {
  //   User? user = auth.currentUser;
  //   _uid = user!.uid;
  //   await
  //       // .where("created_date", isEqualTo: pickedDate)
  //       .get()
  //       .then((userDoc2) {
  //     setState(() {
  //       if (userDoc2.docs.length > 0) {
  //         userDoc2.docs.forEach((element) {
  //           leftEar = List.from(element.get('Left'));
  //           rightEar = List.from(element.get('Right'));
  //           print('my Left ${leftEar}');
  //           print('my Right ${rightEar}');
  //         });
  //       }
  //     });
  //   });
  // }

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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Text("Information");
                  },
                ),
              );
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
                child: CircleButton(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 80),
                child: Container(
                  constraints: BoxConstraints.expand(height: 200),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(
                          "5SgpxjqTg4V9nibJ6WobfdGeAjf2",
                        ) //  auth.currentUser!.uid
                        .collection('audiogram_history')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }

                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final data = snapshot.requireData;

                      return todaySlider(context, data.docs);
                    },
                  ),
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
                              width: 290,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(0, 0, 0, 0.3),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 15,
                                      left: 150,
                                      right: 1,
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 130,
                                          decoration: BoxDecoration(
                                            color: green,
                                            borderRadius:
                                                BorderRadius.circular(11),
                                          ),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 2,
                                                  left: 12,
                                                  right: 2,
                                                ),
                                              ),
                                              Text(
                                                "Audiogram",
                                                style: TextStyle(
                                                  color: light,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500,
                                                ),
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
                                      top: 12,
                                      left: 9,
                                      right: 12,
                                    ),
                                    child: Container(
                                      height: 230,
                                      width: 300,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(0, 0, 0, 0.1),
                                        borderRadius: BorderRadius.circular(11),
                                      ),
                                      child: SfCartesianChart(
                                        tooltipBehavior: _tooltipBehavior,
                                        plotAreaBorderWidth: 0,
                                        primaryXAxis: CategoryAxis(
                                          labelStyle: TextStyle(color: light),
                                          title: AxisTitle(
                                            text: 'Frequency (Hz)',
                                            textStyle: TextStyle(
                                              color: light,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
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
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          majorGridLines: MajorGridLines(
                                            width: 0.5,
                                            color: light.withOpacity(0.5),
                                          ),
                                          axisLine: AxisLine(
                                            width: 3,
                                            color: light,
                                          ),
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
                                                '250',
                                                rightEar[0],
                                              ),
                                              AudiogramData(
                                                '500',
                                                rightEar[1],
                                              ),
                                              AudiogramData(
                                                '1000',
                                                rightEar[2],
                                              ),
                                              AudiogramData(
                                                '2000',
                                                rightEar[3],
                                              ),
                                              AudiogramData(
                                                '4000',
                                                rightEar[4],
                                              ),
                                              AudiogramData(
                                                '8000',
                                                rightEar[5],
                                              ),
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
                                          LineSeries<AudiogramData, String>(
                                            enableTooltip: true,
                                            dataSource: [
                                              AudiogramData(
                                                '250',
                                                leftEar[0],
                                              ),
                                              AudiogramData(
                                                '500',
                                                leftEar[1],
                                              ),
                                              AudiogramData(
                                                '1000',
                                                leftEar[2],
                                              ),
                                              AudiogramData(
                                                '2000',
                                                leftEar[3],
                                              ),
                                              AudiogramData(
                                                '4000',
                                                leftEar[4],
                                              ),
                                              AudiogramData(
                                                '8000',
                                                leftEar[5],
                                              ),
                                            ],
                                            color: neonblue,
                                            width: 4,
                                            xValueMapper:
                                                (AudiogramData freq2, _) =>
                                                    freq2.freq,
                                            yValueMapper:
                                                (AudiogramData freq2, _) =>
                                                    freq2.hear,
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
                            vertical: 10,
                            horizontal: 100,
                          ),
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

  Swiper todaySlider(context, List<QueryDocumentSnapshot> data) {
    return Swiper(
      autoplay: false,
      loop: true,
      itemBuilder: (BuildContext context, int index) {
        print(index);
        return Align(
          alignment: Alignment.center,
          child: Container(
            key: Key(data[index].id),
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
                  // getdata2(time[index]);
                });
              },
              child: RichText(
                text: TextSpan(
                  text: 'การทดสอบวันที่ \n' '${data[index].id}\n',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Prompt',
                    fontWeight: FontWeight.bold,
                    color: blackground,
                  ),
                ),
              ),
            ),
          ),
        );
      },
      itemCount: data.length + 1,
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
