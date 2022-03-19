import 'package:flutter/material.dart';
import 'package:watercooler/routes/route_helper.dart';
import 'package:watercooler/utils/colors.dart';
import 'package:get/get.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/apartment_hallway.jpg"),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/logo.png"),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(40),
          //   topRight: Radius.circular(40),
          // ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 40,
              width: 100,
              child: OutlinedButton(
                onPressed: () {
                  print('Login button Pressed');
                  Get.toNamed(RouteHelper.getLogin());
                },
                style: OutlinedButton.styleFrom(
                  primary: AppColors.textColor,
                  backgroundColor: Colors.white,
                ),
                child: const Text("Login"),
              ),
            ),
            SizedBox(
              height: 40,
              width: 100,
              child: OutlinedButton(
                onPressed: () {
                  print('Signup button pressed');
                  Get.toNamed(RouteHelper.getSignup());
                },
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: AppColors.textColor,
                ),
                child: const Text("Sign up"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
