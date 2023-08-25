import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/Signup.dart';
import 'package:todolist/resuable/resuable_widget.dart';
import 'package:todolist/ui/Theme.dart';

import 'home_page.dart';

class signIn extends StatefulWidget {
  const signIn({Key? key}) : super(key: key);

  @override
  State<signIn> createState() => _signInState();
}

class _signInState extends State<signIn> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Sign In",
          style: TextStyle(
            color: Get.isDarkMode ? Colors.white70 : darkGreyClr,
            fontWeight: FontWeight.bold,
            fontSize: 30,
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
              children: [
                Image.asset(
                  height: MediaQuery.of(context).size.height * 0.20,
                  width: MediaQuery.of(context).size.width * 0.75,
                  "assets/image/todo.png",
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(
                  height: 30,
                ),
                resuableTextfield("Enter Username", Icons.person_outline, false,
                    _emailTextController),
                SizedBox(
                  height: 20.0,
                ),
                resuableTextfield("Enter Password", Icons.lock_outline, true,
                    _passwordTextController),
                SizedBox(
                  height: 20.0,
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
                          "Login",
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
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have account?",
                        style: TextStyle(
                          color: Get.isDarkMode ? Colors.white70 : darkGreyClr,
                        )),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context as BuildContext,
                            MaterialPageRoute(builder: (context) => signUp()));
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color:
                                Get.isDarkMode ? Colors.white70 : darkGreyClr,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _validateDate() {
    if (_passwordTextController.text.isNotEmpty &&
        _emailTextController.text.isNotEmpty) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => App()));
    } else if (_passwordTextController.text.isEmpty ||
        _emailTextController.text.isEmpty) {
      Get.snackbar(
        "Required",
        "All fields are requied!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.isDarkMode ? darkGreyClr : Colors.white70,
        colorText: pinkClr,
        icon: Icon(
          Icons.warning_amber_outlined,
          color: Colors.red,
        ),
      );
    }
  }
}
