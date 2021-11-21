import 'package:flutter/material.dart';
import 'package:hearing_aid/page/profile_page.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(0, 50, 70, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(3, 135, 177, 1),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          //ignore: prefer_const_literals_to_create_immutables
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
                    return const Text("Information");
                  },
                ),
              );
            },
          ),
        ],
      ),
      drawer: MyProfile(),
    );
  }
}
