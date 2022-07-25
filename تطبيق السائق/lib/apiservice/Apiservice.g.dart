// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Apiservice.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://dev.transporter-sudan.com/api/driver/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<String?> driverlogin(emailId, password, deviceToken) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'email_id': emailId,
      'password': password,
      'deviceToken': deviceToken
    };
    final _result = await _dio.fetch<String>(_setStreamType<String>(Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded')
        .compose(_dio.options, 'driver_login',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<register> driverregister(
      firstName, lastName, emailId, phone, phoneCode, password, address) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'firstName': firstName,
      'lastName': lastName,
      'emailId': emailId,
      'phone': phone,
      'phoneCode': phoneCode,
      'password': password,
      'address': address
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<register>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'driver_register',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = register.fromJson(_result.data!);
    return value;
  }

  @override
  Future<String?> drivercheckotp(driverId, otp) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'driverId': driverId, 'otp': otp};
    final _result = await _dio.fetch<String>(_setStreamType<String>(Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded')
        .compose(_dio.options, 'driver_check_otp',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<String?> driverresendotp(emailId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'emailId': emailId};
    final _result = await _dio.fetch<String>(_setStreamType<String>(Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded')
        .compose(_dio.options, 'driver_resendOtp',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<Setting> driversetting() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Setting>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'driver_setting',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Setting.fromJson(_result.data!);
    return value;
  }

  @override
  Future<String?> driveruploaddocument(vehicleType, vehicleNumber,
      licenceNumber, nationalIdentity, licenceDoc) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'vehicleType': vehicleType,
      'vehicleNumber': vehicleNumber,
      'licenceNumber': licenceNumber,
      'nationalIdentity': nationalIdentity,
      'licenceDoc': licenceDoc
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<String>(_setStreamType<String>(Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded')
        .compose(_dio.options, 'update_document',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<Deliveryzone> driverdeliveryZone() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Deliveryzone>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'delivery_zone',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Deliveryzone.fromJson(_result.data!);
    return value;
  }

  @override
  Future<String?> driversetdeliveryzone(deliveryZoneId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'deliveryZoneId': deliveryZoneId};
    final _result = await _dio.fetch<String>(_setStreamType<String>(Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded')
        .compose(_dio.options, 'set_location',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<String?> driverupdatestatus(isOnline) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'isOnline': isOnline};
    final _result = await _dio.fetch<String>(_setStreamType<String>(Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded')
        .compose(_dio.options, 'update_driver',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<Displaydriver> driverprofile() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Displaydriver>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'driver',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Displaydriver.fromJson(_result.data!);
    return value;
  }

  @override
  Future<String?> driverupdateimage(image) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'image': image};
    final _result = await _dio.fetch<String>(_setStreamType<String>(Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded')
        .compose(_dio.options, 'update_driver_image',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<String?> drivereditprofile(
      firstName, lastName, phoneCode, emailId, phone) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'firstName': firstName,
      'lastName': lastName,
      'phoneCode': phoneCode,
      'emailId': emailId,
      'phone': phone
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<String>(_setStreamType<String>(Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded')
        .compose(_dio.options, 'update_driver',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<String?> driverchangepassword(
      oldPassword, password, passwordConfirmation) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'oldPassword': oldPassword,
      'password': password,
      'passwordConfirmation': passwordConfirmation
    };
    final _result = await _dio.fetch<String>(_setStreamType<String>(Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded')
        .compose(_dio.options, 'delivery_person_change_password',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<Earninghistory> driverearninghistory() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Earninghistory>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'earning',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Earninghistory.fromJson(_result.data!);
    return value;
  }

  @override
  Future<orderlistdata> driveorderlist() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<orderlistdata>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'driver_order',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = orderlistdata.fromJson(_result.data!);
    return value;
  }

  @override
  Future<String?> driveorderlist1() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<String>(_setStreamType<String>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options, 'driver_order',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<orderhistory> driverorderhistory() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<orderhistory>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'order_history',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = orderhistory.fromJson(_result.data!);
    return value;
  }

  @override
  Future<orderwiseearning> driverorderwiseearning() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<orderwiseearning>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'order_earning',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = orderwiseearning.fromJson(_result.data!);
    return value;
  }

  @override
  Future<notification> drivernotification() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<notification>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'notification',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = notification.fromJson(_result.data!);
    return value;
  }

  @override
  Future<faq> driverfaq() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<faq>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options, 'driver_faq',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = faq.fromJson(_result.data!);
    return value;
  }

  @override
  Future<String?> orderstatuschange1(orderId, orderStatus) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {'orderId': orderId, 'orderStatus': orderStatus};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<String>(_setStreamType<String>(Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded')
        .compose(_dio.options, 'status_change',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<String?> cancelorder(orderId, orderStatus, cancelReason) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'order_id': orderId,
      'order_status': orderStatus,
      'cancel_reason': cancelReason
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<String>(_setStreamType<String>(Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded')
        .compose(_dio.options, 'status_change',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<String?> driveupdatelatlong(lat, lang) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'lat': lat, 'lang': lang};
    final _result = await _dio.fetch<String>(_setStreamType<String>(Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded')
        .compose(_dio.options, 'update_lat_lang',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<String?> driverforgotpassotp(emailId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'emailId': emailId};
    final _result = await _dio.fetch<String>(_setStreamType<String>(Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded')
        .compose(_dio.options, 'forgot_password_otp',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<String?> driverforgotcheckotp(driverId, otp) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'driverId': driverId, 'otp': otp};
    final _result = await _dio.fetch<String>(_setStreamType<String>(Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded')
        .compose(_dio.options, 'forgot_password_check_otp',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<String?> driverforgotpassword(
      password, passwordConfirmation, userId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'password': password,
      'passwordConfirmation': passwordConfirmation,
      'userId': userId
    };
    final _result = await _dio.fetch<String>(_setStreamType<String>(Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded')
        .compose(_dio.options, 'forgot_password',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
