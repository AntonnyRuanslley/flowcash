import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:cas/data/urls.dart';

class AuthController {
  static Future<bool> login(
    String email,
    String password,
    bool isChecked,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse(urls['login']!);
    var answer = await http.post(
      url,
      body: {
        "email": email,
        "password": password,
      },
    );
    if (answer.statusCode == 200) {
      if (isChecked) {
        await sharedPreferences.setString(
          'token',
          jsonDecode(answer.body)['token'].toString().split('|')[1],
        );
      }
      return true;
    } else {
      return false;
    }
  }
}
