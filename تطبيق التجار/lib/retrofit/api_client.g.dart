// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ApiClient implements ApiClient {
  _ApiClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://192.168.8.100:8000/api/vendor/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<User> login(email, password, deviceToken) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'email_id': email,
      'password': password,
      'device_token': deviceToken
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<User>(
        Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'login',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = User.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonResponse> createOrder(
      userId,
      date,
      time,
      amount,
      items,
      deliveryType,
      addressId,
      deliveryCharge,
      paymentStatus,
      paymentType,
      special) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'user_id': userId,
      'date': date,
      'time': time,
      'amount': amount,
      'item': items,
      'delivery_type': deliveryType,
      'address_id': addressId,
      'delivery_charge': deliveryCharge,
      'payment_status': paymentStatus,
      'payment_type': paymentType,
      'special': special
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonResponse>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'create_order',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<User> createUser(name, phone) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'name': name, 'phone': phone};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<User>(
        Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'create_user',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = User.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Users> getUsers() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Users>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'users',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Users.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Address> getUserAddress(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Address>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user_address/${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Address.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Address> createAddress(userId, lat, lang, address) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'user_id': userId,
      'lat': lat,
      'lang': lang,
      'address': address
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Address>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'create_user_address',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Address.fromJson(_result.data!);
    return value;
  }

  @override
  Future<User> register(param) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(param);
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<User>(
        Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'register',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = User.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Menu> menu() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<Menu>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options, 'menu',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Menu.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonResponse> createMenu(param) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(param);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonResponse>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'create_menu',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ProductResponse> subMenu(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ProductResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'submenu/${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ProductResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonResponse> createSubmenu(param) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(param);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonResponse>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'create_submenu',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<OrdersResponse> orders() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<OrdersResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'order',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = OrdersResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<InsightsResponse> insights() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<InsightsResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'insights',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = InsightsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MyCashBalanceResponse> cashBalance() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<MyCashBalanceResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'cash_balance',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MyCashBalanceResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<EarningHistoryResponse> earningHistory() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<EarningHistoryResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'finance_details',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = EarningHistoryResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FaqResponse> faq() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FaqResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'faq',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FaqResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonResponse> changeStatus(param) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(param);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonResponse>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'change_status',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ProductCustomizationResponse> getCustomization(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ProductCustomizationResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'custimization/${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ProductCustomizationResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonResponse> updateSubmenu(id, param) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(param);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonResponse>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'update_submenu/${id}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonResponse> updateProfile(param) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(param);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonResponse>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'update_profile',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<VendorDetail> vendorDetail() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VendorDetail>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'vendor_login',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = VendorDetail.fromJson(_result.data!);
    return value;
  }

  @override
  Future<VendorSettingResponse> vendorSetting() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VendorSettingResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'vendor_setting',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = VendorSettingResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonResponse> changePassword(param) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(param);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonResponse>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'change_password',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<User> checkOTP(param) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(param);
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<User>(
        Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'check_otp',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = User.fromJson(_result.data!);
    return value;
  }

  @override
  Future<User> resendOTP(param) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(param);
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<User>(
        Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'resend_otp',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = User.fromJson(_result.data!);
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
