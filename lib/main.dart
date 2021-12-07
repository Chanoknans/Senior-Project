import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hearing_aid/bloc/application_cubit.dart';
import 'package:hearing_aid/bloc/home_page_cubit.dart';
import 'package:hearing_aid/page/landing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appCubit = ApplicationCubit();
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: appCubit),
        BlocProvider<HomePageCubit>(
          create: (_) => HomePageCubit(appCubit),
        ),
      ],
      child: MaterialApp(
        title: 'Hearing Test',
        debugShowCheckedModeBanner: false,
        home: LandingPage(),
      ),
    );
  }
}
