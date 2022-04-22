import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watercooler/widgets/big_text.dart';

import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/bottom_nav_widget.dart';

class UserChatPage extends StatefulWidget {
  final int pageId;

  const UserChatPage({Key? key, required this.pageId}) : super(key: key);

  @override
  State<UserChatPage> createState() => _UserChatPageState();
}

class _UserChatPageState extends State<UserChatPage> {
  TextEditingController message = TextEditingController();
  List<String> messages = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
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
