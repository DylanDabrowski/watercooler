import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watercooler/widgets/big_text.dart';

import '../../models/user_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/bottom_nav_widget.dart';

import 'package:http/http.dart' as http;

class UserChatPage extends StatefulWidget {
  final int pageId;

  const UserChatPage({Key? key, required this.pageId}) : super(key: key);

  @override
  State<UserChatPage> createState() => _UserChatPageState();
}

class _UserChatPageState extends State<UserChatPage> {
  TextEditingController message = TextEditingController();
  List<String> messages = List.empty(growable: true);

  Future<User> getUsers() async {
    try {
      var response = await http.get(Uri.parse(AppConstants.BASE_URL +
          AppConstants.GET_USERS_URI +
          '${widget.pageId}'));

      final body = json.decode(response.body);
      return User.fromJson(body);
    } on Exception catch (e) {
      print("ERROR: $e");
    }
    return User();
  }

  @override
  Widget build(BuildContext context) {
    Future<User> user = getUsers();
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10, top: 10),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getChat());
                      },
                      child: const Icon(
                        Icons.arrow_circle_left_outlined,
                        color: AppColors.textColor,
                        size: 40.0,
                      ),
                    ),
                  ),
                  getUsers() != null ? BigText(text: '') : Container(),
                ],
              ),
              const Spacer(),
              ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final m = messages[index];
                  return Container(
                    margin:
                        const EdgeInsets.only(right: 30, top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [BigText(text: m)],
                    ),
                  );
                },
              ),
              Container(
                margin: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller: message,
                        obscureText: false,
                        decoration: const InputDecoration(
                          labelText: 'Type a message...',
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        message.text.isNotEmpty
                            ? setState(() {
                                messages.add(message.text);
                                var newMessages = messages;
                                message.clear();
                                messages = newMessages;
                              })
                            : print("Message is empty");
                      },
                      child: Center(
                        child: Container(
                          margin: const EdgeInsets.only(right: 10, left: 10),
                          width: Dimensions.width45,
                          height: Dimensions.height45,
                          child: Icon(
                            Icons.send_rounded,
                            color: Colors.white,
                            size: Dimensions.iconSize24,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              Dimensions.radius15,
                            ),
                            color: AppColors.mainColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const BottomNav());
  }
}
