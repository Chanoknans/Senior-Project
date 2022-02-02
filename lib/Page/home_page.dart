import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hearing_aid/bloc/application_cubit.dart';
import 'package:hearing_aid/bloc/application_state.dart';
import 'package:hearing_aid/bloc/home_page_cubit.dart';
import 'package:hearing_aid/page/components/bottom_app_bar.dart';
import 'package:hearing_aid/page/components/line_chart.dart';
import 'package:hearing_aid/page/hearing_test_slider.dart';
import 'package:hearing_aid/page/profile_page.dart';
import 'package:hearing_aid/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomePageCubit homepage = BlocProvider.of<HomePageCubit>(context);
    homepage.init();
    return Scaffold(
      backgroundColor: blackground,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(3, 135, 177, 1),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
              showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                        backgroundColor: light2,
                        insetPadding: EdgeInsets.all(10),
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(top: 25),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Instruction',
                                    style: TextStyle(
                                      color: blue,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Nunito',
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(top: 20),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'วิธีใช้งานแอปพลิเคชั่นเครื่องช่วยฟัง',
                                    style: TextStyle(
                                      color: greendialog2,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Prompt',
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  margin:
                                      const EdgeInsets.only(top: 20, left: 20),
                                  child: const Text(
                                    '1. เลือกผลการทดสอบที่จะใช้งานในการชดเชย \n    การได้ยิน',
                                    style: TextStyle(
                                      color: greendialog2,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Prompt',
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  margin:
                                      const EdgeInsets.only(top: 20, left: 20),
                                  child: const Text(
                                    '2. เลือกหูซ้ายหรือหูขวาเพียงหนึ่งข้างที่จะทำการชดเชย\n    การได้ยิน',
                                    style: TextStyle(
                                      color: greendialog2,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Prompt',
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  margin:
                                      const EdgeInsets.only(top: 20, left: 20),
                                  child: const Text(
                                    '3. เลือกหูซ้ายหรือหูขวาเพียงหนึ่งข้างที่จะทำการชดเชย\n    การได้ยิน',
                                    style: TextStyle(
                                      color: greendialog2,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Prompt',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 350),
                              alignment: Alignment.center,
                              child: Image.asset(
                                'assets/image/hearing-aid.png',
                                fit: BoxFit.fill,
                                height: 200,
                                width: 200,
                              ),
                            ),
                            Positioned(
                                right: 0,
                                top: 10,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: Icon(Icons.close),
                                  color: red,
                                ))
                          ],
                        ));
                  });
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
