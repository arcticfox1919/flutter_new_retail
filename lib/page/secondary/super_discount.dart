
import 'package:flutter/material.dart';
import 'package:flutter_yjh/utils/app_size.dart';
import 'package:flutter_yjh/view/app_topbar.dart';
import 'package:flutter_yjh/view/customize_appbar.dart';


///
/// 超值特惠页
///
class SuperDiscount extends StatefulWidget {

  @override
  _SuperDiscountState createState() => _SuperDiscountState();
}

class _SuperDiscountState extends State<SuperDiscount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
            height: AppSize.height(160),
            child: CommonBackTopBar(title: "超值特惠",
                onBack:()=>Navigator.pop(context))
        ),
        body: Container()
    );
  }
}