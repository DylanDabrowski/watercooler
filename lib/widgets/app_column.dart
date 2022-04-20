import 'package:flutter/material.dart';
import 'package:watercooler/widgets/expandable_text_widget.dart';
import 'package:watercooler/widgets/small_text.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String title;
  final String description;

  const AppColumn({Key? key, required this.title, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: title,
          size: Dimensions.font26,
        ),
        SizedBox(height: 5),
        Container(
            height: 35,
            child: ExpandableTextWidget(text: description, characterLimit: 70)),
        SizedBox(height: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            IconAndTextWidget(
                icon: Icons.circle_sharp,
                text: "Normal",
                iconColor: AppColors.mainColor),
            IconAndTextWidget(
                icon: Icons.location_on,
                text: "1.7km",
                iconColor: AppColors.secondaryColor),
            IconAndTextWidget(
                icon: Icons.access_time_rounded,
                text: "32min",
                iconColor: AppColors.textColor),
          ],
        ),
      ],
    );
  }
}
