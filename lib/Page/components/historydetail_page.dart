import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hearing_aid/bloc/home_page_cubit.dart';
import 'package:hearing_aid/bloc/home_page_state.dart';
import 'package:hearing_aid/constant.dart';
import 'package:hearing_aid/models/audiogram.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Audiogram extends StatefulWidget {
  //Audiogram({Key key}) : super(key: key);

  Audiogram({Key? key}) : super(key: key);

  @override
  _AudiogramState createState() => _AudiogramState();
}

class _AudiogramState extends State<Audiogram> {
  // ignore: unused_field
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);
    return BlocBuilder<HomePageCubit, HomePageState>(
        buildWhen: (prev, curr) => prev != curr,
        builder: (context, state) => Padding(
              padding: EdgeInsets.only(top: 20, left: 0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: 25,
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
                    Row(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 5, left: 30, right: 1),
                          child: Text(
                            "Your average hearing loss",
                            style: TextStyle(color: gray, fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 36, right: 1),
                          child: Container(
                            height: 30,
                            width: 140,
                            decoration: BoxDecoration(
                              color: pink,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0.1, left: 2, right: 1),
                                  child: Container(
                                    width: 25,
                                    height: 26,
                                    decoration: BoxDecoration(
                                        color: gray, shape: BoxShape.circle),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, left: 8, right: 1),
                                      child: Text(
                                        "R",
                                        style: TextStyle(
                                            color: pink,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0.3, left: 5, right: 1),
                                  child: Container(
                                    height: 20,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      color: pink,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0.5, left: 20, right: 1),
                                      child: Text(
                                        '${((state.rightEar[1] + state.rightEar[2] + state.rightEar[3]) / 3).round()}',
                                        style: TextStyle(
                                            color: gray,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0.3, left: 5, right: 1),
                                  child: Container(
                                    height: 20,
                                    width: 42,
                                    decoration: BoxDecoration(
                                      color: pink,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 1.8, left: 2, right: 1),
                                      child: Text(
                                        "dB HL",
                                        style: TextStyle(
                                            color: gray,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 20, right: 1),
                          child: Container(
                            height: 30,
                            width: 140,
                            decoration: BoxDecoration(
                              color: neonblue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0.2, left: 3, right: 1),
                                  child: Container(
                                    width: 25,
                                    height: 26,
                                    decoration: BoxDecoration(
                                        color: gray, shape: BoxShape.circle),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, left: 8, right: 1),
                                      child: Text(
                                        "L",
                                        style: TextStyle(
                                            color: neonblue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0.3, left: 5, right: 1),
                                  child: Container(
                                    height: 20,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      color: neonblue,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0.5, left: 20, right: 1),
                                      child: Text(
                                        '${((state.leftEar[1] + state.leftEar[2] + state.leftEar[3]) / 3).round()}',
                                        style: TextStyle(
                                            color: gray,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0.3, left: 5, right: 1),
                                  child: Container(
                                    height: 20,
                                    width: 42,
                                    decoration: BoxDecoration(
                                      color: neonblue,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 1.8, left: 2, right: 1),
                                      child: Text(
                                        "dB HL",
                                        style: TextStyle(
                                            color: gray,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 4, left: 45, right: 1),
                          child: Row(
                            children: [
                              Container(
                                height: 136,
                                width: 300,
                                decoration: BoxDecoration(
                                    color: gray,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 9, left: 1, right: 1),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 275,
                                        decoration: BoxDecoration(
                                          color: gray,
                                        ),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 2.95, left: 5, right: 1),
                                              child: Text(
                                                "Hearing Loss Grade: ",
                                                style: TextStyle(
                                                    color: primary,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                            Container(
                                              height: 30,
                                              width: 110,
                                              decoration: BoxDecoration(
                                                color: gray,
                                              ),
                                              child: Row(
                                                children: <Widget>[
                                                  if ((state.leftEar[1] +
                                                          state.leftEar[2] +
                                                          state.leftEar[3] +
                                                          state.rightEar[1] +
                                                          state.rightEar[2] +
                                                          state.rightEar[3] /
                                                              6) <
                                                      26)
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 3.2,
                                                              left: 1,
                                                              right: 0),
                                                      child: Text(
                                                        "Normal",
                                                        style: TextStyle(
                                                          color: green,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    )
                                                  else if ((state.leftEar[1] +
                                                              state.leftEar[2] +
                                                              state.leftEar[3] +
                                                              state
                                                                  .rightEar[1] +
                                                              state
                                                                  .rightEar[2] +
                                                              state.rightEar[
                                                                      3] /
                                                                  6) >=
                                                          26 &&
                                                      (state
                                                                  .leftEar[1] +
                                                              state.leftEar[2] +
                                                              state.leftEar[3] +
                                                              state
                                                                  .rightEar[1] +
                                                              state
                                                                  .rightEar[2] +
                                                              state.rightEar[
                                                                      3] /
                                                                  6) <
                                                          41)
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 3.2,
                                                              left: 1,
                                                              right: 0),
                                                      child: Text(
                                                        "Slight",
                                                        style: TextStyle(
                                                            color: yellow,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    )
                                                  else if ((state.leftEar[1] +
                                                              state.leftEar[2] +
                                                              state.leftEar[3] +
                                                              state
                                                                  .rightEar[1] +
                                                              state
                                                                  .rightEar[2] +
                                                              state.rightEar[
                                                                      3] /
                                                                  6) >=
                                                          41 &&
                                                      (state
                                                                  .leftEar[1] +
                                                              state.leftEar[2] +
                                                              state.leftEar[3] +
                                                              state
                                                                  .rightEar[1] +
                                                              state
                                                                  .rightEar[2] +
                                                              state.rightEar[
                                                                      3] /
                                                                  6) <
                                                          61)
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 3.2,
                                                              left: 1,
                                                              right: 0),
                                                      child: Text(
                                                        "Moderate",
                                                        style: TextStyle(
                                                            color: orange,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    )
                                                  else if ((state.leftEar[1] +
                                                              state.leftEar[2] +
                                                              state.leftEar[3] +
                                                              state
                                                                  .rightEar[1] +
                                                              state
                                                                  .rightEar[2] +
                                                              state.rightEar[
                                                                      3] /
                                                                  6) >=
                                                          61 &&
                                                      (state
                                                                  .leftEar[1] +
                                                              state.leftEar[2] +
                                                              state.leftEar[3] +
                                                              state
                                                                  .rightEar[1] +
                                                              state
                                                                  .rightEar[2] +
                                                              state.rightEar[
                                                                      3] /
                                                                  6) <
                                                          81)
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 3.2,
                                                              left: 1,
                                                              right: 0),
                                                      child: Text(
                                                        "Severe",
                                                        style: TextStyle(
                                                            color: redtext,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    )
                                                  else
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 3.2,
                                                              left: 1,
                                                              right: 0),
                                                      child: Text(
                                                        "Profound",
                                                        style: TextStyle(
                                                            color: redtext,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 4, left: 6, right: 1),
                                            child: Container(
                                              height: 100,
                                              width: 260,
                                              decoration: BoxDecoration(
                                                color: gray,
                                              ),
                                              child: Column(
                                                children: <Widget>[
                                                  if ((state.leftEar[1] +
                                                          state.leftEar[2] +
                                                          state.leftEar[3] +
                                                          state.rightEar[1] +
                                                          state.rightEar[2] +
                                                          state.rightEar[3]! /
                                                              6) <
                                                      26)
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 2,
                                                              left: 5,
                                                              right: 0),
                                                      child: Text(
                                                        "คุณมีระดับการได้ยินที่ปกติหรือมีปัญหาการได้ยินที่น้อยมากคุณสามารถได้ยินเสียงกระซิบเบาๆและเสียงพูดปกติได้",
                                                        textAlign:
                                                            TextAlign.justify,
                                                        style: TextStyle(
                                                            color: primary,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                'Prompt'),
                                                      ),
                                                    )
                                                  else if ((state.leftEar[1] +
                                                              state.leftEar[2] +
                                                              state.leftEar[3] +
                                                              state
                                                                  .rightEar[1] +
                                                              state
                                                                  .rightEar[2] +
                                                              state.rightEar[
                                                                      3] /
                                                                  6) >=
                                                          26 &&
                                                      (state
                                                                  .leftEar[1] +
                                                              state.leftEar[2] +
                                                              state.leftEar[3] +
                                                              state
                                                                  .rightEar[1] +
                                                              state
                                                                  .rightEar[2] +
                                                              state.rightEar[
                                                                      3] /
                                                                  6) <
                                                          41)
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 2,
                                                              left: 5,
                                                              right: 0),
                                                      child: Text(
                                                        "คุณมีระดับการได้ยินที่ระดับหูตึงเล็กน้อยคุณจะไม่ได้ยินเสียงพูดเบาๆแต่สามารถได้ยินเสียงพูดปกติ ควรปรึกษาแพทย์ผู้เชี่ยวชาญเพื่อตรวจการได้ยินอย่างละเอียด ซึ่งอาจจำเป็นจะต้องใช้เครื่องช่วยฟัง",
                                                        textAlign:
                                                            TextAlign.justify,
                                                        style: TextStyle(
                                                            color: primary,
                                                            fontSize: 12.2,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                'Prompt'),
                                                      ),
                                                    )
                                                  else if ((state.leftEar[1] +
                                                              state.leftEar[2] +
                                                              state.leftEar[3] +
                                                              state
                                                                  .rightEar[1] +
                                                              state
                                                                  .rightEar[2] +
                                                              state.rightEar[
                                                                      3] /
                                                                  6) >=
                                                          41 &&
                                                      (state
                                                                  .leftEar[1] +
                                                              state.leftEar[2] +
                                                              state.leftEar[3] +
                                                              state
                                                                  .rightEar[1] +
                                                              state
                                                                  .rightEar[2] +
                                                              state.rightEar[
                                                                      3] /
                                                                  6) <
                                                          61)
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 2,
                                                              left: 5,
                                                              right: 0),
                                                      child: Text(
                                                        "คุณมีระดับการได้ยินที่ระดับหูตึงปานกลางคุณจะไม่ได้ยินเสียงพูดปกติต้องพูดให้เสียงดังกว่าปกติจึงจะสามารถได้ยิน ควรไปพบแพทย์ผู้เชี่ยวชาญเพื่อตรวจการได้ยินอย่างละเอียดและคำแนะนำสำหรับการใช้เครื่องช่วยฟัง",
                                                        textAlign:
                                                            TextAlign.justify,
                                                        style: TextStyle(
                                                            color: primary,
                                                            fontSize: 12.2,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                'Prompt'),
                                                      ),
                                                    )
                                                  else if ((state.leftEar[1] +
                                                              state.leftEar[2] +
                                                              state.leftEar[3] +
                                                              state
                                                                  .rightEar[1] +
                                                              state
                                                                  .rightEar[2] +
                                                              state.rightEar[
                                                                      3] /
                                                                  6) >=
                                                          61 &&
                                                      (state
                                                                  .leftEar[1] +
                                                              state.leftEar[2] +
                                                              state.leftEar[3] +
                                                              state
                                                                  .rightEar[1] +
                                                              state
                                                                  .rightEar[2] +
                                                              state.rightEar[
                                                                      3] /
                                                                  6) <
                                                          81)
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 2,
                                                              left: 5,
                                                              right: 0),
                                                      child: Text(
                                                        "คุณมีระดับการได้ยินที่ระดับหูตึงรุนแรงคุณจะได้ยินเสียงตะโกนหรือเสียงที่มาจากเครื่องขยายเสียง จำเป็นต้องใช้เครื่องช่วยฟังกรณีที่ไม่มีเครื่องช่วยฟังควรจะฝึกการอ่านปาก",
                                                        textAlign:
                                                            TextAlign.justify,
                                                        style: TextStyle(
                                                            color: primary,
                                                            fontSize: 12.2,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                'Prompt'),
                                                      ),
                                                    )
                                                  else
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 2,
                                                              left: 5,
                                                              right: 0),
                                                      child: Text(
                                                        "คุณมีระดับการได้ยินที่ระดับหูหนวกคุณจะไม่ได้ยินเสียงตะโกนหรือเสียงที่มาจากเครื่องขยายเสียง และสามารถเข้าใจความหมาย เครื่องช่วยฟังอาจช่วยได้ในเรื่องการทำความเข้าใจคำศัพท์การอ่านปากและการเขียนเป็นสิ่งจำเป็น",
                                                        textAlign:
                                                            TextAlign.justify,
                                                        style: TextStyle(
                                                            color: primary,
                                                            fontSize: 12.2,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                'Prompt'),
                                                      ),
                                                    )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
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
                  ],
                ),
              ),
            ));
  }
}
