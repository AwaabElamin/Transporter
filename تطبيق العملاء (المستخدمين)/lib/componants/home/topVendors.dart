import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:alnaqel_user/model/top_restaurants_model.dart';
import 'package:alnaqel_user/screen_animation_utils/transitions.dart';
import 'package:alnaqel_user/screens/restaurants_details_screen.dart';
import 'package:alnaqel_user/utils/constants.dart';
import 'package:alnaqel_user/utils/localization/language/languages.dart';

class TopVendors extends StatelessWidget {
  const TopVendors({
    Key? key,
    required this.isSyncing,
    required this.onLike,
    required this.getTopRestaurantsFood,
    required this.topListData,
  }) : super(key: key);
  final bool isSyncing;
  final List<TopRestaurantsListData> topListData;
  final Function(int index) onLike;
  final String? Function(int index) getTopRestaurantsFood;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(220),
      child: topListData.length == 0
          ? !isSyncing
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
                          Languages.of(context)!.labelNoData,
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
              : Container()
          : GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: ScreenUtil().screenWidth / 1.1,
              ),
              itemCount: topListData.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          Transitions(
                            transitionType: TransitionType.fade,
                            curve: Curves.bounceInOut,
                            reverseCurve: Curves.fastLinearToSlowEaseIn,
                            widget: RestaurantsDetailsScreen(
                              restaurantId: topListData[index].id,
                              isFav: topListData[index].like,
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
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: CachedNetworkImage(
                                  width: 100,
                                  imageUrl: topListData[index].image ?? 'err',
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) =>
                                      SpinKitFadingCircle(
                                          color: Color(Constants.colorTheme)),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    child: Center(
                                        child:
                                            Image.asset('images/noimage.png')),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  width: ScreenUtil().screenWidth / 2,
                                  child: Wrap(
                                    alignment: WrapAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  topListData[index].name ??
                                                      'err',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontFamily:
                                                          Constants.appFontBold,
                                                      fontSize: ScreenUtil()
                                                          .setSp(16.0)),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    onLike(index);
                                                  },
                                                  child: Container(
                                                    child: topListData[index]
                                                                .like ??
                                                            false
                                                        ? SvgPicture.asset(
                                                            'images/ic_filled_heart.svg',
                                                            color: Color(
                                                                Constants
                                                                    .colorLike),
                                                            height: ScreenUtil()
                                                                .setHeight(
                                                                    20.0),
                                                            width: ScreenUtil()
                                                                .setWidth(20.0),
                                                          )
                                                        : SvgPicture.asset(
                                                            'images/ic_heart.svg',
                                                            height: ScreenUtil()
                                                                .setHeight(
                                                                    20.0),
                                                            width: ScreenUtil()
                                                                .setWidth(20.0),
                                                          ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Container(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                getTopRestaurantsFood(index) ??
                                                    '',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontFamily:
                                                        Constants.appFont,
                                                    color: Color(
                                                        Constants.colorGray),
                                                    fontSize: ScreenUtil()
                                                        .setSp(12.0)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 3),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    child: SvgPicture.asset(
                                                      'images/ic_map.svg',
                                                      width: 10,
                                                      height: 10,
                                                    ),
                                                  ),
                                                  Text(
                                                    topListData[index]
                                                            .distance
                                                            .toString() +
                                                        Languages.of(context)!
                                                            .labelKmFarAway,
                                                    style: TextStyle(
                                                      fontSize: ScreenUtil()
                                                          .setSp(12.0),
                                                      fontFamily:
                                                          Constants.appFont,
                                                      color: Color(0xFF132229),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      RatingBar.builder(
                                                        initialRating:
                                                            topListData[index]
                                                                .rate
                                                                .toDouble(),
                                                        ignoreGestures: true,
                                                        minRating: 1,
                                                        direction:
                                                            Axis.horizontal,
                                                        itemSize: ScreenUtil()
                                                            .setWidth(12),
                                                        allowHalfRating: true,
                                                        itemBuilder:
                                                            (context, _) =>
                                                                Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                        ),
                                                        onRatingUpdate:
                                                            (double rating) {
                                                          print(rating);
                                                        },
                                                      ),
                                                      Text(
                                                        '(${topListData[index].review})',
                                                        style: TextStyle(
                                                          fontSize: ScreenUtil()
                                                              .setSp(12.0),
                                                          fontFamily:
                                                              Constants.appFont,
                                                          color:
                                                              Color(0xFF132229),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      bottom: 5,
                                                    ),
                                                    child: (() {
                                                      if (topListData[index]
                                                              .vendorType ==
                                                          'veg') {
                                                        return Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right: 2),
                                                              child: SvgPicture
                                                                  .asset(
                                                                'images/ic_veg.svg',
                                                                height: 10,
                                                                width: 10,
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      } else if (topListData[
                                                                  index]
                                                              .vendorType ==
                                                          'non_veg') {
                                                        return Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right: 2),
                                                              child: SvgPicture
                                                                  .asset(
                                                                'images/ic_non_veg.svg',
                                                                height: 10,
                                                                width: 10,
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      } else if (topListData[
                                                                  index]
                                                              .vendorType ==
                                                          'all') {
                                                        return Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right: 2),
                                                              child: SvgPicture
                                                                  .asset(
                                                                'images/ic_veg.svg',
                                                                height: 10,
                                                                width: 10,
                                                              ),
                                                            ),
                                                            SvgPicture.asset(
                                                              'images/ic_non_veg.svg',
                                                              height: 10,
                                                              width: 10,
                                                            )
                                                          ],
                                                        );
                                                      }
                                                    }()),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
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
                  ),
                );
              },
            ),
    );
  }
}
