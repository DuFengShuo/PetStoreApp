import 'dart:convert';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:local_life_app/local_recommend/iview/recommend_cell.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/widgets/my_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MineJoinPage extends StatefulWidget {

  @override
  _MineJoinPageState createState() => _MineJoinPageState();
}

class _MineJoinPageState extends State<MineJoinPage> {
  List orderList = [];
  bool cancle = false ;
  bool showLoading = true;
  // 修改contentText参数
  // _cancleData(editText) {
  //   if(editText == "success"){ //取消参与后刷新
  //     requestSendListData();
  //   }
  // }
  // //请求数据
  // void requestSendListData()async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await Future.delayed(Duration(seconds: 1), () {
  //     print("延时三秒后请求数据");
  //   });
  //   MineRequestDao.myJoinList(prefs.getInt("userId"), (data) {
  //     LogUtil.e("我的参与" + data);
  //     List orderData = jsonDecode(data);
  //     setState(() {
  //       showLoading = false;
  //       orderList = orderData;
  //     });
  //   });
 // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.3,
        backgroundColor: Colours.material_bg,
        centerTitle: true,
        title: Text(
          "我的参与",
          style: TextStyles.textBold16,
        ),
      ),
      body:ListView.builder(
          itemCount: 10,
          //itemExtent: 100,
          itemBuilder: (BuildContext context, int index) {
            return RecommendCellWidget();
          }),
    );
  }
}

class OrderCell extends StatefulWidget {
//  Map<String, dynamic> orderData;
//
//  OrderCell(this.orderData);

  @override
  _OrderCellState createState() => _OrderCellState();
}

class _OrderCellState extends State<OrderCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: MyCard(
          child: Row(
            children: <Widget>[
              Padding(
                padding:
                EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 5),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          new CircleAvatar(
                            radius: 35.0,
                            backgroundImage: AssetImage("images/niao.png"),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              "小肚",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 80,
                      height: 30,
                      child: FlatButton(
                        color: Colours.app_main,
                        //highlightColor: Colors.blue[700],
                        colorBrightness: Brightness.dark,
                        splashColor: Colors.grey,
                        child: Text(
                          "取消关注",
                          style: TextStyle(color: Colors.black87, fontSize: 12),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        onPressed: () {
                          //导航到新路由
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
