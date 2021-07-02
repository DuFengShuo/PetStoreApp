import 'package:flutter/material.dart';
import 'package:local_life_app/widgets/my_app_bar.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(centerTitle: "我的",isBack: false,),
    );
  }
}
