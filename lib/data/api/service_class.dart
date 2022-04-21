import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:watercooler/utils/app_constants.dart';

import '../../models/login_model.dart';
import '../../models/signup_model.dart';

class APIService {
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

  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    http.Response? response;

    response = await http.post(
        Uri.parse(AppConstants.BASE_URL + AppConstants.LOGIN_URI),
        body: requestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      return LoginResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
