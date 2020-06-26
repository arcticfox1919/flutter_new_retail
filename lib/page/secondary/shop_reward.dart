import 'package:flutter/material.dart';
import 'package:flutter_yjh/utils/app_size.dart';
import 'package:flutter_yjh/view/app_topbar.dart';
import 'package:flutter_yjh/view/customize_appbar.dart';


///
/// 门店奖励页
///
class ShopRewardPage extends StatefulWidget {

  @override
  _ShopRewardPageState createState() => _ShopRewardPageState();
}

class _ShopRewardPageState extends State<ShopRewardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
            height: AppSize.height(160),
            child: CommonBackTopBar(title: "门店奖励",
                onBack:()=>Navigator.pop(context))
        ),
        body: Container()
    );
  }
}