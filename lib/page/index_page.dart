import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yjh/page/findings_page.dart';
import 'package:flutter_yjh/page/home_page.dart';
import 'package:flutter_yjh/page/orderform_page.dart';
import 'package:flutter_yjh/page/personal_page.dart';
import 'package:flutter_yjh/utils/app_size.dart';
import 'package:flutter_yjh/view/my_icons.dart.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

final List<BottomNavigationBarItem> bottomBar = <BottomNavigationBarItem>[
  BottomNavigationBarItem(icon: Icon(MyIcons.home,size: AppSize.width(55)), title: Text("首页")),
  BottomNavigationBarItem(icon: Icon(MyIcons.findings,size: AppSize.width(55)), title: Text("发现")),
  BottomNavigationBarItem(icon: Icon(MyIcons.orderForm,size: AppSize.width(55)), title: Text("订单")),
  BottomNavigationBarItem(icon: Icon(MyIcons.personal,size: AppSize.width(55)), title: Text("我的"))
];

final List<Widget> pages = <Widget>[
  HomePage(),
  FindingsPage(),
  OrderFormPage(),
  PersonalPage()
];

class _IndexPageState extends State<IndexPage>  with AutomaticKeepAliveClientMixin{
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    print("--*-- _IndexPageState");
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // 初始化屏幕适配包
    AppSize.init(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: this.currentIndex,
          onTap: (index) {
            setState(() {
              this.currentIndex = index;
              pageController.jumpToPage(index);
            });
          },
          items: bottomBar),
      body: _getPageBody(context),
    );
  }


  final pageController = PageController();

  _getPageBody(BuildContext context){
    return PageView(
      controller: pageController,
      children: pages,
      physics: NeverScrollableScrollPhysics(), // 禁止滑动
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
