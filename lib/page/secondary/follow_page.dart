import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yjh/dao/home_dao.dart';
import 'package:flutter_yjh/models/store_entity.dart';
import 'package:flutter_yjh/utils/app_size.dart';
import 'package:flutter_yjh/view/app_topbar.dart';
import 'package:flutter_yjh/view/customize_appbar.dart';
import 'package:flutter_yjh/view/theme_ui.dart';


///
/// 我的关注页
///
class FollowPage extends StatefulWidget {

  @override
  _FollowPageState createState() => _FollowPageState();
}

class _FollowPageState extends State<FollowPage> {
  List<StoreModel>? storeList = <StoreModel>[];
  bool _isLoading = false;

  @override
  void initState() {
    _isLoading = true;
    loadData();
    super.initState();
  }

  void loadData() async{
    StoreEntity? stores = await HomeDao.fetch();
    if(stores?.stores != null){
      setState(() {
        storeList = stores!.stores;
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
            height: AppSize.height(160),
            child: CommonBackTopBar(title: "我的关注",
                onBack:()=>Navigator.pop(context))
        ),
        body: _getContent()
    );
  }

  _getContent() {
    if (_isLoading) {
      return Center(
        child: Center(child: CircularProgressIndicator()),
      );
    } else {
      return Container(
        padding: EdgeInsets.only(top: AppSize.height(30)),
        color: Colors.white,
        child: ListView.builder(
          itemCount: storeList!.length,
            itemBuilder: (context,i){
              return Dismissible(
                key: Key(storeList![i].photo!),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: ClipOval(
                          child:CachedNetworkImage(imageUrl: storeList![i].photo!)
                      ),
                      title: Text(storeList![i].name!,style: ThemeTextStyle.primaryStyle,),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: AppSize.height(30)),
                      child: ThemeView.divider(),
                    )
                  ],
                )
              );
            })
      );
    }
  }
}