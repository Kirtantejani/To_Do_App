import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/home_page.dart';
import 'package:todolist/ui/Theme.dart';
import 'package:url_launcher/url_launcher_string.dart';

class feedBack extends StatefulWidget {
  const feedBack({Key? key}) : super(key: key);

  @override
  State<feedBack> createState() => _feedBackState();
}

class _feedBackState extends State<feedBack> {
  TextEditingController controllerFrom = TextEditingController();
  TextEditingController controllerSubject = TextEditingController();
  TextEditingController controllerMessage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FeedBack'),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => App()));
          },
          child: Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 8,
              ),
              Text(
                "Subject",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Get.isDarkMode ? Colors.white70 : primaryClr),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                        color: Get.isDarkMode ? darkHeaderClr : primaryClr)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 2, right: 8.0),
                  child: TextField(
                    controller: controllerSubject,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Enter Subject'),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Message",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Get.isDarkMode ? Colors.white70 : primaryClr),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                        color: Get.isDarkMode ? darkHeaderClr : primaryClr)),
                child: TextField(
                  maxLines: 10,
                  controller: controllerMessage,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter Message',
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: () => launchEmail(
                  subject: controllerSubject.text,
                  message: controllerMessage.text,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  height: 35,
                  child: Center(
                      child: Text(
                    'Send',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Get.isDarkMode ? Colors.white70 : primaryClr),
                  )),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                          color: Get.isDarkMode ? darkHeaderClr : primaryClr)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future launchEmail({required String subject, required String message}) async {
    final url =
        'mailto:tejanimit1@gmail.com?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(message)}';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    }
  }
}
