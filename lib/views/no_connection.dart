import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:blog_mag/Widgets/buttons/outlined_button.dart';
import 'package:blog_mag/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoConnection extends StatelessWidget {
  static const String routeName = "/noConnection";
  NoConnection({super.key});

  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(flex: 3),
            Image.asset(
              "assets/logo-1.png",
              height: 100,
              width: 100,
            ),
            const Spacer(),
            const Icon(
              Icons.wifi_off,
              size: 100,
              color: Colors.grey,
            ),
            const SizedBox(height: 20),
            const Text(
              "No Internet Connection",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            GetBuilder(
                init: authController,
                builder: (controller) {
                  if (controller.initLoading) {
                    return SizedBox(
                      width: 150,
                      child: LinearProgressIndicator(
                        minHeight: 3,
                        color: MyMethods.colorText2,
                        backgroundColor: MyMethods.bgColor2,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    );
                  }
                  return MyOutlinedButton(
                    text: "Connection check",
                    onPressed: () {
                      controller.ready();
                    },
                  );
                }),
            const Spacer(flex: 2),
            const Text(
              "Powerd by",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: MyMethods.colorText2,
              ),
            ),
            const Text(
              "MAG",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
