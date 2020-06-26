import 'package:flutter/material.dart';
import 'package:flutter_yjh/utils/app_size.dart';
import 'package:flutter_yjh/utils/constants.dart';
import 'package:flutter_yjh/view/app_topbar.dart';
import 'package:flutter_yjh/view/customize_appbar.dart';


///
/// 女性课堂页
///
class FemaleClassroom extends StatefulWidget {

  @override
  _FemaleClassroomState createState() => _FemaleClassroomState();
}

class _FemaleClassroomState extends State<FemaleClassroom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
            height: AppSize.height(160),
            child: CommonBackTopBar(title: "女性课堂",
                onBack:()=>Navigator.pop(context))
        ),
        body: Container()
    );
  }
}
