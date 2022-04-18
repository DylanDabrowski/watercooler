import 'package:get/get.dart';
import 'package:watercooler/data/repository/events_repo.dart';

import '../controllers/events_controller.dart';
import '../data/api/api_client.dart';
import '../utils/app_constants.dart';

Future<void> init() async {
  // api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  // repos
  Get.lazyPut(() => EventsRepo(apiClient: Get.find()));

  // controllers
  Get.lazyPut(() => EventsController(eventsRepo: Get.find()));
}
