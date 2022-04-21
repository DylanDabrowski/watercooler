import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:watercooler/utils/app_constants.dart';

import '../../models/signup_model.dart';

Future<http.Response?> register(SignUpBody data) async {
  http.Response? response;

  try {
    response = await http.post(
        Uri.parse(AppConstants.BASE_URL + AppConstants.REGISTER_URI),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode(data.toJson()));
  } catch (e) {
    log(e.toString());
  }
  return response;
}
