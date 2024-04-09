import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

class SplashPost extends StatelessWidget {
  const SplashPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: MyMethods.bgColor2,
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.all(10),
                width: 100,
                decoration: BoxDecoration(
                  color: MyMethods.bgColor2,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                width: 100,
                decoration: BoxDecoration(
                  color: MyMethods.bgColor2,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                width: 150,
                decoration: BoxDecoration(
                  color: MyMethods.bgColor2,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  FontAwesome.heart,
                  color: MyMethods.bgColor2,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  FontAwesome.comment,
                  color: MyMethods.bgColor2,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  FontAwesome.share,
                  color: MyMethods.bgColor2,
                ),
              ),
            ],
          ),
        ),
      ],
    )
        .animate(
          onPlay: (controller) => controller.repeat(),
        )
        .shimmer(
          duration: const Duration(seconds: 1),
          delay: const Duration(milliseconds: 500),
        );
  }
}
