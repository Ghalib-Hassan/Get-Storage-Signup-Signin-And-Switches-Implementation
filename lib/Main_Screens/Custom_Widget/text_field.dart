// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GeneralTextField extends StatefulWidget {
  final String labelText;
  final TextEditingController? generalcontroller;

  const GeneralTextField(
      {super.key, required this.labelText, this.generalcontroller});

  @override
  _GeneralTextFieldState createState() => _GeneralTextFieldState();
}

class _GeneralTextFieldState extends State<GeneralTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        controller: widget.generalcontroller,
        style: TextStyle(color: Colors.black, fontSize: 12.sp),
        decoration: InputDecoration(
          fillColor: Colors.grey.withOpacity(.3),
          filled: true,
          labelText: widget.labelText,
          labelStyle: TextStyle(fontSize: 10.sp),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(const Radius.circular(5).w),
          ),
        ),
      ),
    );
  }
}
