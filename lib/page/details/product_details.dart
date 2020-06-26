import 'package:flutter/material.dart';
import 'package:flutter_yjh/dao/findings_dao.dart';
import 'package:flutter_yjh/models/goods_entity.dart';
import 'package:flutter_yjh/utils/app_size.dart';
import 'package:flutter_yjh/utils/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_yjh/view/custom_view.dart';
import 'package:flutter_yjh/view/flutter_iconfont.dart';
import 'package:flutter_yjh/view/theme_ui.dart';


///
/// 商品详情页
///
class ProductDetails extends StatefulWidget {
  final int id;

  ProductDetails(this.id);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> with SingleTickerProviderStateMixin {

  var descTextStyle1 = TextStyle(fontSize: AppSize.sp(35),color: ThemeColor.subTextColor);
  var descTextStyle2 = TextStyle(fontSize: AppSize.sp(35),color:Color(0xff666666));

  final List<Tab> myTabs = <Tab>[
    Tab(text: '宝贝'),
    Tab(text: '评价'),
    Tab(text: '详情'),
  ];

  GoodsModel goodsModel;

  static const SCROLL_HEIGHT = 100;
  double appBarAlpha = 0;
  double backBtnAlpha = 0;

  TabController mController;
  ScrollController listController = new ScrollController();

  @override
  void initState() {
    loadData();
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

  void loadData() async{
    GoodsEntity entity = await FindingsDao.fetch();
    if(entity?.goods != null){
      entity.goods.forEach((el){
        if (el.id == widget.id){
          setState(() {
            goodsModel = el;
          });
          return;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: ThemeColor.appBg,
            child: _getContent(context)
        ),
      floatingActionButton: FloatingActionButton(
          highlightElevation:1,
        child: Icon(IconFonts.shopping_cart),
          backgroundColor: ThemeColor.appBarTopBg,
          onPressed: (){}),
        floatingActionButtonLocation:CustomFloatingActionButtonLocation()
    );
  }


  Widget _getContent(BuildContext context) {
    if (goodsModel == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: NotificationListener(
                        onNotification: (notification){
                          if(notification is ScrollUpdateNotification
                              && notification.depth == 0){
                            _onScroll(notification.metrics.pixels);
                            return true;
                          }
                          return false;
                        },
                        child: ListView.builder(
                            controller: listController,
                            physics:ClampingScrollPhysics(),
                            itemCount: 3,
                            itemBuilder: _buildListItem))),

                // 渐变顶部栏
                Opacity(
                  opacity: appBarAlpha,
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(top: Screen.statusH),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: AppSize.height(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: Screen.width*0.6,
                            height: AppSize.height(100),
                            child: TabBar(
                              onTap: (i){
                                listController.jumpTo(i * 500.toDouble());
                              },
                              controller: mController,
                              labelColor: ThemeColor.appBarBottomBg,
                              indicatorColor: ThemeColor.appBarBottomBg,
                              indicatorSize: TabBarIndicatorSize.label,
                              indicatorWeight: 1.0,
                              unselectedLabelColor: ThemeColor.hintTextColor,
                              labelStyle: TextStyle(fontSize: AppSize.sp(44)),
                              tabs: myTabs,
                            ),
                          )],
                      ),
                    ),
                  ),
                ),
                // 带背景返回按钮
                Positioned(
                  width: AppSize.width(90),
                  height: AppSize.width(90),
                  top: Screen.statusH+AppSize.height(15),
                  left: AppSize.width(30),
                  child: Opacity(
                    opacity: 1-backBtnAlpha,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(0, 0, 0, 0.6)
                      ),
                      child: Center(child: Icon(IconFonts.arrow_left,color: Colors.white,)),
                    ),
                  ),
                ),

                // 无背景返回按钮
                Positioned(
                  width: AppSize.width(90),
                  height: AppSize.width(90),
                  top: Screen.statusH+AppSize.height(15),
                  left: AppSize.width(30),
                  child: Opacity(
                    opacity: backBtnAlpha,
                    child: InkWell(
                      onTap: ()=>Navigator.pop(context),
                      child: Container(
                        child: Center(child: Icon(IconFonts.arrow_left)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),

          // 底部栏
          Container(
            color: Colors.white,
            height: AppSize.height(150),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSize.width(60)),
                  child: IconBtn(Icons.store,text: '店铺',textStyle:
                  ThemeTextStyle.orderContentStyle,iconColor: ThemeColor.subTextColor),
                ),
                ThemeView.divider(orient: Orient.vertical),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSize.width(60)),
                  child: IconBtn(Icons.star_border,text: '收藏',textStyle:
                  ThemeTextStyle.orderContentStyle,iconColor: ThemeColor.subTextColor),
                ),

                Expanded(
                    child:
                    InkWell(
                      onTap: ()=>showBottomMenu(),
                      child: Container(
                        color: Color(0xFFFFA516),
                          child: Center(child: Text('加入购物车',
                          style: TextStyle(fontSize: AppSize.sp(44),color: Colors.white),))),
                    )),

                
                Expanded(
                    child:
                    Container(
                        color: ThemeColor.appBarTopBg,
                        child: Center(child: Text('立即购买',
                            style: TextStyle(fontSize: AppSize.sp(44),color: Colors.white))))),
              ],
            ),
          )
        ],
      );
    }
  }

  var boxs = List<Widget>.generate(50, (i){
    return Text('这是流式布局$i');
  });

  void showBottomMenu(){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          height: 300.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSize.width(30),vertical: AppSize.height(30)),
                child: Row(children: <Widget>[
                  Padding(
                    padding:EdgeInsets.only(right: AppSize.width(30)),
                    child: Image.network(goodsModel.photo,width: AppSize.width(220),height: AppSize.width(220)),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                      Text(goodsModel.name,
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                          style:ThemeTextStyle.primaryStyle),
                      Text.rich(
                          TextSpan(
                              text: goodsModel.price,
                              style: ThemeTextStyle.cardPriceStyle,
                              children: [
                                TextSpan(
                                    text: '+',
                                    style: descTextStyle1
                                ),
                                TextSpan(
                                    text: '60'
                                ),
                                TextSpan(
                                    text: '积分',
                                    style: descTextStyle1
                                )
                              ]
                          )
                      ),
                      Text('库存:589425件',style: descTextStyle1)
                    ],),
                  )
                ],),
              ),
              
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: AppSize.width(30)),
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 20,
                        runSpacing: 5,
                        children: boxs,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 4, horizontal: AppSize.width(60)),
                      child: RaisedButton(
                        highlightColor: ThemeColor.appBarBottomBg,
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        textColor: Colors.white,
                        color: ThemeColor.appBarTopBg,
                        child: Text('确定'),
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        );
      },
    );
  }

  Widget _buildListItem(BuildContext context,int i){
    if(i == 0){
      return createProductInfo();
    }else if(i == 1){
      return createCommentCard();
    }else{
      return createDescriptionItem();
    }
  }

  // 宝贝信息
  Widget createProductInfo(){
    return Column(
      children: <Widget>[
        CachedNetworkImage(
            imageUrl: goodsModel.photo,
            fit: BoxFit.fill,
            height: Screen.width),
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: AppSize.height(30),
              horizontal: AppSize.width(30)),
          child: Column(
            children: <Widget>[
              Text(goodsModel.name,style:ThemeTextStyle.primaryStyle),
              Padding(
                padding: EdgeInsets.symmetric(vertical: AppSize.height(30)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text.rich(
                        TextSpan(
                            text: goodsModel.price,
                            style: ThemeTextStyle.cardPriceStyle,
                            children: [
                              TextSpan(
                                  text: '+',
                                  style: descTextStyle1
                              ),
                              TextSpan(
                                  text: '60'
                              ),
                              TextSpan(
                                  text: '积分',
                                  style: descTextStyle1
                              )
                            ]
                        )
                    ),
                    Text('销量:2564件',style: descTextStyle1),
                    Text('库存:589425件',style: descTextStyle1)
                  ],
                ),
              ),
              ThemeView.divider(),

              Padding(
                padding: EdgeInsets.symmetric(vertical: AppSize.height(30),
                    horizontal: AppSize.width(30)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('产地直供，破损包赔',style: descTextStyle2),
                    Text('四川  成都', style: descTextStyle2),
                  ],
                ),
              ),
              ThemeView.divider(),
              Padding(
                padding: EdgeInsets.only(top: AppSize.height(30)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text.rich(
                        TextSpan(
                            text: '选择  ',
                            style: ThemeTextStyle.primaryStyle,
                            children: [
                              TextSpan(
                                  text: '规格',style: descTextStyle1
                              )
                            ]
                        )
                    ),
                    Icon(IconFonts.arrow_right)],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  // 评价卡片
  Widget createCommentCard(){
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: AppSize.height(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: AppSize.height(30),
            horizontal: AppSize.width(30)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('评价（123）',style: ThemeTextStyle.primaryStyle),
                Row(children: <Widget>[
                  Text("查看全部",style:
                  TextStyle(fontSize: AppSize.sp(44),color: ThemeColor.appBarTopBg)),
                  Icon(IconFonts.arrow_right,color: ThemeColor.appBarTopBg)])],
            ),
          ),
          ThemeView.divider(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: AppSize.height(30),
                horizontal: AppSize.width(30)),
            child: Row(
              children: <Widget>[
                Image.asset('images/default_avatar.png',
                  width: AppSize.width(110),
                  height: AppSize.height(110),
                ),Text('ax**4')],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: AppSize.height(30),
                horizontal: AppSize.width(30)),
            child: Text('东西非常好非常好非常好，重要的事情说三遍',style: TextStyle(
              fontSize: AppSize.sp(35),color: ThemeColor.hintTextColor
            ),),
          )
        ],
      ),
    );
  }

  // 详情描述
  createDescriptionItem() {
    return Container(
      color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: AppSize.height(30)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[Text('宝贝详情',style: ThemeTextStyle.primaryStyle)],
                ),
              ),
              Image.asset('images/details_description.jpeg', fit: BoxFit.cover,)
            ]));
  }

  _onScroll(offset) {
    double alpha = offset / SCROLL_HEIGHT;

    backBtnAlpha = alpha - 0.3 > 0 ? 1 : 0;

    alpha = alpha < 0 ? 0 : (alpha > 1 ? 1 : alpha);
    setState(() {
      appBarAlpha = alpha;
    });
  }
}

class CustomFloatingActionButtonLocation extends FloatingActionButtonLocation{
  factory CustomFloatingActionButtonLocation() =>_getInstance();
  static CustomFloatingActionButtonLocation get instance => _getInstance();
  static CustomFloatingActionButtonLocation _instance;

  double marginBottom;
  double marginLeft;

  CustomFloatingActionButtonLocation._internal() {
    marginLeft = AppSize.width(30);
    marginBottom = AppSize.height(60+150);
  }

  static CustomFloatingActionButtonLocation _getInstance() {
    if (_instance == null) {
      _instance = new CustomFloatingActionButtonLocation._internal();
    }
    return _instance;
  }
  
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double contentBottom = scaffoldGeometry.contentBottom;
    final double fabHeight = scaffoldGeometry.floatingActionButtonSize.height;

    return Offset(marginLeft, contentBottom-fabHeight-marginBottom);
  }

}