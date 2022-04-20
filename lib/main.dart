import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watercooler/controllers/events_controller.dart';
import 'package:watercooler/pages/login%20pages/welcome_page.dart';
import 'package:watercooler/routes/route_helper.dart';
import 'helper/dependencies.dart' as dep;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<EventsController>().getEvents();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Watercooler',
      home: WelcomePage(),
      initialRoute: RouteHelper.initial,
      getPages: RouteHelper.routes,
    );
  }
}
