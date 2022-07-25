import 'package:alnaqel_seller/retrofit/api_client.dart';
import 'package:alnaqel_seller/retrofit/api_header.dart';
import 'package:alnaqel_seller/retrofit/base_model.dart';
import 'package:alnaqel_seller/retrofit/server_error.dart';

Future<BaseModel<Address>> getAddress(int id) async {
  Address response;
  try {
    response = await ApiClient(ApiHeader().dioData()).getUserAddress(id);
  } catch (error, stacktrace) {
    print("Exception occur: $error stackTrace: $stacktrace");
    return BaseModel()..setException(ServerError.withError(error: error));
  }
  return BaseModel()..data = response;
}

Future<BaseModel<Address>> createAddress(
    {required int UserId,
    required double lat,
    required double lang,
    required String address}) async {
  Address response;
  try {
    response = await ApiClient(ApiHeader().dioData())
        .createAddress(UserId, lat, lang, address);
  } catch (error, stacktrace) {
    print("Exception occur: $error stackTrace: $stacktrace");
    return BaseModel()..setException(ServerError.withError(error: error));
  }
  return BaseModel()..data = response;
}

class Address {
  bool? _success;
  List<Data>? _data;

  bool? get success => _success;
  List<Data>? get data => _data;

  Address({bool? success, List<Data>? data}) {
    _success = success;
    _data = data;
  }

  Address.fromJson(dynamic json) {
    _success = json["success"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = _success;
    if (_data != null) {
      map["data"] = _data!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  int? _id;
  int? _userId;
  double? _lat;
  double? _lang;
  String? _address;

  int? get id => _id;
  String? get address => _address;
  double? get lat => _lat;
  double? get lang => _lang;
  int? get userId => _userId;
  void set setAddress(String address) => _address = address;
  void set setLat(double lat) => _lat = lat;
  void set setLang(double lang) => _lang = lang;
  void set setUserId(int id) => _userId = id;

  Data({int? id, String? address, double? lat, double? lang, int? userId}) {
    _id = id;
    _address = address;
    _lat = lat;
    _lang = lang;
    _userId = userId;
  }

  Data.fromJson(dynamic json) {
    _id = json["id"];
    _address = json["address"];
    _lat = double.parse(json["lat"]);
    _lang = double.parse(json["lang"]);
    _userId = json["user_id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["address"] = _address;
    map["lat"] = _lat;
    map["lang"] = _lang;
    map["user_id"] = _userId;
    return map;
  }
}
