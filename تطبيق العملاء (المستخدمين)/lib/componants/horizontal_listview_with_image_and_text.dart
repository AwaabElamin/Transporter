import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alnaqel_user/utils/constants.dart';

class HorizontalListViewWithImgText extends StatelessWidget {
  final String? strRestaurantsImageUrl, strName;
  final int? listLength;

  HorizontalListViewWithImgText(
      {this.strRestaurantsImageUrl, this.strName, this.listLength});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(360, 690),
    );

    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: SizedBox(
        height: ScreenUtil().setHeight(147),
        width: ScreenUtil().setWidth(114),
        child: ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: listLength,
          itemBuilder: (BuildContext context, int index) => Padding(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.asset(
                      strRestaurantsImageUrl!,
                      fit: BoxFit.cover,
                      height: ScreenUtil().setHeight(104),
                      width: ScreenUtil().setWidth(104),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        strName!,
                        style: TextStyle(
                          fontFamily: Constants.appFontBold,
                          fontSize: ScreenUtil().setSp(16.0),
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
