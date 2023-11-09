import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flowcash/data/users.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../data/urls.dart';
import '../routes/routes_names.dart';

class SplashScreenController extends GetxController {
  bool? _isOnline;

  bool get isOnline => _isOnline!;

  Future<bool> _onLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString('token') == null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> _getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse(urls['user_logged']!);
    var answer = await http.get(url, headers: {
      "Authorization": "Bearer ${sharedPreferences.getString('token')}",
    });

    nameUser = jsonDecode(answer.body)['name'].toString();
    var isAdmin = jsonDecode(answer.body)['administrator'] as bool;

    return isAdmin;
  }

  Future<bool> _onChoice() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getBool('choice') == null) {
      return true;
    } else {
      _isOnline = sharedPreferences.getBool('choice');
      return false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    _onChoice().then((result) async {
      if (result) {
        Get.offAndToNamed(RoutesNames.selectionPage);
      } else {
        if (_isOnline!) {
          final connectivityResult = await Connectivity().checkConnectivity();
          if (connectivityResult == ConnectivityResult.none) {
            Get.offAllNamed(RoutesNames.noConnectionPage);
            return;
          }
          _onLogin().then((value) {
            if (value) {
              Get.offAllNamed(RoutesNames.loginPage);
            } else {
              _getUser().then((value) {
                if (value) {
                  Get.offAllNamed(RoutesNames.homePage);
                } else {
                  Get.offAllNamed(RoutesNames.transactionsListPage);
                }
              });
            }
          });
        } else {
          Get.offAllNamed(RoutesNames.transactionsListLocalPage);
        }
      }
    });
  }
}
