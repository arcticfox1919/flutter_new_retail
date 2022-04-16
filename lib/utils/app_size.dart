
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSize{

  static init(BuildContext context){
    ScreenUtil.init(context,designSize: Size(1080, 1920));
  }

  static height(value){
    return ScreenUtil().setHeight(value.toDouble());
  }

  static width(value){
    return ScreenUtil().setWidth(value.toDouble());
  }

  static sp(value){
    return ScreenUtil().setSp(value.toDouble());
  }

  static instance() => ScreenUtil;
}


