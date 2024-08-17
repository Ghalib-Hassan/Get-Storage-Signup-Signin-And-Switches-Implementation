import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get_storage_signup_login/Main_Screens/Custom_Widget/password_field.dart';
import 'package:get_storage_signup_login/Main_Screens/Custom_Widget/text_field.dart';
import 'package:get_storage_signup_login/Main_Screens/both.dart';
import 'package:get_storage_signup_login/Main_Screens/signin.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final database = GetStorage();

  TextEditingController signupEmail = TextEditingController();
  TextEditingController signupPassword = TextEditingController();
  TextEditingController signupConfirm = TextEditingController();
  TextEditingController signup_Name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 50),
              child: Text(
                'Create Your \nAccount',
                style: TextStyle(fontSize: 20.sp),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GeneralTextField(
                          generalcontroller: signup_Name,
                          labelText: 'Full Name'),
                      SizedBox(height: 10.h),
                      GeneralTextField(
                        generalcontroller: signupEmail,
                        labelText: 'Phone or Gmail',
                      ),
                      SizedBox(height: 10.h),
                      PasswordField(
                        passwwordControllers: signupPassword,
                        labelText: 'Password',
                      ),
                      SizedBox(height: 10.h),
                      PasswordField(
                        passwwordControllers: signupConfirm,
                        labelText: 'Confirm Password',
                      ),
                      SizedBox(height: 50.h),
                      SizedBox(
                        width: 230.w,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (signupPassword.text == signupConfirm.text) {
                              if (signupEmail.text.isEmpty ||
                                  signupEmail.text == 'null' ||
                                  signupPassword.text.isEmpty ||
                                  signupPassword.text == 'null' ||
                                  signupConfirm.text.isEmpty ||
                                  signupConfirm.text == 'null') {
                                final snackBar = SnackBar(
                                  elevation: 0,
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  content: AwesomeSnackbarContent(
                                    title: 'Error!',
                                    message: 'Plz Fill all the sections',
                                    contentType: ContentType.failure,
                                  ),
                                );

                                //     // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(snackBar);
                              } else {
                                String signupName = signup_Name.text.isEmpty
                                    ? 'Anonymous'
                                    : signup_Name.text;
                                database.write('signupName', signupName);
                                database.write('signupEmail', signupEmail.text);
                                database.write(
                                    'signupPassword', signupPassword.text);
                                database.write('signupConfirm', signupConfirm);
                                database.write('isLogin', true);

                                Navigator.push(
                                  // ignore: use_build_context_synchronously
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignupSignin(),
                                  ),
                                );
                              }
                            } else {
                              final snackBar = SnackBar(
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Error!',
                                  message:
                                      'Password and Confirm Password do not match!',
                                  contentType: ContentType.failure,
                                ),
                              );

                              //   // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
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
                                'SIGN UP',
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
                      SizedBox(height: 80.h),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Already have an account?',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.black,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignIn()));
                                  },
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
