import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_yjh/dao/findings_dao.dart';
import 'package:flutter_yjh/dao/home_dao.dart';
import 'package:flutter_yjh/models/goods_entity.dart';
import 'package:flutter_yjh/models/store_entity.dart';
import 'package:flutter_yjh/routes/routes.dart';
import 'package:flutter_yjh/utils/app_size.dart';
import 'package:flutter_yjh/utils/constants.dart';
import 'package:flutter_yjh/view/custom_view.dart';
import 'package:flutter_yjh/view/flutter_iconfont.dart';
import 'package:flutter_yjh/view/my_icons.dart.dart';
import 'package:flutter_yjh/view/ratingbar.dart';
import 'package:flutter_yjh/view/theme_ui.dart';
import 'dart:math' show Random;

class StoreDetails extends StatefulWidget {
  final int id;

  StoreDetails(this.id);

  @override
  _StoreDetailsState createState() => _StoreDetailsState();
}

class _StoreDetailsState extends State<StoreDetails> {
  final TextStyle descTextStyle =
      new TextStyle(color: Colors.white, fontSize: AppSize.sp(30));

  StoreModel data;
  List<GoodsModel> goodsList = new List<GoodsModel>();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData() async {
    StoreEntity stores = await HomeDao.fetch();

    GoodsEntity entity = await FindingsDao.fetch();
    int i = Random().nextInt(entity.goods.length-1);
    if(entity?.goods != null){
        goodsList = entity.goods.sublist(i,entity.goods.length);
    }

    if (stores?.stores != null) {
      stores.stores.forEach((el) {
        if (el.id == widget.id) {
          setState(() {
            data = el;
          });
          return;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(color: ThemeColor.appBg, child: _getContent(context)),
    );
  }

  Widget _getContent(BuildContext context) {
    if (data == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Column(
        children: <Widget>[
          _createHeadInfo(),
          Container(
            width: Screen.width(),
            padding: EdgeInsets.symmetric(vertical: AppSize.height(20)),
            color: Colors.white,
            margin: EdgeInsets.only(top: AppSize.height(30)),
            child: Image.asset('images/store_list_label.png'),
          ),
          _createGridView(),

          Container(
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Expanded(child: Center(child:
                Text('商品分类',style: ThemeTextStyle.primaryStyle,))),

                SizedBox(
                  height: AppSize.height(150),
                    child: ThemeView.divider(orient: Orient.vertical)),

                Expanded(child: Center(child:
                Text('店铺信息',style: ThemeTextStyle.primaryStyle))),

                SizedBox(
                    height: AppSize.height(150),
                    child: ThemeView.divider(orient: Orient.vertical)),

                SizedBox(
                  width: AppSize.width(230),
                  child: IconBtn(Icons.sentiment_satisfied,text: '客服',
                    textStyle: ThemeTextStyle.menuStyle3,iconColor: ThemeColor.appBarTopBg),
                )
              ],
            ),
          )
        ],
      );
    }
  }

  Widget _createHeadInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Stack(
          children: <Widget>[
            CachedNetworkImage(
                imageUrl: data.products[0].img,
                fit: BoxFit.fill,
                height: AppSize.height(450),
                width: Screen.width()),
            Container(
              height: AppSize.height(450),
              color: Color.fromRGBO(0, 0, 0, 0.5),
              padding: EdgeInsets.only(
                  top: Screen.statusH(),
                  right: AppSize.width(30),
                  left: AppSize.width(30)),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: AppSize.height(160),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Icon(IconFonts.arrow_left,
                              color: Colors.white, size: AppSize.height(60)),
                        ),
                        Container(
                          width: AppSize.width(750),
                          height: AppSize.height(70),
                          padding: EdgeInsets.only(left: AppSize.width(30)),
                          decoration: BoxDecoration(
                              color: ThemeColor.appBg,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                CupertinoIcons.search,
                                color: Color(0xff999999),
                                size: AppSize.width(40),
                              ),
                              Text("请输入商品名称",
                                  style: TextStyle(
                                      fontSize: AppSize.sp(35),
                                      color: Color(0xff999999)))
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Icon(IconFonts.shopping_cart,
                              color: Colors.white, size: AppSize.height(50)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: AppSize.height(30)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Row(children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: AppSize.width(30)),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white)),
                              child: CachedNetworkImage(
                                  imageUrl: data.photo,
                                  width: AppSize.width(150),
                                  height: AppSize.width(150)),
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(data.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: AppSize.sp(44),
                                          fontWeight: FontWeight.w700)),

                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: AppSize.height(10)),
                                    child: Row(
                                      children: <Widget>[
                                        StarRatingBarWidget(
                                            rating: 3.5,
                                            starSize: AppSize.width(40),
                                            starCount: 5,
                                            color: ThemeColor.appBarTopBg),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: AppSize.width(30)),
                                          child:
                                              Text('商品868', style: descTextStyle),
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text('销量25868', style: descTextStyle),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: AppSize.width(30)),
                                        child: SizedBox(
                                            height: AppSize.height(20),
                                            child: VerticalDivider(
                                                width: 0.0, color: Colors.white)),
                                      ),
                                      Text('粉丝25868', style: descTextStyle),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ]),
                        ),
                        RaisedButton(
                          color: ThemeColor.appBarTopBg,
                          onPressed: () {},
                          child: Text(
                            '关注',
                            style: TextStyle(
                                color: Colors.white, fontSize: AppSize.sp(43)),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(
              vertical: AppSize.height(30), horizontal: AppSize.width(30)),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('营业时间：09:00—22:00', style: ThemeTextStyle.cardTitleStyle),
              Padding(
                padding: EdgeInsets.only(
                  bottom: AppSize.height(20),
                    top: AppSize.height(20),
                  right: AppSize.width(30)
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('位置：XXXXXXXXXXXXXXX',
                          style: ThemeTextStyle.cardTitleStyle),
                      Icon(MyIcons.location, size: AppSize.width(40),
                        color: Colors.grey[400],)
                    ]),
              ),
              
              Text('联系方式：400-2856-5898', style: ThemeTextStyle.cardTitleStyle),
              
              Padding(
                padding: EdgeInsets.symmetric(vertical: AppSize.height(20)),
                child: ThemeView.divider(),
              ),
              
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('其他连锁门店：XXXXXXXXXXXXXX',
                        style: ThemeTextStyle.cardTitleStyle),
                    Icon(IconFonts.arrow_right, size: AppSize.width(60))
                  ]),
            ],
          ),
        )
      ],
    );
  }

  Widget _createGridView() {
    return Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: AppSize.width(30),
              vertical: AppSize.height(20)),
          child: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: StaggeredGridView.countBuilder(
              primary: false,
              crossAxisCount: 4,
              itemCount: goodsList.length,
              physics:ClampingScrollPhysics(),
              itemBuilder: (ctx,i){
                return InkWell(
                  onTap: ()=>onItemClick(i),
                  child: ThemeCard(
                    title: goodsList[i].name,
                    price: goodsList[i].price,
                    imgUrl: goodsList[i].photo,
                    number: '63524人已付款',
                  ),
                );
              },
              staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 6.0,
            ),
          ),
        ),
    );
  }

  void onItemClick(int i){
    int id = goodsList[i].id;
    Routes.instance.navigateTo(context, Routes.PRODUCT_DETAILS,id.toString());
  }
}
