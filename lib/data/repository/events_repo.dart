import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class EventsRepo extends GetxService {
  final ApiClient apiClient;

  EventsRepo({
    required this.apiClient,
  });

  Future<Response> getEvents() async {
    return await apiClient.get(AppConstants.EVENTS_URI);
  }
}
