import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hearing_aid/Page/profile_page.dart';
import 'package:hearing_aid/constant.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:line_icons/line_icons.dart';

class RecordingPrototype extends StatefulWidget {
  RecordingPrototype({Key? key}) : super(key: key);

  @override
  _RecordingPrototypeState createState() => _RecordingPrototypeState();
}

class _RecordingPrototypeState extends State<RecordingPrototype> {
  final List<bool> _isVisible = List<bool>.generate(1000, (indexs) => false);
  final datetimes = [
    '21:01234',
    '21:012345',
    '21:01236',
    '21:012378'
  ]; //can be datetime length
  final dayy = ['11-01-2022', '10-01-2022', '09-01-2022', '09-01-2022'];
  get _durationState => null;
  final List<bool> _pauseplay = List<bool>.generate(100, (indexs) => true);
  bool _pause = true;

  // List<bool> _isVisible = [false, false, false, false];
  // void showDialog() {
  //   setState(() {
  //     _isVisible = !_isVisible;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackground,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(3, 135, 177, 1),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Recording",
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
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 35, left: 20),
            child: Container(
              height: 40,
              width: 200,
              decoration: BoxDecoration(color: blackground),
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  "All Recordings",
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 23.5,
                      color: white,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 85, left: 25),
            child: Container(
              height: 2,
              width: 340,
              decoration: BoxDecoration(color: white),
            ),
          ),
          SizedBox(
            height: 90,
          ),
          Padding(
            padding: EdgeInsets.only(top: 100, left: 25, right: 30),
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: white),
                        ),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            enabled: true,
                            onTap: () {
                              setState(() {
                                _isVisible[index] = !_isVisible[index];
                              });
                            },
                            title: Align(
                              //padding: EdgeInsets.symmetric(vertical: 1,horizontal: 0),
                              alignment:
                                  Alignment(-1.42, -1.5), //Alignment.topLeft,
                              child: Text(
                                "บันทึกการใช้งานวันที่ " + "${dayy[index]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Prompt',
                                  fontWeight: FontWeight.w600,
                                  color: white,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            subtitle: Align(
                              alignment: Alignment(-1.12, -1.85),
                              child: Text(
                                datetimes[index],
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Prompt',
                                  fontWeight: FontWeight.w400,
                                  color: darkgray,
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: _isVisible[index],
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Container(
                                    decoration:
                                        BoxDecoration(color: blackground),
                                    height: 78,
                                    width: 330,
                                    child: StreamBuilder<DurationState>(
                                      stream: _durationState,
                                      builder: (context, snapshot) {
                                        final durationState = snapshot.data;
                                        final progress =
                                            durationState?.progress ??
                                                Duration.zero;
                                        final buffered =
                                            durationState?.buffered ??
                                                Duration.zero;
                                        final total = durationState?.total ??
                                            Duration.zero;
                                        return Column(
                                          children: [
                                            ProgressBar(
                                              progress: progress,
                                              buffered: buffered,
                                              total: total,
                                              onSeek: (duration) {
                                                _player.seek(duration);
                                              },
                                              progressBarColor: white,
                                              baseBarColor: Colors.white
                                                  .withOpacity(0.24),
                                              bufferedBarColor: Colors.white
                                                  .withOpacity(0.24),
                                              thumbColor: white,
                                              barHeight: 3.5,
                                              thumbRadius: 6.0,
                                              timeLabelTextStyle: TextStyle(
                                                  color: darkgray,
                                                  fontFamily: 'Nunito',
                                                  fontSize: 12),
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 140),
                                                  child: IconButton(
                                                    icon: Icon(_pause
                                                        ? Icons.play_arrow
                                                        : Icons.pause),
                                                    iconSize: 32.0,
                                                    color: white,
                                                    alignment: Alignment.center,
                                                    onPressed: () {
                                                      setState(() {
                                                        _pause = !_pause;
                                                      });
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 94),
                                                  child: IconButton(
                                                    icon: const Icon(
                                                        LineIcons.trash),
                                                    iconSize: 30.0,
                                                    color: white,
                                                    alignment: Alignment.center,
                                                    onPressed: () => showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                        title: Text(
                                                          "Are you sure you want to delete this record ?",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Nunito',
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        content: Text(
                                                          "คุณแน่ใจที่ต้องการจะลบไฟล์บันทึกเสียงนี้ ? ",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Prompt',
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                            child: Text(
                                                              "CANCEL",
                                                              style: TextStyle(
                                                                color: redtext,
                                                                fontFamily:
                                                                    'Nunito',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                          TextButton(
                                                            child: Text(
                                                              "OK",
                                                              style: TextStyle(
                                                                color: dgreen,
                                                                fontFamily:
                                                                    'Nunito',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                            onPressed: () {},
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ), //container
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _player {
  static void seek(Duration duration) {}
}

class DurationState {
  const DurationState(
      {required this.progress, required this.buffered, required this.total});
  final Duration progress;
  final Duration buffered;
  final Duration total;
}