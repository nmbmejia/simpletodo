import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpleflutter/models/task_model.dart';
import 'package:simpleflutter/screens/homepage/all.dart';
import 'package:simpleflutter/screens/homepage/completed.dart';
import 'package:simpleflutter/screens/homepage/incomplete.dart';
import 'package:simpleflutter/services/constants.dart';
import 'package:simpleflutter/widgets/colors.dart';

// ignore: must_be_immutable
class HomePageController extends GetxController {
  late var hiveBox = formatDate().toString();
  late List<Task> taskList;
  // var box = Hive.box(ServiceConstants.hiveBox);
  RxInt selectedIndex = 0.obs;
  RxString newTaskBody = ''.obs;
  RxList allTasks = [].obs;
  RxString currentDate = ''.obs;

  List<Widget> pages = <Widget>[
    AllPage(),
    const CompletePage(),
    const IncompletePage(),
  ];

  String getDate() {
    final DateTime now = DateTime.now();
    final DateTime date = DateTime(now.year, now.month, now.day);
    currentDate.value = date.toString();
    return date.toString();
  }

  void addNewTask() async {
    if (newTaskBody.value.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();

      int? taskCounter = prefs.getInt('taskCounter');
      int currentTaskId = (taskCounter ?? 1);

      var newTask = {
        "body": newTaskBody.value,
        "createdAt": getDate(),
        "category": "new",
        "completed": false
      };

      //Update local
      allTasks.add(newTask);

      //Update db
      var box = await openHiveBox(hiveBox);
      if (box.containsKey(ServiceConstants.taskList)) {
        box.delete(ServiceConstants.taskList);
        box.put(ServiceConstants.taskList, allTasks);
      } else {
        List<dynamic> taskList = [];
        box.put(ServiceConstants.taskList, taskList);
      }
      await prefs.setInt('taskCounter', currentTaskId++);
    } else {
      Navigator.of(Get.context!).pop();
    }
  }

  formatDate() {
    var date = DateTime.now();
    var suffix = "th";
    var digit = DateTime.now().day % 10;
    if ((digit > 0 && digit < 4) && (date.day < 11 || date.day > 13)) {
      suffix = ["st", "nd", "rd"][digit - 1];
    }
    return DateFormat("EEEE, MMMM d'$suffix'").format(DateTime.now());
  }

  void initializeTasks() async {
    var box = await openHiveBox(hiveBox);
    List<dynamic> taskList = await box.get(ServiceConstants.taskList) ?? [];
    if (taskList.isNotEmpty) {
      print("TASK LIST REFRESH: $taskList");
      allTasks.clear();
      allTasks.addAll(taskList);
    }
  }

  Future<Box> openHiveBox(String boxName) async {
    if (!kIsWeb && !Hive.isBoxOpen(boxName)) {
      Hive.init((await getApplicationDocumentsDirectory()).path);
    }
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box(boxName);
    } else {
      return await Hive.openBox(boxName);
    }
  }

  Future<void> addNewDialog() async {
    return showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            title: const Text('ADD NEW',
                style: TextStyle(
                    color: AppColors.text,
                    fontSize: 12,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w500)),
            content: TextField(
              decoration: const InputDecoration(
                hintText: "Type here",
                hintStyle: TextStyle(fontWeight: FontWeight.w300),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                    vertical: 10), //Change this value to custom as you like
                isDense: true, // and add this line
              ),
              onChanged: (value) {
                newTaskBody.value = value;
              },
            ),
            actions: [
              Obx(() {
                return Visibility(
                  visible: newTaskBody.value.isNotEmpty,
                  child: FlatButton(
                      child: const Text('ADD',
                          style: TextStyle(
                              color: AppColors.text,
                              fontSize: 12,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w500)),
                      onPressed: () {
                        addNewTask();
                        Navigator.of(Get.context!).pop();
                      }),
                );
              })
            ],
          );
        });
  }

  Widget build(BuildContext context) {
    return const Material();
  }
}
