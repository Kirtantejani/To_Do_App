import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ui/Theme.dart';

Image logoWidget(String imagename) {
  return Image.asset(
      imagename,
      fit: BoxFit.fitWidth,
      width: 240,
      height: 240,
      color: Colors.white,
      );
}

TextField resuableTextfield(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(
      color: Get.isDarkMode ? Colors.white : darkGreyClr,
    ),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Get.isDarkMode ? Colors.white70 : darkGreyClr,
      ),
      labelText: text,
      labelStyle: TextStyle(
        color: Get.isDarkMode ? Colors.white : darkGreyClr,
      ),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}
