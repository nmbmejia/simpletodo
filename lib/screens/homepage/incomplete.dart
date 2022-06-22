import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:simpleflutter/screens/homepage/controllers/homepage_controller.dart';
import 'package:simpleflutter/services/constants.dart';
import 'package:simpleflutter/widgets/colors.dart';
import 'package:simpleflutter/widgets/task.dart';

class IncompletePage extends StatefulWidget {
  const IncompletePage({Key? key}) : super(key: key);

  @override
  State<IncompletePage> createState() => _IncompletePageState();
}

class _IncompletePageState extends State<IncompletePage> {
  final HomePageController homepageController = Get.put(HomePageController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return homepageController.allTasks.isEmpty
          ? const Center(
              child: Text(ServiceConstants.emptyList,
                  style: TextStyle(
                      color: AppColors.text,
                      fontSize: 12,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w500)))
          : Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                        itemCount: homepageController.allTasks.length,
                        itemBuilder: (context, index) {
                          if (homepageController.allTasks[index]["completed"] ==
                              false) {
                            return TaskWidget(
                              homepageController.allTasks[index]["body"],
                              homepageController.allTasks[index]["completed"],
                              () async {
                                print(index);
                                var box = await homepageController
                                    .openHiveBox(homepageController.hiveBox);
                                homepageController.allTasks[index]
                                        ["completed"] =
                                    !homepageController.allTasks[index]
                                        ["completed"];

                                var newTask = {
                                  "body": homepageController.allTasks[index]
                                      ["body"],
                                  "createdAt": homepageController
                                      .allTasks[index]["createdAt"],
                                  "category": homepageController.allTasks[index]
                                      ["category"],
                                  "completed": homepageController
                                      .allTasks[index]["completed"],
                                };
                                homepageController.allTasks[index] = newTask;

                                box.delete(ServiceConstants.taskList);
                                box.put(ServiceConstants.taskList,
                                    homepageController.allTasks);

                                setState(() {});
                              },
                            );
                          }
                          return const Material();
                        }),
                  ),
                ),
              ],
            );
    });
  }
}
