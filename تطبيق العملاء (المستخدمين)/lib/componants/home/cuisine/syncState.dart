import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alnaqel_user/utils/constants.dart';
import 'package:alnaqel_user/utils/localization/language/languages.dart';

class CuisineSyncState extends StatelessWidget {
  const CuisineSyncState({Key? key, required this.isSync}) : super(key: key);
  final bool isSync;
  @override
  Widget build(BuildContext context) {
    return isSync
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
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
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
        : Container(
            height: ScreenUtil().setHeight(147),
          );
  }
}
