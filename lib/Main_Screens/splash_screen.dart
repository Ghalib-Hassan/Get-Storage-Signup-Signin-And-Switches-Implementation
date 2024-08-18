import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get_storage_signup_login/Main_Screens/both.dart';
import 'package:get_storage_signup_login/Main_Screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final database = GetStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('loading data...');
    loadData();
  }

  void loadData() {
    bool isLogin = database.read('isLogin') ?? false;
    print('is login - $isLogin');

    if (isLogin) {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      });
      print('if: $isLogin');
    } else {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const SignupSignin()));
      });
      print('else: $isLogin');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.red.shade300, Colors.black])),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: 50.h,
            ),
            const FaIcon(
              FontAwesomeIcons.dumbbell,
              size: 100,
            ),
            Text(
              'FITNESS CLUB',
              style: GoogleFonts.timmana(fontSize: 20.sp),
            ),
          ]))
    ]));
  }
}
