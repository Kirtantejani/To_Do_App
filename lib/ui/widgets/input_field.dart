import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/ui/Theme.dart';

class MyInputField extends StatefulWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  const MyInputField(
      {Key? key,
      required this.title,
      required this.hint,
      this.controller,
      this.widget})
      : super(key: key);

  @override
  State<MyInputField> createState() => _MyInputFieldState();
}

class _MyInputFieldState extends State<MyInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: titleStyle,
          ),
          Container(
            height: 40,
            margin: EdgeInsets.only(
              top: 10.0,
            ),
            padding: EdgeInsets.only(
              left: 14,
            ),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: widget.controller,
                    readOnly: widget.widget == null ? false : true,
                    autofocus: false,
                    cursorColor:
                        Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                    style: subTitleStyle,
                    decoration: InputDecoration(
                        hintText: widget.hint,
                        hintStyle: subHeadingStyle,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: context.theme.backgroundColor,
                                width: 0)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: context.theme.backgroundColor,
                                width: 0))),
                  ),
                ),
                widget.widget == null
                    ? Container()
                    : Container(child: widget.widget)
              ],
            ),
          )
        ],
      ),
    );
  }
}
