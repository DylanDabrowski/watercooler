import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watercooler/pages/user%20pages/home_page_body.dart';
import 'package:watercooler/widgets/bottom_nav_widget.dart';

import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                    Center(
                      child: Container(
                        width: Dimensions.width45,
                        height: Dimensions.height45,
                        child: Icon(
                          Icons.search,
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
                    )
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
        bottomNavigationBar: BottomNav());
  }
}
