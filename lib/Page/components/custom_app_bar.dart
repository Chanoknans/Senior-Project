import 'package:flutter/material.dart';
import 'package:hearing_aid/page/bottom_app_bar.dart';
import 'package:hearing_aid/page/hearing_test_home.dart';
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
              page: BottomAppBarbar(),
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Page5();
                },
              ),
            );
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
