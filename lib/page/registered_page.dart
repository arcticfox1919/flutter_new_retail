import 'package:flutter/material.dart';
import 'package:flutter_yjh/utils/app_size.dart';
import 'package:flutter_yjh/utils/constants.dart';
import 'package:flutter_yjh/view/arc_bg.dart';
import 'package:flutter_yjh/view/custom_view.dart';
import 'package:flutter_yjh/view/flutter_iconfont.dart';
import 'package:flutter_yjh/view/theme_ui.dart';

///
/// 注册页面
///
class Registered extends StatefulWidget {
  @override
  _RegisteredState createState() => _RegisteredState();
}

class _RegisteredState extends State<Registered> {
  TextEditingController _phoneNum = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: ThemeColor.appBg,
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                ArcBackground(Screen.width, AppSize.height(800)),
                Container(
                  margin: EdgeInsets.only(
                      top: AppSize.height(380),
                      left: AppSize.width(30),
                      right: AppSize.width(30),
                      bottom: AppSize.height(120)),
                  padding: EdgeInsets.only(
                      top: AppSize.height(300),
                      right: AppSize.width(60),
                      left: AppSize.width(60)),
                  decoration: ThemeDecoration.card,
                  child: Column(
                    children: <Widget>[
                      TextField(
                        keyboardType: TextInputType.phone,
                        controller: _phoneNum,
                        maxLines: 1,
                        maxLength: 30,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone_iphone),
                            hintText: "请输入手机号",
                            contentPadding: EdgeInsets.symmetric(
                                vertical: AppSize.height(30))),
                      ),
                      TextField(
                        controller: _password,
                        maxLines: 1,
                        maxLength: 6,
                        obscureText: true,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: "请输入短信验证码",
                            contentPadding: EdgeInsets.symmetric(
                                vertical: AppSize.height(30)),
                            suffixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: AppSize.height(30)),
                              child: Text(
                                '获取验证码',
                                style: TextStyle(
                                    fontSize: AppSize.sp(40),
                                    color: ThemeColor.appBarTopBg),
                              ),
                            )),
                      ),
                      TextField(
                        controller: _password,
                        maxLines: 1,
                        maxLength: 32,
                        obscureText: true,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_outline),
                            hintText: "请输入登录密码",
                            contentPadding: EdgeInsets.symmetric(
                                vertical: AppSize.height(30)),
                            suffixIcon: Icon(
                              IconFonts.eye_close,
                              size: AppSize.width(50),
                            )),
                      ),
                      TextField(
                        controller: _password,
                        maxLines: 1,
                        maxLength: 32,
                        obscureText: true,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_outline),
                            hintText: "请再次确认登录密码",
                            contentPadding: EdgeInsets.symmetric(
                                vertical: AppSize.height(30)),
                            suffixIcon: Icon(
                              IconFonts.eye_close,
                              size: AppSize.width(50),
                            )),
                      ),
                      TextField(
                        keyboardType: TextInputType.phone,
                        controller: _phoneNum,
                        maxLines: 1,
                        maxLength: 30,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone_iphone),
                            hintText: "邀请人手机号/推荐码",
                            contentPadding: EdgeInsets.symmetric(
                                vertical: AppSize.height(30))),
                      ),
                      InkWell(
                        child: Container(
                          width: Screen.width,
                          margin: EdgeInsets.symmetric(
                              vertical: AppSize.height(30)),
                          padding: EdgeInsets.symmetric(
                              vertical: AppSize.height(20)),
                          child: Center(
                              child: Text(
                            '注册',
                            style: TextStyle(
                                fontSize: AppSize.sp(45), color: Colors.white),
                          )),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                ThemeColor.appBarTopBg,
                                ThemeColor.appBarBottomBg
                              ]),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(1.0, 5.0),
                                  color: Color.fromRGBO(234, 61, 135, 0.4),
                                  blurRadius: 5.0,
                                )
                              ]),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: AppSize.height(30)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('已有账号，', style: ThemeTextStyle.cardNumStyle),
                            Text(
                              '立即登录',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: AppSize.sp(36),
                                  color: Color(0xFF02A9FF)),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            child: Checkbox(
                              value: true,
                              onChanged: (v) {},
                            ),
                          ),
                          Text('我已阅读并同意遵守',
                              style: TextStyle(
                                  fontSize: AppSize.sp(30),
                                  color: ThemeColor.subTextColor)),
                          Text('《服务许可协议》',
                              style: TextStyle(
                                  fontSize: AppSize.sp(30),
                                  decoration: TextDecoration.underline,
                                  color: ThemeColor.hintTextColor)),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  width: Screen.width,
                  top: AppSize.height(320),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      AvatarView(
                        imgPath: 'images/logo.png',
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: AppSize.height(30)),
                        child: Text("注册",
                            style: ThemeTextStyle.personalShopNameStyle),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: Screen.statusH + AppSize.height(30),
                  left: AppSize.width(30),
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        IconFonts.arrow_left,
                        color: Colors.white,
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
