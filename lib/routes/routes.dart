import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_yjh/page/details/order_details.dart';
import 'package:flutter_yjh/page/details/product_details.dart';
import 'package:flutter_yjh/page/details/store_details.dart';
import 'package:flutter_yjh/page/index_page.dart';
import 'package:flutter_yjh/page/login_page.dart';
import 'package:flutter_yjh/page/registered_page.dart';
import 'package:flutter_yjh/page/secondary/card_voucher.dart';
import 'package:flutter_yjh/page/secondary/edit_profile.dart';
import 'package:flutter_yjh/page/secondary/famous_brand.dart';
import 'package:flutter_yjh/page/secondary/favorite_page.dart';
import 'package:flutter_yjh/page/secondary/female_channel.dart';
import 'package:flutter_yjh/page/secondary/follow_page.dart';
import 'package:flutter_yjh/page/secondary/good_shop.dart';
import 'package:flutter_yjh/page/secondary/income_record.dart';
import 'package:flutter_yjh/page/secondary/invite_friends.dart';
import 'package:flutter_yjh/page/secondary/my_fans.dart';
import 'package:flutter_yjh/page/secondary/my_scores.dart';
import 'package:flutter_yjh/page/secondary/nearby_business.dart';
import 'package:flutter_yjh/page/secondary/new_shop.dart';
import 'package:flutter_yjh/page/secondary/points_lottery.dart';
import 'package:flutter_yjh/page/secondary/points_mall.dart';
import 'package:flutter_yjh/page/secondary/shop_referrer.dart';
import 'package:flutter_yjh/page/secondary/shop_reward.dart';
import 'package:flutter_yjh/page/secondary/store_live.dart';
import 'package:flutter_yjh/page/secondary/super_discount.dart';

class Routes {
  static final Router router = new Router();
  static const root = '/';
  static const points_mall = '/points_mall';
  static const famous_brand = '/famous_brand';
  static const nearby_business = '/nearby_business';
  static const female_channel = '/female_channel';
  static const store_live = '/store_live';
  static const invite_friends = '/invite_friends';
  static const good_shop = '/good_shop';
  static const points_lottery = '/points_lottery';
  static const new_shop = '/new_shop';
  static const super_discount = '/super_discount';

  // details
  static const order_details = '/order_details';
  static const product_details = '/product_details';
  static const store_details = '/store_details';

  // 个人中心二级界面
  static const favorite_page = '/favorite_page';
  static const follow_page = '/follow_page';
  static const my_scores = '/my_scores';
  static const edit_profile = '/edit_profile';
  static const shop_referrer = '/shop_referrer';
  static const card_voucher = '/card_voucher';
  static const my_fans = '/my_fans';
  static const income_record = '/income_record';
  static const shop_reward = '/shop_reward';

  static const login_page = '/login_page';
  static const registered_page = '/registered_page';

  void _config() {
    router.define(
        root, handler: Handler(handlerFunc: (context, params) => IndexPage()));

    router.define(
        points_mall, handler: Handler(handlerFunc: (context, params) => PointsMall()));

    router.define(
        famous_brand, handler: Handler(handlerFunc: (context, params) => FamousBrand()));

    router.define(
        nearby_business, handler: Handler(handlerFunc: (context, params) => NearbyBusiness()));

    router.define(
        female_channel, handler: Handler(handlerFunc: (context, params) => FemaleClassroom()));

    router.define(
        store_live, handler: Handler(handlerFunc: (context, params) => StoreLive()));

    router.define(
        invite_friends, handler: Handler(handlerFunc: (context, params) => InviteFriends()));

    router.define(
        good_shop, handler: Handler(handlerFunc: (context, params) => GoodShop()));

    router.define(
        points_lottery, handler: Handler(handlerFunc: (context, params) => PointsLottery()));

    router.define(
        new_shop, handler: Handler(handlerFunc: (context, params) => NewShop()));

    router.define(
    '$order_details/:id', handler: Handler(handlerFunc: (context, params) => OrderDetails(int.parse(params['id'][0]))));

    router.define(
        '$product_details/:id', handler:
    Handler(handlerFunc: (context, params) => ProductDetails(int.parse(params['id'][0]))));


    router.define(
        super_discount, handler: Handler(handlerFunc: (context, params) => SuperDiscount()));

    router.define(
        '$store_details/:id', handler: Handler(handlerFunc: (context, params) => StoreDetails(
        int.parse(params['id'][0]))));

    // 个人中心二级界面
    router.define(
        favorite_page, handler: Handler(handlerFunc: (context, params) => FavoritePage()));

    router.define(
        follow_page, handler: Handler(handlerFunc: (context, params) => FollowPage()));

    router.define(
        my_scores, handler: Handler(handlerFunc: (context, params) => MyScoresPage()));

    router.define(
        edit_profile, handler: Handler(handlerFunc: (context, params) => EditProfilePage()));

    router.define(
        shop_referrer, handler: Handler(handlerFunc: (context, params) => ShopReferrerPage()));

    router.define(
        card_voucher, handler: Handler(handlerFunc: (context, params) => CardVoucherPage()));

    router.define(
        my_fans, handler: Handler(handlerFunc: (context, params) => MyFansPage()));

    router.define(
        income_record, handler: Handler(handlerFunc: (context, params) => IncomeRecordPage()));

    router.define(
        shop_reward, handler: Handler(handlerFunc: (context, params) => ShopRewardPage()));


    router.define(
        login_page, handler: Handler(handlerFunc: (context, params) => Login()));

    router.define(
        registered_page, handler: Handler(handlerFunc: (context, params) => Registered()));

  }

  Future navigateTo(BuildContext context, String path,[String param='']){
    var p = param.isNotEmpty?'$path/$param':path;
    return router.navigateTo(context,p,transition: TransitionType.inFromRight);
  }

  Future navigateFromBottom(BuildContext context, String path,[String param='']){
    var p = param.isNotEmpty?'$path/$param':path;
    return router.navigateTo(context,p,transition: TransitionType.inFromBottom);
  }

  factory Routes() =>_getInstance();
  static Routes get instance => _getInstance();
  static Routes _instance;

  Routes._() {
    _config();
  }
  static Routes _getInstance() {
    if (_instance == null) {
      _instance = new Routes._();
    }
    return _instance;
  }
}
