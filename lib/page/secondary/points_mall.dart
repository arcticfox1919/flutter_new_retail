import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_yjh/dao/findings_dao.dart';
import 'package:flutter_yjh/models/goods_entity.dart';
import 'package:flutter_yjh/utils/app_size.dart';
import 'package:flutter_yjh/view/app_topbar.dart';
import 'package:flutter_yjh/view/custom_view.dart';
import 'package:flutter_yjh/view/customize_appbar.dart';
import 'package:flutter_yjh/view/theme_ui.dart';

///
/// 积分商城页
///
class PointsMall extends StatefulWidget {
  @override
  _PointsMallState createState() => _PointsMallState();
}

class _PointsMallState extends State<PointsMall> with SingleTickerProviderStateMixin{

  final List<Tab> myTabs = <Tab>[
    Tab(text: '实物'),
    Tab(text: '虚拟'),
    Tab(text: '代金券'),
  ];

  final List<MallPageView> bodys = [
    MallPageView(0),
    MallPageView(1),
    MallPageView(2),
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
  void dispose() {
    mController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          preferredSize: Size.fromHeight(AppSize.height(160)),
          child: CommonBackTopBar(title: "积分商城",
              onBack:()=>Navigator.pop(context))
        ),
        body: Container(
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
                    children: bodys,
                  ),
                )
              ],
            )
        )
    );
  }
}

class MallPageView extends StatefulWidget {
  final int currentPage;

  MallPageView(this.currentPage);

  @override
  _MallPageViewState createState() => _MallPageViewState();
}

class _MallPageViewState extends State<MallPageView> with AutomaticKeepAliveClientMixin{
  GlobalKey<MaterialHeaderWidgetState> _headerKey = GlobalKey<MaterialHeaderWidgetState>();
  GlobalKey<MaterialFooterWidgetState> _footerKey = GlobalKey<MaterialFooterWidgetState>();

  bool _isLoading = false;

  List<GoodsModel> goodsList = new List<GoodsModel>();

  @override
  void initState() {
    _isLoading = true;
    loadData();
    super.initState();
  }

  void loadData() async{
    GoodsEntity entity = await FindingsDao.fetch();
    if(entity.goods != null){
      setState(() {
        goodsList = entity.goods.sublist(widget.currentPage*30,entity.goods.length);
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
            child: StaggeredGridView.countBuilder(
              primary: false,
              crossAxisCount: 4,
              itemCount: goodsList.length,
              itemBuilder: _buildCardItem,
              staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 6.0,
            ),
            onRefresh: () async {
              goodsList = goodsList.reversed.toList();
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

  Widget _buildCardItem(BuildContext context, int i){
    return ThemeBtnCard(
      title: goodsList[i].name,
      price: goodsList[i].price,
      imgUrl: goodsList[i].photo,
    );

  }

  @override
  bool get wantKeepAlive => true;
}

