import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_yjh/dao/findings_dao.dart';
import 'package:flutter_yjh/models/goods_entity.dart';
import 'package:flutter_yjh/routes/routes.dart';
import 'package:flutter_yjh/utils/app_size.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_yjh/view/app_topbar.dart';
import 'package:flutter_yjh/view/custom_view.dart';
import 'package:flutter_yjh/view/customize_appbar.dart';
import 'package:flutter_yjh/view/flutter_iconfont.dart';
import 'package:flutter_yjh/view/theme_ui.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/material_footer.dart';

///
/// app 发现页
///
class FindingsPage extends StatefulWidget {
  @override
  _FindingsPageState createState() => _FindingsPageState();
}

class _FindingsPageState extends State<FindingsPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(text: '推荐'),
    Tab(text: '衣服'),
    Tab(text: '化妆品'),
    Tab(text: '潮鞋'),
    Tab(text: '医美'),
    Tab(text: '包包'),

  ];

  final List<FindingTabView> bodys = [
    FindingTabView(0),
    FindingTabView(1),
    FindingTabView(2),
    FindingTabView(3),
    FindingTabView(4),
    FindingTabView(5),
  ];

  TabController mController;
  PopupWindow popupWindow;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    popupWindow = PopupWindow(context);
    return Scaffold(
      appBar: MyAppBar(
        height: AppSize.height(160),
        child: CommonTopBar(title: "发现"),
      ),
      body: Container(
        color: ThemeColor.appBg,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              height: AppSize.height(120),
              child: Row(children: <Widget>[
                Expanded(
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
                Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: ThemeView.divider(orient: Orient.vertical)),
                Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: InkWell(
                        onTap: () {
                          popupWindow.show(
                            Container(
                              margin:
                                  EdgeInsets.only(bottom: AppSize.height(500)),
                              child: Padding(
                                padding: EdgeInsets.only(left: 16,top: 8),
                                child: Text("全部分类"),
                              ),
                              color: Colors.white,
                            ),
                          );
                        },
                        child: Icon(IconFonts.arrow_down,color: Color(0xff999999),)))
              ]),
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

  @override
  void initState() {
    super.initState();

    mController = TabController(
      length: myTabs.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    mController.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}


///
/// 分类页
///
class FindingTabView extends StatefulWidget {
  final int currentPage;

  FindingTabView(this.currentPage);

  @override
  _FindingTabViewState createState() => _FindingTabViewState();
}

class _FindingTabViewState extends State<FindingTabView> with AutomaticKeepAliveClientMixin{
  GlobalKey<MaterialHeaderWidgetState> _headerKey = GlobalKey<MaterialHeaderWidgetState>();
  GlobalKey<MaterialFooterWidgetState> _footerKey = GlobalKey<MaterialFooterWidgetState>();

  List<GoodsModel> goodsList = new List<GoodsModel>();
  bool _isLoading = false;

  @override
  void initState() {
    _isLoading = true;
    loadData();
    super.initState();
  }

  void loadData() async{
    GoodsEntity entity = await FindingsDao.fetch();
    if(entity?.goods != null){
      setState(() {
        goodsList = entity.goods.sublist(widget.currentPage*30,entity.goods.length);
        _isLoading = false;
      });
    }
  }

  _buildContent(){
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
    return _buildContent();
  }


  // 生成每项卡片
  Widget _buildCardItem(BuildContext context, int i){
    return InkWell(
      onTap: ()=>onItemClick(i),
      child: ThemeCard(
        title: goodsList[i].name,
        price: goodsList[i].price,
        imgUrl: goodsList[i].photo,
        number: '63524人已付款',
      ),
    );

  }

  void onItemClick(int i){
    int id = goodsList[i].id;
    Routes.instance.navigateTo(context, Routes.product_details,id.toString());
  }

  @override
  bool get wantKeepAlive => true;
}


///
/// 弹出窗口
///
class PopupWindow {
  BuildContext ctx;
  OverlayState overlayState;
  OverlayEntry overlayEntry;

  PopupWindow(this.ctx) {
    overlayState = Overlay.of(this.ctx);
  }

  isShowing() {
    return overlayEntry != null;
  }

  show(Widget child) {
    if (isShowing()) {
      return;
    }

    overlayEntry = new OverlayEntry(builder: (context) {
      return SafeArea(
        child: GestureDetector(
          onTap: () {
            this.dismiss();
          },
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              color: Color.fromRGBO(0, 0, 0, 0.5),
              margin: EdgeInsets.only(top: AppSize.height(280)),
              child: child,
            ),
          ),
        ),
      );
    });
    overlayState.insert(overlayEntry);
  }

  dismiss() {
    overlayEntry?.remove();
    overlayEntry = null;
  }
}
