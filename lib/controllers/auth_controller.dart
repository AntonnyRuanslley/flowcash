import '../api/user_api_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static Future<bool> login(
    String email,
    String password,
    bool isChecked,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final result = await UserApiRequest.login(
      email: email,
      password: password,
    );
    if (result['success'] != "false") {
      if (isChecked) {
        await sharedPreferences.setString(
          'token',
          result['token'].toString().split('|')[1],
        );
      }
      return true;
    } else {
      return false;
    }
  }
}
