
import 'package:flutter/material.dart';
import 'package:flutter_yjh/utils/app_size.dart';
import 'package:flutter_yjh/view/app_topbar.dart';
import 'package:flutter_yjh/view/customize_appbar.dart';
import 'package:flutter_yjh/view/theme_ui.dart';


///
/// 邀请好友页
///
class InviteFriends extends StatelessWidget {

  final btnStyle = TextStyle(fontSize: AppSize.sp(43),color:Colors.white);

  void onAction(String content){
      print(content);
  }

  _buildBtn(String text, List<Color> colors){
    return InkWell(
      onTap: ()=>onAction(text),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2,horizontal: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(colors: colors)
        ),
        child: Text(text,style: btnStyle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
            preferredSize: Size.fromHeight(AppSize.height(160)),
            child: CommonBackTopBar(title: "邀请好友",
                onBack:()=>Navigator.pop(context))
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Expanded(child: Image.asset("images/poster_content.png",fit: BoxFit.fill)),
              ThemeView.divider(),
              SizedBox(
                height: AppSize.height(150),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                _buildBtn("分享邀请链接",[Color(0xFFF98315),Color(0xFFF6C53C)]),
                _buildBtn("分享邀请海报",[Color(0xFFEA3D87),Color(0xFFFF7095)]),
                ])
              )
            ],
          ),
        )
    );
  }
}
