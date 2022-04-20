import 'package:flutter/material.dart';
import 'package:watercooler/utils/colors.dart';
import 'package:watercooler/widgets/big_text.dart';
import 'package:watercooler/widgets/bottom_nav_widget.dart';
import 'package:watercooler/widgets/icon_and_text_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BigText(
                text: "Adnan Joraid",
                color: AppColors.textColor,
                size: 30.0,
              ),
              const SizedBox(height: 20),
              Container(
                width: 190.0,
                height: 190.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/images/adnan.jpg"),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconAndTextWidget(
                    icon: Icons.circle,
                    text: "Online",
                    iconColor: Colors.green,
                  ),
                  GestureDetector(
                    onTap: () {
                      print("drop down pressed");
                    },
                    child: Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.textColor,
                      size: 24,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
