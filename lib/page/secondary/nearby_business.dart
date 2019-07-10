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
import 'package:flutter_yjh/view/flutter_iconfont.dart';
import 'package:flutter_yjh/view/theme_ui.dart';

///
/// 附近商圈页
///
class NearbyBusiness extends StatefulWidget {

  @override
  _NearbyBusinessState createState() => _NearbyBusinessState();
}

class _NearbyBusinessState extends State<NearbyBusiness> {
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
            child: CommonBackTopBar(title: "附近商圈",
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: AppSize.width(40)),
                    child: CachedNetworkImage(imageUrl: storeList[i].photo,
                        fit: BoxFit.cover,
                        width: AppSize.width(170), height: AppSize.width(170)),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: AppSize.height(30)),
                          child: Text(storeList[i].name,
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                              style: ThemeTextStyle.primaryStyle),
                        ),

                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                            border: Border.all(color: ThemeColor.appBarTopBg),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text("商城", style: TextStyle(
                              fontSize: AppSize.sp(26),
                              color: ThemeColor.appBarTopBg
                          )
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Icon(IconFonts.location, color: ThemeColor.subTextColor,
                  size: AppSize.width(45),),
                Text("1.37KM", style: ThemeTextStyle.orderContentStyle)
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



