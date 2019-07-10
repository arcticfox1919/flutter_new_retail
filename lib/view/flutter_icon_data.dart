library flutter_iconfont;

import 'package:flutter/widgets.dart' show IconData;

class IconDataEx extends IconData {
  const IconDataEx(int codePoint)
      : super(
    codePoint,
    fontFamily: 'IconFont',
  );
}
