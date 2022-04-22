import 'package:get/get.dart';
import 'package:watercooler/pages/admin%20pages/add_event_page.dart';
import 'package:watercooler/pages/login%20pages/login_page.dart';
import 'package:watercooler/pages/login%20pages/signup_page.dart';
import 'package:watercooler/pages/login%20pages/welcome_page.dart';
import 'package:watercooler/pages/user%20pages/chat_page.dart';
import 'package:watercooler/pages/user%20pages/emergency_call_page.dart';
import 'package:watercooler/pages/user%20pages/event_details_page.dart';
import 'package:watercooler/pages/user%20pages/profile_page.dart';

import '../pages/user pages/home_page.dart';
import '../pages/user pages/user_chat_page.dart';

class RouteHelper {
  static const String initial = "/";
  static const String login = "/login";
  static const String signup = "/signup";
  static const String home = "/home";
  static const String eventDetails = "/eventDetails";
  static const String profile = "/profile";
  static const String chat = "/chat";
  static const String userChat = "/userChat";
  static const String emergency = "/emergency";
  static const String addEvent = "/addEvent";

  static String getInitial() => '$initial';
  static String getLogin() => '$login';
  static String getSignup() => '$signup';
  static String getHome() => '$home';
  static String getEventDetails(int pageId) => '$eventDetails?pageId=$pageId';
  static String getProfile() => '$profile';
  static String getChat() => '$chat';
  static String getUserChat(int pageId) => '$userChat?pageId=$pageId';
  static String getEmergency() => '$emergency';
  static String getAddEvent() => '$addEvent';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => WelcomePage()),
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: signup, page: () => SignUpPage()),
    GetPage(name: home, page: () => HomePage()),
    GetPage(
        name: eventDetails,
        page: () {
          var pageId = Get.parameters['pageId'];
          return EventDetailsPage(
            pageId: int.parse(pageId!),
          );
        }),
    GetPage(name: profile, page: () => ProfilePage()),
    GetPage(name: chat, page: () => ChatPage()),
    GetPage(
        name: userChat,
        page: () {
          var pageId = Get.parameters['pageId'];
          return UserChatPage(
            pageId: int.parse(pageId!),
          );
        }),
    GetPage(name: emergency, page: () => EmergencyCallPage()),
    GetPage(name: addEvent, page: () => AddEventPage()),
  ];
}
