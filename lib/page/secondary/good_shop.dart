import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_yjh/dao/home_dao.dart';
import 'package:flutter_yjh/models/store_entity.dart';
import 'package:flutter_yjh/utils/app_size.dart';
import 'package:flutter_yjh/view/app_topbar.dart';
import 'package:flutter_yjh/view/custom_view.dart';
import 'package:flutter_yjh/view/customize_appbar.dart';
import 'package:flutter_yjh/view/my_icons.dart.dart';
import 'package:flutter_yjh/view/ratingbar.dart';
import 'package:flutter_yjh/view/theme_ui.dart';


///
/// 星选好店页
///
class GoodShop extends StatefulWidget {

  @override
  _GoodShopState createState() => _GoodShopState();
}

class _GoodShopState extends State<GoodShop> {
  GlobalKey<RefreshHeaderState> _headerKey = GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
            preferredSize: Size.fromHeight(AppSize.height(160)),
            child: CommonBackTopBar(title: "星选好店",
                onBack:()=>Navigator.pop(context))
        ),
        body: _getContent()
    );
  }

  _getContent(){
    if(_isLoading){
      return Center(
        child: CircularProgressIndicator(),
      );
    }else{
      return Container(
        color: ThemeColor.appBg,
        padding: EdgeInsets.only(
            top: AppSize.width(30),
            left: AppSize.width(30),
            right: AppSize.width(30)),
        child: EasyRefresh(
            refreshHeader: MaterialHeader(
              key: _headerKey,
            ),
            refreshFooter: MaterialFooter(
              key: _footerKey,
            ),
            child: ListView.builder(
                itemCount: storeList.length,
                itemBuilder: _buildItem),
            onRefresh: () async {
              storeList = storeList.reversed.toList();
              setState(()=>{});
            },
            loadMore: () async {}
        ),
      );
    }
  }

  Widget _buildItem(BuildContext context, int i){
    return InkWell(
      onTap: () => onItemClick(i),
      child: Container(
        margin: EdgeInsets.only(bottom: AppSize.height(30)),
        padding: EdgeInsets.symmetric(vertical: AppSize.height(30),
            horizontal: AppSize.width(30)),
        decoration: ThemeDecoration.card2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: AppSize.height(30),),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: AppSize.width(30)),
                          child: Icon(Icons.store,color: ThemeColor.subTextColor),
                        ),

                        Flexible(
                          child: Text(storeList[i].name,
                            style: ThemeTextStyle.primaryStyle,
                            maxLines: 1,overflow: TextOverflow.clip,
                          ),
                        )],
                    ),
                  ),
                  Text("距离 1.37KM", style: ThemeTextStyle.orderContentStyle)
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: AppSize.width(30)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(imageUrl: storeList[i].photo,
                        fit: BoxFit.cover,
                        width: AppSize.width(300), height: AppSize.height(250)),
                  ),
                ),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text("评分: "),
                          StarRatingBarWidget(
                              rating: 4.5,
                              starSize: AppSize.width(50),
                              starCount: 5,
                              color: ThemeColor.starColor)
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: AppSize.height(30),
                            bottom: AppSize.height(60)),
                        child: Row(
                          children: <Widget>[
                            Badge('女性'),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: AppSize.width(30)),
                              child: Badge('品牌'),
                            ),
                            Badge('折扣'),
                          ],
                        ),
                      ),
                      Text('品牌上新，全场七折优惠~',style: ThemeTextStyle.cardNumStyle,)
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
}
