import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_life_app/common/common.dart';
import 'package:local_life_app/login/login_router.dart';
import 'package:local_life_app/login/page/sms_login_page.dart';
import 'package:local_life_app/mine/about_detail.dart';
import 'package:local_life_app/mine/mine_router.dart';
import 'package:local_life_app/mine/my_join_page.dart';
import 'package:local_life_app/mine/my_send_page.dart';
import 'package:local_life_app/mine/setting.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/routers/fluro_navigator.dart';
import 'package:local_life_app/util/global_eventbus.dart';
import 'package:local_life_app/util/image_utils.dart';
import 'package:local_life_app/util/sp_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_life_app/mine/bottom_clip.dart';
import 'package:local_life_app/mine/member_page.dart';

class MinePages extends StatefulWidget {
  @override
  _MinePagesState createState() => _MinePagesState();
}

class _MinePagesState extends State<MinePages> {
  // var titles = ["我的订单", "我的关注", "我的参与", "设置", "关于我们"];
  var titles = ["小帮会员", "我的参与", "设置", "关于我们"];
  String phone = "点击登录";
  int userId;
  var iconArray = [
    Icon(
      Icons.local_atm,
      color: Colours.text,
    ),
    Icon(
      Icons.sort,
      color: Colours.text,
    ),
    Icon(
      Icons.settings,
      color: Colours.text,
    ),
    Icon(
      Icons.account_box,
      color: Colours.text,
    ),
  ];
  var sendList = ["我的发布", "待审核", "已审核", "已取消"];
  var sendIcon = [
    Icon(
      Icons.featured_play_list,
      color: Colours.app_main,
    ),
    Icon(
      Icons.person_pin,
      color: Colours.app_main,
    ),
    Icon(
      Icons.exit_to_app,
      color: Colours.app_main,
    ),
    Icon(
      Icons.screen_share,
      color: Colours.app_main,
    ),
  ];

  bool isLogin = false;

  Future checkIsLogin() async {
    String phones = SpUtil.getString(Constant.phone);
    // int userIds = prefs.getInt("userId");
    if (phones != null || phones.isNotEmpty) {
      setState(() {
        isLogin = true;
        phone = phones;
        // userId = userIds;
      });
    } else {
      setState(() {
        phone = "立即登录";
        isLogin = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //checkIsLogin();
    GlobalEventBus().event.on<String>().listen((event) async {
      if (event == 'login') {
          setState(() {
            isLogin =true;
          });
      } else if (event == 'logout') {
        setState(() {
          isLogin = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // color: Colours.app_main,

        body: SingleChildScrollView(
            // physics: NeverScrollableScrollPhysics(),
            // shrinkWrap: true,
            child: Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand, //未定位widget占满Stack整个空间
        children: <Widget>[
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
              Widget>[
            GestureDetector(
                onTap: () async {
                  // NavigatorUtils.push(context, LoginRouter.smsLoginPage);
                  if (isLogin) {
                    NavigatorUtils.push(context, MineRouter.mineInfo);
                  } else {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SMSLoginPage();
                        },
                      ),
                    ).then((value) {
                      checkIsLogin();

                    });
                  }
                },

                // onTap: ()=>  NavigatorUtils.push(context, isLogin==true?MineRouter.mineInfo:LoginRouter.smsLoginPage),
                child: ClipPath(
                  // 只裁切底部的方法
                  clipper: BottonClipper(),
                  child: Container(
                    //  color: Colours.app_main,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        Colours.app_main_light_text,
                        // Colours.app_main_light_text,
                        Colours.app_main,
                        // Colours.dark_app_main,
                      ]),
                      // borderRadius: BorderRadius.circular(ScreenUtil().setHeight(44.0)),
                    ),
                    height: 250,
                    // margin: EdgeInsets.only(top: 30),
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 45),
                      child: Column(
                        children: <Widget>[
                          Gaps.vGap15,
                          //Icon(Icons.person,color: Colors.black45,),
                          new CircleAvatar(
                            radius: 30.0,
                            backgroundColor: Colours.material_bg,
                            backgroundImage:
                                ImageUtils.getAssetImage("me/avatar"),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              isLogin == true ? "18801114226" : "点击登录",
                              // "点击登录",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )),
            // 裁切的控件

            Container(
              // height: 400,
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  //禁止滚动
                  itemCount: titles.length,
                  itemExtent: 80,
                  itemBuilder: (BuildContext context, int index) {
                    return new GestureDetector(
                      onTap: () {
                        switch (index) {
                          case 0:
                            {
                              Navigator.push(context,
                                  new MaterialPageRoute(builder: (context) {
                                return MemberPage();
                              }));
                            }
                            break;
                          case 1:
                            {
                              Navigator.push(context,
                                  new MaterialPageRoute(builder: (context) {
                                return MineJoinPage();
                              }));
                            }
                            break;
                          case 2:
                            {
                              Navigator.push(context,
                                  new MaterialPageRoute(builder: (context) {
                                return SettingPage();
                              }));
                            }
                            break;
                          case 3:
                            {
                              Navigator.push(context,
                                  new MaterialPageRoute(builder: (context) {
                                return AboutUs();
                              }));
                            }
                            break;
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 10,
                        ),
                        margin: EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            // //背景装饰
                            // gradient: RadialGradient(
                            //     //背景径向渐变
                            //     colors: [Colors.white, Colors.white],
                            //     center: Alignment.topLeft,
                            //     radius: .20),
                            color: Colours.material_bg,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            boxShadow: [
                              //卡片阴影
                              BoxShadow(
                                  color: Colors.black.withAlpha(13),
                                  offset: Offset(0, 0),
                                  blurRadius: 2.0)
                            ]),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            iconArray[index],
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  "${titles[index]}",
                                  style: TextStyles.textSize13,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.navigate_next,
                              color: Colors.black45,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ]),
          Positioned(
            top: 175.0,
            child: Container(
              alignment: Alignment.center,
              child: ListView.builder(
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context,
                            new MaterialPageRoute(builder: (context) {
                          return MySendPage(
                            index,
                          );
                        }));
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        width: (MediaQuery.of(context).size.width - 15) / 4,
                        height: 100,
                        //  alignment: Alignment.center,
                        child: Column(
                          children: <Widget>[
                            sendIcon[index],
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                "${sendList[index]}",
                                style: TextStyles.textSize13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    //卡片阴影
                    BoxShadow(
                        color: Colors.black.withAlpha(8),
                        offset: Offset(0, 2.0),
                        blurRadius: 7.0)
                  ]),
              width: MediaQuery.of(context).size.width - 20,
              height: 70,
            ),
          ),
        ],
      ),
    )));
  }
}
