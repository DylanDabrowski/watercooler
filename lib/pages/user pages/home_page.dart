import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watercooler/pages/user%20pages/home_page_body.dart';
import 'package:watercooler/widgets/bottom_nav_widget.dart';

import '../../models/user_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

import 'package:watercooler/utils/globals.dart' as globals;

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => checkForAdminMessage());
  }

  signOut() {
    globals.user = User();
    Get.toNamed(RouteHelper.getInitial());
    const snackbar = SnackBar(content: Text("Signed Out"));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  checkForAdminMessage() {
    print(globals.adminMessage);
    if (globals.user.permissionLevel != null &&
        globals.user.permissionLevel! > 1) {
      if (globals.adminMessage != null && globals.adminMessage != '') {
        var snackbar = SnackBar(
          content: Text("EMERGENCY MESSAGE: ${globals.adminMessage}"),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 15),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: Dimensions.height10, bottom: Dimensions.height10),
                padding: EdgeInsets.only(
                    left: Dimensions.width20, right: Dimensions.width20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BigText(
                      text: "Events",
                      size: 35.0,
                      color: AppColors.mainColor,
                    ),
                    Row(
                      children: [
                        globals.user.permissionLevel != null &&
                                globals.user.permissionLevel! > 1
                            ? GestureDetector(
                                onTap: () {
                                  Get.toNamed(RouteHelper.getAddEvent());
                                },
                                child: Center(
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    width: Dimensions.width45,
                                    height: Dimensions.height45,
                                    child: Icon(
                                      Icons.add,
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
                            : Container(),
                        GestureDetector(
                          onTap: () {
                            signOut();
                          },
                          child: Center(
                            child: Container(
                              width: Dimensions.width45,
                              height: Dimensions.height45,
                              child: Icon(
                                Icons.exit_to_app,
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
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: SingleChildScrollView(
                  child: HomePageBody(),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const BottomNav());
  }
}
