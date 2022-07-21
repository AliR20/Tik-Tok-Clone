import 'package:flutter/material.dart';
import 'package:tiktok_clone/const.dart';

class CustomTextInputField extends StatelessWidget {
  const CustomTextInputField({Key? key, required this.controller, required this.labelText, required this.icon, this.isObscure = false}) : super(key: key);
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final bool isObscure;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        labelStyle: const TextStyle(
          fontSize: 20,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            5,
          ),
          borderSide: const BorderSide(
            color: borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: borderColor,
          ),
        ),
        
      ),
      obscureText: isObscure,
    );
  }
}
