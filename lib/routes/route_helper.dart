import 'package:get/get.dart';
import 'package:watercooler/models/user_model.dart';
import 'package:watercooler/pages/login%20pages/login_page.dart';
import 'package:watercooler/pages/login%20pages/signup_page.dart';
import 'package:watercooler/pages/login%20pages/welcome_page.dart';
import 'package:watercooler/pages/user%20pages/chat_page.dart';
import 'package:watercooler/pages/user%20pages/emergency_call_page.dart';
import 'package:watercooler/pages/user%20pages/profile_page.dart';

import '../pages/user pages/home_page.dart';

class RouteHelper {
  static const String initial = "/";
  static const String login = "/login";
  static const String signup = "/signup";
  static const String home = "/home";
  static const String profile = "/profile";
  static const String chat = "/chat";
  static const String emergency = "/emergency";

  static String getInitial() => '$initial';
  static String getLogin() => '$login';
  static String getSignup() => '$signup';
  static String getHome() => '$home';
  static String getProfile() => '$profile';
  static String getChat() => '$chat';
  static String getEmergency() => '$emergency';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => WelcomePage()),
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: signup, page: () => SignUpPage()),
    GetPage(name: home, page: () => HomePage()),
    GetPage(name: profile, page: () => ProfilePage()),
    GetPage(name: chat, page: () => ChatPage()),
    GetPage(name: emergency, page: () => EmergencyCallPage()),
  ];
}
