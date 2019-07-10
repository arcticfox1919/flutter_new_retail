import 'package:flutter/material.dart';

///评分数值变化回调
typedef void RatingChangeCallback(double rating);


///创建一个StarRatingBar Widget
class StarRatingBarWidget extends StatefulWidget {
  final double rating;
  final int starCount;
  final double starSize;
  final Color color;
  final RatingChangeCallback onRatingCallback;

  StarRatingBarWidget(
      {Key key,
        this.onRatingCallback,
        this.rating = 0.0,
        this.starCount,
        this.starSize,
        this.color});

  @override
  StarRatingBarState createState() {
    return StarRatingBarState(
        onRatingCallback: this.onRatingCallback,
        rating: this.rating,
        starCount: this.starCount,
        starSize: this.starSize,
        color: this.color);
  }
}

///创建一个 StarRatingBar State
class StarRatingBarState extends State<StarRatingBarWidget> {
  double rating;
  final int starCount;
  final double starSize;
  final Color color;
  final RatingChangeCallback onRatingCallback;

  StarRatingBarState(
      {this.onRatingCallback,
        this.rating,
        this.starCount,
        this.starSize,
        this.color});

  ///通过滑动的距离来计算出当前评分数值
  double getRatingValue(double dragDx) {
    if (dragDx <= 0) return 0.0;
    //评分控件宽度
    double totalWidth = starSize * starCount + 4;
    //单个星星占据的空间距离
    double singleDistance = totalWidth / starCount + 2;
    for (int i = 1; i <= starCount; i++) {
      if (dragDx < singleDistance * i) {
        if (dragDx < singleDistance * (i * 2 - 1) / 2) {
          return (i * 2 - 1) / 2;
        }
        return i * 1.0;
      }
    }
    return starCount * 1.0;
  }

  @override
  Widget build(BuildContext context) {
    void postInvalidateRatingValue(double rating) {
      this.onRatingCallback(rating);
      setState(() {
        this.rating = rating;
      });
    }

    return new GestureDetector(
      //水平拖拽位置更新,注意:onRatingCallback此处做非空判断,如果为空,则不处理水平滑动手势
      onHorizontalDragUpdate: onRatingCallback == null? null : (DragUpdateDetails details) {
        RenderBox getBox = context.findRenderObject();
        //details.globalPosition更新时显示的全局位置Offset
        //globalToLocal将全局坐标转换为当前盒子内部的坐标
        double dragDx = getBox.globalToLocal(details.globalPosition).dx;
        print("当前控件内部滑动距离:$dragDx");
        postInvalidateRatingValue(getRatingValue(dragDx));
      },
      child: new StarRating(
        rating: this.rating,
        starCount: this.starCount,
        starSize: this.starSize,
        color: this.color,
        //注意:此处也做onRatingCallback非空判断,如果为空不做点击操作响应
        onRatingChanged: onRatingCallback == null ? null: (rating) => postInvalidateRatingValue(rating),
      ),
    );
  }
}

///构建星星列表
class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final double starSize;
  final Color color;
  final RatingChangeCallback onRatingChanged;

  StarRating(
      {@required this.starCount,
        @required this.starSize,
        this.rating,
        this.onRatingChanged,
        this.color});

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = new Icon(
        Icons.star_border,
        color: Theme.of(context).buttonColor,
        size: starSize,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = new Icon(
        Icons.star_half,
        color: color ?? Theme.of(context).primaryColor,
        size: starSize,
      );
    } else {
      icon = new Icon(
        Icons.star,
        color: color ?? Theme.of(context).primaryColor,
        size: starSize,
      );
    }
    ///如果你对水波纹有迷之热爱,你可以用InkResponse/InkWell/IconButton等包装即可
    return new GestureDetector(
      onTap:
      onRatingChanged == null ? null : () => onRatingChanged(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    //生成水平展示的星星列表
    return new Row(
        children:
        new List.generate(starCount, (index) => buildStar(context, index)));
  }
}