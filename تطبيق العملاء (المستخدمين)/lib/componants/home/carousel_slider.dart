import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:alnaqel_user/model/banner_response.dart';
import 'package:alnaqel_user/retrofit/api_client.dart';
import 'package:alnaqel_user/retrofit/api_header.dart';
import 'package:alnaqel_user/retrofit/base_model.dart';
import 'package:alnaqel_user/retrofit/server_error.dart';
import 'package:alnaqel_user/utils/constants.dart';

class HomeCarouselSlider extends StatefulWidget {
  const HomeCarouselSlider({Key? key}) : super(key: key);

  @override
  State<HomeCarouselSlider> createState() => _HomeCarouselSliderState();
}

class _HomeCarouselSliderState extends State<HomeCarouselSlider> {
  List<Data> banenrList = [];
  int _current = 0;
  Future<BaseModel<BannerResponse>> getBanners() async {
    BannerResponse response;
    try {
      response = await RestClient(RetroApi().dioData()).getBanner();
      if (response.data != null) {
        setState(() {
          print("check bannwe lwngrh ${response.data!.length}");
          banenrList = response.data!;
        });
      } else {
        banenrList = [];
      }
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  @override
  void initState() {
    super.initState();
    Constants.checkNetwork().whenComplete(() => getBanners());
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: banenrList.length > 0 ? true : false,
      child: CarouselSlider(
        options: CarouselOptions(
          viewportFraction: 0.8,
          autoPlayAnimationDuration: const Duration(milliseconds: 200),
          autoPlay: true,
          enlargeCenterPage: true,
          height: 150,
          onPageChanged: (index, index1) {
            setState(() {
              _current = index;
              print(_current);
            });
          },
        ),
        items: banenrList.map((it) {
          return Center(
            child: Container(
              /*decoration: BoxDecoration(
                                  color: Colors.red,
                                      borderRadius: BorderRadius.all(Radius.circular(100))
                                  ),*/
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  it.image ?? '',
                  fit: BoxFit.fill,
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
