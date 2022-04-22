import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:watercooler/routes/route_helper.dart';
import 'package:watercooler/utils/colors.dart';
import 'package:get/get.dart';

import '../../models/user_model.dart';

import 'package:http/http.dart' as http;
import 'package:watercooler/utils/globals.dart' as globals;

import '../../utils/app_constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  loginUser() async {
    try {
      User request = User(
          username: username.text,
          password: password.text,
          firstName: '',
          lastName: '',
          userActivity: 0,
          profilePictureUri: "",
          permissionLevel: 1);

      var response = await http.post(
          Uri.parse(AppConstants.BASE_URL + AppConstants.LOGIN_URI),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
          body: jsonEncode(request.toJson()));
      print(response.statusCode);
      if (response.statusCode == 200) {
        globals.isLoggedIn = true;
        globals.user = User.fromJson(jsonDecode(response.body));
        print(globals.user);
        Get.toNamed(RouteHelper.getHome());
      } else {
        const snackbar = SnackBar(content: Text("Invalid Login"));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    } catch (e) {
      print('ERROR: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // back button
              GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.getInitial());
                },
                child: const Icon(
                  Icons.arrow_circle_left_outlined,
                  color: AppColors.textColor,
                  size: 40.0,
                ),
              ),
              const SizedBox(height: 10),
              // title
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 40.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // email textfield
              TextFormField(
                controller: username,
                obscureText: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  labelText: 'Username',
                ),
              ),
              const SizedBox(height: 10),
              // password textfield
              TextFormField(
                controller: password,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 40),
              // sign up button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      loginUser();
                    },
                    style: OutlinedButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: AppColors.textColor,
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 20, left: 50, right: 50)),
                    child: const Text("Login"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
