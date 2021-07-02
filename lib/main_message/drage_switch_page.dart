import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/util/image_utils.dart';
import 'package:local_life_app/util/screen_utils.dart';
import 'package:local_life_app/widgets/grade_button.dart';
import 'package:local_life_app/widgets/text_avatar_widget.dart';
class DrageSwitchPage extends StatefulWidget {
  List<Map> titles = [];
  DrageSwitchPage(this.titles);
  @override
  State<StatefulWidget> createState() {
    return _DrageSwitchPageState();
  }
}

class _DrageSwitchPageState extends State<DrageSwitchPage> {
  String _movingValue; // 记录正在移动的值
  var _align = Alignment.bottomCenter;
  bool isDraged = false;

  @override
  Widget build(BuildContext context) {
    var duration = Duration(seconds: 3);
    return Scaffold(
//      backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65),
          child: AppBar(
              // leading: new IconButton(
              //     icon:
              //         new Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
              //     onPressed: () {
              //       isDraged == true
              //           ? Navigator.pop(context, {"titleList": widget.titles})
              //           : Navigator.pop(context);
              //     }),
            //  brightness: Brightness.dark,
              //backgroundColor: Colours.app_main,
              elevation: 0.3,
              centerTitle: true,
              title: TopTitle()),
        ),
        body: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand, //未定位widget占满Stack整个空间
            children: <Widget>[
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    // height: 1200,
                    child: GridView(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: 0.9),
                      children: buildItems(),
                      physics: NeverScrollableScrollPhysics(), //禁止滚动
                    ),
                  ),
                ),
              ),
              isDraged == true
                  ?
              Positioned(
                bottom: 0,
                child: Container(
                  width: Screen.width(context),
                  height: 60.h,
                  decoration: BoxDecoration(
                      border: Border(
                        top: Divider.createBorderSide(context, width: 0.6),
                      )),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 20.w, right: 20.w, top: 10, bottom: 10),
                    child: GradeButtonWidget(
                      text: "保存调整",
                      onTap: () {
                        Navigator.pop(
                            context, {"titleList": widget.titles});
                      },
                    ),
                  ),
                ),
              )
                  : Gaps.empty
            ]));
  }

  // 生成GridView的items
  List<Widget> buildItems() {
    List<Widget> items = List<Widget>();
    widget.titles.forEach((value) {
      items.add(draggableItem(value));
    });
    return items;
  }

  // 生成可拖动的item
  Widget draggableItem(value) {
    return Container(
      child: Draggable(
        data: value,
        child: DragTarget(
          builder: (context, candidateData, rejectedData) {
            return baseItem(value, Colors.white);
          },
          onWillAccept: (moveData) {
            print('=== onWillAccept: $moveData ==> $value');

            var accept = moveData != null;
            if (accept) {
              exchangeItem(moveData, value, false);
            }
            return accept;
          },
          onAccept: (moveData) {
            print('=== onAccept: $moveData ==> $value');
            exchangeItem(moveData, value, true);
          },
          onLeave: (moveData) {
            print('=== onLeave: $moveData ==> $value');
          },
        ),
        feedback: baseItem(value, Colours.bg_gray.withOpacity(1)),
        childWhenDragging: null,
        onDragStarted: () {
          print('=== onDragStarted');

          setState(() {
            _movingValue = value["title"];
          });
        },
        onDraggableCanceled: (Velocity velocity, Offset offset) {
          print('=== onDraggableCanceled');
          setState(() {
            _movingValue = null;
          });
        },
        onDragCompleted: () {
          print('=== onDragCompleted');
          setState(() {
            isDraged = true;
            _align = Alignment.topCenter;
          });
        },
      ),
    );
  }

  // 基础展示的item 此处设置width,height对GridView 无效，主要是偷懒给feedback用
  Widget baseItem(value, bgColor) {
    if (value["title"] == _movingValue) {
      return Container();
    }
    return Material(
        child: GestureDetector(
      onTap: () {
        Navigator.pop(
          context,
          {"selectIndex": value["title"]},
        );
      },
      child: Container(
        width: 110,
        height: 120,
//      margin: EdgeInsets.only(left: 5,right: 5,top: 5),
        decoration: BoxDecoration(
          //背景装饰
          border: Border.all(
            color: Colors.grey[100],
            width: 0.6,
            style: BorderStyle.solid,
          ),
          color: bgColor,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // new CircleAvatar(
              //   backgroundColor: Colours.app_main_light,
              //   radius: 28.0,
              //   backgroundImage: ImageUtils.getAssetImage("${value["img"]}"),
              // ),
              TextAvatarWidget(title: value["title"].substring(0,2),),
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Text(
                  value["title"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  // 重新排序
  void exchangeItem(moveData, toData, onAccept) {
    setState(() {
      var toIndex = widget.titles.indexOf(toData);

      widget.titles.remove(moveData);
      widget.titles.insert(toIndex, moveData);

      if (onAccept) {
        _movingValue = null;
      }
    });
  }
}

///头部
class TopTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      //  alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "点击跳转到首页对应栏目",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: Colours.text),
          ),
          Padding(
            padding: EdgeInsets.only(top: 3),
            child: Text(
              "拖拽调整栏目顺序",
              style: TextStyles.textSize11.copyWith(color: Colours.sub_text_gray),
            ),
          ),
        ],
      ),
    );
  }
}
