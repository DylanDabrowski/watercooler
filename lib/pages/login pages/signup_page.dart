import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

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
              const SizedBox(height: 100),
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
              // email textfield
              const TextField(
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 20),
              // password textfield
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
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
                      Get.toNamed(RouteHelper.getHome());
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
