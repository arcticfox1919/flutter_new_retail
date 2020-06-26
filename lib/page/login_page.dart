import 'package:flutter/material.dart';
import 'package:flutter_yjh/routes/routes.dart';
import 'package:flutter_yjh/utils/app_size.dart';
import 'package:flutter_yjh/utils/constants.dart';
import 'package:flutter_yjh/view/arc_bg.dart';
import 'package:flutter_yjh/view/custom_view.dart';
import 'package:flutter_yjh/view/flutter_iconfont.dart';
import 'package:flutter_yjh/view/theme_ui.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _phoneNum = TextEditingController();
  TextEditingController _password = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        color: ThemeColor.appBg,
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
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
                    Padding(
                      padding: EdgeInsets.only(
                          top: AppSize.height(30), bottom: AppSize.height(60)),
                      child: TextField(
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
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            '忘记密码?',
                            style: ThemeTextStyle.menuStyle3,
                          )
                        ]),
                    InkWell(
                      child: Container(
                        width: Screen.width,
                        margin:
                            EdgeInsets.symmetric(vertical: AppSize.height(30)),
                        padding:
                            EdgeInsets.symmetric(vertical: AppSize.height(20)),
                        child: Center(
                            child: Text(
                          '登录',
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
                      padding: EdgeInsets.symmetric(vertical: AppSize.height(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('验证码登录',style: ThemeTextStyle.menuStyle3),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: AppSize.width(30)),
                            child: SizedBox(
                              height: AppSize.height(30),
                                child: ThemeView.divider(orient: Orient.vertical)),
                          ),

                          InkWell(
                            onTap: (){
                              Routes.instance.navigateFromBottom(context, Routes.registered_page);
                            },
                            child: Text('新用户注册',style: TextStyle(
                                fontSize: AppSize.sp(36),
                                color: Color(0xFF02A9FF)),),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                width: Screen.width,
                top: AppSize.height(320),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    AvatarView(imgPath: 'images/logo.png',),
                    Padding(
                      padding: EdgeInsets.only(top: AppSize.height(30)),
                      child: Text("登陆", style: ThemeTextStyle.personalShopNameStyle),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: AppSize.width(60),
                right: AppSize.width(60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      child: Checkbox(
                        value: true,
                        onChanged: (v){},
                      ),
                    ),

                    Text('我已阅读并同意遵守',style: TextStyle(
                        fontSize: AppSize.sp(30),
                      color: ThemeColor.subTextColor
                    )),
                    Text('《服务许可协议》',style: TextStyle(
                        fontSize: AppSize.sp(30),
                        decoration: TextDecoration.underline,
                        color: ThemeColor.hintTextColor
                    )),
                  ],
                ),
                bottom: AppSize.height(150)),
              
              Positioned(
                top: Screen.statusH+AppSize.height(30),
                left: AppSize.width(30),
                child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                    child: Icon(IconFonts.arrow_left,color: Colors.white,)),

              )
            ],
          ),
        ),
      ),
    );
  }
}
