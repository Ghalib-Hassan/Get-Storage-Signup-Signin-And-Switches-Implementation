// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get_storage_signup_login/Main_Screens/both.dart';
import 'package:get_storage_signup_login/Main_Screens/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final database = GetStorage();

  String? name = '', email = '';
  bool notify = true;
  bool theme = true;
  bool recommendation = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadName();
    loadEmail();
    loadSettings();
  }

  void loadSettings() {
    setState(() {
      notify = database.read('notify');
      theme = database.read('theme');
      recommendation = database.read('recommendation');
    });
  }

  void loadName() {
    name = database.read('signupName');
  }

  void loadEmail() {
    email = database.read('signupEmail');
  }

  void notification(bool value) {
    setState(() {
      notify = value;
      database.write('notify', notify);
    });
  }

  void themeSwitch(bool value) {
    setState(() {
      theme = value;
      database.write('theme', theme);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Your Profile',
          style: GoogleFonts.acme(textStyle: TextStyle(color: Colors.red)),
        ),
        centerTitle: true,
        backgroundColor: theme ? Colors.black : Colors.white,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: theme ? Colors.white : Colors.black),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      body: Stack(children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.red.shade300, Colors.black],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image(
                          image: const NetworkImage(
                              'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
                          height: 60.h,
                          width: 40.w,
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        )),
                    SizedBox(
                      width: 5.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name.toString(),
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          email.toString(),
                          style: TextStyle(
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 200.h,
                ),
                SizedBox(
                  width: 230.w,
                  child: ElevatedButton(
                    onPressed: () async {
                      bool isLogout = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                'Logout',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              content: Text(
                                'Do you really want to logout?',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10.sp),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: const Text('Cancel')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                    child: const Text('Ok'))
                              ],
                            );
                          });

                      if (isLogout) {
                        database.remove('signupName');
                        database.remove('signupEmail');
                        database.remove('signupPassword');
                        database.remove('signupConfirm');
                        database.remove('isLogin');
                        database.remove('notify');
                        database.remove('theme');
                        database.remove('recommendation');

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupSignin()));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Colors.red.shade300, Colors.black],
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        constraints: BoxConstraints(
                          minHeight: 40.h,
                        ),
                        child: Text(
                          'Log Out',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
      drawer: Drawer(
        backgroundColor: theme ? Colors.black : Colors.white,
        width: 300,
        child: ListView(children: [
          const Align(
            alignment: Alignment.topCenter,
            child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                    'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2')),
          ),
          SizedBox(
            height: 13.h,
          ),
          Center(
              child: Text(
            name.toString().toUpperCase(),
            style:
                GoogleFonts.arbutus(color: theme ? Colors.white : Colors.black),
          )),
          SizedBox(
            height: 8.h,
          ),
          Divider(
            height: 2.h,
          ),
          SizedBox(
            height: 8.h,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Settings',
              style: GoogleFonts.aboreto(
                  color: theme ? Colors.white : Colors.black, fontSize: 20.sp),
            ),
          ),
          ListTile(
            leading: Text(
              'Notifications',
              style: GoogleFonts.abrilFatface(
                  color: theme ? Colors.white : Colors.black),
            ),
            trailing: Switch(
              value: notify,
              onChanged: notification,
            ),
          ),
          ListTile(
            leading: Text('Dark Mode',
                style: GoogleFonts.abrilFatface(
                    color: theme ? Colors.white : Colors.black)),
            trailing: Switch(
              value: theme,
              onChanged: themeSwitch,
            ),
          ),
          ListTile(
            leading: Text('Recommendations',
                style: GoogleFonts.abrilFatface(
                    color: theme ? Colors.white : Colors.black)),
            trailing: Switch(
              value: recommendation,
              onChanged: (bool newValue) {
                setState(() {
                  recommendation = newValue;
                  database.write('recommendation', recommendation);
                });
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SplashScreen()));
            },
            child: Text('Go to Splash Screen',
                style: GoogleFonts.abrilFatface(
                    color: theme ? Colors.white : Colors.black)),
          )
        ]),
      ),
    );
  }
}
