class VehicletypeList {
  final List<VehicleType>? photos;

  VehicletypeList({
    this.photos,
  });

  factory VehicletypeList.fromJson(List<dynamic> parsedJson) {
    List<VehicleType> photos = <VehicleType>[];
    photos = parsedJson.map((i) => VehicleType.fromJson(i)).toList();

    return new VehicletypeList(photos: photos);
  }
}

class VehicleType {
  final String? license;
  final String? vehicalType;

  VehicleType({this.license, this.vehicalType});

  factory VehicleType.fromJson(Map<String, dynamic> json) {
    return new VehicleType(
      license: json['license'].toString(),
      vehicalType: json['vehical_type'],
    );
  }
}
