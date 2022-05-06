import 'dart:convert';

import 'package:cas/data/urls.dart';
import 'package:cas/models/user.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<List<User>> getUsers() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var url = Uri.parse(urls['users']!);
  var answer = await http.get(
    url,
    headers: {
      "Authorization": "Bearer ${sharedPreferences.getString('token')}",
    },
  );
  if (answer.statusCode == 200) {
    var list = (json as List).map((item) => User.fromJson(item)).toList();
    return list;
  } else {
    return [];
  }
}

final users = getUsers();
