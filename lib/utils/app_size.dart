
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSize{

  static init(BuildContext context){
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
  }

  static height(value){
    return ScreenUtil.getInstance().setHeight(value.toDouble());
  }

  static width(value){
    return ScreenUtil.getInstance().setWidth(value.toDouble());
  }

  static sp(value){
    return ScreenUtil.getInstance().setSp(value.toDouble());
  }

  static instance() => ScreenUtil;
}


