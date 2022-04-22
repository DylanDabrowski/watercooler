import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:get/get.dart';
import '../../models/event_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_column.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/small_text.dart';
import 'package:http/http.dart' as http;

class HomePageBody extends StatefulWidget {
  const HomePageBody({Key? key}) : super(key: key);

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
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

  deleteEvent(int index) async {
    var response = await http.delete(
        Uri.parse(AppConstants.BASE_URL + AppConstants.EVENTS_URI + '$index'));
    try {
      if (response.statusCode == 200) {
        setState(() {
          eventsFuture = getEvents();
        });
        const snackbar = SnackBar(content: Text("Event Deleted"));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      } else {
        const snackbar = SnackBar(content: Text("Error deleting event"));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    } catch (e) {
      print('ERROR DELETING EVENT: $e');
    }
  }

  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
        // print("Current value is " + _currPageValue.toString());
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // color: Colors.red,
          height: Dimensions.pageView,
          child: FutureBuilder<List<Event>>(
            future: eventsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else if (snapshot.hasData) {
                final events = snapshot.data!;
                return PageView.builder(
                  controller: pageController,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return _buildPageItem(index, events[index]);
                  },
                );
              } else {
                return const Text("No data");
              }
            },
          ),
        ),
        DotsIndicator(
          dotsCount: 3,
          position: _currPageValue,
          decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              activeColor: AppColors.mainColor),
        ),
        SizedBox(height: Dimensions.height30),
        Container(
          margin: EdgeInsets.only(
              left: Dimensions.width30, bottom: Dimensions.height20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "All Events"),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: SmallText(text: "All upcoming events"),
              ),
            ],
          ),
        ),
        Container(
          child: FutureBuilder<List<Event>>(
            future: eventsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else if (snapshot.hasData) {
                final events = snapshot.data!;
                return buildEvents(events);
              } else {
                return const Text("No data");
              }
            },
          ),
        )
      ],
    );
  }

  Widget buildEvents(List<Event> events) => ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return Container(
          margin: EdgeInsets.only(
              left: Dimensions.width10,
              right: Dimensions.width10,
              bottom: Dimensions.height10),
          child: Row(
            children: [
              // image section
              event.imageUri != null && event.imageUri != ''
                  ? Container(
                      width: Dimensions.listViewImgSize,
                      height: Dimensions.listViewImgSize,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white38,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(event.imageUri!),
                        ),
                      ),
                    )
                  : Container(
                      width: Dimensions.listViewImgSize,
                      height: Dimensions.listViewImgSize,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white38,
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/no-image.png"),
                        ),
                      ),
                    ),
              // text container
              Expanded(
                child: Container(
                  height: Dimensions.listViewTextContSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimensions.radius20),
                        bottomRight: Radius.circular(Dimensions.radius20)),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: Dimensions.width10, right: Dimensions.width10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            event.title != null && event.title != ''
                                ? BigText(text: event.title!)
                                : BigText(
                                    text: "No Title",
                                    color: AppColors.secondaryColor),
                            GestureDetector(
                              onTap: () {
                                deleteEvent(event.id!);
                              },
                              child:
                                  const Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.height10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconAndTextWidget(
                                icon: Icons.calendar_month,
                                text: event.date != null && event.date != ''
                                    ? event.date!
                                    : "N/A",
                                iconColor: AppColors.secondaryColor),
                            IconAndTextWidget(
                                icon: Icons.location_on,
                                text: event.location != null &&
                                        event.location != ''
                                    ? event.location!
                                    : "N/A",
                                iconColor: AppColors.mainColor),
                            IconAndTextWidget(
                                icon: Icons.access_time_rounded,
                                text: event.time != null && event.time != ''
                                    ? event.time!
                                    : "N/A",
                                iconColor: AppColors.textColor),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      });

  Widget _buildPageItem(int index, Event event) {
    Matrix4 matrix = new Matrix4.identity();

    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              // Get.toNamed(RouteHelper.getPopularFood(index));
            },
            child: event.imageUri != null && event.imageUri != ''
                ? Container(
                    height: Dimensions.pageViewContainer,
                    margin: EdgeInsets.only(
                        left: Dimensions.width10, right: Dimensions.width10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: index.isEven
                          ? AppColors.mainColor
                          : AppColors.secondaryColor,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(event.imageUri!),
                      ),
                    ),
                  )
                : Container(
                    height: Dimensions.pageViewContainer,
                    margin: EdgeInsets.only(
                        left: Dimensions.width10, right: Dimensions.width10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: index.isEven
                          ? AppColors.mainColor
                          : AppColors.secondaryColor,
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/no-image.png"),
                      ),
                    ),
                  ),
          ),
          GestureDetector(
            onTap: () {
              deleteEvent(event.id!);
            },
            child: const Icon(Icons.delete, color: Colors.red),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                left: Dimensions.width30,
                right: Dimensions.width30,
                bottom: Dimensions.height30,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, 0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5, 0),
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height15, left: 15, right: 15),
                child: Row(
                  children: [
                    AppColumn(
                      title: event.title != null && event.title != ''
                          ? event.title!
                          : 'No Title'.toString(),
                      titleColor: event.title != null && event.title != ''
                          ? AppColors.textColor
                          : AppColors.secondaryColor,
                      description:
                          event.description != null ? event.description! : '',
                      date: event.date != null && event.date != ''
                          ? event.date!
                          : 'N/A',
                      location: event.location != null && event.location != ''
                          ? event.location!
                          : 'N/A',
                      time: event.time != null && event.time != null
                          ? event.time!
                          : 'N/A',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
