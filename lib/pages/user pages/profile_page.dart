import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:watercooler/models/user_model.dart';
import 'package:watercooler/utils/colors.dart';
import 'package:watercooler/widgets/big_text.dart';
import 'package:watercooler/widgets/bottom_nav_widget.dart';
import 'package:watercooler/widgets/icon_and_text_widget.dart';

import 'package:watercooler/utils/globals.dart' as globals;

import '../../utils/dimensions.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var activityStatus = "ONLINE";
  var imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BigText(
                text: "${globals.user.firstName} ${globals.user.lastName}",
                color: AppColors.textColor,
                size: 30.0,
              ),
              const SizedBox(height: 20),
              globals.user.profilePictureUri != ""
                  ? Container(
                      width: 190.0,
                      height: 190.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(globals.user.profilePictureUri!),
                        ),
                      ),
                    )
                  : Icon(Icons.person, size: 150),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<String>(
                    value: activityStatus,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: AppColors.secondaryColor),
                    underline: Container(
                      height: 2,
                      color: AppColors.secondaryColor,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        activityStatus = newValue!;
                      });
                    },
                    items: <String>[
                      'ONLINE',
                      'AWAY',
                      'DO NOT DISTURB',
                      'OFFLINE'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(width: 25),
                  // GestureDetector(
                  //   onTap: () {
                  //     _getFromGallery();
                  //   },
                  //   child: Center(
                  //     child: Container(
                  //       width: Dimensions.width45,
                  //       height: Dimensions.height45,
                  //       child: Icon(
                  //         Icons.camera_alt,
                  //         color: Colors.white,
                  //         size: Dimensions.iconSize24,
                  //       ),
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(
                  //           Dimensions.radius15,
                  //         ),
                  //         color: AppColors.secondaryColor,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNav(),
    );
  }

  // Get from gallery
  _getFromGallery() async {
    // Pick an image
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    } else {
      const snackbar =
          SnackBar(content: Text("Sorry, that image is not acceptable"));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
}
