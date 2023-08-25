import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todolist/Signin.dart';
import 'package:todolist/Signup.dart';
import 'package:todolist/controller/task_controller.dart';
import 'package:todolist/services/notification_services.dart';
import 'package:todolist/services/theme_services.dart';
import 'package:todolist/ui/FAQ.dart';
import 'package:todolist/ui/Feedback.dart';
import 'package:todolist/ui/Theme.dart';
import 'package:todolist/ui/add_task_bar.dart';
import 'package:todolist/ui/widgets/button.dart';
import 'package:todolist/ui/widgets/task_tile.dart';

import 'models/task.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());

  @override
  void initState() {
    super.initState();
    NotifyHelper().initialiseNotifications();
  }

  int index = 0;
  List screens = [const signIn(), const AddTaskPage(), const signUp()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Image.asset(
                "assets/image/drawer.jpg",
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitWidth,
              ),
              decoration: BoxDecoration(
                  color: Get.isDarkMode ? darkGreyClr : Colors.white70),
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Add Task"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddTaskPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.color_lens_rounded),
              title: Text("Theme"),
              onTap: () {
                ThemeServices().switchTheme();
                NotifyHelper().sendNotification(
                    "Theme Changed",
                    Get.isDarkMode
                        ? "Activated Light Theme"
                        : "Activated Dark Theme");
              },
            ),
            ListTile(
              leading: Icon(Icons.feedback_rounded),
              title: Text("Feedback"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => feedBack()));
              },
            ),
            ListTile(
              leading: Icon(Icons.question_mark_rounded),
              title: Text("FAQ"),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => FAQ()));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text("Log Out"),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => signIn()));
              },
            ),
          ],
        ),
      ),
      // body: screens[index],
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            _addTaskBar(),
            _addDateBar(),
            SizedBox(
              height: 10,
            ),
            _showTasks(),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: const NavigationBarThemeData(
          indicatorColor: Colors.redAccent,
        ),
        child: NavigationBar(
          animationDuration: Duration(seconds: 2),
          surfaceTintColor: Colors.white,
          shadowColor: Get.isDarkMode ? Colors.white : Colors.black,
          elevation: 30,
          selectedIndex: index,
          onDestinationSelected: (index) => setState(() {
            this.index = index;
          }),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          height: 60,
          backgroundColor: context.theme.backgroundColor,
          destinations: [
            NavigationDestination(
              icon: Icon(
                Icons.home,
                color: index == 0 ? Colors.white : Colors.black,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_today,
                  color: index == 1 ? Colors.white : Colors.black),
              label: 'Add Task',
            ),
            NavigationDestination(
                icon: Icon(Icons.person,
                    color: index == 2 ? Colors.white : Colors.black),
                label: 'Profile'),
          ],
        ),
      ),
    );
  }

  _showTasks() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
            itemCount: _taskController.taskList.length,
            itemBuilder: (_, index1) {
              Task task = _taskController.taskList[index1];
              // print(task.toJson());
              if (task.repeat == 'Daily') {
                DateTime date =
                    DateFormat.jm().parse(task.startTime.toString());
                var myTime = DateFormat("HH:mm").format(date);
                NotifyHelper().scheduledNotification(
                    int.parse(myTime.toString().split(":")[0]),
                    int.parse(myTime.toString().split(":")[1]),
                    task);

                return AnimationConfiguration.staggeredList(
                  position: index1,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(context, task);
                            },
                            child: TaskTile(task),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
              if (task.date == DateFormat.yMd().format(_selectedDate)) {
                return AnimationConfiguration.staggeredList(
                  position: index1,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(context, task);
                            },
                            child: TaskTile(task),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            });
      }),
    );
  }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 4),
        height: task.isComplete == 1
            ? MediaQuery.of(context).size.height * 0.24
            : MediaQuery.of(context).size.height * 0.32,
        color: Get.isDarkMode ? darkGreyClr : Colors.white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300]),
            ),
            Spacer(),
            task.isComplete == 1
                ? Container()
                : _botttomSheetButton(
                    label: "Task Completed",
                    onTap: () {
                      _taskController.markTaskCompleted(task.id!);
                      Get.back();
                    },
                    clr: primaryClr,
                    context: context,
                  ),
            _botttomSheetButton(
              label: "Delete Task",
              onTap: () {
                _taskController.delete(task);

                Get.back();
              },
              clr: Colors.red[300]!,
              context: context,
            ),
            SizedBox(
              height: 20,
            ),
            _botttomSheetButton(
              label: "Close",
              onTap: () {
                Get.back();
              },
              clr: Colors.red[300]!,
              isClose: true,
              context: context,
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  _botttomSheetButton(
      {required String label,
      required Function()? onTap,
      required Color clr,
      required BuildContext context,
      bool isClose = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 50,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
              width: 2,
              color: isClose == true
                  ? Get.isDarkMode
                      ? Colors.grey[600]!
                      : Colors.grey[300]!
                  : clr),
          borderRadius: BorderRadius.circular(20),
          color: isClose == true ? Colors.transparent : clr,
        ),
        child: Center(
            child: Text(
          label,
          style:
              isClose ? titleStyle : titleStyle.copyWith(color: Colors.white),
        )),
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 15),
      child: DatePicker(
        DateTime.now(),
        height: 80,
        width: 65,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }

  _addTaskBar() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text(
                  "Today",
                  style: headingStyle,
                ),
              ],
            ),
          ),
          MyButton(
              label: "+ Add Task",
              onTap: () async {
                await Get.to(AddTaskPage());
                _taskController.getTasks();
              })
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Get.back();

          // ThemeServices().switchTheme();
          // NotifyHelper().sendNotification(
          //     "Theme Changed",
          //     Get.isDarkMode
          //         ? "Activated Light Theme"
          //         : "Activated Dark Theme");

          // NotifyHelper().scheduledNotification();
        },
        child: Icon(
          // Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
          // color: Get.isDarkMode ? Colors.white : Colors.black,
          Icons.arrow_back_rounded,
          size: 20,
        ),
      ),
      actions: [],
    );
  }
}
