import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowImage extends StatelessWidget {
  static const String routeName = "/showImg";

  const ShowImage({super.key});

  @override
  Widget build(BuildContext context) {
    String imgUrl = Get.arguments;
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Center(
          child: Image.network("${MyMethods.mediaPostsPath}/$imgUrl"),
        ),
      ),
    );
  }
}
