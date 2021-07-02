import 'package:flutter/material.dart';
import 'package:local_life_app/center/send_car.dart';
import 'package:local_life_app/center/send_find.dart';
import 'package:local_life_app/center/send_house.dart';
import 'package:local_life_app/center/send_input_page.dart';
import 'package:local_life_app/center/send_message.dart';
import 'package:local_life_app/center/send_old.dart';
import 'package:local_life_app/center/send_work.dart';
import 'package:local_life_app/center/send_yh.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/widgets/text_avatar_widget.dart';
import 'package:marquee_flutter/marquee_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


//import 'package:shared_preferences/shared_preferences.dart';
class SendAllWidget extends StatefulWidget {
  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<SendAllWidget> {
  String phone;
  bool isLogin = false;
  int userIds;
  var iconArray = [
    "use_icon/1",
    "use_icon/2",
    "use_icon/3",
    "use_icon/4",
    "use_icon/5",
    "use_icon/6",
    "use_icon/7",
    "use_icon/8",
    "use_icon/9",
    "use_icon/12",
  ];
  var titlesArray = [
    "本地事",
    "优惠活动",

    // "服务信息",
    "招聘|招工|帮忙",
    "买房|卖房|租房",
    "拼车|打车",
    "寻人寻物",
    "二手信息",
  ];
  var detailArray = [
    "身边有趣的事",
    "发布你的优惠信息，获取更多关注",
    // "家政，维修，干洗，搬家，洗车等服务信息",
    "全职工，兼职工，小时工，等招聘信息",
    "提供准确的房源信息",
    "不分远近到各地的拼车信息，短租或长租车，婚庆车队等信息",
    "详细的丢失的物品信息，适当悬赏，有助于更快传播",
    "家电，手机，车，家具，衣物等二手商品信息",
  ];
  var sendType = [SendType.message, SendType.discount,SendType.work,SendType.house,SendType.useCar,SendType.find,SendType.oldGoods,];
  // var appleyArray = ["信息越明确，找回机率更大", "信息越明确，找回机率更大", "问题描述清楚，", "带领，送货等需要他人代办需求","发布项目信息，寻找合作","发布招聘小时工，短工，或其他人员需求","线下或线上活动信息", "生活相关需求"];
  String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  Widget divider1 = Divider(
    color: Colors.transparent,
  ); //分割线颜色
  bool showTipItem = false; //提示开关
  var pageArray = [new SendMessagePage(),new SendYhPage(), new SendWorkPage(),new SendHousePage(),new SendUseCarPage(),new SendFindPage(),new SendOldPage()];
  Future checkIsLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String phones = prefs.getString("phone");
    int userId = prefs.getInt("userId");
    if (phones != null) {
      setState(() {
        isLogin = true;
        phone = phones;
        userIds = userId;
      });

    } else {
      setState(() {
        isLogin = false;
        phone = null;
        userIds = null;
      });
    }
  }
  // void _showRouleDialog() {
  //   showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (_) => RouleDialog());
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIsLogin();

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      // backgroundColor: Colors.amber,
      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 0,
      //  backgroundColor: Colours.app_main,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [
              Colours.app_main_light_text,
              // Colours.app_main_light_text,
              Colours.app_main,
              // Colours.dark_app_main,
            ]),
            // borderRadius: BorderRadius.circular(ScreenUtil().setHeight(44.0)),
          ),
        ),
        title: Text(
          '发布',
          style: TextStyles.textBold15
              .copyWith(color: Colours.material_bg),
        ),
        centerTitle: true,
        actions: <Widget>[
          SizedBox(
            width:  showTipItem == true?90:60 ,
            height: 50,
            child: FlatButton(
              child: Text(
                showTipItem ? "关闭规则" : "规则",
                style: TextStyle(
                  fontSize: 13,
                  color: Colours.material_bg
                ),
              ),
              onPressed: () {
                setState(() {
                  // 关闭提示
                  showTipItem = !showTipItem;
                });
              },
            ),
          ),
        ],
      ),
      body: Container(
        child: new Column(children: [
          Container(
            child: AnimatedSwitcher(
              switchInCurve: Cubic(0.4, 0.0, 0.2, 1.0),
              switchOutCurve: Cubic(1.0, 0.1, 1.0, 0.1),
              transitionBuilder: (child, anim) {
                return SlideTransition(
                    child: child,
                    position: Tween<Offset>(
                      begin: Offset(0.0, -1.0),
                      end: Offset(0.0, 0.0),
                    ).animate(anim));
              },
              duration: Duration(milliseconds: 100),
              child: showTipItem
                  ? GestureDetector(
                      onTap: (){
                        // _showRouleDialog();
                       //Fluttertoast.showToast(msg: "规则提示",gravity:ToastGravity.CENTER);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          //背景装饰
                          borderRadius:
                              new BorderRadius.all(Radius.elliptical(5, 5)),
                          color: Colors.white,
                        ),
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width,
                        //margin: EdgeInsets.only(left: 10,right: 10,top: 5),
                        height: 40,
                        key: ValueKey("TipItem"),
//                color: Colors.white,  //red[500]
                        child: new Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                              ),
                              child: SizedBox(
                                child: new Icon(Icons.notification_important,
                                    color: Colors.black, size: 20),
                              ),
                            ),
                            new SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 50,
                              height: 30,
                              child: new MarqueeWidget(
                                text:
                                "优惠活动,拼车用车，新用户每天可发布3次，其他类别不限次数，分享获得更多发布次数！",
                                textStyle: new TextStyle(
                                    fontSize: 13.0, color: Colors.black),
                                scrollAxis: Axis.horizontal,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : new Container(
                      key: ValueKey("hideItem"),
                    ),
            ),
          ),
          Divider(
            height: 1,
          ),
          new Expanded(
            child: new Container(
//              margin: EdgeInsets.only(top: 10),
              child: ListView.builder(
                //tableview带分割线
                padding: EdgeInsets.only(top: 10, bottom: 10),
                itemCount: titlesArray.length,
                //列表项构造器
                itemBuilder: (BuildContext context, int index) {
                  return new GestureDetector(
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 10, top: 5, right: 10, bottom: 5),
                      decoration: BoxDecoration(
                          //背景装饰
                          borderRadius:
                              new BorderRadius.all(Radius.elliptical(5, 5)),
                          gradient: RadialGradient(
                              //背景径向渐变
                              colors: [Colors.white, Colors.white],
                              center: Alignment.topLeft,
                              radius: 5),
                          boxShadow: [
                            //卡片阴影
                            BoxShadow(
                                color: Colors.grey[200],
                                offset: Offset(2.0, 2.0),
                                blurRadius: 8.0)
                          ]
                      ),
                      child: Flex(
                        //弹性布局
                        direction: Axis.horizontal, //水平方向分割
                        children: <Widget>[
                          Expanded(
                            //cell左边
                            flex: 6,
                            child: Container(
                              // color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 5, left: 10, bottom: 10, right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  //排除colum居中对齐干扰
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 5, right: 10),
                                      child: Text(
                                        titlesArray[index],
                                        style: TextStyles.textBold13.copyWith(color: Colours.text,fontWeight: FontWeight.w600),
                                      ),
                                    ),

                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 5, right: 10),
                                      child: Text(
                                        detailArray[index],
                                        style: TextStyles.textSize11.copyWith(color: Colours.text_gray_holder),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 0),
                            child:
                            TextAvatarWidget(title: titlesArray[index].substring(0,2),),
                            // new CircleAvatar(
                            //   radius: 24.0,
                            //   backgroundColor: Colors.white30,
                            //   backgroundImage: ImageUtils.getAssetImage(iconArray[index]),
                            // ),
                          ),
                          Container(
                            width: 20,
                            height: 20,
                            margin: EdgeInsets.only(right: 5),
                            // padding: EdgeInsets.only(top:15),
                            child: Icon(Icons.navigate_next,color:  Colors.black45,),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context, new MaterialPageRoute(builder: (context) {
                        return pageArray[index];
                      }));
                    }
                  );

                },
              ),
            ),
          )
        ]),
      ),
    );
  }
}
