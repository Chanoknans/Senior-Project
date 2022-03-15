import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hearing_aid/Page/aids_home.dart';
import 'package:hearing_aid/Page/profile_page.dart';
import 'package:hearing_aid/constant.dart';
import 'package:line_icons/line_icons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:file_manager/file_manager.dart';
import 'package:flutter/services.dart' show rootBundle;

typedef Fn = void Function();

class RecordingPrototype extends StatefulWidget {
  RecordingPrototype({Key? key}) : super(key: key);

  @override
  _RecordingPrototypeState createState() => _RecordingPrototypeState();
}

class _RecordingPrototypeState extends State<RecordingPrototype> {
  List<bool> _isVisible = [];
  get _durationState => null;
  var files;
  List file = [];
  bool permissionGranted = true;
  var path;
  Uint8List? datas;

  Uint8List? buffer2;
  final FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
  bool _mPlayerIsInited = false;
  double _mSubscriptionDuration = 0;
  Uint8List? _data;
  Uint8List? _data2;
  StreamSubscription? _mPlayerSubscription;
  int pos = 0;
  Duration? dur;
  String time = '--:--:--.------';
  double a = 10000.0;
  List<FileSystemEntity> Filemimi = [];
  List<FileSystemEntity> name = [];
  // Future<Directory?>? _downloadDir;
  // StreamSubscription? _playerSubscription2;
  // String? _mPath;
  // final List<bool> _pauseplay = List<bool>.generate(100, (indexs) => true);

  Future<List<FileSystemEntity>> get _getStoragepermission async {
    if (await Permission.storage.request().isGranted) {
      String dir =
          (await getExternalStorageDirectory())!.absolute.path + "/sound";
      //List<HearingAidss> recording = [];
      final List<FileSystemEntity> files =
          Directory(dir).listSync(recursive: true);
      name = files;
    }
    return name;
  }

  @override
  void initState() {
    super.initState();
    init().then((value) {
      setState(() {
        _mPlayerIsInited = true;
      });
    });
  }

  @override
  void dispose() {
    stopPlayer(_mPlayer);
    cancelPlayerSubscriptions();
    // Be careful : you must `close` the audio session when you have finished with it.
    _mPlayer.closeAudioSession();

    super.dispose();
  }

  void cancelPlayerSubscriptions() {
    if (_mPlayerSubscription != null) {
      _mPlayerSubscription!.cancel();
      _mPlayerSubscription = null;
    }
  }

  Future<void> init() async {
    await _mPlayer.openAudioSession();
    Filemimi = await _getStoragepermission;
    print(Filemimi.length);
    _isVisible = List<bool>.generate(Filemimi.length, (indexs) => false);

    //dur = (await _mPlayer.getProgress())['duration'];
    _mPlayerSubscription = _mPlayer.onProgress!.listen((e) {
      setState(() {
        pos = e.position.inMilliseconds;
      });
      dur = e.duration;
    });
  }

  // -------  Here is the code to playback  -----------------------

  void play(FlutterSoundPlayer? player, int x) async {
    await player!.startPlayer(
        // fromDataBuffer: _data,
        fromURI: Filemimi[x].path,
        codec: Codec.pcm16,
        sampleRate: 44100,
        whenFinished: () {
          setState(() {});
        });
    setState(() {});
    a = dur!.inMilliseconds.toDouble();
    time = dur!.toString().split(':')[2];
  }

  Future<void> stopPlayer(FlutterSoundPlayer player) async {
    await player.stopPlayer();
  }

  Future<void> setSubscriptionDuration(
      double d) async // v is between 0.0 and 2000 (milliseconds)
  {
    _mSubscriptionDuration = d;
    setState(() {});
    await _mPlayer.setSubscriptionDuration(
      Duration(milliseconds: d.floor()),
    );
  }

  // --------------------- UI -------------------
  Fn? getPlaybackFn(FlutterSoundPlayer? player, int x) {
    if (!_mPlayerIsInited) {
      return null;
    }
    return player!.isStopped
        ? () {
            setSubscriptionDuration(1);
            play(player, x);
          }
        : () {
            stopPlayer(player).then((value) => setState(() {}));
          };
  }

  Future<void> delete(FileSystemEntity file) async {
    try {
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      print(e);
    }
  }

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
              itemCount: Filemimi.length,
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
                                // _getStoragepermission();
                                //_extractDirectory();
                              });
                            },
                            title: Align(
                              //padding: EdgeInsets.symmetric(vertical: 1,horizontal: 0),
                              alignment:
                                  Alignment(-1.42, -1.5), //Alignment.topLeft,
                              child: Text(
                                "บันทึกการใช้งานวันที่ " +
                                    "${(Filemimi[index].path.split('sound/')[1]).split('.')[0]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Prompt',
                                  fontWeight: FontWeight.w600,
                                  color: white,
                                ),
                                textAlign: TextAlign.start,
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
                                    height: 55,
                                    width: 330,
                                    child: Column(
                                      children: [
                                        // Slider(
                                        //   value: pos.toDouble(),
                                        //   min: 0.0,
                                        //   max: _mPlayer.isPlaying
                                        //       ? dur!.inMilliseconds.toDouble()
                                        //       : a,
                                        //   onChanged: (double value) async {
                                        //     _mPlayer.seekToPlayer(Duration(
                                        //         milliseconds: value.round()));
                                        //     print(value);
                                        //     pos = value.round();
                                        //     setState(() {});
                                        //     await _mPlayer
                                        //         .setSubscriptionDuration(
                                        //             Duration(
                                        //                 milliseconds:
                                        //                     value.floor()));
                                        //   },
                                        //   inactiveColor:
                                        //       Colors.white.withOpacity(0.24),
                                        //   thumbColor: white,
                                        //   activeColor: white,
                                        // ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 140),
                                              child: IconButton(
                                                  icon: Icon(_mPlayer.isPlaying
                                                      ? Icons.pause
                                                      : Icons.play_arrow),
                                                  iconSize: 32.0,
                                                  color: white,
                                                  alignment: Alignment.center,
                                                  onPressed: getPlaybackFn(
                                                      _mPlayer, index)),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 94),
                                              child: IconButton(
                                                icon:
                                                    const Icon(LineIcons.trash),
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
                                                          fontFamily: 'Nunito',
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    content: Text(
                                                      "คุณแน่ใจที่ต้องการจะลบไฟล์บันทึกเสียงนี้ ? ",
                                                      style: TextStyle(
                                                          fontFamily: 'Prompt',
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
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
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(context)
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
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          delete(
                                                              Filemimi[index]);
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
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
