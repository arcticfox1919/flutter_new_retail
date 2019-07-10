import 'package:flutter/material.dart';
import 'package:flutter_yjh/utils/app_size.dart';
import 'package:flutter_yjh/view/app_topbar.dart';
import 'package:flutter_yjh/view/customize_appbar.dart';
import 'package:flutter_yjh/view/theme_ui.dart';


///
/// 我的积分页
///
class MyScoresPage extends StatefulWidget {

  @override
  _MyScoresPageState createState() => _MyScoresPageState();
}

class _MyScoresPageState extends State<MyScoresPage> {

  List<ScoresEntity> scoresList;


  @override
  void initState() {
    scoresList = new List<ScoresEntity>();
    scoresList.add(ScoresEntity()
      ..title='兑换商品'
      ..date='2019-05-01  15:23:26'
      ..value='-2000'..color=Color(0xff333333));

    scoresList.add(ScoresEntity()
      ..title='幸运抽奖抵扣'
      ..date='2019-05-01  15:23:26'
      ..value='-500'..color=Color(0xff333333));

    scoresList.add(ScoresEntity()
      ..title='购物积分'
      ..date='2019-05-01  15:23:26'
      ..value='+288'..color=ThemeColor.appBarTopBg);

    scoresList.add(ScoresEntity()
      ..title='签到积分'
      ..date='2019-05-01  15:23:26'
      ..value='+50'..color=ThemeColor.appBarTopBg);

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
            preferredSize: Size.fromHeight(AppSize.height(160)),
            child: CommonBackTopBar(title: "我的积分",
                onBack:()=>Navigator.pop(context))
        ),
        body: Container(
          color: ThemeColor.appBg,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: AppSize.height(30)),
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: AppSize.width(30),vertical:AppSize.height(60)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('剩余积分',style: ThemeTextStyle.primaryStyle),
                    Text('26340', style: TextStyle(fontSize: AppSize.sp(60),color: Color(0xfff14141)))
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    physics:ClampingScrollPhysics(),
                  itemCount: scoresList.length,
                    itemBuilder: (context, i){
                      return Container(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              title: Text(scoresList[i].title,style: ThemeTextStyle.cardTitleStyle),
                              subtitle: Text(scoresList[i].date,style: ThemeTextStyle.orderContentStyle),
                              trailing: Text(scoresList[i].value,
                                style: TextStyle(fontSize: AppSize.sp(52),color: scoresList[i].color)),
                            ),
                            ThemeView.divider()
                          ],
                        ),
                      );
                    }),
              )
            ],
          ),
        )
    );
  }
}

class ScoresEntity{
  String title;
  String date;
  String value;
  Color color;
}