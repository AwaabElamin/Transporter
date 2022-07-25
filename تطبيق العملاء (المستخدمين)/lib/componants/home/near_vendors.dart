import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:alnaqel_user/model/nearByRestaurantsModel.dart';
import 'package:alnaqel_user/screen_animation_utils/transitions.dart';
import 'package:alnaqel_user/screens/restaurants_details_screen.dart';
import 'package:alnaqel_user/utils/constants.dart';
import 'package:alnaqel_user/utils/localization/language/languages.dart';

class NearVendors extends StatefulWidget {
  const NearVendors({
    Key? key,
    required this.isSyncing,
    required this.onLike,
    required this.getRestaurantsFood,
    required this.nearbyListData,
  }) : super(key: key);
  final bool isSyncing;
  final List<NearByRestaurantListData> nearbyListData;
  final Function(int index) onLike;
  final String Function(int index) getRestaurantsFood;

  @override
  State<NearVendors> createState() => _NearVendorsState();
}

class _NearVendorsState extends State<NearVendors> {
  List<NearByRestaurantListData> _nearbyListData = [];
  @override
  Widget build(BuildContext context) {
    _nearbyListData = widget.nearbyListData;
    return Container(
      height: ScreenUtil().setHeight(220),
      child: (() {
        if (_nearbyListData.length == 0) {
          return !widget.isSyncing
              ? Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        width: ScreenUtil().setWidth(100),
                        height: ScreenUtil().setHeight(100),
                        image: AssetImage('images/ic_no_rest.png'),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                        child: Text(
                          Languages.of(context)!.labelNoRestNear,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(18),
                            fontFamily: Constants.appFontBold,
                            color: Color(Constants.colorTheme),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : Container();
        } else {
          return GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: ScreenUtil().screenWidth /
                  1.1, // <== change the height to fit your needs
            ),
            itemCount: _nearbyListData.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      Transitions(
                        transitionType: TransitionType.fade,
                        curve: Curves.bounceInOut,
                        reverseCurve: Curves.fastLinearToSlowEaseIn,
                        widget: RestaurantsDetailsScreen(
                          restaurantId: _nearbyListData[index].id,
                          isFav: _nearbyListData[index].like,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.only(bottom: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: CachedNetworkImage(
                              width: 100,
                              imageUrl: _nearbyListData[index].image!,
                              fit: BoxFit.fill,
                              placeholder: (context, url) =>
                                  SpinKitFadingCircle(
                                      color: Color(Constants.colorTheme)),
                              errorWidget: (context, url, error) => Container(
                                child: Center(
                                    child: Image.asset('images/noimage.png')),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              width: ScreenUtil().screenWidth / 2,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                _nearbyListData[index].name!,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontFamily:
                                                        Constants.appFontBold,
                                                    fontSize: ScreenUtil()
                                                        .setSp(16.0)),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () => widget.onLike(index),
                                              child: _nearbyListData[index]
                                                      .like!
                                                  ? SvgPicture.asset(
                                                      'images/ic_filled_heart.svg',
                                                      color: Color(
                                                          Constants.colorLike),
                                                      width: 20,
                                                    )
                                                  : SvgPicture.asset(
                                                      'images/ic_heart.svg',
                                                      width: 20,
                                                    ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            widget.getRestaurantsFood(index),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontFamily: Constants.appFont,
                                                color:
                                                    Color(Constants.colorGray),
                                                fontSize:
                                                    ScreenUtil().setSp(12.0)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(left: 8),
                                        child: Row(
                                          children: [
                                            RatingBar.builder(
                                              initialRating:
                                                  _nearbyListData[index]
                                                      .rate
                                                      .toDouble(),
                                              ignoreGestures: true,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              itemSize:
                                                  ScreenUtil().setWidth(12),
                                              allowHalfRating: true,
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (double rating) {
                                                print(rating);
                                              },
                                            ),
                                            Text(
                                              '(${_nearbyListData[index].review})',
                                              style: TextStyle(
                                                fontSize:
                                                    ScreenUtil().setSp(12.0),
                                                fontFamily: Constants.appFont,
                                                color: Color(0xFF132229),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(right: 10),
                                        child: (() {
                                          if (_nearbyListData[index]
                                                  .vendorType ==
                                              'veg') {
                                            return Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 2),
                                                  child: SvgPicture.asset(
                                                    'images/ic_veg.svg',
                                                    height: ScreenUtil()
                                                        .setHeight(10.0),
                                                    width: ScreenUtil()
                                                        .setHeight(10.0),
                                                  ),
                                                ),
                                              ],
                                            );
                                          } else if (_nearbyListData[index]
                                                  .vendorType ==
                                              'non_veg') {
                                            return Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 2),
                                                  child: SvgPicture.asset(
                                                    'images/ic_non_veg.svg',
                                                    height: ScreenUtil()
                                                        .setHeight(10.0),
                                                    width: ScreenUtil()
                                                        .setHeight(10.0),
                                                  ),
                                                ),
                                              ],
                                            );
                                          } else if (_nearbyListData[index]
                                                  .vendorType ==
                                              'all') {
                                            return Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 2),
                                                  child: SvgPicture.asset(
                                                    'images/ic_veg.svg',
                                                    height: ScreenUtil()
                                                        .setHeight(10.0),
                                                    width: ScreenUtil()
                                                        .setHeight(10.0),
                                                  ),
                                                ),
                                                SvgPicture.asset(
                                                  'images/ic_non_veg.svg',
                                                  height: ScreenUtil()
                                                      .setHeight(10.0),
                                                  width: ScreenUtil()
                                                      .setHeight(10.0),
                                                )
                                              ],
                                            );
                                          }
                                        }()),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      }()),
    );
  }
}
