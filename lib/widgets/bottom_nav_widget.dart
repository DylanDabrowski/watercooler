import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/route_helper.dart';
import '../utils/colors.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
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
            width: 50,
            child: OutlinedButton(
              onPressed: () {
                Get.toNamed(RouteHelper.getHome());
              },
              style: OutlinedButton.styleFrom(
                primary: AppColors.textColor,
                backgroundColor: Colors.white,
              ),
              child: const Icon(
                Icons.home_outlined,
                color: AppColors.textColor,
                size: 20.0,
              ),
            ),
          ),
          SizedBox(
            height: 40,
            width: 50,
            child: OutlinedButton(
              onPressed: () {
                Get.toNamed(RouteHelper.getEmergency());
              },
              style: OutlinedButton.styleFrom(
                primary: Colors.white,
                backgroundColor: AppColors.textColor,
              ),
              child: const Icon(
                Icons.system_security_update_warning,
                color: Colors.white,
                size: 20.0,
              ),
            ),
          ),
          SizedBox(
            height: 40,
            width: 50,
            child: OutlinedButton(
              onPressed: () {
                Get.toNamed(RouteHelper.getChat());
              },
              style: OutlinedButton.styleFrom(
                primary: AppColors.textColor,
                backgroundColor: Colors.white,
              ),
              child: const Icon(
                Icons.chat_bubble_outline,
                color: AppColors.textColor,
                size: 20.0,
              ),
            ),
          ),
          SizedBox(
            height: 40,
            width: 50,
            child: OutlinedButton(
              onPressed: () {
                Get.toNamed(RouteHelper.getProfile());
              },
              style: OutlinedButton.styleFrom(
                primary: Colors.white,
                backgroundColor: AppColors.textColor,
              ),
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 20.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
