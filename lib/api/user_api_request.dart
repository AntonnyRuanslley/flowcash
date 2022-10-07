import 'package:cas/data/urls.dart';
import 'package:dio/dio.dart';

class UserApiRequest {
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await Dio().post(
        urls['login']!,
        queryParameters: {
          "email": email,
          "password": password,
        },
        options: Options(
          validateStatus: (status) {
            return status == 200;
          },
        ),
      );

      return response.data;
    } on DioError catch (e) {
      return {
        "success": "false",
      };
    }
  }
}
