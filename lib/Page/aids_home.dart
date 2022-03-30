import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/util/wave_header.dart';
import 'package:hearing_aid/page/components/custom_app_bar.dart';
import 'package:hearing_aid/constant.dart';
import 'package:hearing_aid/page/components/bottom_app_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hearing_aid/bloc/home_page_cubit.dart';
import 'package:hearing_aid/bloc/home_page_state.dart';

const int tSampleRate = 44100;
typedef Fn = void Function();

class HearingAidss extends StatefulWidget {
  HearingAidss({Key? key}) : super(key: key);

  @override
  _HearingAidssState createState() => _HearingAidssState();
}

class _HearingAidssState extends State<HearingAidss> {
  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  FlutterSoundPlayer? _mPlayer2 = FlutterSoundPlayer();
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
  bool _mPlayerIsInited = false;
  bool _mPlayerIsInited2 = false;
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;
  String? _mPath;
  StreamSubscription? _mRecordingDataSubscription;
  String fileExtension = '.aac';
  String fileName = 'Recording_';
  String dirpath = "/assets/sound/";

  Future<void> open() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }

    // Be careful : openAudioSession returns a Future.
    // Do not access your FlutterSoundPlayer or FlutterSoundRecorder before the completion of the Future
    await _mPlayer!.openAudioSession(
      device: AudioDevice.blueToothA2DP,
      audioFlags: allowHeadset | allowEarPiece | allowBlueToothA2DP,
      category: SessionCategory.playAndRecord,
    );
    //   await _mRecorder!.openAudioSession();
    //   setState(() {
    //   _mRecorderIsInited = true;
    //  });
  }

  Future<void> _openRecorder() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }
    await _mRecorder!.openAudioSession();
    setState(() {
      _mRecorderIsInited = true;
    });
  }

  //@override
  void initState() {
    super.initState();
    _mPlayer!.openAudioSession().then((value) {
      setState(() {
        _mPlayerIsInited = true;
        //_mPlayerIsInited2 = true;
      });
    });
    open();
    _mPlayer2!.openAudioSession().then((value) {
      setState(() {
        _mPlayerIsInited2 = true;
      });
    });
    _openRecorder();
  }

  //@override
  void dispose() {
    stopPlayer();
    _mPlayer!.closeAudioSession();
    _mPlayer = null;
    //stopPlayer2();
    // Be careful : you must `close` the audio session when you have finished with it.

    stopRecorder();
    _mRecorder!.closeAudioSession();
    _mRecorder = null;

    stopPlayer2();
    _mPlayer2!.closeAudioSession();
    _mPlayer2 = null;
    super.dispose();
  }

  // -------  Here is the code to play from the microphone -----------------------
  Future<IOSink> createFile() async {
    var tempDir = await getExternalStorageDirectory();
    var testdir =
        await Directory('${tempDir!.path}/sound').create(recursive: true);
    _mPath = '${testdir.path}/${DateTime.now().toString()}.pcm';
    print(_mPath);
    var outputFile = File(_mPath!);
    if (outputFile.existsSync()) {
      await outputFile.delete(); // sent file to local storage
    }
    return outputFile.openWrite();
  }

  Future<void> record() async {
    HomePageCubit homePageCubit = BlocProvider.of<HomePageCubit>(context);
    assert(_mRecorderIsInited && _mPlayer2!.isStopped || _mPlayer!.isPlaying);
    var sink = await createFile();
    var recordingDataController = StreamController<Food>();
    _mRecordingDataSubscription =
        recordingDataController.stream.listen((buffer) async {
      if (buffer is FoodData) {
        print('Input data uint8 type: ${buffer.data!}');
        List<double> beforedataLeft = [];
        List<double> beforedataRight = [];
        for (var i = 0; i < buffer.data!.length; i += 2) {
          beforedataLeft.add(
              (reduce(buffer.data![i]) / homePageCubit.state.maxGain!.floor()));
          beforedataRight.add((reduce(buffer.data![i + 1]) /
              homePageCubit.state.maxGain!.floor()));
        }
        print('double : ${beforedataLeft}');
        List<num> data = await homePageCubit.generateSampleRate(
            beforedataLeft, beforedataLeft.length);
        List<num> data2 = await homePageCubit.generateSampleRate(
            beforedataRight, beforedataRight.length);
        List<int> afterdataLeft = [];
        List<int> afterdataRight = [];
        print('DSP: ${data}');
        for (var i = 2; i < data.length; i += 1) {
          afterdataLeft.add(scaling(data[i]));
          afterdataRight.add(scaling(data2[i]));
        }

        List<int> afterdata0 = adding(afterdataLeft, afterdataRight);
        Uint8List afterdata2 = Uint8List.fromList(afterdata0);
        print('Output data uint8 type: ${afterdata2}');
        sink.add(afterdata2); // xUint8 type
      }
    });
    print('Recording...');
    await _mRecorder!.startRecorder(
      toStream: recordingDataController.sink,
      codec: Codec.pcm16,
      numChannels: 1,
      sampleRate: tSampleRate,
      //toFile: '$fileName',
    );

    setState(() {});
  }

  List<int> adding(List<int> data, List<int> data2) {
    List<int> op = [];
    for (int i = 0; i < data.length; i += 1) {
      op.add(data[i]);
      op.add(data2[i]);
    }
    return op;
  }

  int scaling(num value) {
    int y;
    if (value >= 0 && value <= 1) {
      y = (value * 128).round();
    } else if (value < 0 && value >= -1) {
      y = ((value * 128) + 256).floor();
    } else if (value < -1) {
      y = 128;
    } else if (value > 1) {
      y = 127;
    } else {
      y = 0;
    }
    return y;
  }

  double reduce(int value) {
    double y;
    if (value < 128) {
      y = value / 128;
    } else {
      y = (value - 256) / 128;
    }
    return y;
  }

  Future<void> stopRecorder() async {
    await _mRecorder!.stopRecorder();
    // _writeFileToStorage();
    if (_mRecordingDataSubscription != null) {
      await _mRecordingDataSubscription!.cancel();
      _mRecordingDataSubscription = null;
    }
    _mplaybackReady = true;
  }

  Fn? getRecorderFn() {
    if (!_mRecorderIsInited || !_mPlayer2!.isStopped) {
      return null;
    }
    return _mRecorder!.isStopped
        ? record
        : () {
            stopRecorder().then((value) => setState(() {}));
          };
  }

  void play() async {
    assert(_mPlayerIsInited &&
        _mPlayerIsInited2 &&
        _mplaybackReady &&
        _mRecorder!.isStopped &&
        _mPlayer2!.isStopped);
    await _mPlayer!.startPlayer(
        fromURI: _mPath,
        sampleRate: tSampleRate,
        codec: Codec.pcm16,
        numChannels: 1,
        whenFinished: () {
          setState(() {});
        }); // The readability of Dart is very special :-(
    setState(() {});
  }

  Future<void> stopPlayer2() async {
    await _mPlayer2!.stopPlayer();
  }

  Fn? getPlaybackFn2() {
    if (!_mPlayerIsInited ||
        !_mPlayerIsInited2 ||
        !_mplaybackReady ||
        !_mRecorder!.isStopped) {
      return null;
    }
    return _mPlayer2!.isStopped
        ? play
        : () {
            stopPlayer2().then((value) => setState(() {}));
          };
  }

  Future<IOSink> createFile2() async {
    var tempDir = await getTemporaryDirectory();
    _mPath = '${tempDir.path}/${DateTime.now().toString()}.pcm';
    var outputFile = File(_mPath!);
    if (outputFile.existsSync()) {
      await outputFile.delete(); // sent file to local storage
    }
    return outputFile.openWrite();
  }

  void startPlayer() async {
    HomePageCubit homePageCubit = BlocProvider.of<HomePageCubit>(context);
    assert(_mRecorderIsInited && _mPlayer2!.isStopped || _mPlayer!.isPlaying);
    await _mPlayer!.startPlayerFromStream(
      codec: Codec.pcm16,
      numChannels: 1,
      sampleRate: tSampleRate,
    );
    var sink = await createFile2();
    var recordingDataController = StreamController<Food>();
    _mRecordingDataSubscription =
        recordingDataController.stream.listen((buffer) async {
      if (buffer is FoodData) {
        print('Input data uint8 type: ${buffer.data!}');
        List<double> beforedataLeft = [];
        List<double> beforedataRight = [];
        for (var i = 0; i < buffer.data!.length; i += 2) {
          beforedataLeft.add(
              (reduce(buffer.data![i]) / homePageCubit.state.maxGain!.floor()));
          beforedataRight.add((reduce(buffer.data![i + 1]) /
              homePageCubit.state.maxGain!.floor()));
        }
        List<num> data = await homePageCubit.generateSampleRate(
            beforedataLeft, beforedataLeft.length);
        List<num> data2 = await homePageCubit.generateSampleRate(
            beforedataRight, beforedataRight.length);
        List<int> afterdataLeft = [];
        List<int> afterdataRight = [];
        for (var i = 2; i < data.length; i += 1) {
          afterdataLeft.add(scaling(data[i]));
          afterdataRight.add(scaling(data2[i]));
        }
        List<int> afterdata0 = adding(afterdataLeft, afterdataRight);
        Uint8List afterdata2 = Uint8List.fromList(afterdata0);
        print('Output data uint8 type: ${afterdata2}');
        sink.add(afterdata2); // xUint8 type
        _mPlayer!.feedFromStream(afterdata2.sublist(0, afterdata2.length));
      }
    });
    print('Recording...');
    await _mRecorder!.startRecorder(
      toStream: recordingDataController.sink,
      codec: Codec.pcm16,
      numChannels: 1,
      sampleRate: tSampleRate,
      //toFile: '$fileName',
    );
    setState(() {});
  }


  Future<void> stopPlayer() async {
    if (_mRecorder != null) {
      await _mRecorder!.stopRecorder();
    }
    if (_mPlayer != null) {
      await _mPlayer!.stopPlayer();
    }
  }

  // ---------------------------------------

  Fn? getPlaybackFn() {
    if (!_mPlayerIsInited) {
      return null;
    }
    return _mPlayer!.isStopped
        ? startPlayer
        : () {
            stopPlayer().then((value) => setState(() {}));
          };
  }

  @override
  Widget build(BuildContext context) {
    HomePageCubit homePageCubit = BlocProvider.of<HomePageCubit>(context);
    return Scaffold(
      backgroundColor: blackground,
      body: Stack(
        children: [
          CustomAppBar(),
          Padding(
            padding: EdgeInsets.only(top: 100, left: 18),
            child: Container(width: 2, height: 54, color: light),
          ),
          Padding(
            padding: EdgeInsets.only(top: 100, left: 30),
            child: RichText(
              text: TextSpan(
                text:
                    'การทดสอบวันที่ ${homePageCubit.state.Date!.toDate().toString().split(' ')[0]}\n',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Prompt',
                  fontWeight: FontWeight.w600,
                  color: gray,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text:
                        '${homePageCubit.state.Date!.toDate().toString().split(' ')[1]}',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 230),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                "Before you begin, put on your headphones.",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w600,
                  color: _mPlayer!.isPlaying ? redtext : green,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 270),
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 185,
                height: 185,
                padding: EdgeInsets.only(top: 2),
                child: FloatingActionButton(
                  onPressed: getPlaybackFn(),
                  elevation: 5,
                  backgroundColor: _mPlayer!.isPlaying ? redtext : green,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          _mPlayer!.isPlaying ? "STOP" : "START",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold,
                            color: white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                        height: 5,
                      ),
                      Image.asset(
                        "assets/image/headphones.png",
                        scale: 2.05,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          "pressed here",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w600,
                            color: white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 480,
            left: 105,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                      fixedSize: const Size(180, 35),
                      textStyle: TextStyle(),
                      primary: Color.fromRGBO(240, 238, 233, 0.95),
                    ),
                    onPressed: getRecorderFn(),
                    child: Row(
                      children: [
                        Icon(
                          LineIcons.microphone,
                          color: redtext,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 22),
                          child: Text(
                            _mRecorder!.isRecording ? 'Stop' : 'Record',
                            style: TextStyle(
                              color: blackground,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Nunito',
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                      fixedSize: const Size(180, 35),
                      textStyle: TextStyle(),
                      primary: Color.fromRGBO(240, 238, 233, 0.95),
                    ),
                    onPressed: getPlaybackFn2(),
                    child: Row(
                      children: [
                        Icon(
                          _mPlayer!.isPlaying
                              ? LineIcons.pause
                              : LineIcons.play,
                          color: grayy,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 28),
                          child: Text(
                            _mPlayer!.isPlaying
                                ? 'Stop'
                                : 'Play' /*"Settings"*/,
                            style: TextStyle(
                              color: blackground,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Nunito',
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
