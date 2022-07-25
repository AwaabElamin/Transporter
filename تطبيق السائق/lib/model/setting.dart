class Setting {
  bool? success;
  Data? data;

  Setting({this.success, this.data});

  Setting.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? driverVehicalType;
  int? isDriverAcceptMultipleorder;
  String? driverAppId;
  String? driverAuthKey;
  String? driverApiKey;
  int? driverAcceptMultipleOrdercount;
  String? companyWhiteLogo;
  String? companyBlackLogo;
  int? driverAutoRefrese;
  String? cancelReason;
  String? globalDriver;
  String? zoner;
  String? whitelogo;
  String? blacklogo;

  Data(
      {this.driverVehicalType,
      this.isDriverAcceptMultipleorder,
      this.driverAppId,
      this.driverAuthKey,
      this.driverApiKey,
      this.driverAcceptMultipleOrdercount,
      this.companyWhiteLogo,
      this.zoner,
      this.companyBlackLogo,
      this.driverAutoRefrese,
      this.cancelReason,
      this.globalDriver,
      this.whitelogo,
      this.blacklogo});

  Data.fromJson(Map<String, dynamic> json) {
    driverVehicalType = json['driver_vehical_type'];
    isDriverAcceptMultipleorder = json['isDriverAcceptMultipleorder'];
    driverAppId = json['driver_app_id'];
    driverAuthKey = json['driver_auth_key'];
    driverApiKey = json['driver_api_key'];
    zoner = json['zoner'];
    driverAcceptMultipleOrdercount = json['driverAcceptMultipleOrdercount'];
    companyWhiteLogo = json['company_white_logo'];
    companyBlackLogo = json['company_black_logo'];
    driverAutoRefrese = json['driverAutoRefrese'];
    cancelReason = json['cancelReason'];
    globalDriver = json['global_driver'];
    whitelogo = json['whitelogo'];
    blacklogo = json['blacklogo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['driver_vehical_type'] = this.driverVehicalType;
    data['isDriverAcceptMultipleorder'] = this.isDriverAcceptMultipleorder;
    data['driver_app_id'] = this.driverAppId;
    data['driver_auth_key'] = this.driverAuthKey;
    data['driver_api_key'] = this.driverApiKey;
    data['driverAcceptMultipleOrdercount'] =
        this.driverAcceptMultipleOrdercount;
    data['company_white_logo'] = this.companyWhiteLogo;
    data['company_black_logo'] = this.companyBlackLogo;
    data['driverAutoRefrese'] = this.driverAutoRefrese;
    data['cancelReason'] = this.cancelReason;
    data['global_driver'] = this.globalDriver;
    data['whitelogo'] = this.whitelogo;
    data['blacklogo'] = this.blacklogo;
    return data;
  }
}
