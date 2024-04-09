import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:blog_mag/Widgets/text_input.dart';
import 'package:blog_mag/Widgets/user_avater.dart';
import 'package:blog_mag/controllers/search_controller.dart';
import 'package:blog_mag/models/user_model.dart';
import 'package:blog_mag/views/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = '/searchScreen';

  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchUsersController>(
      init: SearchUsersController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Search"),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: Get.width / 1.5,
                  child: TextInput(
                    label: "search",
                    controller: controller.search,
                    onChanged: (e) => controller.searchByUsers(e),
                  ),
                ),
              ),
            ],
          ),
          body: ListView(
            children: [
              if (controller.isLoading) ...[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ] else ...[
                if (controller.users.isEmpty &&
                    controller.search.text.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text("Not found"),
                    ),
                  ),
                ],
                if (controller.users.isNotEmpty &&
                    controller.search.text.isNotEmpty) ...[
                  ListView.builder(
                    itemCount: controller.users.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      User user = controller.users[index];
                      return ListTile(
                        leading: UserAvater(
                          imgUrl: "${MyMethods.mediaAccountsPath}/${user.imgUrl}",
                          verified: user.accountConfirmation,
                        ),
                        title: Text(
                          "${user.name}",
                          style: const TextStyle(
                            color: MyMethods.colorText1,
                          ),
                        ),
                        onTap: () {
                          Get.toNamed(
                            UserProfileScreen.routeName,
                            arguments: user.id,
                          );
                        },
                      );
                    },
                  ),
                ],
              ],
            ],
          ),
        );
      },
    );
  }
}
