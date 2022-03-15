import 'package:flutter/material.dart';
import 'package:hearing_aid/page/components/bottom_app_bar.dart';
import 'package:hearing_aid/constant.dart';
import 'package:hearing_aid/fade_route.dart';
import 'package:line_icons/line_icons.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: blackground,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.push(
            context,
            FadeRoute(
              page: Dashboard(),
            ),
          );
        },
        icon: Icon(
          LineIcons.times,
          color: light,
        ),
      ),
      title: Text(
        "Hearing Aids",
        style: TextStyle(
          color: light,
          fontSize: 20,
          fontFamily: 'Nunito',
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        IconButton(
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
                                    fontFamily: 'Nunito',
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
                                    fontFamily: 'Nunito',
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
                                    fontFamily: 'Nunito',
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
                                    fontFamily: 'Nunito',
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
          icon: Icon(
            Icons.info_outline_rounded,
            color: light,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120.0);
}
