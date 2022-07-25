import 'package:dio/dio.dart' hide Headers;
import 'package:alnaqel_seller/utilities/device_utils.dart';

class ServerError implements Exception {
  int? _errorCode;
  String _errorMessage = "";

  ServerError.withError({error}) {
    _handleError(error);
  }

  getErrorCode() {
    return _errorCode;
  }

  getErrorMessage() {
    return _errorMessage;
  }

  _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        _errorMessage = "Connection timeout";
        DeviceUtils.toastMessage('Connection timeout');
        break;
      case DioErrorType.sendTimeout:
        _errorMessage = "Receive timeout in send request";
        DeviceUtils.toastMessage('Receive timeout in send request');
        break;
      case DioErrorType.receiveTimeout:
        _errorMessage = "Receive timeout in connection";
        DeviceUtils.toastMessage('Receive timeout in connection');
        break;
      case DioErrorType.response:
        _errorMessage = "Received invalid status code: ${error.response!.data}";
        try {
          print('=========');
          print(error.response!.data);
          DeviceUtils.toastMessage(error.response!.data['message'].toString());
        } catch (error1, stacktrace) {
          DeviceUtils.toastMessage(error.response!.data.toString());
          print(
              "Exception occurred: $error stackTrace: $stacktrace apiError: ${error.response!.data}");
        }
        break;
      case DioErrorType.cancel:
        _errorMessage = "Request was cancelled";
        DeviceUtils.toastMessage('Request was cancelled');
        break;
      case DioErrorType.other:
        _errorMessage = "Connection failed due to internet connection";
        DeviceUtils.toastMessage(
            'Connection failed due to internet connection');
        break;
    }
    return _errorMessage;
  }
}
