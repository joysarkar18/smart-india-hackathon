import 'package:flutter/material.dart';
import 'package:flutter_shop/Controllers/MainController/main_controller.dart';
import 'package:flutter_shop/Views/Componants/glossy_extra.dart';
import 'package:flutter_shop/Views/Screens/HomeScreen/diseas_screen.dart';
import 'package:flutter_shop/Views/Screens/HomeScreen/home_screen.dart';
import 'package:flutter_shop/Views/Screens/HomeScreen/wikipediaScreen.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final mainController = Get.put(MainController());

  List<Widget> _pages = [
    HomeScreen(),
    DiseasScreen(),
    WikipediaScreen(),
  ];

  // @override
  // void initState() {
  //   super.initState();

  //   mainController.loadData();
  // }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: Colors.white,
          body: _pages[mainController.navBarIndex.value],
          bottomNavigationBar: EnhancedNavigationBar(
            currentIndex: mainController.navBarIndex.value,
            onTap: (index) {
              mainController.navBarIndex.value = index;
            },
          ),
        ));
  }
}

class EnhancedNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  EnhancedNavigationBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return
        // Container(
        //   height: 80.0,
        //   color: Colors.white,
        // ),
        GlossyCardDark(
      height: 62.5,
      width: Get.width,
      borderRadius: 0.0,
      borderWith: 0.0000001,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, "Plant detection ", 0),
            _buildNavItem(Icons.bug_report_rounded, "Plant Disease", 1),
            _buildNavItem(Icons.desktop_mac_rounded, "Plant wikipedia", 2),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    return InkWell(
      onTap: () {
        onTap(index);
      },
      child: Container(
        width: 80,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: currentIndex == index ? Colors.green : Colors.black,

              // size: currentIndex == index ? Size(12, 12) : Size(10, 10),
            ),
            const SizedBox(height: 2.0),
            Text(
              label,
              style: TextStyle(
                color: currentIndex == index ? Colors.green : Colors.black,
                fontSize: currentIndex == index ? 10 : 9,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
