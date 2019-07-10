import 'package:flutter/material.dart';
import 'package:flutter_yjh/utils/app_size.dart';
import 'package:flutter_yjh/view/app_topbar.dart';
import 'package:flutter_yjh/view/customize_appbar.dart';


///
/// 新增店铺页
///
class NewShop extends StatefulWidget {

  @override
  _NewShopState createState() => _NewShopState();
}

class _NewShopState extends State<NewShop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
            preferredSize: Size.fromHeight(AppSize.height(160)),
            child: CommonBackTopBar(title: "新增店铺",
                onBack:()=>Navigator.pop(context))
        ),
        body: Container()
    );
  }
}