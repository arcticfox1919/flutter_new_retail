import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_yjh/dao/home_dao.dart';
import 'package:flutter_yjh/models/home_entity.dart';
import 'package:flutter_yjh/models/store_entity.dart';
import 'package:flutter_yjh/routes/routes.dart';
import 'package:flutter_yjh/utils/app_size.dart';
import 'package:flutter_yjh/view/app_topbar.dart';
import 'package:flutter_yjh/view/custom_view.dart';
import 'package:flutter_yjh/utils/constants.dart';
import 'package:flutter_yjh/view/customize_appbar.dart';
import 'package:flutter_yjh/view/theme_ui.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  with AutomaticKeepAliveClientMixin{

  List<HomeListItem>? homeList;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: MyAppBar(
        height: AppSize.height(160),
        child: HomeTopBar(),
      ),
      body:Container(
          color: Color(0xfff5f6f7),
          child: homeList == null? Center(
              child: CircularProgressIndicator()):_buildList()
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;


  @override
  void initState() {
    loadData();
    super.initState();
  }

  ///
  ///  构建列表主体
  ///
  Widget _buildList(){
    List<HomeListItem>? data = homeList;
    return EasyRefresh(
        header: ClassicalHeader(
          bgColor: ThemeColor.appBarBottomBg,
          refreshText:"下拉触发",
          textColor: Colors.white,
          refreshReadyText:"释放刷新",
          refreshingText: "刷新中...",
          refreshedText: "已刷新",
        ),
        footer: ClassicalFooter(
          bgColor: ThemeColor.appBg,
          textColor: ThemeColor.hintTextColor,
          loadText:"上拉触发",
          loadReadyText:"加载更多",
          loadingText:"正在加载",
          loadedText:"加载完成",
          noMoreText:"没有更多",
        ),

        onRefresh: () async {
          loadData();
          setState(() {});
        },
        onLoad: () async {
          loadData();
          setState(() {});
        },

        child: ListView.builder(
          itemCount: data?.length,
          itemBuilder: (context, i) {
            if (data![i] is HeadMenuItem) {
              return _createHeadNav();
            } else if (data[i] is ScrollMenuItem) {
              return _createScrollNav();
            } else if (data[i] is GridMenuItem) {
              return _createGridNav();
            } else if (data[i] is AdBarItem) {
              return _createAdBar();
            } else if (data[i] is OfferItem) {
              return _createOfferBar();
            } else {
              return _createNearbyStoreItem(data[i] as StoreModel, i);
            }
          },
        ));
  }

  /// 头部导航菜单
  _createHeadNav() {

    /// 生成一行网格菜单
    _getImgBtns(int lineNo) {
      int offset = lineNo == 0 ? 0 : 4;
      return List<Widget>.generate(4, (index){
        return ImageButton('images/head_menu_${index+ offset + 1}.png',
            func: navigate,
            text: HEAD_NAV_TEXT[index+ offset],
            textStyle: ThemeTextStyle.primaryStyle2);
      });
    }

    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            color: ThemeColor.appBarBottomBg,
            margin: EdgeInsets.only(bottom: AppSize.width(10)),
            padding: EdgeInsets.only(
                left: AppSize.width(30),
                right: AppSize.width(30),
                bottom: AppSize.width(12)),
            height: AppSize.height(430),
            child: Swiper(
              autoplay:true,
              itemBuilder: (BuildContext context, int index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    "images/banner_1.png",
                    fit: BoxFit.cover,
                  ),
                );
              },
              itemCount: 3,
              pagination: SwiperPagination(margin: EdgeInsets.all(1.0)),
              scale: 0.9,
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(vertical: AppSize.height(30)),
            child: Column(
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: _getImgBtns(0)),
                SizedBox(
                  height: AppSize.height(30),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: _getImgBtns(1))
              ],
            ),
          )
        ],
      ),
    );
  }

  /// 横向滚动菜单
  _createScrollNav() {
    return Container(
      decoration: ThemeDecoration.card,
      margin: EdgeInsets.symmetric(vertical: AppSize.height(30),
          horizontal: AppSize.width(30)),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Image.asset("images/scrollmenu_1.png", fit: BoxFit.cover),
          ),
          Expanded(
            child: Image.asset("images/scrollmenu_2.png", fit: BoxFit.cover),
          ),
          Expanded(
            child: Image.asset("images/scrollmenu_3.png", fit: BoxFit.cover),
          )
        ],
      ),
    );
  }

  /// 网格导航菜单
  _createGridNav() {
    return Container(
        decoration: ThemeDecoration.card,
        margin: EdgeInsets.only(
            bottom: AppSize.height(30),
            left: AppSize.height(30),
            right: AppSize.height(30)),
        child: Column(
            children: <Widget>[
              Table(
                border: TableBorder(
                    bottom: BorderSide(color: ThemeColor.appBg),
                    horizontalInside: BorderSide(color: ThemeColor.appBg),
                    verticalInside: BorderSide(color: ThemeColor.appBg)),
                children: <TableRow>[
                  TableRow(children: <Widget>[
                    _getRlImageBtn(
                        "签到打卡", "签到领积分", "images/check_in.png",
                        'images/check_in_text.png',navigate),
                    _getRlImageBtn(
                        "积分抽奖", "好礼转不停", "images/lottery.png",
                        'images/points_lottery_text.png',navigate)
                  ]),
                  TableRow(children: <Widget>[
                    _getRlImageBtn(
                        "新人专享", "新人专享福利", "images/new_talent.png",
                        'images/newcomer_text.png',navigate),
                    _getRlImageBtn("新增店铺", "好货不贵", "images/new_store.png",
                        'images/new_shop_text.png',navigate)
                  ])
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: AppSize.width(30),
                    top: AppSize.width(30),bottom: AppSize.width(30)),
                child: Row(
                    children: <Widget>[
                      Image.asset("images/headline_icon.png"),
                      Padding(
                        padding: EdgeInsets.only(left: AppSize.width(30)),
                        child: Text("Q**35分钟前获得600积分", style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: AppSize.sp(40)),),)

                    ]),
              )
            ]));
  }

  // 封装每个网格菜单中的Image 和 Text
  _getRlImageBtn(String title, String subtitle, String imgPath, String textPath, Function callback) {
    return InkWell(
      onTap: ()=>callback(title),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(textPath,width: AppSize.width(200),height: AppSize.height(60)),
              Text(subtitle, style: TextStyle(
                  fontSize: AppSize.sp(32), color: Color(0xff666666)))
            ],
          ), Image.asset(imgPath,
              width: AppSize.width(260), height: AppSize.height(260))
        ],
      ),
    );
  }

  /// 广告横幅项
  _createAdBar() {
    return Container(
        decoration: ThemeDecoration.card,
        margin: EdgeInsets.only(
            bottom: AppSize.height(30),
            left: AppSize.height(30),
            right: AppSize.height(30)),
        height: AppSize.height(170),
        child: ClipRRect(
            child: Image.asset("images/ad_bar.png", fit: BoxFit.cover,),
            borderRadius: BorderRadius.circular(6))
    );
  }

  /// 特惠信息项
  _createOfferBar(){
    return Container(
        padding: EdgeInsets.symmetric(vertical: AppSize.height(30)),
        margin: EdgeInsets.only(
            bottom: AppSize.height(30),
            left: AppSize.height(30),
            right: AppSize.height(30)),

        decoration: ThemeDecoration.card,
        child: Table(
          border: TableBorder(
              verticalInside: BorderSide(color: ThemeColor.appBg)),
          children: <TableRow>[
            TableRow(
                children: <Widget>[
                  InkWell(
                    onTap: ()=>navigate('超值特惠'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: AppSize.width(30)),
                              child: Image.asset('images/wallet_red.png'),
                            ),
                            Text('超值特惠', style: ThemeTextStyle.primaryBoldStyle)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text('更多优惠等你拿',
                                    style: ThemeTextStyle.cardNumStyle),
                                Padding(
                                  padding: EdgeInsets.only(top: AppSize.height(60)),
                                  child: Image.asset('images/see_more_text1.png',
                                      width: AppSize.width(200),
                                      height: AppSize.height(70)),
                                )
                              ],
                            ),
                            Image.asset('images/huazp.png',
                                width: AppSize.width(200),
                                height: AppSize.height(200))
                          ],
                        )
                      ],
                    ),
                  ),

                  InkWell(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: AppSize.width(30)),
                              child: Image.asset('images/wallet_yellow.png'),
                            ),
                            Text('限时兑换', style: ThemeTextStyle.primaryBoldStyle)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                    '品牌限时钜惠', style: ThemeTextStyle.cardNumStyle),

                                Padding(
                                  padding: EdgeInsets.only(top: AppSize.height(60)),
                                  child: Image.asset('images/see_more_text2.png',
                                      width: AppSize.width(200),
                                      height: AppSize.height(70)),
                                )
                              ],
                            ),
                            Image.asset('images/baobao.png',
                                width: AppSize.width(200),
                                height: AppSize.height(200))
                          ],
                        )
                      ],
                    ),
                  ),
                ]
            )
          ],
        )
    );
  }

  /// 附近商家项
  _createNearbyStoreItem(StoreModel item, int type) {
    var proName = ["xxxx项目","xxxx服务","wwww商品"];

    // 物品卡片
    _getImgBtn(_item) {
      return List<Widget>.generate(3, (i) =>
          Expanded(
              child: InkWell(
                onTap: (){
                  Routes().navigateTo(context, Routes.store_details,item.id.toString());
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(
                            bottom: AppSize.height(30),
                            right: i != 2 ? AppSize.width(20) : 0),
                        child: SizedBox(
                            height: AppSize.height(259),
                            child: ClipRRect(child: CachedNetworkImage(imageUrl:
                            _item.products[i].img, fit: BoxFit.cover,),
                                borderRadius: BorderRadius.circular(6)
                            )
                        )),
                    Text(proName[i],
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: ThemeTextStyle.menuStyle3,),
                    Text(_item.products[i].price+" + 220积分",
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: ThemeTextStyle.priceStyle)
                  ],
                ),
              ))
      );
    }

    final contentList = <Widget>[
      Padding(
          padding: EdgeInsets.only(bottom: AppSize.height(20)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(item.name!, style: ThemeTextStyle.primaryStyle),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(CupertinoIcons.heart,size: AppSize.width(40),),
                  Padding(
                    padding:EdgeInsets.only(left: 8),
                    child:Text("2852",style: TextStyle(
                        fontSize: AppSize.sp(34),color: Color(0xff999999)
                    ),) ,)],
              )
            ],
          )
      ),

      Padding(
        padding: EdgeInsets.only(bottom: AppSize.height(30)),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: AppSize.width(15)),
              child: Text("全场", style: ThemeTextStyle.menuStyle2),
            ),
            Container(
              padding: EdgeInsets.only(left: AppSize.width(20),right: AppSize.width(10)),
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("images/discount_bg.png"),fit: BoxFit.fill)
              ),
              child: Text("6.1折",style: TextStyle(fontSize: AppSize.sp(30),color: Colors.white)),
            ),
            Container(
              padding: EdgeInsets.only(left: 4, right: 4),
              margin: EdgeInsets.only(left: AppSize.width(30)),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFFEA3D87), Color(0xFFFF7095)])
              ),
              child: Text("感恩节特惠", style: TextStyle(
                  fontSize: AppSize.sp(34), color: Colors.white),),
            )
          ],
        ),),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _getImgBtn(item),
      ),
    ];

    if (type == 5){   // 附近商家列首
      return Container(
        margin: EdgeInsets.only(
            bottom: AppSize.height(30),
            left: AppSize.width(30),
            right: AppSize.width(30)),
        padding: EdgeInsets.only(
            left:AppSize.width(30),
            right:AppSize.width(30),
            bottom: AppSize.width(20)
        ),
        decoration: ThemeDecoration.card,
        child: Column(
          children: <Widget>[
            Container(
              height: AppSize.height(100),
              child: Center(
                  child:Image.asset("images/home_near_store.png")
              ),
            ),
            Padding(
                padding: EdgeInsets.only(bottom: AppSize.height(30)),
                child: ThemeView.divider()
            ),
          ]..addAll(contentList),
        ),
      );
    }else{
      return Container(
        margin: EdgeInsets.only(
            bottom: AppSize.height(30),
            left: AppSize.width(30),
            right: AppSize.width(30)),
        padding: EdgeInsets.symmetric(vertical:AppSize.width(20),
            horizontal:AppSize.height(30)),
        decoration: ThemeDecoration.card,
        child: Column(
          children: contentList,
        ),
      );
    }
  }

  void navigate(String name){
    // int i = HEAD_NAV_TEXT.indexOf(name);
  }

  void loadData() async {
    StoreEntity? stores =  await HomeDao.fetch();
    var result = <HomeListItem>[];
    result.add(HeadMenuItem());
    result.add(ScrollMenuItem());
    result.add(GridMenuItem());
    result.add(AdBarItem());
    result.add(OfferItem());

    if(stores != null) {
      result.addAll(stores.stores!);
    }

    setState(() {
      homeList = result;
    });
  }
}
