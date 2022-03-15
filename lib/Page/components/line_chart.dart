// ignore_for_file: deprecated_member_use

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hearing_aid/Page/components/historydetail_page.dart';
import 'package:hearing_aid/Page/history_page.dart';
import 'package:hearing_aid/Page/historyhome_page.dart';
import 'package:hearing_aid/bloc/home_page_cubit.dart';
import 'package:hearing_aid/bloc/home_page_state.dart';
import 'package:hearing_aid/constant.dart';
import 'package:hearing_aid/fade_route.dart';
import 'package:hearing_aid/models/audiogram.dart';
import 'package:hearing_aid/page/aids_home.dart';
import 'package:hearing_aid/page/history_page.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AudiogramLineChart extends StatelessWidget {
  const AudiogramLineChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);
    HomePageCubit homepage = BlocProvider.of<HomePageCubit>(context);
    return BlocBuilder<HomePageCubit, HomePageState>(
      buildWhen: (prev, curr) => prev != curr,
      builder: (context, state) => Padding(
        padding: EdgeInsets.only(top: 280, left: 0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                                  borderRadius: BorderRadius.circular(11),
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
                                majorGridLines: MajorGridLines(width: 0),
                                axisLine: AxisLine(width: 3, color: light),
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
                                      state.rightEar[0],
                                    ),
                                    AudiogramData(
                                      '500',
                                      state.rightEar[1],
                                    ),
                                    AudiogramData(
                                      '1000',
                                      state.rightEar[2],
                                    ),
                                    AudiogramData(
                                      '2000',
                                      state.rightEar[3],
                                    ),
                                    AudiogramData(
                                      '4000',
                                      state.rightEar[4],
                                    ),
                                    AudiogramData(
                                      '8000',
                                      state.rightEar[5],
                                    ),
                                  ],
                                  color: pink,
                                  width: 4,
                                  xValueMapper: (AudiogramData freq, _) =>
                                      freq.freq,
                                  yValueMapper: (AudiogramData freq, _) =>
                                      freq.hear,
                                  markerSettings:
                                      MarkerSettings(isVisible: true),
                                ),
                                LineSeries<AudiogramData, String>(
                                  enableTooltip: true,
                                  dataSource: [
                                    AudiogramData(
                                      '250',
                                      state.leftEar[0],
                                    ),
                                    AudiogramData(
                                      '500',
                                      state.leftEar[1],
                                    ),
                                    AudiogramData(
                                      '1000',
                                      state.leftEar[2],
                                    ),
                                    AudiogramData(
                                      '2000',
                                      state.leftEar[3],
                                    ),
                                    AudiogramData(
                                      '4000',
                                      state.leftEar[4],
                                    ),
                                    AudiogramData(
                                      '8000',
                                      state.leftEar[5],
                                    ),
                                  ],
                                  color: neonblue,
                                  width: 4,
                                  xValueMapper: (AudiogramData freq2, _) =>
                                      freq2.freq,
                                  yValueMapper: (AudiogramData freq2, _) =>
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
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    BlocBuilder<HomePageCubit, HomePageState>(
                      builder: (_, coeff) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          child: TextButton(
                            onPressed: () async {
                              await homepage.checkdata().then(
                                (complete) {
                                  if (complete == true) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          backgroundColor: light2,
                                          insetPadding: EdgeInsets.all(10),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: <Widget>[
                                              Container(
                                                  height: 400,
                                                  child: Column(children: [
                                                    Container(
                                                      width: double.infinity,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 25),
                                                      alignment:
                                                          Alignment.center,
                                                      child: const Text(
                                                        'Instruction',
                                                        style: TextStyle(
                                                          color: blue,
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily: 'Nunito',
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 20),
                                                      alignment:
                                                          Alignment.center,
                                                      child: const Text(
                                                        'วิธีใช้งานแอปพลิเคชั่นเครื่องช่วยฟัง',
                                                        style: TextStyle(
                                                          color: greendialog2,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily: 'Prompt',
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 20,
                                                              left: 20),
                                                      child: const Text(
                                                        '1. เลือกผลการทดสอบที่จะใช้งานในการชดเชย \n    การได้ยิน',
                                                        style: TextStyle(
                                                          color: greendialog2,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontFamily: 'Prompt',
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 20,
                                                              left: 20),
                                                      child: const Text(
                                                        '2. เลือกหูซ้ายหรือหูขวาเพียงหนึ่งข้างที่จะทำการชดเชย\n    การได้ยิน',
                                                        style: TextStyle(
                                                          color: greendialog2,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontFamily: 'Prompt',
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 20,
                                                              left: 20),
                                                      child: const Text(
                                                        '3. กดปุ่มวงกลมสีเขียว เพื่อเริ่มใช้งานเครื่องช่วยฟัง',
                                                        style: TextStyle(
                                                          color: greendialog2,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontFamily: 'Prompt',
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          top: 30),
                                                      width: 300,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 5),
                                                            child: TextButton(
                                                              // ignore: sort_child_properties_last
                                                              child: Text(
                                                                '  หูซ้าย  ',
                                                                style:
                                                                    TextStyle(
                                                                  color: white,
                                                                  fontSize: 30,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontFamily:
                                                                      'Prompt',
                                                                ),
                                                              ),
                                                              onPressed: () {
                                                                homepage
                                                                    .chooseData(
                                                                        context,
                                                                        'L');
                                                              },
                                                              style:
                                                                  ButtonStyle(
                                                                foregroundColor:
                                                                    MaterialStateProperty
                                                                        .all<Color>(
                                                                            white),
                                                                backgroundColor:
                                                                    MaterialStateProperty.all<
                                                                            Color>(
                                                                        Color.fromARGB(
                                                                            255,
                                                                            214,
                                                                            198,
                                                                            52)),
                                                                shape: MaterialStateProperty
                                                                    .all<
                                                                        RoundedRectangleBorder>(
                                                                  RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(6),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 30),
                                                            child: TextButton(
                                                              // ignore: sort_child_properties_last
                                                              child: Text(
                                                                '  หูขวา  ',
                                                                style:
                                                                    TextStyle(
                                                                  color: white,
                                                                  fontSize: 30,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontFamily:
                                                                      'Prompt',
                                                                ),
                                                              ),
                                                              onPressed: () {
                                                                homepage
                                                                    .chooseData(
                                                                        context,
                                                                        'R');
                                                              },
                                                              style:
                                                                  ButtonStyle(
                                                                foregroundColor:
                                                                    MaterialStateProperty
                                                                        .all<Color>(
                                                                            white),
                                                                backgroundColor:
                                                                    MaterialStateProperty
                                                                        .all<Color>(
                                                                            green),
                                                                shape: MaterialStateProperty
                                                                    .all<
                                                                        RoundedRectangleBorder>(
                                                                  RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(6),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ])),
                                              Positioned(
                                                  right: 0,
                                                  top: 10,
                                                  child: IconButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    icon: Icon(Icons.close),
                                                    color: red,
                                                  ))
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
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
                        );
                      },
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                backgroundColor: blackground,
                                insetPadding: EdgeInsets.all(10),
                                child: Stack(
                                  overflow: Overflow.visible,
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      height: 650,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: grayy2,
                                      ),
                                      padding: EdgeInsets.fromLTRB(
                                        5,
                                        50,
                                        20,
                                        20,
                                      ),
                                      child: Audiogram(),
                                    ),
                                    Positioned(
                                      right: 0,
                                      top: 10,
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        icon: Icon(Icons.close),
                                        color: white,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(blue),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                        child: Text(" more details"),
                      ),
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
    );
  }
}
