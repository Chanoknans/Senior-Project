import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hearing_aid/bloc/home_page_cubit.dart';
import 'package:hearing_aid/constant.dart';

class HearingTestSlider extends StatelessWidget {
  final List<QueryDocumentSnapshot> data;

  const HearingTestSlider({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomePageCubit homePageCubit = BlocProvider.of<HomePageCubit>(context);
    return Swiper(
      autoplay: false,
      loop: true,
      itemBuilder: (BuildContext context, int index) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.all(8.0),
            key: Key(data[index].id),
            width: 150,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: white,
            ),
            child: RichText(
              text: TextSpan(
                text: 'การทดสอบวันที่: '
                    '${data[index]["created_date"].toDate()}\n',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Prompt',
                  fontWeight: FontWeight.bold,
                  color: blackground,
                ),
              ),
            ),
          ),
        );
      },
      itemCount: data.length,
      viewportFraction: 0.4,
      scale: 0.5,
      onIndexChanged: (index) => homePageCubit.getHearingResult(data[index].id),
      pagination: SwiperPagination(
        margin: EdgeInsets.only(top: 120),
        builder: const DotSwiperPaginationBuilder(
          activeColor: yellow,
          size: 6.0,
          activeSize: 10.0,
          space: 5,
        ),
      ),
    );
  }
}
