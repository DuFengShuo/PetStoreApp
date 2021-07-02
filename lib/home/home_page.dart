import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:local_life_app/center/send_all.dart';
import 'package:local_life_app/main_message/main_message_page.dart';
import 'package:local_life_app/mine/mine_root.dart';
import 'package:local_life_app/res/colors.dart';
import 'package:local_life_app/res/resources.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> _pageList;
  int index = 0;
  @override
  void initState() {
    super.initState();
    //AnimatedWidgetsTest
    //MainMessagePage
    //QuestSendPage
    //SendAllWidget
    _pageList = [MainMessagePage(), SendAllWidget(), MinePages()];
    // /// 权限检查弹框
    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) => SpUtil.getString("hasPermission") != null
    //     ? null
    //     : showModalBottomSheet(
    //     backgroundColor: Colors.transparent,
    //     context: context,
    //     builder: (BuildContext context) {
    //       return PermissionContent();
    //     }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.bg_color,
      // appBar: MyAppBar(title: "首页",centerTitle: "首页",isBack: false,),
      bottomNavigationBar: ConvexAppBar(
        //curveSize: 50,
        top:0,
        backgroundColor: Colours.material_bg,
        color: Colours.text,
        activeColor: Colours.app_main,
        elevation: 0.3,
        //   curveSize:12.0,
        items: [
          TabItem(icon: Icons.home, title: '首页',),
          // TabItem(icon: Icons.map, title: 'Discovery'),
          TabItem(icon: Icons.add, title: '发布'),
          // TabItem(icon: Icons.message, title: 'Message'),
          TabItem(icon: Icons.people, title: '我的'),
        ],
        initialActiveIndex: 0,//optional, default as 0
        onTap: (int i) {
          setState(() {
            index = i;
          });
        },
      ),
      body: IndexedStack(
        //保持状态
        index: index,
        children: _pageList,
      )
    );
  }
}
