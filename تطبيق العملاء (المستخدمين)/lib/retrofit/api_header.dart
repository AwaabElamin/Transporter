import 'package:dio/dio.dart';
import 'package:alnaqel_user/utils/constants.dart';
import 'package:alnaqel_user/utils/preference_utils.dart';

class RetroApi {
  Dio dioData() {
    final dio = Dio();
    dio.options.headers["Accept"] =
        "application/json"; // config your dio headers globally
    dio.options.headers["Authorization"] = "Bearer" +
        " " +
        PreferenceUtils.getString(
            Constants.headerToken); // config your dio headers globally
    dio.options.headers["Content-Type"] = "application/x-www-form-urlencoded";
    dio.options.followRedirects = false;
    return dio;
  }
}
