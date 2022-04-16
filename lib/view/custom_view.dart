import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yjh/models/order_form_entity.dart';
import 'package:flutter_yjh/utils/app_size.dart';
import 'package:flutter_yjh/view/theme_ui.dart';

import 'flutter_iconfont.dart';

typedef ImgBtnFunc = void Function(String);

class ImageButton extends StatelessWidget {
  double? width;
  double? height;
  double? iconSize;
  Color? iconColor;

  String assetPath;
  String text;

  TextStyle? textStyle;
  ImgBtnFunc func;

  ImageButton(this.assetPath,
      {this.width, this.height, this.iconSize, required this.text, this.textStyle
      ,required this.func});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>func(text),
      child: SizedBox(
//      width: this.width,
//      height: this.height,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage(assetPath),
//              width: iconSize,
//              height: iconSize,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(text, style: textStyle),
              )
            ]),
      ),
    );
  }
}

class IconBtn extends StatelessWidget {
  double? iconSize;
  Color? iconColor;

  final IconData icon;
  String text;

  TextStyle? textStyle;
  ImgBtnFunc func;

  IconBtn(this.icon,
      {this.iconColor, required this.text, this.textStyle
        ,required this.func});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>func(text),
      child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon,color: iconColor),
              Padding(
                padding: const EdgeInsets.only(top: 1),
                child: Text(text, style: textStyle),
              )
            ]),
    );
  }
}

class AvatarView extends StatelessWidget {
  String? imgPath;

  AvatarView({this.imgPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.width(232),
      height: AppSize.width(232),
      padding: EdgeInsets.all(4),
      child: ClipOval(
          child: Image.asset(
            imgPath == null?"images/default_avatar.png":imgPath!,
        fit: BoxFit.cover,
      )),
      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
    );
  }
}

class AdBarView extends StatelessWidget {
  final Image image;
  final double height;
  double left;
  double top;
  double right;
  double bottom;

  AdBarView(this.image, this.height,
      {this.left = 0.0, this.top = 0.0, this.right = 0.0, this.bottom = 0.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: EdgeInsets.only(
          top:top, left: left, right: right, bottom: bottom),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6)),
      child: ClipRRect(child: image, borderRadius: BorderRadius.circular(6)),
    );
  }
}

class ThemeCard extends StatelessWidget {
  final String? title;
  final String? price;
  final String? number;
  final String? imgUrl;

  ThemeCard({
    this.title,
    this.price,
    this.number,
    this.imgUrl
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: AppSize.height(30)),
      decoration: ThemeDecoration.card2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
      ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8)),
          child:Image(image:CachedNetworkImageProvider(imgUrl!),fit: BoxFit.cover,))
          ,
          Padding(
              child: Text(title!,style: ThemeTextStyle.cardTitleStyle,
                  maxLines:2,overflow: TextOverflow.clip,
              ),
              padding: EdgeInsets.all(AppSize.width(30))),
          Padding(
              padding: EdgeInsets.only(left: AppSize.width(30)),
              child:Text(price!,style: ThemeTextStyle.cardPriceStyle)),
          Padding(
              padding: EdgeInsets.only(left: AppSize.width(30)),
              child:Text(number!,style: ThemeTextStyle.cardNumStyle))
        ],
      ),
    );
  }
}

class ThemeBtnCard extends StatelessWidget {
  final String? title;
  final String? price;
  final String? imgUrl;

  ThemeBtnCard({
    this.title,
    this.price,
    this.imgUrl
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: AppSize.height(20)),
      decoration: ThemeDecoration.card2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8)),
              child:Image(image:CachedNetworkImageProvider(imgUrl!),fit: BoxFit.cover,))
          ,
          Padding(
              child: Text(title!,style: ThemeTextStyle.cardTitleStyle,
                maxLines:2,overflow: TextOverflow.clip,
              ),
              padding: EdgeInsets.all(AppSize.width(30))),
          Padding(
              padding: EdgeInsets.only(left: AppSize.width(30)),
              child:Text(price!,style: ThemeTextStyle.cardPriceStyle)),
          Padding(
              padding: EdgeInsets.only(left: AppSize.width(30)),
              child:Image.asset("images/exchange_btn.png",fit: BoxFit.cover))
        ],
      ),
    );
  }
}



class OrderFormCard extends StatelessWidget {
  final OrderFormListItem item;

  OrderFormCard({
    required
    this.item});

  Widget _buildOutBtn(String text){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2,horizontal: 10),
      decoration: ThemeDecoration.outlineBtn,
      child: Text(text,style: ThemeTextStyle.orderFormBtnStyle),
    );
  }

  List<Widget>? _buildBottomBtn() {
    switch (item.type) {
      case OrderForm.payment:
        return <Widget>[_buildOutBtn("立即支付")];
      case OrderForm.pending:
        return <Widget>[_buildOutBtn("确认完成")];
      case OrderForm.comment:
        return <Widget>[Padding(
          padding: EdgeInsets.only(right: AppSize.width(30)),
          child: _buildOutBtn("再次订购"),
        ), _buildOutBtn("评价得积分")];
      case OrderForm.afterSale:
        return <Widget>[
          Padding(
            padding: EdgeInsets.only(right: AppSize.width(30)),
            child: _buildOutBtn("再次订购"),
          ), _buildOutBtn("申请售后")];
    }
    return null;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSize.height(30)),
      margin: EdgeInsets.only(
          left: AppSize.width(30),
          right: AppSize.width(30),
          bottom: AppSize.width(30)
      ),
      height: AppSize.height(520),
      decoration: ThemeDecoration.card,
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
                        padding: EdgeInsets.only(right: AppSize.width(10)),
                        child: Text(item.storeName, style: ThemeTextStyle.primaryStyle),
                      ),
                      Icon(IconFonts.arrow_right, color: Color(0xffcccccc),size: AppSize.height(70)),
                    ],
                  ),
                  Text(item.status, style: ThemeTextStyle.orderFormStatusStyle,)
                ]),
          ),
          ThemeView.divider(),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              Padding(
                padding:EdgeInsets.only(top: AppSize.height(30),
                bottom: AppSize.height(10),right: AppSize.width(30)),
                child: Image.asset(item.imgUrl,
                    width: AppSize.width(200),
                    height: AppSize.width(200),fit: BoxFit.cover,),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: AppSize.height(30)),
                  child: Column(
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                        Expanded(
                          child: Text(item.title,
                              overflow: TextOverflow.clip,
                              maxLines: 2,
                              style:ThemeTextStyle.orderFormTitleStyle),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: AppSize.width(40)),
                          child: Text("￥${item.price}",style:ThemeTextStyle.menuStyle3),
                        )]),

                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                        Text(item.weight,style:ThemeTextStyle.menuStyle),
                        Text("x ${item.amount}",style:ThemeTextStyle.menuStyle)]),
                    ],
                  ),
                ),
              ),
            ]),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: AppSize.height(30)),
            child: RichText(text: TextSpan(
                text: "共${item.amount}件商品 合计:",
                style: ThemeTextStyle.menuStyle,
                children: <TextSpan>[
                  TextSpan(
                      text: "￥${item.total}",
                      style: TextStyle(color: Color(0xfff14141)))
                ]
            )),
          ),
          ThemeView.divider(),
          SizedBox(
            height: AppSize.height(120),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _buildBottomBtn()!),
            )
        ],
      ),
    );
  }
}

class Badge extends StatelessWidget {
  final String text;

  Badge(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1,horizontal: 6),
      decoration: BoxDecoration(
        border: Border.all(color: ThemeColor.subTextColor),
        borderRadius: BorderRadius.circular(2)
      ),
      child: Text(text,style: TextStyle(
        fontSize: AppSize.sp(24),
        color: ThemeColor.hintTextColor
      ),),
    );
  }
}

