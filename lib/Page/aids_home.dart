import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hearing_aid/page/components/custom_app_bar.dart';
import 'package:hearing_aid/constant.dart';
import 'package:hearing_aid/page/components/bottom_app_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';

const int tSampleRate = 44100;
const int tBlockSize = 4096;
typedef Fn = void Function();

class HearingAidss extends StatefulWidget {
  HearingAidss({Key? key}) : super(key: key);

  @override
  _HearingAidssState createState() => _HearingAidssState();
}

class _HearingAidssState extends State<HearingAidss> {
  bool started = false;
  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  bool _mPlayerIsInited = false;

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
    setState(() {
      _mPlayerIsInited = true;
    });
  }

  //@override
  void initState() {
    super.initState();
    open();
  }

  //@override
  void dispose() {
    stopPlayer();
    // Be careful : you must `close` the audio session when you have finished with it.
    _mPlayer!.closeAudioSession();
    _mPlayer = null;

    super.dispose();
  }

  // -------  Here is the code to play from the microphone -----------------------

  void play() async {
    await _mPlayer!.startPlayerFromMic(sampleRate: 44000);
    setState(() {});
  }

  Future<void> stopPlayer() async {
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
        ? play
        : () {
            stopPlayer().then((value) => setState(() {}));
          };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackground,
      body: Stack(
        children: [
          CustomAppBar(),
          Padding(
            padding: EdgeInsets.only(top: 145, left: 18),
            child: Container(
              height: 40,
              width: 300,
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
            padding: EdgeInsets.only(top: 135, left: 330),
            child: CircleButton(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 200, left: 18),
            child: Container(width: 2, height: 54, color: light),
          ),
          Padding(
            padding: EdgeInsets.only(top: 200, left: 30),
            child: RichText(
              text: TextSpan(
                text: 'การทดสอบวันที่ 2-11-2021\n',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Prompt',
                  fontWeight: FontWeight.w600,
                  color: gray,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '00:36:21224236',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 280),
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
            padding: EdgeInsets.only(top: 320),
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
                      SizedBox(height: 5),
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
            top: 530,
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
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(
                          LineIcons.microphone,
                          color: redtext,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 22),
                          child: Text(
                            "Recording",
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
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(
                          LineIcons.cog,
                          color: grayy,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 28),
                          child: Text(
                            "Settings",
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
