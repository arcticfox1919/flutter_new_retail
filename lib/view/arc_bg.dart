

import 'package:flutter/material.dart';
import 'package:flutter_yjh/view/theme_ui.dart';

class ArcBackground extends CustomPaint{
  ArcBackground(double w,double h):super(painter:new ArcBackgroundView(w,h));
}



class ArcBackgroundView extends CustomPainter{
  static const PI = 3.1415926;

  final double width;
  final double height;

  ArcBackgroundView(this.width,this.height);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = new Paint()
      ..color = ThemeColor.appBarTopBg
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    Rect rect = Rect.fromLTWH(0.0,0.0,width,height/2);
    canvas.drawRect(rect, paint);

    Rect rect2 = Rect.fromLTWH(-50,0.0,width+100,height);
    canvas.drawArc(rect2, 0, PI, true, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

}

