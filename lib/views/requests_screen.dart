import 'package:blog_mag/MyMethods/my_methods.dart';
import 'package:blog_mag/controllers/requests_controller.dart';
import 'package:blog_mag/models/user_request_model.dart';
import 'package:blog_mag/views/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:get/get.dart';

class RequestsScreen extends StatelessWidget {
  static const String routeName = "/requestsScreen";

  RequestsScreen({super.key});

  final RequestsController requestsController = Get.put(RequestsController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: requestsController,
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Requests"),
            centerTitle: true,
          ),
          body: RefreshIndicator(
            color: MyMethods.colorText1,
            backgroundColor: MyMethods.bgColor2,
            onRefresh: () async {
              await controller.getRequests();
            },
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: ListView(
                children: [
                  if (controller.isLoading) ...[
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ] else ...[
                    if (controller.requests.isNotEmpty) ...[
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        itemCount: controller.requests.length,
                        itemBuilder: (context, index) {
                          FullUserRequest userRequest =
                              controller.requests[index];
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: const BoxDecoration(
                              border: Border.symmetric(
                                horizontal: BorderSide(
                                  color: MyMethods.borderColor,
                                  width: 0.5,
                                ),
                              ),
                            ),
                            child: ListTile(
                              trailing: Icon(
                                FontAwesome.check_circle_o,
                                color: userRequest.status == true
                                    ? Colors.green
                                    : Colors.yellow.shade300,
                              ),
                              onTap: () {
                                Get.toNamed(
                                  UserProfileScreen.routeName,
                                  arguments: userRequest.owner!.id,
                                );
                              },
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundColor: MyMethods.bgColor2,
                                backgroundImage:
                                    userRequest.owner!.imgUrl != null
                                        ? NetworkImage(
                                            "${MyMethods.mediaAccountsPath}${userRequest.owner!.imgUrl}",
                                          )
                                        : null,
                              ),
                              title: Text(
                                "${userRequest.owner?.name}",
                                style: const TextStyle(
                                  color: MyMethods.colorText1,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ] else ...[
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "Not found",
                            style: TextStyle(
                              color: MyMethods.colorText1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
