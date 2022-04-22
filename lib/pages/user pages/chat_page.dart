import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:watercooler/models/user_model.dart';
import 'package:watercooler/widgets/big_text.dart';
import 'package:watercooler/widgets/bottom_nav_widget.dart';

import 'package:http/http.dart' as http;
import 'package:watercooler/widgets/small_text.dart';

import '../../utils/app_constants.dart';
import '../../utils/dimensions.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Future<List<User>> usersFuture = getUsers();

  static Future<List<User>> getUsers() async {
    print("getUsers called");
    var response = await http
        .get(Uri.parse(AppConstants.BASE_URL + AppConstants.GET_USERS_URI));
    print(response.statusCode);

    final body = json.decode(response.body);
    print(body);

    return List<User>.from(body.map((model) => User.fromJson(model)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin:
              const EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 35),
          child: FutureBuilder<List<User>>(
            future: usersFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else if (snapshot.hasData) {
                final users = snapshot.data!;
                return buildUserList(users);
              } else {
                return const Text("No data");
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}

Widget buildUserList(List<User> users) => ListView.builder(
    physics: const AlwaysScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: users.length,
    itemBuilder: (context, index) {
      final user = users[index];
      return Container(
        margin: EdgeInsets.only(
            left: Dimensions.width10,
            right: Dimensions.width10,
            bottom: Dimensions.height10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(60),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.35),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            // image section
            user.profilePictureUri != ""
                ? Container(
                    width: Dimensions.listViewImgSize,
                    height: Dimensions.listViewImgSize,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      color: Colors.white38,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(user.profilePictureUri!),
                      ),
                    ),
                  )
                : const Icon(
                    Icons.person,
                    size: 100,
                  ),
            // text container
            Expanded(
              child: Container(
                height: Dimensions.listViewTextContSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.radius20),
                      bottomRight: Radius.circular(Dimensions.radius20)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: Dimensions.width10,
                      right: Dimensions.width10,
                      top: Dimensions.height10,
                      bottom: Dimensions.height10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(
                        text: '${user.firstName} ${user.lastName}',
                      ),
                      const SizedBox(height: 10),
                      SmallText(text: user.username.toString()),
                      user.permissionLevel! > 1
                          ? SmallText(
                              text: "Admin",
                              color: Colors.red,
                            )
                          : Container(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Icon(
                            Icons.arrow_circle_right_outlined,
                            size: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
