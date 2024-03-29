import 'package:flutter/material.dart';
import 'package:watercooler/utils/app_constants.dart';
import 'package:watercooler/widgets/expandable_text_widget.dart';
import 'package:watercooler/widgets/small_text.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String title;
  final Color titleColor;
  final String description;
  final String date;
  final String location;
  final String time;

  const AppColumn(
      {Key? key,
      required this.title,
      this.titleColor = AppColors.textColor,
      required this.description,
      required this.date,
      required this.location,
      required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: title,
          size: Dimensions.font26,
          color: titleColor,
        ),
        SizedBox(height: 5),
        Container(
            height: 35,
            child: ExpandableTextWidget(text: description, characterLimit: 30)),
        SizedBox(height: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(
                icon: Icons.calendar_month,
                text: date,
                iconColor: AppColors.mainColor),
            IconAndTextWidget(
                icon: Icons.location_on,
                text: location,
                iconColor: AppColors.secondaryColor),
            IconAndTextWidget(
                icon: Icons.access_time_rounded,
                text: time,
                iconColor: AppColors.textColor),
          ],
        ),
      ],
    );
  }
}
