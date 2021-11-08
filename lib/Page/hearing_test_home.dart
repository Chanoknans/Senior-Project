import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:card_swiper/card_swiper.dart';
import '../constant.dart';

class Page5 extends StatefulWidget {
  const Page5({Key? key}) : super(key: key);
  @override
  _Page5State createState() => _Page5State();
}

class _Page5State extends State<Page5> {
  //final controller = ScrollController(initialScrollOffset: 50.0);
  final FirebaseAuth auth = FirebaseAuth.instance;
  int i = 0;
  String _uid = '';
  List<String> today = [];
  List<int> history = [];
  List<int> history2 = [];
  String? meen;
  //ScrollController? _scrollController;
  void initState() {
    getdata();
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

  Future getdata3(int value) async {
    for (var i; i < value; i++) {
      User? user = auth.currentUser;
      _uid = user!.uid;
      final DocumentReference<Map<String, dynamic>> userDoc3 =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(_uid)
              .collection('history')
              .doc(today[i]);

      setState(() {
        userDoc3.delete();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackground,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(3, 135, 177, 1),
        elevation: 0,
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
                    return const Text("Information");
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          constraints: BoxConstraints.expand(height: 150),
          child: todaySlider(context),
        ),
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
                width: 140,
                height: 110,
                decoration: BoxDecoration(
                    color: white, borderRadius: BorderRadius.circular(10)),
                child: TextButton(
                  onPressed: () {
                    _showDialog(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: RichText(
                      text: TextSpan(
                        text: 'การทดสอบวันที่ \n'
                            '${today[index].split(" ")[0]}\n',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Prompt',
                            fontWeight: FontWeight.bold,
                            color: blackground),
                        children: <TextSpan>[
                          TextSpan(
                              text: '${today[index].split(" ")[1]}',
                              style: TextStyle(
                                  fontSize: 13.5, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ),
                )));
      },
      itemCount: today.length,
      viewportFraction: 0.4,
      scale: 0.4,
      scrollDirection: Axis.horizontal,
      pagination: SwiperPagination(
          margin: EdgeInsets.only(top: 10),
          builder:
              DotSwiperPaginationBuilder(color: white, activeColor: yellow)),
      //control: new SwiperControl(),
    );
  }
}

void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text("Alert!!"),
        content: new Text("You are awesome!"),
        actions: <Widget>[
          new FlatButton(
            child: new Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
