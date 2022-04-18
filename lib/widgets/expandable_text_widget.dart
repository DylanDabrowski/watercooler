import 'package:flutter/material.dart';
import 'package:watercooler/widgets/small_text.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;

  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  _ExpandableTextWidgetState createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;

  double textHeight = 60;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(
              size: 12,
              color: AppColors.textColor,
              text: firstHalf,
            )
          : Column(
              children: [
                SmallText(
                  size: 12,
                  color: AppColors.textColor,
                  text: hiddenText
                      ? (firstHalf + "...")
                      : (firstHalf + secondHalf),
                ),
                // InkWell(
                //   onTap: () {
                //     setState(() {
                //       hiddenText = !hiddenText;
                //     });
                //   },
                //   child: Row(
                //     children: [
                //       SmallText(
                //         text: hiddenText ? "Show more" : "Show less",
                //         color: AppColors.mainColor,
                //       ),
                //       Icon(
                //         hiddenText
                //             ? Icons.arrow_drop_down
                //             : Icons.arrow_drop_up,
                //         color: AppColors.mainColor,
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
    );
  }
}
