import 'package:flutter/material.dart';
import 'package:flutter_yjh/utils/constants.dart';

///
/// 自定义AppBar
///
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget child;

  @override
  final Size preferredSize;

  MyAppBar({
    Key key,
    @required this.child,
    @required double height,
  }) :  preferredSize = Size.fromHeight(height),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    double _statusHeight = Screen.statusH;

    return Container(
      padding: EdgeInsets.only(left: 6, right: 6,top: _statusHeight),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xFFEA3D87), Color(0xFFFF7095)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      height: preferredSize.height+_statusHeight,
//        color: Theme.of(context).primaryColor,
      child: this.child,
    );
  }
}
