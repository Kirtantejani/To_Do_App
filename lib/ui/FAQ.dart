import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/ui/Theme.dart';

import '../home_page.dart';

class FAQ extends StatefulWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  int index = 0;

  List l1 = [
    "The phone cannot receive notification and reminders.",
    'There is no sound for task reminders . ',
    'After purchasing the PRO version , PRO functions are still not activated .',
    'If the phone is formatted or replaced , and then the PRO subscription is not activated anymore .',
    'Synchronize account information on different devices .',
    'How to import system calendar events ?',
    'How to add widgets ?',
    "How to resize a widget on an Android's home screen ?",
    'Other issues',
  ];
  List l2 = [
    'If you did not receive notifications , it may be because you did not give authority to receive notifications from the app . Please follow the steps below :                                                      ( App Settings > Notifications and Reminders > Task Reminder does not Work > Authorization )                                                    1. Click Settings in the sidebar ;                        2. Click Notifications and Reminders ;                       3. Click the first option Task reminder Does not Work ;                                                              4. Enable the 3 authority options .                                  If you still cannot receive notifications and reminders , please go to the phone system settings and authorize to receive notifications from the app .                                        ( Phone Settings > Apps and Reminders > To - do list > Notifications > Show notifications ) 1. Click the " Settings " of the mobile phone system ;                                                                       2. Click Apps and Reminders ;                                                   3. Click on this application ;                                           4. Click Notifications ;                                              5. Turn on Show notifications .',
    'Please check whether the sound of the mobile phone system is turned on .                  ( Settings > Sound > Alarm volume & Ring volume )                                                                 1. Click the settings from phone system ; ringtones ;                                                            2. Click Sound , the system gives a total of 4 3. If your task reminder type is Alarm , please turn on Alarm volume ; if your task reminder type is Reminder , please turn on Ring volume.',
    "This situation may be due to a delay in the synchronization of Google's purchase information , please be patient ! You can also try as the following :                                            1. Check the purchase status of the app on google play :                                                          2. Update google play ;                                           3. Exit and re - enter the app :                                        4. Change network , etc.                                                        If none of the above is valid , please check the purchase order number on google play . and send us the GPA number and payment screenshot .",
    'Please follow the steps below :                      ( Confirm the network > Login > Upgrade to Pro > Restore )                                                            1. Confirm that the network is in good condition ;                                                                  2. Log in to the account that has successfully purchased the PRO version ;                                       3. Click Upgrade to Pro in the sidebar ;          4. Click Restore ;                                                  5. Other operations that can be tried : update Google Play ; exit and re - enter the app : change network , etc.                                         If none of the above is valid , please check the purchase order number on Google Play . and send us the GPA number and payment screenshot .',
    'Please follow the steps below :                      ( Confirm the network > Login > Settings > Account sync > Sync records > Log in on another device )                                                    1. Confirm that the network is in good condition ;                                                             2. Login account ;                                                    3. Click Settings in the sidebar ;                              4. Click Account Sync ;                                           5. Click Sync record ;                                           6. Log in to the same account on another device , and you can see all history tasks at this time .',
    'Please follow the steps below :                      ( Settings > Import system calendar events > Switch button > Calendar sync )                      1. Click Settings in the sidebar ;                           2. Click Import System Calendar Events ;                                      3. Click the switch button ;                                 4. Click Calendar Sync .',
    'Please follow the steps below :                      ( Long press the home screen > Widgets > This app > Long press a widget and drag it ) 1. Long press the blank area of the home screen ( or slide in the middle with two fingers , pinch motion ) ;                                     2. Click on the Widgets that appear on the main interface ;                                                       3. Find this app :                                                    4. Long press a widget and drag it to the position you want .                                                If you cannot add it successfully , please try the following steps to add it :                ( Widget > Add > Automatically add )                1. Click Widget in the sidebar ;                          2. Click Add ;                                                                3. A pop - up window will display , then click Automatically add .',
    "1. For resizable widgets , press firmly on the widget on your home screen .                                2. A white box with circular adjustment markers will appear around the widget . Slide them in or out to make the widget smaller or larger , respectively .                                                      3. Once you're done , tap on a space outside the widget to complete the resize and lock it into place .",
    'If you have any other questions or suggestions , you can click Feedback and send us an email via todolist @ betterapptech .com , thank you !',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Frequently Asked Questions"),
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => App()));
            },
            child: Icon(Icons.arrow_back_rounded),
          ),
        ),
        body: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: l1.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildPlayerModelList(l1[index], l2[index]);
            }));
  }

  Widget _buildPlayerModelList(String text, String text1) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border:
                Border.all(color: Get.isDarkMode ? darkHeaderClr : primaryClr)),
        child: Card(
          child: ExpansionTile(
            title: Text(
              text,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            children: <Widget>[
              ListTile(
                title: Text(
                  text1,
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
