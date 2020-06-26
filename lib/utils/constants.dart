

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_yjh/routes/routes.dart';

const HEAD_NAV_TEXT = const <String>[
  "积分商城",
  "知名品牌",
  "附近商圈",
  "女性课堂",
  "商家直播",
  "邀请好友",
  "星选好店",
  "医学美容"
];

const HEAD_NAV_PATH = const <String>[
  Routes.points_mall,
  Routes.famous_brand,
  Routes.nearby_business,
  Routes.female_channel,
  Routes.store_live,
  Routes.invite_friends,
  Routes.good_shop,
  ""
];


class Screen{
  static double get width {
    return ScreenUtil.screenWidthDp;
  }

  ///
  /// 状态栏高度
  ///
  static double get statusH{
    return ScreenUtil.statusBarHeight;
  }

}







