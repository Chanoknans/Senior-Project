import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hearing_aid/Page/audiogram_detail_page.dart';

import 'package:hearing_aid/bloc/home_page_cubit.dart';
import 'package:hearing_aid/constant.dart';
import 'package:hearing_aid/page/profile_page.dart';

class Historypage extends StatelessWidget {
  final List<QueryDocumentSnapshot> data;

  const Historypage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomePageCubit homePageCubit = BlocProvider.of<HomePageCubit>(context);
    return Scaffold(
      backgroundColor: blackground,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(3, 135, 177, 1),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "History",
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
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(top: 250),
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.fromLTRB(20, 0, 300, 0),
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          width: 4,
                          height: 16,
                          color: Colors.white,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: yellow,
                              borderRadius: BorderRadius.circular(20)),
                          child: Icon(
                            Icons.circle,
                            color: yellow,
                            size: 20,
                          ),
                        ),
                        Container(
                          width: 4,
                          height: 16,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(40, 245, 0, 0),
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                  title: TextButton(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'การทดสอบวันที่ ${data[index]["created_date"].toDate()}',
                    style: TextStyle(
                        color: white, fontFamily: 'Prompt', fontSize: 15),
                    //textAlign: TextAlign.start,
                  ),
                ),
                onPressed: () async {
                  await homePageCubit.getHearingResult(data[index].id);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => detailPage()));
                },
              ));
            },
          ),
        ),
      ]),
    );
  }
}
