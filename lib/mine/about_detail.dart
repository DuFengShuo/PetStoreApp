import 'package:flutter/material.dart';
import 'package:local_life_app/res/resources.dart';


class AboutUs extends StatelessWidget {
  // String neirongs;
//  MainContents(String contests) {
//    this.neirongs = contests;
//    print("内容值"+neirongs);
//  }  ///通过构造函数传值

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          backgroundColor: Colours.material_bg,
          title: Text("关于我们",style: TextStyles.textBold16,),
          centerTitle: true,
        ),
        body: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 20, left: 10, right: 10),
          ///容器外调整位置
          constraints: BoxConstraints.tightFor(height: 150.0),
          //卡片大小
          decoration: BoxDecoration(
              //背景装饰
              borderRadius: new BorderRadius.all(Radius.elliptical(5, 5)),
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
              ]),

          ///
          ///width: 200,
          // height: 200,
          // color: Colors.white,
          child: Column(
            children: <Widget>[

              new CircleAvatar(
                radius: 30.0,
                backgroundColor: Colours.app_main_light,
                backgroundImage: AssetImage("images/niao.png"),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 5
                ),
                child: Text("本地帮APP",style: TextStyles.textBold16,),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Text("v1.0.0"),
              )
            ],
          ),
          padding: EdgeInsets.only(
            top: 20,
          ),
        ));
  }
}
