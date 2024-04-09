import 'package:blog_mag/layouts/app_layout.dart';
import 'package:blog_mag/views/home_screen.dart';
import 'package:blog_mag/views/preofile_screen.dart';
import 'package:blog_mag/views/search_screen.dart';
import 'package:flutter/cupertino.dart';

class RoutingLayout extends StatelessWidget {
  static const String routeName = "/routing";

  RoutingLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(screens: screens);
  }

  List<Widget> screens = [
    HomeScreen(),
    const SearchScreen(),
    const ProfileScreen(),
  ];
}
