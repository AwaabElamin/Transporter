import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:alnaqel_user/model/common_res.dart';
import 'package:alnaqel_user/retrofit/api_header.dart';
import 'package:alnaqel_user/retrofit/api_client.dart';
import 'package:alnaqel_user/retrofit/base_model.dart';
import 'package:alnaqel_user/retrofit/server_error.dart';
import 'package:alnaqel_user/screen_animation_utils/transitions.dart';
import 'package:alnaqel_user/screens/manage_your_location.dart';
import 'package:alnaqel_user/utils/constants.dart';
import 'package:alnaqel_user/utils/localization/language/languages.dart';
import 'package:alnaqel_user/utils/rounded_corner_app_button.dart';
import 'package:alnaqel_user/utils_google_map/address_search.dart';
import 'package:alnaqel_user/utils_google_map/place_service.dart';

import 'package:uuid/uuid.dart';

class AddAddressScreen extends StatefulWidget {
  final bool isFromAddAddress;
  final double? currentLat, currentLong;
  final marker;

  const AddAddressScreen(
      {Key? key,
      required this.isFromAddAddress,
      required this.currentLat,
      required this.currentLong,
      required this.marker})
      : super(key: key);

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  late LatLng _initialCameraPosition;
  late GoogleMapController _controller;
  BitmapDescriptor _markerIcon = BitmapDescriptor.defaultMarker;

  TextEditingController _textFullAddress = new TextEditingController();

  TextEditingController _textAddressLable = new TextEditingController();

  String strLongitude = '',
      strLatitude = '',
      strSearchedAddress = '',
      strAddressLabel = '';

  Set<Marker> _createMarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId("marker_1"),
        position: _initialCameraPosition,
        icon: _markerIcon,
      ),
    ].toSet();
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
  }

  @override
  void initState() {
    super.initState();
    _markerIcon = widget.marker;
    _initialCameraPosition = LatLng(widget.currentLat!, widget.currentLong!);
  }

  @override
  Future<void> didUpdateWidget(covariant AddAddressScreen oldWidget) async {
    super.didUpdateWidget(oldWidget);
    // _createMarkerImageFromAsset(context);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(360, 690),
    );

    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: _initialCameraPosition, zoom: 13),
                  mapType: MapType.normal,
                  onMapCreated: _onMapCreated,
                  myLocationEnabled: true,
                  markers: _createMarker(),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final sessionToken = Uuid().v4();
                          var result = await showSearch(
                            context: context,
                            delegate: AddressSearch(sessionToken),
                          );
                          if (result != null) {
                            final placeDetails =
                                await PlaceApiProvider(sessionToken)
                                    .getPlaceDetailFromId(result.placeId);
                            setState(() {
                              String address = '';
                              address = result.description + '\n';
                              if (placeDetails.street != null)
                                address = address + placeDetails.street! + ' ';
                              if (placeDetails.city != null)
                                address = address + placeDetails.city!;
                              _textFullAddress.text = address;
                              strSearchedAddress = address;
                              print(result.lat);
                              print(result.longi);
                              strLongitude = result.longi.toString();
                              strLatitude = result.lat.toString();
                              _controller.animateCamera(
                                CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                      target: LatLng(double.parse(strLatitude),
                                          double.parse(strLongitude)),
                                      zoom: 18),
                                ),
                              );
                              _initialCameraPosition = LatLng(
                                  double.parse(strLatitude),
                                  double.parse(strLongitude));
                              _createMarker();
                            });
                          }
                        },
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      right: ScreenUtil().setHeight(10)),
                                  child: SvgPicture.asset(
                                    'images/search.svg',
                                    width: ScreenUtil().setWidth(15),
                                    color: Colors.black,
                                    height: ScreenUtil().setHeight(15),
                                  ),
                                ),
                              ),
                              TextSpan(
                                text:
                                    Languages.of(context)!.labelSearchLocation,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: Constants.appFontBold,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          strSearchedAddress,
                          style: TextStyle(
                              color: Color(Constants.colorGray),
                              fontFamily: Constants.appFont),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          Languages.of(context)!.labelHouseNo,
                          style: TextStyle(
                              fontFamily: Constants.appFontBold,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Container(
                          height: 100,
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _textFullAddress,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 10),
                                    hintText: Languages.of(context)!
                                        .labelTypeFullAddressHere,
                                    border: InputBorder.none),
                                maxLines: 3,
                                style: TextStyle(
                                    fontFamily: Constants.appFont,
                                    fontSize: 16,
                                    color: Color(
                                      Constants.colorGray,
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          Languages.of(context)!.labelLandmark,
                          style: TextStyle(
                              fontFamily: Constants.appFontBold,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 2, bottom: 2),
                              child: TextField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10),
                                  hintText: Languages.of(context)!
                                      .labelAnyLandmarkNearYourLocation,
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontFamily: Constants.appFont,
                                    color: Color(Constants.colorGray),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFFFFFFF),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 10),
                        child: RoundedCornerAppButton(
                          onPressed: () {
                            dialogShowDialog();
                          },
                          btnLabel: widget.isFromAddAddress
                              ? Languages.of(context)!.labelAddAddress
                              : 'Set This & Proceed to Payment',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }

  dialogShowDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 0, top: 20),
              child: Container(
                height: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Languages.of(context)!.labelAttachLabel,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            fontFamily: Constants.appFontBold,
                          ),
                        ),
                        GestureDetector(
                          child: Icon(Icons.close),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 1,
                      color: Color(0xffcccccc),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 2, bottom: 2),
                                child: TextField(
                                  controller: _textAddressLable,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 10),
                                    hintText: Languages.of(context)!
                                        .labelAddLabelForThisLocation,
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      fontFamily: Constants.appFont,
                                      color: Color(Constants.colorGray),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Color(0xFFFFFFFF),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              'images/ic_map.svg',
                              width: 18,
                              height: 18,
                              color: Color(Constants.colorTheme),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, top: 2),
                                child: Text(
                                  strSearchedAddress,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: Constants.appFont,
                                      color: Color(Constants.colorBlack)),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(
                          thickness: 1,
                          color: Color(0xffcccccc),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  Languages.of(context)!.labelCancel,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Constants.appFontBold,
                                      color: Color(Constants.colorGray)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: GestureDetector(
                                  onTap: () {
                                    if (strSearchedAddress.isEmpty) {
                                      Constants.toastMessage(
                                          Languages.of(context)!
                                              .labelPleaseSearchAddress);
                                    } else if (_textAddressLable.text.isEmpty) {
                                      Constants.toastMessage(
                                          Languages.of(context)!
                                              .labelPleaseAddLabelForAddress);
                                    } else {
                                      String strAddressLabel =
                                          _textAddressLable.text;
                                      if (strAddressLabel.trim().isNotEmpty) {
                                        callAddUserAddress(strAddressLabel);
                                      } else {
                                        Constants.toastMessage(
                                            'Please Add Label For Your Location');
                                      }
                                    }
                                  },
                                  child: Text(
                                    'Save',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Constants.appFontBold,
                                        color: Color(Constants.colorBlue)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<BaseModel<CommenRes>> callAddUserAddress(strAddressLabel) async {
    CommenRes response;
    try {
      Constants.onLoading(context);
      Map<String, String> body = {
        'address': strSearchedAddress,
        'lat': strLatitude,
        'lang': strLongitude,
        'type': strAddressLabel,
      };

      response = await RestClient(RetroApi().dioData()).addAddress(body);
      Constants.hideDialog(context);
      print(response.success);
      if (response.success!) {
        Navigator.pop(context);
        Navigator.of(context).pushReplacement(
          Transitions(
            transitionType: TransitionType.slideUp,
            curve: Curves.bounceInOut,
            reverseCurve: Curves.fastLinearToSlowEaseIn,
            widget: ManageYourLocation(),
          ),
        );
      } else {
        Constants.toastMessage(
            Languages.of(context)!.labelErrorWhileAddAddress);
      }
    } catch (error, stacktrace) {
      Constants.hideDialog(context);
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }
}
