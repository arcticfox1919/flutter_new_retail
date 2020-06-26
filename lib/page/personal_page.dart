import 'package:flutter/material.dart';
import 'package:flutter_yjh/routes/routes.dart';
import 'package:flutter_yjh/utils/app_size.dart';
import 'package:flutter_yjh/utils/constants.dart';
import 'package:flutter_yjh/view/arc_bg.dart';
import 'package:flutter_yjh/view/custom_view.dart';
import 'package:flutter_yjh/view/theme_ui.dart';
import '../view/theme_ui.dart';

///
/// app 我的页
///
class PersonalPage extends StatefulWidget {
  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage>
    with AutomaticKeepAliveClientMixin {
  List<Widget> contentList;

  @override
  void initState() {
    super.initState();
    print("--*-- _PersonalPageState");
  }

  List<Widget> generateList(BuildContext ctx) {
    if (contentList == null) {
      contentList = new List<Widget>();
      contentList.add(createHeadInfo(ctx));
      contentList.add(createCardNav_1());
      contentList.add(createAdBar());
      contentList.add(createCardNav_2());
      contentList.add(createToolBar());
    }
    return contentList;
  }

  createHeadInfo(BuildContext ctx) {
    _generateInfo(String label, String val) {
      return Expanded(
        child: InkWell(
          onTap: ()=>navigateTo(label),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(val, style: ThemeTextStyle.personalNumStyle,),
              Text(label, style: ThemeTextStyle.menuStyle),
            ],
          ),
        ),
      );
    }

    final screenWidth = Screen.width;
    return Container(
        margin: EdgeInsets.only(bottom: AppSize.height(30)),
        height: AppSize.height(900),
        child: Stack(
          children: <Widget>[
            ArcBackground(screenWidth, AppSize.height(500)),
            Container(
              margin: EdgeInsets.only(
                  top: AppSize.height(183),
                  left: AppSize.width(30),
                  right: AppSize.width(30)),
              height: AppSize.height(720),
              decoration: ThemeDecoration.card,
              child: Column(
                children: <Widget>[
                  Expanded(child: Container(decoration: ThemeDecoration.card)),
                  ThemeView.divider(),
                  SizedBox(
                      height: AppSize.height(202),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          _generateInfo("收藏", "32"),
                          Padding(
                            padding: EdgeInsets.only(top: 15, bottom: 15),
                            child: ThemeView.divider(orient: Orient.vertical),
                          ),
                          _generateInfo("关注", "52"),
                          Padding(
                            padding: EdgeInsets.only(top: 15, bottom: 15),
                            child: ThemeView.divider(orient: Orient.vertical),
                          ),
                          _generateInfo("积分", "5230"),
                        ],
                      )),
                  ThemeView.divider(),
                  SizedBox(
                      height: AppSize.height(157),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "邀请码:",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: AppSize.sp(44),
                                color: Color(0xff333333)),
                          ),
                          Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.0, color: Color(0xFFFFF0F4)),
                                  color: Color(0xFFFFF0F4),
                                  borderRadius: BorderRadius.circular(18.0)),
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: Text(
                                "DHUAS256HD",
                                style: TextStyle(
                                    fontSize: AppSize.sp(44),
                                    color: Color(0xFFEA3D87)),
                              )),
                          Text("点击复制",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: AppSize.sp(36),
                                  color: Color(0xFF15AFF7))),
                        ],
                      ))
                ],
              ),
            ),
            Positioned(
              width: screenWidth,
              top: AppSize.height(110),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  AvatarView(),

                  Text("昵称/账号", style: ThemeTextStyle.primaryStyle),
                  Container(
                      margin: EdgeInsets.only(top: 6, bottom: 25),
                      padding: EdgeInsets.only(left: 8, right: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Color(0xFFEA3D87))),
                      child: Text("等价:VIP3",
                          style: TextStyle(
                              color: Color(0xFFEA3D87),
                              fontSize: AppSize.sp(32))))
                ],
              ),

//              child: AvatarView(),
            )
          ],
        ));
  }

  createCardNav_1() {
    var title = <String>["完善资料", "门店/推荐人", "我的卡券"];
    var path = <String>[
      "images/information.png",
      "images/referrer.png",
      "images/card_coupon.png"
    ];

    var imageBtns = List<Widget>();
    for (int i = 0; i < path.length; i++) {
      imageBtns.add(ImageButton(path[i],
          text: title[i], func: navigateTo,
          textStyle: ThemeTextStyle.primaryStyle2));
    }

    return Container(
      height: AppSize.height(260),
      margin: EdgeInsets.only(
          bottom: AppSize.height(30),
          left: AppSize.height(30),
          right: AppSize.height(30)),
      decoration: ThemeDecoration.card,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: imageBtns,
      ),
    );
  }

  createAdBar() {
    return AdBarView(Image.asset("images/personal_ad.png",fit: BoxFit.cover), AppSize.height(200),
        bottom: AppSize.height(30),
        left: AppSize.height(30),
        right: AppSize.height(30));
  }

  createCardNav_2() {
    var title = <String>["邀请好友", "我的粉丝", "收益记录", "门店奖励"];
    var path = <String>[
      "images/invite_friends.png",
      "images/my_fans.png",
      "images/income.png",
      "images/reward.png"
    ];

    var imageBtns = List<Widget>();
    for (int i = 0; i < path.length; i++) {
      imageBtns.add(ImageButton(path[i],func: navigateTo,
          text: title[i], textStyle: ThemeTextStyle.menuStyle2));
    }

    return Container(
      height: AppSize.height(200),
      margin: EdgeInsets.only(
          bottom: AppSize.height(30),
          left: AppSize.height(30),
          right: AppSize.height(30)),
      decoration: ThemeDecoration.card,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: imageBtns,
      ),
    );
  }

  createToolBar() {
    var title = <String>[
      "新手攻略",
      "我的足迹",
      "关于我们",
      "投诉通道",
      "客服帮助",
      "常见问题",
      "清楚缓存",
      "登录账号"
    ];
    var path = <String>[
      "images/guide.png",
      "images/footprint.png",
      "images/about.png",
      "images/complaint.png",
      "images/customer.png",
      "images/problem.png",
      "images/clear.png",
      "images/sign_out.png",
    ];

    _getImgBtns(int op) {
      int i = op == 0 ? 0 : 4;
      int offset = 4 - i;
      var imageBtns = List<Widget>();
      for (; i < path.length - offset; i++) {
        imageBtns.add(ImageButton(path[i],func: navigateTo,
            text: title[i], textStyle: ThemeTextStyle.menuStyle2));
      }
      return imageBtns;
    }

    return Container(
        height: AppSize.height(580),
        margin: EdgeInsets.only(
            bottom: AppSize.height(30),
            left: AppSize.height(30),
            right: AppSize.height(30)),
        decoration: ThemeDecoration.card,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: AppSize.width(30)),
              height: AppSize.height(137),
              child: Align(
                alignment: Alignment.centerLeft,
                  child: Text("我的工具",style: ThemeTextStyle.primaryStyle,)),
            ),
            ThemeView.divider(),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _getImgBtns(0),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _getImgBtns(1),
              ),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
        color: ThemeColor.appBg,
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView(children: generateList(context),
              physics:ClampingScrollPhysics()
          ),
        ));
  }

  void navigateTo(String lab){
    switch(lab){
      case '收藏':
        Routes.instance.navigateTo(context, Routes.favorite_page);
        break;
      case '关注':
        Routes.instance.navigateTo(context, Routes.follow_page);
        break;
      case '积分':
        Routes.instance.navigateTo(context, Routes.my_scores);
        break;
      case '完善资料':
        Routes.instance.navigateTo(context, Routes.edit_profile);
        break;
      case '门店/推荐人':
        Routes.instance.navigateTo(context, Routes.shop_referrer);
        break;
      case '我的卡券':
        Routes.instance.navigateTo(context, Routes.card_voucher);
        break;
      case '邀请好友':
        Routes.instance.navigateTo(context, Routes.invite_friends);
        break;
      case '我的粉丝':
        Routes.instance.navigateTo(context, Routes.my_fans);
        break;
      case '收益记录':
        Routes.instance.navigateTo(context, Routes.income_record);
        break;
      case '门店奖励':
        Routes.instance.navigateTo(context, Routes.shop_reward);
        break;
      case '登录账号':
        Routes.instance.navigateFromBottom(context, Routes.login_page);
        break;
    }
  }

  @override
  bool get wantKeepAlive => true;
}
