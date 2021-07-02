import 'dart:convert';
import 'package:common_utils/common_utils.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:local_life_app/mine/widget/send_cell_widget.dart';
import 'package:local_life_app/res/resources.dart';


class MySendPage extends StatefulWidget {
  int select;
  // int userId;

  MySendPage(this.select,);

  @override
  _MySendPageState createState() => _MySendPageState();
}

class _MySendPageState extends State<MySendPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController; //需要定义一个Controller
  List tabs = ["我的发布", "待审核", "已审核", "已取消"];
  List sendallList = [];
  List dshList = [];
  List yshList = [];
  List ysendList = [];
  bool showLoading = true;
  // //请求数据
  // void requestSendListData(int userId) {
  //   print("账号:$userId");
  //   MineRequestDao.mySendList(userId, (data) async {
  //     LogUtil.e("我的发布" + data);
  //     List orderData = jsonDecode(data);
  //     await Future.delayed(Duration(seconds: 1), () {
  //       //数据加载完后延迟一秒
  //       print("延时三秒后请求数据");
  //       showLoading = false;
  //       setState(() {
  //         sendallList.addAll(orderData);
  //         for (int i = 0; i < orderData.length; i++) {
  //           int sendType = orderData[i]["sh_stu"];
  //           if (sendType == 1 ) {
  //             dshList.add(orderData[i]);
  //           } else if (sendType == 2 || sendType == 3) {
  //             yshList.add(orderData[i]);
  //           } else if (sendType == 4) {
  //             ysendList.add(orderData[i]);
  //           } else {
  //             sendallList.add(orderData[i]);
  //           }
  //         }
  //       });
  //     });
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(
        length: tabs.length, vsync: this, initialIndex: widget.select);

    // requestSendListData(
    //   widget.userId,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0.3,
        brightness: Brightness.dark,
        backgroundColor: Colours.app_main,
        centerTitle: true,
        title: Text(
          "我的发布",
          style: TextStyles.textBold16.copyWith(color: Colours.material_bg),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: Material(
            color: Colors.white,
            child: Container(
              height: 40,
              child: TabBar(
                //生成Tab菜单
                // labelColor: Colors.white,
                  indicatorColor: Colours.app_main,
                  unselectedLabelColor: Colors.black54,
                  labelColor: Colors.black,
                  unselectedLabelStyle: TextStyle(
                      fontSize:
                      ScreenUtil.getScaleSp(context, Dimens.font_sp14)),
                  labelStyle: TextStyle(
                      fontSize:
                      ScreenUtil.getScaleSp(context, Dimens.font_sp14),
                      fontWeight: FontWeight.bold),
                  indicatorSize: TabBarIndicatorSize.label,
                  controller: _tabController,
                  indicatorWeight: 2,
                  tabs: tabs.map((e) => Tab(text: e)).toList()),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: tabs.map((e) {
          List datalist = [];
          if (e == "待审核") {
            datalist.addAll(dshList);
          } else if (e == "已审核") {
            datalist.addAll(yshList);
          } else if (e == "已取消") {
            datalist.addAll(ysendList);
          } else {
            datalist.addAll(sendallList);
          }
          //创建3个Tab页
          return
              ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return SendCellWidget();
              });
        }).toList(),
      ),
    );
  }
}
