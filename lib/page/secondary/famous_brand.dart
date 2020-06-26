
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_yjh/dao/home_dao.dart';
import 'package:flutter_yjh/models/store_entity.dart';
import 'package:flutter_yjh/utils/app_size.dart';
import 'package:flutter_yjh/view/app_topbar.dart';
import 'package:flutter_yjh/view/customize_appbar.dart';
import 'package:flutter_yjh/view/theme_ui.dart';


///
/// 知名品牌页
///
class FamousBrand extends StatefulWidget {

  @override
  _FamousBrandState createState() => _FamousBrandState();
}

class _FamousBrandState extends State<FamousBrand> with SingleTickerProviderStateMixin {

  final List<Tab> myTabs = <Tab>[
    Tab(text: '衣服'),
    Tab(text: '化妆品'),
    Tab(text: '潮鞋'),
    Tab(text: '医美'),
    Tab(text: '包包'),

  ];

  final List<FamousTabView> bodys = [
    FamousTabView(0),
    FamousTabView(1),
    FamousTabView(2),
    FamousTabView(3),
    FamousTabView(4),
  ];

  TabController mController;

  @override
  void initState() {
    mController = TabController(
      length: myTabs.length,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          height: AppSize.height(160),
        child: CustomBackBar(onBack:()=>Navigator.pop(context))),

      body: Container(
        color: ThemeColor.appBg,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              height: AppSize.height(120),
              child: TabBar(
                    isScrollable: true,
                    controller: mController,
                    labelColor: Color(0xFFFF7095),
                    indicatorColor: Color(0xFFFF7095),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 1.0,
                    unselectedLabelColor: Color(0xff333333),
                    labelStyle: TextStyle(fontSize: AppSize.sp(44)),
                    indicatorPadding: EdgeInsets.only(
                        left: AppSize.width(30), right: AppSize.width(80)),
                    labelPadding: EdgeInsets.only(
                        left: AppSize.width(30), right: AppSize.width(80)),
                    tabs: myTabs,
                  ),
            ),
            Expanded(
              child: TabBarView(
                controller: mController,
                children: bodys,
              ),
            )
          ],
        ),
      ),
    );
  }
}

///
/// 分类页
///
class FamousTabView extends StatefulWidget {
  final int currentPage;

  FamousTabView(this.currentPage);

  @override
  _FamousTabViewState createState() => _FamousTabViewState();
}

class _FamousTabViewState extends State<FamousTabView> with AutomaticKeepAliveClientMixin{
  GlobalKey<MaterialHeaderWidgetState> _headerKey = GlobalKey<MaterialHeaderWidgetState>();
  GlobalKey<MaterialFooterWidgetState> _footerKey = GlobalKey<MaterialFooterWidgetState>();

  List<StoreModel> storeList = new List<StoreModel>();
  bool _isLoading = false;

  @override
  void initState() {
    _isLoading = true;
    loadData();
    super.initState();
  }

  void loadData() async{
    StoreEntity stores = await HomeDao.fetch();
    if(stores?.stores != null){
      setState(() {
        storeList = stores.stores;
        _isLoading = false;
      });
    }
  }

  _getContent(){
    if(_isLoading){
      return Center(
        child: CircularProgressIndicator(),
      );
    }else{
      return Container(
        padding: EdgeInsets.only(
            top: AppSize.width(30),
            left: AppSize.width(30),
            right: AppSize.width(30)),
        child: EasyRefresh(
            header: MaterialHeader(
              key: _headerKey,
            ),
            footer: MaterialFooter(
              key: _footerKey,
            ),
            child: ListView.builder(
              itemCount: storeList.length,
                itemBuilder: _buildItem),
            onRefresh: () async {
              storeList = storeList.reversed.toList();
              setState(()=>{});
            },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _getContent();
  }


  Widget _buildItem(BuildContext context, int i){
    return InkWell(
      onTap: ()=>onItemClick(i),
      child: Container(
        margin: EdgeInsets.only(bottom: AppSize.height(30)),
        padding: EdgeInsets.symmetric(vertical: AppSize.height(30),
        horizontal: AppSize.width(30)),
        decoration: ThemeDecoration.card2,
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: AppSize.width(80)),
              child: CachedNetworkImage(imageUrl: storeList[i].photo,
                fit: BoxFit.cover,
                width: AppSize.width(170),height: AppSize.width(170)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: AppSize.height(30)),
                  child: Text(storeList[i].name,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: ThemeTextStyle.primaryStyle),
                ),
                
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(colors: [ThemeColor.appBarTopBg,ThemeColor.appBarBottomBg])
                  ),
                  child: Row(
                    children: <Widget>[
                      Image.asset("images/flame_ico.png"),
                      Text("热度指数100",style: TextStyle(
                        fontSize: AppSize.sp(28),
                        color: Colors.white
                      ),)
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );

  }

  void onItemClick(int i){

  }

  @override
  bool get wantKeepAlive => true;
}