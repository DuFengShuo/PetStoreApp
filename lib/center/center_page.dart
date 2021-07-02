import 'package:flutter/material.dart';
import 'package:local_life_app/res/colors.dart';
import 'package:local_life_app/widgets/my_app_bar.dart';

class CenterPage extends StatefulWidget {
  @override
  _CenterPageState createState() => _CenterPageState();
}

class _CenterPageState extends State<CenterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.bg_color,
      appBar: MyAppBar(centerTitle: "发布",isBack: false,),
    );
  }
}
