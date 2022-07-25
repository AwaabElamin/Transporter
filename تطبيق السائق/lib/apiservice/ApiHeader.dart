import 'package:dio/dio.dart';
import 'package:alnaqel_driver/util/constants.dart';
import 'package:alnaqel_driver/util/preferenceutils.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiHeader {
  Dio dioData() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
// customization
   dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,));

    dio.options.headers["Authorization"] = "Bearer" +
        "  " +
        PreferenceUtils.getString(
            Constants.headertoken); // config your dio headers globally
    dio.options.headers["Accept"] =
        "application/json"; // config your dio headers globally
    // dio.options.headers["Content-Type"] = "application/x-www-form-urlencoded";
    dio.options.followRedirects = false;

    // print("tokwen123:${PreferenceUtils.getString(Constants.headertoken)}");

    return dio;
  }
}
