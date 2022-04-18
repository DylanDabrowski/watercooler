import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watercooler/data/repository/events_repo.dart';
import '../models/event_model.dart';
import '../utils/colors.dart';

class EventsController extends GetxController {
  final EventsRepo eventsRepo;
  EventsController({
    required this.eventsRepo,
  });
  List<dynamic> _eventsList = [];
  List<dynamic> get eventsList => _eventsList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;
  // ^ can also be written like this:
  // int get quantity {
  //   return _quantity
  // };

  Future<void> getEvents() async {
    Response response = await eventsRepo.getEvents();

    if (response.statusCode == 200) {
      _eventsList = [];
      _eventsList.addAll(Events.fromJson(response.body).events);
      _isLoaded = true;
      update();
    } else {}
  }
}
