import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/event_model.dart';

import 'package:http/http.dart' as http;

import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_column.dart';
import '../../widgets/big_text.dart';
import '../../widgets/expandable_text_widget.dart';

class EventDetailsPage extends StatefulWidget {
  final int pageId;
  const EventDetailsPage({Key? key, required this.pageId}) : super(key: key);

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  Future<List<Event>> eventsFuture = getEvents();

  static Future<List<Event>> getEvents() async {
    print("getEvents called");
    var response = await http
        .get(Uri.parse(AppConstants.BASE_URL + AppConstants.EVENTS_URI));
    print(response.statusCode);

    final body = json.decode(response.body);
    print(body);

    return List<Event>.from(body.map((model) => Event.fromJson(model)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // background image
          FutureBuilder<List<Event>>(
            future: eventsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else if (snapshot.hasData) {
                final events = snapshot.data!;
                return _buildPageItem(events[widget.pageId]);
              } else {
                return const Text("No data");
              }
            },
          ),
        ],
      ),
    );
  }
}

Widget _buildPageItem(Event event) {
  return Stack(
    children: [
      Positioned(
        left: 0,
        right: 0,
        child: Container(
          width: double.maxFinite,
          height: Dimensions.popularFoodImgSize,
          decoration: BoxDecoration(
            image: event.imageUri != null && event.imageUri != ''
                ? DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(event.imageUri!))
                : const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/no-image.png"),
                  ),
          ),
        ),
      ),
      // back button
      Positioned(
        top: 30,
        left: 10,
        child: GestureDetector(
          onTap: () {
            Get.toNamed(RouteHelper.getHome());
          },
          child: const Icon(
            Icons.arrow_circle_left_outlined,
            color: AppColors.mainColor,
            size: 40.0,
          ),
        ),
      ),
      Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        top: Dimensions.popularFoodImgSize - 20,
        child: Container(
          padding: EdgeInsets.only(
              left: Dimensions.width20,
              right: Dimensions.width30,
              top: Dimensions.height20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(Dimensions.radius20),
              topLeft: Radius.circular(Dimensions.radius20),
            ),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppColumn(
                title: event.title != null && event.title != ''
                    ? event.title!
                    : 'No Title',
                description: '',
                date: event.date != null && event.date != ''
                    ? event.date!
                    : 'N/A',
                time: event.time != null && event.time != ''
                    ? event.time!
                    : 'N/A',
                location: event.location != null && event.location != ''
                    ? event.location!
                    : 'N/A',
              ),
              SizedBox(height: Dimensions.height20),
              BigText(text: "Description"),
              SizedBox(height: Dimensions.height20),
              Expanded(
                child: SingleChildScrollView(
                  child: ExpandableTextWidget(
                    text: event.description!,
                    characterLimit: 500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
