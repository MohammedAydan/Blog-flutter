import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

class UserAvater extends StatelessWidget {
  const UserAvater({super.key, required this.imgUrl, this.verified = false});
  final String imgUrl;
  final bool? verified;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundColor: MyMethods.bgColor2,
          radius: 20,
          backgroundImage: NetworkImage(imgUrl),
        ),
        if (verified == true) ...[
          const SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: MyMethods.bgColor2,
            ),
            child: const Icon(
              Icons.verified,
              color: MyMethods.blueColor1,
            ),
          ),
        ],
      ],
    );
  }
}
