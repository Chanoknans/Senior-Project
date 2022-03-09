import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hearing_aid/Page/aids_home.dart';
import 'package:hearing_aid/Page/profile_page.dart';
import 'package:hearing_aid/constant.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:file_manager/file_manager.dart';
import 'package:flutter/services.dart' show rootBundle;

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
  var files;
  List file = [];
  // ignore: unused_field
  final List<bool> _pauseplay = List<bool>.generate(100, (indexs) => true);
  bool _pause = true;
  bool permissionGranted = true;
  StreamSubscription? _mRecordingDataSubscription;
  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  var path;
  Uint8List? datas;
  Codec codec = Codec.aacADTS;
  Future<Directory?>? _downloadDir;
  Uint8List? buffer2;
  FlutterSoundPlayer? _mPlayer2 = FlutterSoundPlayer();
  bool _mPlayer2IsInited = false;
  StreamSubscription? _playerSubscription2;
  String? _mPath;
  double _mSubscriptionDuration = 0;
  Uint8List? _boumData;
  StreamSubscription? _mPlayerSubscription;

  Future<void> setSubscriptionDuration(
      double d) async // v is between 0.0 and 2000 (milliseconds)
  {
    _mSubscriptionDuration = d;
    setState(() {});
    await _mPlayer2!.setSubscriptionDuration(
      Duration(milliseconds: d.floor()),
    );
  }

  Future<Uint8List> _getAssetData(String path) async {
    var asset = await rootBundle.load(path);
    return asset.buffer.asUint8List();
  }

  Future<File> get _getStoragepermission async {
    if (await Permission.storage.request().isGranted) {
      String dir =
          (await getExternalStorageDirectory())!.absolute.path + "/sound";
      //List<HearingAidss> recording = [];
      final List<FileSystemEntity> files = Directory(dir).listSync();
      print(files[0]);
    }
    return File(files);
  }

  void initState() {
    super.initState();
    _getStoragepermission;
    _getAssetData(
      'assets/sound/2022-02-28 13_22_16.961722.pcm',
    ).then((value) => setState(() {
          buffer2 = value;
        }));
    _mPlayer2!.openAudioSession().then((value) {
      setState(() {
        _mPlayer2IsInited = true;
      });
    });
  }

  void dispose() {
    // Be careful : you must `close` the audio session when you have finished with it.
    cancelPlayerSubscriptions2();
    _mPlayer2!.closeAudioSession();
    _mPlayer2 = null;
    super.dispose();
  }

  void play2() async {
    await _mPlayer2!.setSubscriptionDuration(Duration(milliseconds: 10));
    _addListener2();
    await _mPlayer2!.startPlayer(
        fromDataBuffer: buffer2,
        codec: Codec.pcm16,
        whenFinished: () {
          setState(() {});
        });
    setState(() {});
  }

  void _addListener2() {
    cancelPlayerSubscriptions2();
  }

  void cancelPlayerSubscriptions2() {
    if (_playerSubscription2 != null) {
      _playerSubscription2!.cancel();
      _playerSubscription2 = null;
    }
  }

  Future<void> stopPlayer2() async {
    cancelPlayerSubscriptions2();
    if (_mPlayer2 != null) {
      await _mPlayer2!.stopPlayer();
    }
    setState(() {});
  }

  Future<void> pause2() async {
    if (_mPlayer2 != null) {
      await _mPlayer2!.pausePlayer();
    }
    setState(() {});
  }

  Future<void> resume2() async {
    if (_mPlayer2 != null) {
      await _mPlayer2!.resumePlayer();
    }
    setState(() {});
  }

  Fn? getPlaybackFn() {
    if (!_mPlayer2IsInited || buffer2 == null) {
      return null;
    }
    return _mPlayer2!.isStopped
        ? play2
        : () {
            stopPlayer2().then((value) => setState(() {}));
          };
  }

  // void _requestDownload(){
  //   setState(() {
  //     _downloadDir = getDownloadsDirectory();
  //   });
  // }

  // await flutterSoundHelper.pcmToWave(
  //   inputFile: dir,
  //   outputFile: dir,
  //   numChannels: 1,
  //   //bitsPerSample: 16,
  //   sampleRate: 44100,
  // );
  // codec = Codec.pcm16WAV;
  // void initState() {
  //   super.initState();
  //   init().then((value) {
  //     setState(() {
  //       _mPlayerIsInited = true;
  //     });
  //   });
  // }

  // void dispose() {
  //   stopPlayer(_mPlayer!);

  //   // Be careful : you must `close` the audio session when you have finished with it.
  //   _mPlayer!.closePlayer();

  //   super.dispose();
  // }

  // Future<void> init() async {
  //   await _mPlayer!.openPlayer();
  //   await _mPlayer!.setSpeed(
  //       1.0); // This dummy instruction is MANDATORY on iOS, before the first `startRecorder()`.
  //   datas = await getAssetData();
  // }

  // Future<Uint8List> getAssetData(String path) async {
  //   var asset = await rootBundle.load(path);
  //   return asset.buffer.asUint8List();
  // }

  // void play(FlutterSoundPlayer? player) async {
  //   await player!.startPlayer(
  //       fromDataBuffer: datas,
  //       codec: Codec.pcm16,
  //       whenFinished: () {
  //         setState(() {});
  //       });
  //   setState(() {});
  // }

  // Future<void> stopPlayer(FlutterSoundPlayer player) async {
  //   await player.stopPlayer();
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
                                //_getStoragepermission();
                                //_extractDirectory();
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
                                    height: 100,
                                    width: 330,
                                    child: StreamBuilder<DurationState>(
                                      stream: _durationState,
                                      builder: (context, snapshot) {
                                        // final durationState = snapshot.data;
                                        // final progress =
                                        //     durationState?.progress ??
                                        //         Duration.zero;
                                        // final buffered =
                                        //     durationState?.buffered ??
                                        //         Duration.zero;
                                        // final total = durationState?.total ??
                                        //     Duration.zero;
                                        return Column(
                                          children: [
                                            Slider(
                                              value: _mSubscriptionDuration,
                                              min: 0.0,
                                              max: 1000.0,
                                              onChanged:
                                                  setSubscriptionDuration,
                                              //divisions: 100
                                            ),
                                            // ProgressBar(
                                            //   progress: progress,
                                            //   buffered: buffer2,
                                            //   total: total,
                                            //   onSeek: (duration) {
                                            //     _player.seek(duration);
                                            //   },
                                            //   progressBarColor: white,
                                            //   baseBarColor: Colors.white
                                            //       .withOpacity(0.24),
                                            //   bufferedBarColor: Colors.white
                                            //       .withOpacity(0.24),
                                            //   thumbColor: white,
                                            //   barHeight: 3.5,
                                            //   thumbRadius: 6.0,
                                            //   timeLabelTextStyle: TextStyle(
                                            //       color: darkgray,
                                            //       fontFamily: 'Nunito',
                                            //       fontSize: 12),
                                            // ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 140),
                                                  child: IconButton(
                                                    icon: Icon(_mPlayer2!.isPlaying
                                                        ? Icons.play_arrow
                                                        : Icons.pause),
                                                    iconSize: 32.0,
                                                    color: white,
                                                    alignment: Alignment.center,
                                                    onPressed: () {
                                                      // for (int i = 0;
                                                      //     i < files.length;
                                                      //     i++) {
                                                      //   files[i].playingstatus =
                                                      //       0;
                                                      // }
                                                      // setState(() {
                                                        getPlaybackFn();
                                                      // });
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

// _FileExtraction() async {
//   var root = await getExternalStorageDirectory();
//   var files = await FileManager(root: root).walk().toList();
//   return files;
// }
