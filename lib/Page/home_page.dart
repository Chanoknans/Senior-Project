import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hearing_aid/bloc/application_cubit.dart';
import 'package:hearing_aid/bloc/application_state.dart';
import 'package:hearing_aid/bloc/home_page_cubit.dart';
import 'package:hearing_aid/fade_route.dart';
import 'package:hearing_aid/page/aids_home.dart';

import 'package:hearing_aid/page/components/bottom_app_bar.dart';
import 'package:hearing_aid/page/components/line_chart.dart';
import 'package:hearing_aid/page/hearing_test_slider.dart';
import 'package:hearing_aid/page/history_page.dart';

import 'package:hearing_aid/page/profile_page.dart';
import 'package:hearing_aid/constant.dart';

import 'package:flutter/widgets.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  final List<int>? result; //left
  final List<int>? result2; //right
  final int? sumall;

  HomePage({
    Key? key,
    this.result,
    this.result2,
    this.sumall,
  }) : super(key: key);

  // final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();

    DateTime fromTime =
        DateTime(today.year, today.month, today.day, 0, 0, 0, 0, 0)
            .toLocal(); // start_time 00:00
    DateTime toTime =
        DateTime(today.year, today.month, today.day, 23, 59, 59, 999)
            .toLocal(); //end_date
    HomePageCubit homepage = BlocProvider.of<HomePageCubit>(context);
    homepage.init();
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
                  child:
                      BlocSelector<ApplicationCubit, ApplicationState, User?>(
                    selector: (state) => state.currentUser,
                    builder: (_, currentUser) => StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(
                            currentUser!.uid,
                          ) //
                          .collection('audiogram_history')
                          // .where(
                          //   'created_at',
                          //   isGreaterThanOrEqualTo: Timestamp.fromDate(fromTime),
                          // )
                          // .where(
                          //   'created_at',
                          //   isLessThanOrEqualTo: Timestamp.fromDate(toTime),
                          // )
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
                        if (data.docs.length != 0) {
                          return HearingTestSlider(data: data.docs);
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ),
              ),
              AudiogramLineChart(),
            ],
          ),
        ),
      ),
    );
  }
}
