import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watercooler/models/login_model.dart';
import 'package:watercooler/models/user_model.dart';
import 'package:watercooler/utils/app_constants.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';

import 'package:http/http.dart' as http;
import 'package:watercooler/utils/globals.dart' as globals;

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isLoading = false;

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();

  registerUser() async {
    try {
      User request = User(
          username: username.text,
          password: password.text,
          firstName: firstName.text,
          lastName: lastName.text,
          userActivity: 0);

      var response = await http.post(
          Uri.parse(AppConstants.BASE_URL + AppConstants.REGISTER_URI),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
          body: jsonEncode(request.toJson()));
      if (response.statusCode == 200) {
        globals.isLoggedIn = true;
        globals.user = request;
        Get.toNamed(RouteHelper.getHome());
      }
      print(response.body);
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
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 40.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: firstName,
                obscureText: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'First Name',
                ),
              ),
              const SizedBox(height: 10),
              // last name texfield
              TextField(
                controller: lastName,
                obscureText: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Last Name',
                ),
              ),
              const SizedBox(height: 10),
              // email textfield
              TextFormField(
                controller: username,
                obscureText: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
              ),
              const SizedBox(height: 10),
              // password textfield
              TextFormField(
                controller: password,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
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
                      registerUser();
                    },
                    style: OutlinedButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: AppColors.textColor,
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 20, left: 50, right: 50)),
                    child: const Text("Sign Up"),
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
