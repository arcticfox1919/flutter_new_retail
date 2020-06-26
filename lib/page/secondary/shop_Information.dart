
import 'package:flutter/material.dart';
import 'package:flutter_yjh/utils/app_size.dart';
import 'package:flutter_yjh/view/app_topbar.dart';
import 'package:flutter_yjh/view/customize_appbar.dart';

///
/// 店铺信息页
///
class ShopInfo extends StatefulWidget {

  @override
  _ShopInfoState createState() => _ShopInfoState();
}

class _ShopInfoState extends State<ShopInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
            height: AppSize.height(160),
            child: CommonBackTopBar(title: "店铺信息",
                onBack:()=>Navigator.pop(context))
        ),
        body: Container()
    );
  }
}
