import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/resuable/resuable_widget.dart';
import 'package:todolist/ui/Theme.dart';

class signUp extends StatefulWidget {
  const signUp({Key? key}) : super(key: key);

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _phoneNumerTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Sign up",
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Get.isDarkMode ? Colors.white70 : darkGreyClr),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: Get.isDarkMode ? Colors.white70 : darkGreyClr,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.1, 20, 0),
            child: Column(
              children: <Widget>[
                Image.asset(
                  height: MediaQuery.of(context).size.height * 0.20,
                  width: MediaQuery.of(context).size.width * 0.75,
                  "assets/image/todo.png",
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(
                  height: 20,
                ),
                resuableTextfield(
                    "Enter UserName",
                    Icons.account_circle_outlined,
                    false,
                    _userNameTextController),
                SizedBox(
                  height: 20,
                ),
                resuableTextfield("Enter Email", Icons.email_outlined, false,
                    _emailTextController),
                SizedBox(
                  height: 20,
                ),
                resuableTextfield("Enter Phone Number", Icons.phone, false,
                    _phoneNumerTextController),
                SizedBox(
                  height: 20,
                ),
                resuableTextfield("Enter Password", Icons.lock_outline, true,
                    _passwordTextController),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => _validateDate(),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color:
                                Get.isDarkMode ? Colors.white70 : darkGreyClr)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color:
                                Get.isDarkMode ? Colors.white70 : darkGreyClr,
                            fontSize: 16,
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
      ),
    );
  }

  _validateDate() {
    if (_passwordTextController.text.isNotEmpty &&
        _emailTextController.text.isNotEmpty &&
        _userNameTextController.text.isNotEmpty &&
        _phoneNumerTextController.text.isNotEmpty) {
      Get.back();
    } else if (_passwordTextController.text.isEmpty ||
        _emailTextController.text.isEmpty ||
        _userNameTextController.text.isEmpty ||
        _phoneNumerTextController.text.isEmpty) {
      Get.snackbar(
        "Required",
        "All fields are requied!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.isDarkMode ? darkGreyClr : Colors.white70,
        colorText: Get.isDarkMode ? pinkClr : pinkClr,
        icon: Icon(
          Icons.warning_amber_outlined,
          color: Colors.red,
        ),
      );
    }
  }
}
