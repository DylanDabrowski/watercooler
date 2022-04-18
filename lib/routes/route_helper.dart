import 'package:get/get.dart';
import 'package:watercooler/pages/login%20pages/login_page.dart';
import 'package:watercooler/pages/login%20pages/signup_page.dart';
import 'package:watercooler/pages/login%20pages/welcome_page.dart';

import '../pages/user pages/home_page.dart';

class RouteHelper {
  static const String initial = "/";
  static const String login = "/login";
  static const String signup = "/signup";
  static const String home = "/home";

  static String getInitial() => '$initial';
  static String getLogin() => '$login';
  static String getSignup() => '$signup';
  static String getHome() => '$home';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => WelcomePage()),
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: signup, page: () => SignupPage()),
    GetPage(name: home, page: () => HomePage()),
  ];
}
