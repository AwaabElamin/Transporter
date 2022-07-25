import 'package:dio/dio.dart' hide Headers;
import 'package:alnaqel_driver/model/deliveryzone.dart';
import 'package:alnaqel_driver/model/displaydriver.dart';
import 'package:alnaqel_driver/model/earninghistory.dart';
import 'package:alnaqel_driver/model/faq.dart';
import 'package:alnaqel_driver/model/notification.dart';
import 'package:alnaqel_driver/model/orderhistory.dart';
import 'package:alnaqel_driver/model/orderlistdata.dart';
import 'package:alnaqel_driver/model/orderwiseearning.dart';
import 'package:alnaqel_driver/model/register.dart';
import 'package:alnaqel_driver/model/setting.dart';
import 'package:retrofit/retrofit.dart';

part 'Apiservice.g.dart';

@RestApi(baseUrl: 'http://192.168.8.100:8000/api/driver/')
// @RestApi(
//     baseUrl: 'https://dev.transporter-sudan.com/api/driver/')
//@RestApi(baseUrl: 'Enter_YOUR_BASE_URL_HERE/api/driver/')
//please don't remove "/api/driver".
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  // @POST("/posts")
  // Future<List<loginmodel>> getTasks();

  @POST("driver_login")
  @FormUrlEncoded()
  Future<String?> driverlogin(@Field('email_id') String emailId, @Field() String password,
      @Field() String deviceToken);

  @POST("driver_register")
  @FormUrlEncoded()
  Future<register> driverregister(
    @Field() String firstName,
    @Field() String lastName,
    @Field() String emailId,
    @Field() String phone,
    @Field() String phoneCode,
    @Field() String password,
    @Field() String address,
  );

  @POST("driver_check_otp")
  @FormUrlEncoded()
  Future<String?> drivercheckotp(
    @Field() String driverId,
    @Field() String otp,
  );

  @POST("driver_resendOtp")
  @FormUrlEncoded()
  Future<String?> driverresendotp(
    @Field() String emailId,
  );

  @GET("driver_setting")
  Future<Setting> driversetting();

  @POST("update_document")
  @FormUrlEncoded()
  Future<String?> driveruploaddocument(
    @Field() String? vehicleType,
    @Field() String vehicleNumber,
    @Field() String licenceNumber,
    @Field() String nationalIdentity,
    @Field() String licenceDoc,
  );

  @GET("delivery_zone")
  Future<Deliveryzone> driverdeliveryZone();

  @POST("set_location")
  @FormUrlEncoded()
  Future<String?> driversetdeliveryzone(
    @Field() String deliveryZoneId,
  );

  @POST("update_driver")
  @FormUrlEncoded()
  Future<String?> driverupdatestatus(
    @Field() String isOnline,
  );

  @GET("driver")
  Future<Displaydriver> driverprofile();

  @POST("update_driver_image")
  @FormUrlEncoded()
  Future<String?> driverupdateimage(
    @Field() String image,
  );

  @POST("update_driver")
  @FormUrlEncoded()
  Future<String?> drivereditprofile(
    @Field() String? firstName,
    @Field() String? lastName,
    @Field() String? phoneCode,
    @Field() String emailId,
    @Field() String? phone,
  );

  @POST("delivery_person_change_password")
  @FormUrlEncoded()
  Future<String?> driverchangepassword(
    @Field() String oldPassword,
    @Field() String password,
    @Field() String passwordConfirmation,
  );

  @GET("earning")
  Future<Earninghistory> driverearninghistory();

  @GET("driver_order")
  Future<orderlistdata> driveorderlist();

  @GET("driver_order")
  Future<String?> driveorderlist1();

  @GET("order_history")
  Future<orderhistory> driverorderhistory();

  //
  @GET("order_earning")
  Future<orderwiseearning> driverorderwiseearning();

  //
  //
  @GET("notification")
  Future<notification> drivernotification();

  //
  @GET("driver_faq")
  Future<faq> driverfaq();

  // @POST("status_change")
  // @FormUrlEncoded()
  // Future<orderstatus> orderstatuschange(
  //     @Field() String order_id,
  //     @Field() String order_status,
  //    );

  @POST("status_change")
  @FormUrlEncoded()
  Future<String?> orderstatuschange1(
    @Field() String? orderId,
    @Field() String orderStatus,
  );

  @POST("status_change")
  @FormUrlEncoded()
  Future<String?> cancelorder(
    @Field() String? orderId,
    @Field() String orderStatus,
    @Field() String? cancelReason,
  );

  @POST("update_lat_lang")
  @FormUrlEncoded()
  Future<String?> driveupdatelatlong(
    @Field() String lat,
    @Field() String lang,
  );

  @POST("forgot_password_otp")
  @FormUrlEncoded()
  Future<String?> driverforgotpassotp(
    @Field() String emailId,
  );

  @POST("forgot_password_check_otp")
  @FormUrlEncoded()
  Future<String?> driverforgotcheckotp(
    @Field() String driverId,
    @Field() String otp,
  );

  @POST("forgot_password")
  @FormUrlEncoded()
  Future<String?> driverforgotpassword(
    @Field() String password,
    @Field() String passwordConfirmation,
    @Field() String userId,
  );
}
