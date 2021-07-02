import 'dart:convert';

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/util/image_utils.dart';
import 'package:local_life_app/widgets/my_button.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_life_app/mine/bottom_clip.dart';

class MemberPage extends StatefulWidget {
  @override
  _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  // var titles = ["我的订单", "我的关注", "我的参与", "设置", "关于我们"];

  var sendList = ["会员权益1", "会员权益2", "会员权益3", "会员权益1"];
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


  // Future<void> selectAssets() async {
  //   final Set<AssetEntity> result = await AssetPicker.pickAssets(
  //     context,
  //     maxAssets: 9,
  //     pathThumbSize: 84,
  //     gridCount: 4,
  //     selectedAssets: assets,
  //   );
  //   if (result != null) {
  //     assets = Set<AssetEntity>.from(result);
  //     print(assets.first);
  //     AssetEntity asset = assets.first;
  //     File file = await asset.file;
  //     print(file.path);
  //   }
  // }
  //


  bool isLogin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.bg_color,
      appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          brightness: Brightness.dark,
          backgroundColor: Colours.app_main,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "小帮会员",
            style: TextStyles.textBold16.copyWith(color: Colours.material_bg),
          )),
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand, //未定位widget占满Stack整个空间
        children: <Widget>[
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                    child: ClipPath(
                  // 只裁切底部的方法
                  clipper: BottonClipper(),
                  child: Container(
                    color: Colours.app_main,
                    height: 130,
                    // margin: EdgeInsets.only(top: 30),
                    alignment: Alignment.topCenter,
                  ),
                )),
                // 裁切的控件
                Container(
                  height: 400,
                ),
              ]),
          // Container(
          //   margin: EdgeInsets.only(left: 20,top: 10),
          //   child: Text("会员四大权益",style: TextStyles.textBold15,),
          // ),

          Container(
            padding: EdgeInsets.only(top: 150),
            height: 400,
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                //禁止滚动
                itemCount: 5,
                itemExtent: 90,
                itemBuilder: (BuildContext context, int index) {
                  return new GestureDetector(
                    child: ListTile(
                      title: Text(
                        "会员权益",
                        style:
                            TextStyles.textBold15.copyWith(color: Colours.text),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "权益介绍1",
                              style: TextStyles.textSize12
                                  .copyWith(color: Colours.sub_text_gray),
                            ),
                            Text(
                              "权益介绍1",
                              style: TextStyles.textSize12
                                  .copyWith(color: Colours.sub_text_gray),
                            ),
                            Text(
                              "权益介绍1",
                              style: TextStyles.textSize12
                                  .copyWith(color: Colours.sub_text_gray),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),

          Positioned(
            top: 45.0,
            child: Container(
              alignment: Alignment.center,
              child: ListView.builder(
                  itemCount: sendList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {},
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
                  //背景装饰
//                      gradient: RadialGradient(
//                          //背景径向渐变
//                          colors: [Colors.white, Colors.white],
//                          center: Alignment.topLeft,
//                          radius: .80),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    //卡片阴影
                    BoxShadow(
                        color: Colors.grey[200],
                        offset: Offset(2.0, 2.0),
                        blurRadius: 8.0)
                  ]),
              width: MediaQuery.of(context).size.width - 20,
              height: 70,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: ScreenUtil.getScreenW(context),
              height: 60,
              color: Colours.material_bg,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 10),
                child: MyButton(
                  minHeight: 40,
                  fontSize: 14,
                  textColor: Colours.material_bg,
                  onPressed: ()  {
                    Share.share('check out my website https://example.com', subject: 'Look what I made!');
                   // Share.shareFiles(['assets/images/none.png'], text: 'Great picture');
                    // Share.shareFiles(['${directory.path}/image1.jpg', '${directory.path}/image2.jpg']);

                   // Share.shareFiles(["${图片绝对路径，选择图片后获取其路径}"], text: 'Great picture');//传入图片的绝对路径
                   //      File file = await asset.file;
                   //      print(file.path);
                  },
                  backgroundColor: Colours.app_main,
                  text: "立即开通",
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
