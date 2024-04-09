import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:blog_mag/controllers/bottom_nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:get/get.dart';

class AppLayout extends StatelessWidget {
  AppLayout({super.key, required this.screens});

  final List<Widget> screens;
  final BottomNavController bottomNavController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: bottomNavController,
      builder: (controller) {
        return Scaffold(
          body: screens[controller.currentIndex],
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: MyMethods.borderColor,
                  width: 1,
                ),
              ),
            ),
            child: BottomNavigationBar(
              currentIndex: controller.currentIndex,
              onTap: (e) => controller.selectScreen(e),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(FontAwesome.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesome.search),
                  label: "Search",
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesome.user),
                  label: "Account",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
