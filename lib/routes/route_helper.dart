import 'package:get/get.dart';
import 'package:watercooler/pages/login%20pages/login_page.dart';
import 'package:watercooler/pages/login%20pages/signup_page.dart';
import 'package:watercooler/pages/login%20pages/welcome_page.dart';

class RouteHelper {
  static const String initial = "/";
  static const String login = "/login";
  static const String signup = "/signup";

  static String getInitial() => '$initial';
  static String getLogin() => '$login';
  static String getSignup() => '$signup';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => WelcomePage()),
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: signup, page: () => SignupPage()),
  ];
}
