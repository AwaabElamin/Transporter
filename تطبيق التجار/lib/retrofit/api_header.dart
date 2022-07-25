import 'package:dio/dio.dart';
import 'package:alnaqel_seller/utilities/prefConstatnt.dart';
import 'package:alnaqel_seller/utilities/preference.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiHeader {
  Dio dioData() {
    final dio = Dio(); // config your dio headers globally
    dio.interceptors.add(PrettyDioLogger());
// customization
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        request: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        ));
    dio.options.headers["Authorization"] = "Bearer" +
        "  " +
        SharedPreferenceHelper.getString(
            Preferences.token); // config your dio headers globally
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Content-Type"] = "application/x-www-form-urlencoded";
    dio.options.followRedirects = false;
    print('call api');
    return dio;
  }
}
