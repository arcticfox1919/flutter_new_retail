import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_yjh/dao/order_form_dao.dart';
import 'package:flutter_yjh/models/order_form_entity.dart';
import 'package:flutter_yjh/routes/routes.dart';
import 'package:flutter_yjh/utils/app_size.dart';
import 'package:flutter_yjh/view/app_topbar.dart';
import 'package:flutter_yjh/view/custom_view.dart';
import 'package:flutter_yjh/view/customize_appbar.dart';

///
/// app 订单页
///
class OrderFormPage extends StatefulWidget {

  @override
  _OrderFormPageState createState() => _OrderFormPageState();
}


class _OrderFormPageState extends State<OrderFormPage> with AutomaticKeepAliveClientMixin,
    SingleTickerProviderStateMixin{
  final List<Tab> myTabs = <Tab>[
    Tab(text: '全部'),
    Tab(text: '待付款'),
    Tab(text: '待完成'),
    Tab(text: '待评价'),
    Tab(text: '售后'),
  ];

  final ValueNotifier<OrderFormEntity> orderFormData
  = ValueNotifier<OrderFormEntity>(null);


  List<Widget> bodys;

  _initTabView(){
    bodys = List<Widget>.generate(myTabs.length, (i){
      return OrderFormTabView(i,orderFormData);
    });
  }


  TabController mController;

  @override
  void initState() {
    _initTabView();

    loadData();
    mController = TabController(
      length: myTabs.length,
      vsync: this,
    );
    super.initState();
  }

  void loadData() async{
    orderFormData.value = await OrderFormDao.fetch();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: MyAppBar(
        preferredSize: Size.fromHeight(AppSize.height(160)),
        child: CommonTopBar(title: "订单"),
      ),
      body: Container(
        color: Color(0xfff5f6f7),
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              height: AppSize.height(120),
              child: Row(
                  children:<Widget>[Expanded(
                    child: TabBar(
                      isScrollable: true,
                      controller: mController,
                      labelColor: Color(0xFFFF7095),
                      indicatorColor:Color(0xFFFF7095),
                      indicatorSize:TabBarIndicatorSize.tab,
                      indicatorWeight:1.0,
                      unselectedLabelColor: Color(0xff333333),
                      labelStyle: TextStyle(fontSize: AppSize.sp(44)),
                      indicatorPadding:EdgeInsets.only(left:AppSize.width(30),right: AppSize.width(70)),
                      labelPadding:EdgeInsets.only(left:AppSize.width(30),right: AppSize.width(70)),
                      tabs: myTabs,
                    ),
                  )]
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class OrderFormTabView extends StatefulWidget {
  final ValueNotifier<OrderFormEntity> data;
  final int currentIndex;

  OrderFormTabView(this.currentIndex,this.data);

  @override
  _OrderFormTabViewState createState() => _OrderFormTabViewState();
}

class _OrderFormTabViewState extends State<OrderFormTabView> {
  GlobalKey<MaterialHeaderWidgetState> _headerKey = GlobalKey<MaterialHeaderWidgetState>();
  GlobalKey<MaterialFooterWidgetState> _footerKey = GlobalKey<MaterialFooterWidgetState>();

  List<OrderFormListItem> listData;

  @override
  void initState() {
    widget.data.addListener(notifyDataChange);
    listData = _getDataList();
    super.initState();
  }

  @override
  void dispose() {
    widget.data.removeListener(notifyDataChange);
    super.dispose();
  }

  List<OrderFormListItem> _getDataList(){
    var itemList = widget.data.value !=null ?
        widget.data.value.items : <OrderFormListItem>[];

    switch(widget.currentIndex){
      case 0:
        return itemList;
      case 1:
        return List.of(itemList.where((ele)=>ele.type == OrderForm.payment));
      case 2:
        return List.of(itemList.where((ele)=>ele.type == OrderForm.pending));
      case 3:
        return List.of(itemList.where((ele)=>ele.type == OrderForm.comment));
      case 4:
        return List.of(itemList.where((ele)=>ele.type == OrderForm.afterSale));
    }
    return listData;
  }


  void notifyDataChange(){
    setState((){
      listData = _getDataList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: AppSize.height(30)),
      child: EasyRefresh(
        header: MaterialHeader(
          key: _headerKey,
        ),
        footer: MaterialFooter(
          key: _footerKey,
        ),
        onRefresh: () async {

        },
        child: ListView.builder(
            itemCount: listData.length,
            itemBuilder: (context, i) {
              return InkWell(
                onTap: ()=>navigate(listData[i].id),
                  child: OrderFormCard(item: listData[i]));
            }),
      ),
    );
  }

  void navigate(int id){
      Routes.instance.navigateTo(context, Routes.ORDER_DETAILS,id.toString());
  }
}







