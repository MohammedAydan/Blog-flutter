import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class ButtonSelectFile extends StatelessWidget {
  const ButtonSelectFile({super.key, this.onPressed});

  final Callback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyMethods.bgColor2,
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.attach_file,
              color: MyMethods.blueColor1,
            ),
            SizedBox(width: 10),
            Text(
              'Select File',
              style: TextStyle(
                color: MyMethods.colorText2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
