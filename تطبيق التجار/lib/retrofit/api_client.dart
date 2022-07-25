import 'package:alnaqel_seller/models/address.dart';
import 'package:dio/dio.dart';
import 'package:alnaqel_seller/models/common_response.dart';
import 'package:alnaqel_seller/models/earning_history_response.dart';
import 'package:alnaqel_seller/models/faq_response.dart';
import 'package:alnaqel_seller/models/insights_response.dart';
import 'package:alnaqel_seller/models/menu.dart';
import 'package:alnaqel_seller/models/my_cash_balance_response.dart';
import 'package:alnaqel_seller/models/orders_response.dart';
import 'package:alnaqel_seller/models/product_customization_response.dart';
import 'package:alnaqel_seller/models/product_response.dart';
import 'package:alnaqel_seller/models/user.dart';
import 'package:alnaqel_seller/models/vendor_detail.dart';
import 'package:alnaqel_seller/models/vendor_setting_response.dart';
import 'package:flutter/foundation.dart';
import 'package:retrofit/retrofit.dart';

import 'apis.dart';

part 'api_client.g.dart';

//@RestApi(baseUrl: 'Enter_YOUR_BASE_URL_HERE/api/vendor/')
@RestApi(baseUrl:kDebugMode?'http://192.168.8.100:8000/api/vendor/': 'https://dev.transporter-sudan.com/api/vendor/')
// @RestApi(baseUrl: 'http://192.168.8.100:8000/api/vendor/')
//Please don't remove "/api/vendor/".
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @POST(Apis.login)
  @FormUrlEncoded()
  Future<User> login(
      @Field('email_id') String email,
      @Field('password') String password,
      @Field('device_token') String deviceToken);

  @POST(Apis.createOrder)
  @FormUrlEncoded()
  Future<CommonResponse> createOrder(
      @Field('user_id') int? userId,
      @Field('date') String date,
      @Field('time') String time,
      @Field('amount') double amount,
      @Field('item') List<Map<String,dynamic>> items,
      @Field('delivery_type') String deliveryType,
      @Field('address_id') int? addressId,
      @Field('delivery_charge') String? deliveryCharge,
      @Field('payment_status') int? paymentStatus,
      @Field('payment_type') String? paymentType,
       @Field('special') int? special,
  );

  @POST(Apis.createUser)
  @FormUrlEncoded()
  Future<User> createUser(
    @Field('name') String name,
    @Field('phone') int phone,
  );


  @POST(Apis.users)
  Future<Users> getUsers();

  @GET('${Apis.userAddress}/{id}')
  Future<Address> getUserAddress(@Path() int? id);

  @POST(Apis.createAddress)
  @FormUrlEncoded()
  Future<Address> createAddress(
    @Field('user_id') int userId,
    @Field('lat') double lat,
    @Field('lang') double lang,
    @Field('address') String address,
  );

  @POST(Apis.register)
  @FormUrlEncoded()
  Future<User> register(@Body() Map<String, String> param);

  @GET(Apis.menu)
  Future<Menu> menu();

  @POST(Apis.createMenu)
  @FormUrlEncoded()
  Future<CommonResponse> createMenu(@Body() Map<String, String> param);

  @GET('${Apis.subMenu}/{id}')
  Future<ProductResponse> subMenu(@Path() int? id);

  @POST(Apis.createSubmenu)
  @FormUrlEncoded()
  Future<CommonResponse> createSubmenu(@Body() Map<String, String?> param);

  @GET(Apis.orders)
  Future<OrdersResponse> orders();

  @GET(Apis.insights)
  Future<InsightsResponse> insights();

  @GET(Apis.cashBalance)
  Future<MyCashBalanceResponse> cashBalance();

  @GET(Apis.earningHistory)
  Future<EarningHistoryResponse> earningHistory();

  @GET(Apis.faq)
  Future<FaqResponse> faq();

  @POST(Apis.changeStatus)
  @FormUrlEncoded()
  Future<CommonResponse> changeStatus(@Body() Map<String, String?> param);

  @GET('${Apis.customization}/{id}')
  Future<ProductCustomizationResponse> getCustomization(@Path() int? id);

  @POST('${Apis.updateSubmenu}/{id}')
  @FormUrlEncoded()
  Future<CommonResponse> updateSubmenu(
      @Path() int? id, @Body() Map<String, String?> param);

  @POST(Apis.updateProfile)
  @FormUrlEncoded()
  Future<CommonResponse> updateProfile(@Body() Map<String, String> param);

  @GET(Apis.vendorDetail)
  Future<VendorDetail> vendorDetail();

  @GET(Apis.vendorSetting)
  Future<VendorSettingResponse> vendorSetting();

  @POST(Apis.changePassword)
  @FormUrlEncoded()
  Future<CommonResponse> changePassword(@Body() Map<String, String> param);

  @POST(Apis.checkOTP)
  @FormUrlEncoded()
  Future<User> checkOTP(@Body() Map<String, String> param);

  @POST(Apis.resendOTP)
  @FormUrlEncoded()
  Future<User> resendOTP(@Body() Map<String, String> param);
}
