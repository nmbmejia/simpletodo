import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpleflutter/screens/homepage/controllers/homepage_controller.dart';
import 'package:simpleflutter/services/constants.dart';
import 'package:simpleflutter/widgets/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageController homepageController = Get.put(HomePageController());

  void onItemTapped(int index) {
    homepageController.selectedIndex.value = index;
  }

  @override
  void initState() {
    super.initState();
    homepageController.initializeTasks();
    //clearAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() {
                return Text('${homepageController.allTasks.length} TASKS',
                    style: const TextStyle(
                        color: AppColors.text,
                        fontSize: 12,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w500));
              }),
              SizedBox(
                width: 100,
                child: Text(
                  homepageController.formatDate().split(",")[0] +
                      "\n" +
                      homepageController.formatDate().split(",")[1],
                  maxLines: 2,
                  style: const TextStyle(
                      color: AppColors.blue,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 2,
                      fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
              GestureDetector(
                onTap: () {
                  homepageController.addNewDialog();
                },
                child: const Text('ADD NEW +',
                    style: TextStyle(
                        color: AppColors.text,
                        fontSize: 12,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w500)),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          titleSpacing: 0,
          elevation: 0,
        ),
        body: Obx(() {
          return Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Divider(color: Colors.black.withOpacity(0.1)),
              ),
              Center(
                child: homepageController.pages
                    .elementAt(homepageController.selectedIndex.value),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Divider(color: Colors.black.withOpacity(0.1)),
              ),
            ],
          );
        }),
        bottomNavigationBar: Obx(() {
          return BottomNavigationBar(
            currentIndex: homepageController.selectedIndex.value,
            onTap: onItemTapped,
            unselectedIconTheme: const IconThemeData(
              color: AppColors.selectedBlue,
            ),
            unselectedItemColor: AppColors.selectedBlue,
            selectedItemColor: AppColors.blue,
            iconSize: 25,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedLabelStyle: const TextStyle(
                fontSize: 12, letterSpacing: 1.2, fontWeight: FontWeight.bold),
            unselectedLabelStyle: const TextStyle(
                fontSize: 12, letterSpacing: 1.2, fontWeight: FontWeight.w300),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.format_list_bulleted),
                label: 'ALL',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.check_circle),
                label: 'COMPLETE',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.rule),
                label: 'INCOMPLETE',
              ),
            ],
          );
        }));
  }
}
