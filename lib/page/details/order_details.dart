import 'package:flutter/material.dart';
import 'package:flutter_yjh/dao/order_form_dao.dart';
import 'package:flutter_yjh/models/order_form_entity.dart';
import 'package:flutter_yjh/utils/app_size.dart';
import 'package:flutter_yjh/utils/constants.dart';
import 'package:flutter_yjh/view/app_topbar.dart';
import 'package:flutter_yjh/view/customize_appbar.dart';
import 'package:flutter_yjh/view/flutter_iconfont.dart';
import 'package:flutter_yjh/view/my_icons.dart.dart';
import 'package:flutter_yjh/view/theme_ui.dart';

///
/// 订单详情页
///
class OrderDetails extends StatefulWidget {
  final int id;

  OrderDetails(this.id);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  OrderFormListItem data = AllItem().emptyInstance();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData() async {
    OrderFormEntity ofe = await OrderFormDao.fetch();

    var allList = ofe != null ? ofe.items : <OrderFormListItem>[];
    allList.forEach((el) {
      if (el.id == widget.id) {
        setState(() {
          data = el;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = Screen.width();
    return Scaffold(
        appBar: MyAppBar(
            preferredSize: Size.fromHeight(AppSize.height(160)),
            child: CommonBackTopBar(
                title: "订单详情", onBack: () => Navigator.pop(context))),
        body: Container(
          color: ThemeColor.appBg,
          child: Stack(
            children:<Widget>[Column(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(
                      vertical: AppSize.height(30),
                      horizontal: AppSize.width(30)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(right: AppSize.width(30)),
                          width: AppSize.width(120),
                          height: AppSize.width(120),
                          decoration: BoxDecoration(
                            color: ThemeColor.appBarTopBg,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(MyIcons.location, color: Colors.white)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                text: "姓名 ",
                                style: ThemeTextStyle.primaryStyle,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '13265892214',
                                      style: TextStyle(
                                          color: ThemeColor.subTextColor))
                                ],
                              ),
                            ),
                            Text(
                              "四川省 成都市 xxx区 xxx街道 xxx小区1栋一单元0201号",
                              maxLines: 3,
                              style: ThemeTextStyle.primaryStyle,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: AppSize.height(30)),
                  margin: EdgeInsets.symmetric(vertical: AppSize.height(30)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                        height: AppSize.height(100),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        EdgeInsets.only(right: AppSize.width(10)),
                                    child: Text(data.storeName,
                                        style: ThemeTextStyle.primaryStyle),
                                  ),
                                  Icon(IconFonts.arrow_right,
                                      color: Color(0xffcccccc),
                                      size: AppSize.height(70)),
                                ],
                              ),
                              Text(
                                data.status,
                                style: ThemeTextStyle.orderFormStatusStyle,
                              )
                            ]),
                      ),
                      ThemeView.divider(),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  top: AppSize.height(30),
                                  bottom: AppSize.height(10),
                                  right: AppSize.width(30)),
                              child: data.imgUrl.isNotEmpty?Image.asset(
                                data.imgUrl,
                                width: AppSize.width(200),
                                height: AppSize.width(200),
                                fit: BoxFit.cover,
                              ):Icon(MyIcons.placeholder,size:AppSize.width(200),
                                  color: ThemeColor.subTextColor),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(top: AppSize.height(30)),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(data.title,
                                                overflow: TextOverflow.clip,
                                                maxLines: 2,
                                                style: ThemeTextStyle
                                                    .orderFormTitleStyle),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: AppSize.width(40)),
                                            child: Text("￥${data.price}",
                                                style: ThemeTextStyle.menuStyle3),
                                          )
                                        ]),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(data.weight,
                                              style: ThemeTextStyle.menuStyle),
                                          Text("x ${data.amount}",
                                              style: ThemeTextStyle.menuStyle)
                                        ]),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                      Padding(
                        padding: EdgeInsets.only(bottom: AppSize.height(30)),
                        child: RichText(
                            text: TextSpan(
                                text: "共${data.amount}件商品 合计:",
                                style: ThemeTextStyle.menuStyle,
                                children: <TextSpan>[
                              TextSpan(
                                  text: "￥${data.total}",
                                  style: TextStyle(color: Color(0xfff14141)))
                            ])),
                      ),
                      ThemeView.divider(),
                      SizedBox(
                        height: AppSize.height(120),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: _buildContactBtn("images/contact_merchant.png", "联系商家"),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                child: ThemeView.divider(orient: Orient.vertical),
                              ),
                              Expanded(
                                child: _buildContactBtn("images/call_hotline.png", "拨打热线"),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(
                      vertical: AppSize.height(30),
                      horizontal: AppSize.width(30)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text('订单编号：5681564572215685',
                          style: ThemeTextStyle.orderContentStyle),
                      Text('支付方式：支付宝', style: ThemeTextStyle.orderContentStyle),
                      Text('下单时间：2019-05-01 10:23:56',
                          style: ThemeTextStyle.orderContentStyle),
                      Text('付款时间：2019-05-01 10:25:29',
                          style: ThemeTextStyle.orderContentStyle),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              height: AppSize.height(180),
              width: screenWidth,
              bottom: 0,
              child: Container(
                color: Colors.white,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: _getBottomBar(),
                ),
              ),
            )]
          ),
        ));
  }

  _buildContactBtn(String resPath, String text){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSize.height(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(resPath),
          Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Text(text),
          )
        ],
      ),
    );
  }

  _getBottomBar(){
    switch(data.type){
      case OrderForm.payment:
        return [
          _buildOutBtn('取消',true),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSize.width(30)),
            child: _buildOutBtn('立即付款',false),
          )
        ];
      case OrderForm.pending:
        return [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSize.width(30)),
            child: _buildOutBtn('确认完成',false),
          )
        ];
      case OrderForm.comment:
        return [
          _buildOutBtn('再来一单',false),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSize.width(30)),
            child: _buildOutBtn('评价得积分',false),
          )
        ];
      case OrderForm.afterSale:
        return [
          _buildOutBtn('再来一单',false),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSize.width(30)),
            child: _buildOutBtn('申请售后',true),
          )
        ];
    }
  }

  Widget _buildOutBtn(String text, bool isCancel){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2,horizontal: 10),
      decoration: isCancel?ThemeDecoration.outlineCancelBtn:ThemeDecoration.outlineBtn,
      child: Text(text,style: isCancel?ThemeTextStyle.orderCancelBtnStyle:ThemeTextStyle.orderFormBtnStyle),
    );
  }
}
