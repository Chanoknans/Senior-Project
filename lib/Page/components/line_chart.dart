// ignore_for_file: deprecated_member_use

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
                              await homepage.generateSampleRate().then(
                                (complete) {
                                  if (complete) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => HearingAidss(),
                                      ),
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
