import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordField extends StatefulWidget {
  final String labelText;
  final TextEditingController? passwwordControllers;

  const PasswordField(
      {super.key, required this.labelText, this.passwwordControllers});

  @override
  // ignore: library_private_types_in_public_api
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: widget.passwwordControllers,
        style: TextStyle(color: Colors.black, fontSize: 12.sp),
        obscureText: _obscureText,
        decoration: InputDecoration(
          fillColor: Colors.grey.withOpacity(.3),
          filled: true,
          labelText: widget.labelText,
          labelStyle: TextStyle(fontSize: 10.sp),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
            ),
            onPressed: _toggleVisibility,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(const Radius.circular(5).w),
          ),
        ),
      ),
    );
  }
}
