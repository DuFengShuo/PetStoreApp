import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/widgets/my_card.dart';


class SendCellWidget extends StatefulWidget {
  // Map<String, dynamic> sendData;
  // int type;
  //
  // SendCellWidget(this.sendData, this.type);

  @override
  _SendCellWidgetState createState() => _SendCellWidgetState();
}

class _SendCellWidgetState extends State<SendCellWidget> {
  String msgType;
  String shStu = "审核中";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String type = "优惠活动";
    if (type == "yh") {
      msgType = "优惠活动";
    } else if (type == "house") {
      msgType = "本地房产";
    } else if (type == "find") {
      msgType = "寻人寻物";
    } else if (type == "useCar") {
      msgType = "拼车";
    } else if (type == "jz") {
      msgType = "服务";
    }else if (type == "work") {
      msgType = "招聘招工";
    }else if (type == "ershou") {
      msgType = "二手信息";
    } else {
      msgType = "优惠活动";
    }
    int sh_stu = 1;
    if (sh_stu == 1) {
      shStu = "审核中";
    } else if (sh_stu == 2) {
      shStu = "已发布";
    } else if (sh_stu == 3) {
      shStu = "审核失败";
    } else if (sh_stu == 4) {
      shStu = "已取消";
    }else if (sh_stu == 5) {
      shStu = "已到期";
    }
//    }else if (sh_stu == 1) {
//      shStu = "待审核";
//    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MyCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10, top: 15),
                  child: Text(
                    "信息类型：",
                    style: TextStyle(fontSize: ScreenUtil.getScaleSp(context, Dimens.font_sp12), color: Colors.black87),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      "${msgType}",
                      style: TextStyle(
                          fontSize: ScreenUtil.getScaleSp(context, Dimens.font_sp12),
                          fontWeight: FontWeight.w600,
                          color: Colours.app_main),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15, top: 15),
                  child: Text(
                    "${shStu}",
                    style: TextStyle(
                        fontSize: ScreenUtil.getScaleSp(context, Dimens.font_sp12),
                        fontWeight: FontWeight.w600,
                        color: shStu == "审核失败" ? Colors.red : Colours.text),
                  ),
                ),
              ],
            ),
            shStu == "审核失败"
                ? Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10, top: 15),
                  child: Text(
                    "审核结果：",
                    style: TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                ),
                Expanded(child:   Padding(
                  padding: EdgeInsets.only( top: 15,right: 10),
                  child: Text(
                    "",
                    style: TextStyle(fontSize: ScreenUtil.getScaleSp(context, Dimens.font_sp12), color: Colors.black87),
                  ),
                ),)

              ],
            )
                : Container(),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 10, top: 15),
                    child: Text(
                      "标题",
                      style: TextStyle(
                          fontSize: ScreenUtil.getScaleSp(context, Dimens.font_sp14),
                          fontWeight: FontWeight.w600,
                          color: Colors.black87),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding:
              EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 15),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "发布日期：",
                            style:
                            TextStyle(fontSize: ScreenUtil.getScaleSp(context, Dimens.font_sp12), color: Colors.black87),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "2021.02.11-2021.9.1",
                            softWrap: true,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                            TextStyle(color: Colors.black54, fontSize: ScreenUtil.getScaleSp(context, Dimens.font_sp12)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 90,
                    height: 30,
                    child: FlatButton(
                      color: Colours.app_main,
                      //highlightColor: Colors.blue[700],
                      colorBrightness: Brightness.dark,
                      splashColor: Colors.grey,
                      child: Text(
                         "取消发布",
                        style: TextStyle(color: Colors.white, fontSize: ScreenUtil.getScaleSp(context, Dimens.font_sp12)),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      onPressed: () {
                        //导航到新路由
                      },
                    ),
                  ),
//                  widget.type == 3
//                      ? Padding(
//                          padding: const EdgeInsets.only(left: 3),
//                          child: SizedBox(
//                            width: 80,
//                            height: 30,
//                            child: FlatButton(
//                              color: Colors.amber,
//                              //highlightColor: Colors.blue[700],
//                              colorBrightness: Brightness.dark,
//                              splashColor: Colors.grey,
//                              child: Text(
//                                widget.type == 3 ? "刷一刷" : "询问结果",
//                                style: TextStyle(
//                                    color: Colors.black87, fontSize: 12),
//                              ),
//                              shape: RoundedRectangleBorder(
//                                  borderRadius: BorderRadius.circular(20.0)),
//                              onPressed: () {
//                                //导航到新路由
//                              },
//                            ),
//                          ),
//                        )
//                      : Container()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
