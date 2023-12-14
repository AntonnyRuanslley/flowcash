import 'dart:convert';

import 'package:flowcash/data/users.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../data/urls.dart';

class SettingsService extends GetxService {
  bool? _hasChoice;
  bool? _isOnline;

  bool get hasChoice => _hasChoice ?? false;
  bool get isOnline => _isOnline ?? false;

  Future<SettingsService> init() async {
    await getChoice();
    return this;
  }

  Future<void> getChoice() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getBool('choice') == null) {
      _hasChoice = false;
    } else {
      _isOnline = sharedPreferences.getBool('choice');
      _hasChoice = true;
    }
  }

  Future<void> postChoice({
    required bool choice,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (choice) {
      await sharedPreferences.setBool('choice', true);
    } else {
      await sharedPreferences.setBool('choice', false);
    }
    getChoice();
  }

  Future<bool> onLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString('token') == null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse(urls['user_logged']!);
    var answer = await http.get(url, headers: {
      "Authorization": "Bearer ${sharedPreferences.getString('token')}",
    });

    nameUser = jsonDecode(answer.body)['name'].toString();
    var isAdmin = jsonDecode(answer.body)['administrator'] as bool;

    return isAdmin;
  }

  Future<bool> cleanChoice() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove('choice');
    getChoice();
    return true;
  }
}
