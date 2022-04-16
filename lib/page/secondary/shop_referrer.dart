import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yjh/dao/home_dao.dart';
import 'package:flutter_yjh/models/store_entity.dart';
import 'package:flutter_yjh/utils/app_size.dart';
import 'package:flutter_yjh/view/app_topbar.dart';
import 'package:flutter_yjh/view/custom_view.dart';
import 'package:flutter_yjh/view/customize_appbar.dart';
import 'package:flutter_yjh/view/theme_ui.dart';
import 'dart:math' show Random;


///
/// 门店/推荐人页
///
class ShopReferrerPage extends StatefulWidget {

  @override
  _ShopReferrerPageState createState() => _ShopReferrerPageState();
}

class _ShopReferrerPageState extends State<ShopReferrerPage> with SingleTickerProviderStateMixin{
  final List<Tab> myTabs = <Tab>[
    Tab(text: '加入的门店'),
    Tab(text: '我的推荐人'),
  ];

  List<Widget>? bodys;

  StoreModel? storeModel;

  TabController? mController;


  createBody(){
    if(bodys == null){
      bodys = <_TabPage>[];
      bodys!.add(_createShopPage());
      bodys!.add(_createReferrerPage());
    }
    return bodys;
  }

  @override
  void initState() {
    mController = TabController(
      length: myTabs.length,
      vsync: this,
    );

    loadData();
    super.initState();
  }

  void loadData() async{
    StoreEntity? stores = await HomeDao.fetch();
    if(stores?.stores != null){
      int i = Random().nextInt(stores!.stores!.length);
      setState(() {
        storeModel = stores.stores![i];
      });
    }
  }

  @override
  void dispose() {
    mController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
            height: AppSize.height(160),
            child: CommonBackTopBar(title: "门店/推荐人",
                onBack:()=>Navigator.pop(context))
        ),
        body: _getContent()
    );
  }

  Widget _getContent(){
    if(storeModel != null){
      return Container(
          color: ThemeColor.appBg,
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                height: AppSize.height(115),
                child: TabBar(
                  controller: mController,
                  labelColor: ThemeColor.appBarBottomBg,
                  indicatorColor: ThemeColor.appBarBottomBg,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 1.0,
                  unselectedLabelColor: ThemeColor.hintTextColor,
                  labelStyle: TextStyle(fontSize: AppSize.sp(44)),
                  tabs: myTabs,
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: mController,
                  children: createBody(),
                ),
              )
            ],
          )
      );
    }else{
      return Center(child: CircularProgressIndicator());
    }
  }

  Widget _createShopPage(){
    return _TabPage(
      child:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: AppSize.width(30)),
                  child: ClipRRect(
                  borderRadius:BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: storeModel!.photo!,
                      fit: BoxFit.cover,width: AppSize.width(200),height: AppSize.width(200)),
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: AppSize.height(50)),
                        child: Text(storeModel!.name!,
                            style: ThemeTextStyle.personalShopNameStyle),
                      ),

                      Text("加入时间:2019-05-12",style: ThemeTextStyle.orderContentStyle)
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppSize.height(30)),
              child: ThemeView.divider(),
            ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: AppSize.height(30)),
                child: Text('门店地址',style: ThemeTextStyle.primaryStyle),
              ),
              Text('四川省 成都市 XXXX区 XXX街道 XXXXXX小区1栋一单元0201号',style: ThemeTextStyle.menuStyle),
              Padding(
                padding: EdgeInsets.symmetric(vertical: AppSize.height(30)),
                child: ThemeView.divider(),
              ),

              _getContact('会长微信:','DHU8925656'),

              Padding(
                padding: EdgeInsets.symmetric(vertical: AppSize.height(30)),
                child: ThemeView.divider(),
              ),
              _getContact('会长电话:','13256842256'),
              Padding(
                padding: EdgeInsets.symmetric(vertical: AppSize.height(30)),
                child: ThemeView.divider(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CachedNetworkImage(imageUrl: 'https://f12.baidu.com/it/u=3168097238,1008455172&fm=72',)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Text('扫一扫加会长微信',style: ThemeTextStyle.primaryStyle)],
              )
            ],
        ),
      )
    );
  }

  Widget _getContact(String label,String value){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
      Text(
        label,
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
          child: Text(value, style: ThemeTextStyle.orderFormBtnStyle)),
      Text("点击复制",
          style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: AppSize.sp(36),
              color: Color(0xFF15AFF7))),
    ],);
  }

  Widget _createReferrerPage(){
    return _TabPage(
        child:Column(
            children: <Widget>[
              AvatarView(),
              Text("昵称/账号", style: ThemeTextStyle.primaryStyle),

              Padding(
                padding: EdgeInsets.only(top: AppSize.height(90)),
                child: _getContact('微信:','dhu8925656'),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: AppSize.height(30)),
                child: ThemeView.divider(),
              ),

              _getContact('电话:','13256842256'),

              Padding(
                padding: EdgeInsets.symmetric(vertical: AppSize.height(30)),
                child: ThemeView.divider(),
              ),
              Text('邀请人二维码',style: ThemeTextStyle.orderContentStyle),
              CachedNetworkImage(imageUrl: 'https://f12.baidu.com/it/u=3168097238,1008455172&fm=72'),
              Text('长按保存',style: ThemeTextStyle.primaryStyle)
            ],
        )
    );
  }
}

class _TabPage extends StatelessWidget {
  final Widget? child;

  _TabPage({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: AppSize.height(30),
          horizontal: AppSize.width(30)
      ),
      padding: EdgeInsets.symmetric(
          vertical: AppSize.height(30),
          horizontal: AppSize.width(30)
      ),
      decoration: ThemeDecoration.card2,
      child: child,
    );
  }
}
