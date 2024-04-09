import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class MyOutlinedButton extends StatelessWidget {
  const MyOutlinedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.width,
  });
  final String text;
  final Callback? onPressed;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed ?? () => {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: MyMethods.borderColor, width: 1),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(color: MyMethods.colorText1),
        ),
      ),
    );
  }
}
