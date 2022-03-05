import 'dart:async';
import 'dart:typed_data';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/public/util/wave_header.dart';
import 'package:hearing_aid/bloc/home_page_cubit.dart';

/*
 *
 * This is a very simple example for Flutter Sound beginners,
 * that show how to record, and then playback a file.
 *
 * This example is really basic.
 *
 */

final _exampleAudioFilePathMP3 =
    'https://file-examples-com.github.io/uploads/2017/11/file_example_MP3_700KB.mp3';

///
typedef Fn = void Function();

/// Example app.
class MultiPlayback extends StatefulWidget {
  MultiPlayback({Key? key}) : super(key: key);
  @override
  _MultiPlaybackState createState() => _MultiPlaybackState();
}

class _MultiPlaybackState extends State<MultiPlayback> {
  FlutterSoundPlayer? _mPlayer1 = FlutterSoundPlayer();
  FlutterSoundPlayer? _mPlayer2 = FlutterSoundPlayer();
  FlutterSoundPlayer? _mPlayer3 = FlutterSoundPlayer();
  bool _mPlayer1IsInited = false;
  bool _mPlayer2IsInited = false;
  bool _mPlayer3IsInited = false;
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;
  Uint8List? buffer2;
  Uint8List? buffer3;
  String _playerTxt1 = '';
  String _playerTxt2 = '';
  String _playerTxt3 = '';
  StreamSubscription? _playerSubscription1;
  StreamSubscription? _playerSubscription2;
  StreamSubscription? _playerSubscription3;
  String? _mPath;
  StreamSubscription? _mRecordingDataSubscription;
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();

  Future<Uint8List> _getAssetData(String path) async {
    var asset = await rootBundle.load(path);
    return asset.buffer.asUint8List();
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    _getAssetData(
      'assets/sound/2022-02-28 13_22_16.961722.pcm',
    ).then((value) => setState(() {
          buffer2 = value;
        }));
    _getAssetData(
      'assets/sound/2022-02-23 14_32_15.411270_01.wav',
    ).then((value) => setState(() {
          buffer3 = value;
        }));
    _mPlayer1!.openAudioSession().then((value) {
      setState(() {
        _mPlayer1IsInited = true;
      });
    });
    _mPlayer2!.openAudioSession().then((value) {
      setState(() {
        _mPlayer2IsInited = true;
      });
    });
    _mPlayer3!.openAudioSession().then((value) {
      setState(() {
        _mPlayer3IsInited = true;
      });
    });
  }

  @override
  void dispose() {
    // Be careful : you must `close` the audio session when you have finished with it.
    cancelPlayerSubscriptions1();
    _mPlayer1!.closeAudioSession();
    _mPlayer1 = null;
    cancelPlayerSubscriptions2();
    _mPlayer2!.closeAudioSession();
    _mPlayer2 = null;
    cancelPlayerSubscriptions3();
    _mPlayer3!.closeAudioSession();
    _mPlayer3 = null;

    super.dispose();
  }

  // ------- Create File Path for Filtering---------------------

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

  Future<IOSink> createFile() async {
    var tempDir = await getExternalStorageDirectory();
    var testdir =
        await Directory('${tempDir!.path}/filter').create(recursive: true);
    _mPath = '${testdir.path}/${DateTime.now().toString()}.pcm';
    print(_mPath);
    var outputFile = File(_mPath!);
    // Uint8List bytes = await outputFile.readAsBytes();
    // await outputFile.writeAsBytes(bytes);
    if (outputFile.existsSync()) {
      await outputFile.delete(); // sent file to local storage
    }
    return outputFile.openWrite();
  }

  Future<void> record() async {
    HomePageCubit homePageCubit = BlocProvider.of<HomePageCubit>(context);
    assert(_mPlayer2!.isStopped || _mPlayer2!.isPlaying);
    var sink = await createFile();
    var recordingDataController = StreamController<Food>();
    _mRecordingDataSubscription =
        recordingDataController.stream.listen((buffer) async {
      if (buffer is FoodData) {
        print('double: ${buffer.data!}');
        List<double> beforedata = [
          for (var offset = 0; offset < buffer.data!.length; offset += 1)
            (reduce(buffer.data![offset])),
        ];
        List<int> beforedata2 = [
          for (var offset = 0; offset < buffer.data!.length; offset += 1)
            buffer.data![offset] = 255,
        ];
        print('before data to double: ${beforedata}');
        List<num> data = homePageCubit.conv(beforedata, beforedata.length);
        // List<num> data2 = await data; //float type
        print('after filter is double: ${data}');
        List<int> afterdata = [
          for (var offset = 2; offset < data.length; offset += 1)
            scaling(data[offset]),
        ];
        Uint8List afterdata2 = Uint8List.fromList(beforedata2);
        print('after filter is Uint8List: ${afterdata2}');

         // xUint8 type
      }
      sink.add(buffer3!);
    });
    print('Recording...');
    await _mPlayer3!.setSubscriptionDuration(Duration(milliseconds: 10));
    _addListener3();
    await _mRecorder!.startRecorder(
        toStream: recordingDataController.sink,
        codec: Codec.pcm16,
        sampleRate: 44100,
        numChannels: 1,
        //toFile: '$fileName',
        );
    setState(() {});
  }

  int scaling(num value) {
    int y;
    if (value >= 0) {
      y = (value * 127).round();
    } else {
      y = ((value * 127) + 255).round();
    }
    return y;
  }

  double reduce(int value) {
    double y;
    if (value < 128) {
      y = ((value).round() / 127);
    } else {
      y = (((value).round()) - 255) / 127;
    }
    return y;
  }

  // -------  Player1 play a remote file -----------------------

  void play1() async {
    await _mPlayer1!.setSubscriptionDuration(Duration(milliseconds: 10));
    _addListener1();
    await _mPlayer1!.startPlayer(
        fromURI: _exampleAudioFilePathMP3,
        codec: Codec.mp3,
        whenFinished: () {
          setState(() {});
        });
    setState(() {});
  }

  void cancelPlayerSubscriptions1() {
    if (_playerSubscription1 != null) {
      _playerSubscription1!.cancel();
      _playerSubscription1 = null;
    }
  }

  Future<void> stopPlayer1() async {
    cancelPlayerSubscriptions1();
    if (_mPlayer1 != null) {
      await _mPlayer1!.stopPlayer();
    }
    setState(() {});
  }

  Future<void> pause1() async {
    if (_mPlayer1 != null) {
      await _mPlayer1!.pausePlayer();
    }
    setState(() {});
  }

  Future<void> resume1() async {
    if (_mPlayer1 != null) {
      await _mPlayer1!.resumePlayer();
    }
    setState(() {});
  }

  // -------  Player2 play a PCM file -----------------------

  void play2() async {
    await _mPlayer2!.setSubscriptionDuration(Duration(milliseconds: 10));
    _addListener2();
    await _mPlayer2!.startPlayer(
        fromDataBuffer: buffer2,
        sampleRate: 44100,
        codec: Codec.pcm16,
        whenFinished: () {
          setState(() {});
          print('my fonmeen value ${buffer2!.getRange(30000,300000)} !!!!!!!!!');
        });
    setState(() {});
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

  // -------  Player3 play a MP4 file -----------------------

  void play3() async {
    await _mPlayer3!.setSubscriptionDuration(Duration(milliseconds: 10));
    _addListener3();
    await _mPlayer3!.startPlayer(
        fromDataBuffer: buffer3,
        codec: Codec.aacMP4,
        whenFinished: () {
          setState(() {});
          print('my fonmeen value ${buffer3!.buffer.asUint8List()} !!!!!!!!!');
        });
    setState(() {});
  }

  void cancelPlayerSubscriptions3() {
    if (_playerSubscription3 != null) {
      _playerSubscription3!.cancel();
      _playerSubscription3 = null;
    }
  }

  Future<void> stopPlayer3() async {
    cancelPlayerSubscriptions3();
    if (_mPlayer3 != null) {
      await _mPlayer3!.stopPlayer();
    }
    setState(() {});
  }

  Future<void> pause3() async {
    if (_mPlayer3 != null) {
      await _mPlayer3!.pausePlayer();
    }
    setState(() {});
  }

  Future<void> resume3() async {
    if (_mPlayer3 != null) {
      await _mPlayer3!.resumePlayer();
    }
    setState(() {});
  }

  // ------------------------------------------------------------------------------------

  void _addListener1() {
    cancelPlayerSubscriptions1();
    _playerSubscription1 = _mPlayer1!.onProgress!.listen((e) {
      var date = DateTime.fromMillisecondsSinceEpoch(e.position.inMilliseconds,
          isUtc: true);
      var txt = DateFormat('mm:ss:SS', 'en_GB').format(date);
      setState(() {
        _playerTxt1 = txt.substring(0, 8);
      });
    });
  }

  Fn? getPlaybackFn1() {
    if (!_mPlayer1IsInited) {
      return null;
    }
    return _mPlayer1!.isStopped
        ? play1
        : () {
            stopPlayer1().then((value) => setState(() {}));
          };
  }

  Fn? getPauseResumeFn1() {
    if (!_mPlayer1IsInited || _mPlayer1!.isStopped) {
      return null;
    }
    return _mPlayer1!.isPaused ? resume1 : pause1;
  }

  void _addListener2() {
    cancelPlayerSubscriptions2();
    _playerSubscription2 = _mPlayer2!.onProgress!.listen((e) {
      var date = DateTime.fromMillisecondsSinceEpoch(e.position.inMilliseconds,
          isUtc: true);
      var txt = DateFormat('mm:ss:SS', 'en_GB').format(date);
      setState(() {
        _playerTxt2 = txt.substring(0, 8);
      });
    });
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

  Fn? getPlaybackFn2() {
    if (!_mRecorderIsInited || !_mPlayer2!.isStopped) {
      return null;
    }
    return _mRecorder!.isStopped
        ? record
        : () {
            stopRecorder().then((value) => setState(() {}));
          };
  }

  Fn? getPauseResumeFn2() {
    if (!_mPlayer2IsInited || _mPlayer2!.isStopped || buffer2 == null) {
      return null;
    }
    return _mPlayer2!.isPaused ? resume2 : pause2;
  }

  void _addListener3() {
    cancelPlayerSubscriptions3();
    _playerSubscription3 = _mPlayer3!.onProgress!.listen((e) {
      var date = DateTime.fromMillisecondsSinceEpoch(e.position.inMilliseconds,
          isUtc: true);
      var txt = DateFormat('mm:ss:SS', 'en_GB').format(date);
      setState(() {
        _playerTxt3 = txt.substring(0, 8);
      });
    });
  }

  Fn? getPlaybackFn3() {
    if (!_mPlayer3IsInited || buffer3 == null) {
      return null;
    }
    return _mPlayer3!.isStopped
        ? play3
        : () {
            stopPlayer3().then((value) => setState(() {}));
          };
  }

  Fn? getPauseResumeFn3() {
    if (!_mPlayer3IsInited || _mPlayer3!.isStopped || buffer3 == null) {
      return null;
    }
    return _mPlayer3!.isPaused ? resume3 : pause3;
  }

  @override
  Widget build(BuildContext context) {
    Widget makeBody() {
      return Column(
        children: [
          Container(
            margin: const EdgeInsets.all(3),
            padding: const EdgeInsets.all(3),
            height: 80,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xFFFAF0E6),
              border: Border.all(
                color: Colors.indigo,
                width: 3,
              ),
            ),
            child: Row(children: [
              ElevatedButton(
                onPressed: getPlaybackFn1(),
                //color: Colors.white,
                //disabledColor: Colors.grey,
                child: Text(_mPlayer1!.isStopped ? 'Play' : 'Stop'),
              ),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: getPauseResumeFn1(),
                //color: Colors.white,
                //disabledColor: Colors.grey,
                child: Text(_mPlayer1!.isPaused ? 'Resume' : 'Pause'),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                _playerTxt1,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ]),
          ),
          Container(
            margin: const EdgeInsets.all(3),
            padding: const EdgeInsets.all(3),
            height: 80,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xFFFAF0E6),
              border: Border.all(
                color: Colors.indigo,
                width: 3,
              ),
            ),
            child: Row(children: [
              ElevatedButton(
                onPressed: getPlaybackFn2(),
                //color: Colors.white,
                //disabledColor: Colors.grey,
                child: Text(_mPlayer2!.isStopped ? 'Play' : 'Stop'),
              ),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: getPauseResumeFn2(),
                //color: Colors.white,
                //disabledColor: Colors.grey,
                child: Text(_mPlayer2!.isPaused ? 'Resume' : 'Pause'),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                _playerTxt2,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ]),
          ),
          Container(
            margin: const EdgeInsets.all(3),
            padding: const EdgeInsets.all(3),
            height: 80,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xFFFAF0E6),
              border: Border.all(
                color: Colors.indigo,
                width: 3,
              ),
            ),
            child: Row(children: [
              ElevatedButton(
                onPressed: getPlaybackFn3(),
                //color: Colors.white,
                //disabledColor: Colors.grey,
                child: Text(_mPlayer3!.isStopped ? 'Play' : 'Stop'),
              ),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: getPauseResumeFn3(),
                //color: Colors.white,
                //disabledColor: Colors.grey,
                child: Text(_mPlayer3!.isPaused ? 'Resume' : 'Pause'),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                _playerTxt3,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ]),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('Multi Playback'),
      ),
      body: makeBody(),
    );
  }
}
