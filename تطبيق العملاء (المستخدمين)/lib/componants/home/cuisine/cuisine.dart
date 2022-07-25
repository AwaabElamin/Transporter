import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:alnaqel_user/model/AllCuisinesModel.dart';
import 'package:alnaqel_user/screen_animation_utils/transitions.dart';
import 'package:alnaqel_user/screens/single_cuisine_details_screen.dart';
import 'package:alnaqel_user/utils/constants.dart';

class CuisineView extends StatelessWidget {
  const CuisineView({Key? key, required this.allCuisineListData})
      : super(key: key);
  final List<AllCuisineData> allCuisineListData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: SizedBox(
        height: ScreenUtil().setHeight(147),
        width: ScreenUtil().setWidth(114),
        child: ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: allCuisineListData.length,
          itemBuilder: (BuildContext context, int index) => Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(Transitions(
                    transitionType: TransitionType.none,
                    curve: Curves.bounceInOut,
                    reverseCurve: Curves.fastLinearToSlowEaseIn,
                    widget: SingleCuisineDetailsScreen(
                      cuisineId: allCuisineListData[index].id,
                      strCuisineName: allCuisineListData[index].name,
                    )));
              },
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: CachedNetworkImage(
                      height: 110,
                      width: 110,
                      imageUrl: allCuisineListData[index].image!,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => SpinKitFadingCircle(
                          color: Color(Constants.colorTheme)),
                      errorWidget: (context, url, error) => Container(
                        child: Center(child: Image.asset('images/noimage.png')),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: ScreenUtil().setWidth(5),
                          right: ScreenUtil().setWidth(5),
                        ),
                        child: Text(
                          allCuisineListData[index].name!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: Constants.appFontBold,
                            fontSize: ScreenUtil().setSp(16.0),
                          ),
                        ),
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
  }
}
