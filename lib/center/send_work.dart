import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_life_app/center/widget/select_cell.dart';
import 'package:local_life_app/center/widget/select_sendcontent_widget.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/util/image_utils.dart';
import 'package:local_life_app/util/screen_utils.dart';
import 'package:local_life_app/util/toast_utils.dart';
import 'package:local_life_app/widgets/grade_button.dart';
import 'package:local_life_app/widgets/select_img.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class SendWorkPage extends StatefulWidget {
  const SendWorkPage({
    Key key,
  }) : super(key: key);

  @override
  _SendWorkPageState createState() => _SendWorkPageState();
}

class _SendWorkPageState extends State<SendWorkPage> {
  String _imgPath;
  List imgList;
  TextEditingController textOneController = new TextEditingController();
  FocusNode textONeFocusNode = new FocusNode();
  TextEditingController textTwoController = new TextEditingController();
  FocusNode textTwoFocusNode = new FocusNode();
  TextEditingController textThreeController = new TextEditingController();
  FocusNode textThreeFocusNode = new FocusNode();
  String workType = "";

  showSelectServiceBottom(BuildContext context, List data, String title) {
    showModalBottomSheet(
        //带背景的弹框
        backgroundColor: Colors.transparent, //重点
        context: context,
        builder: (BuildContext context) {
          return new Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              //  padding: EdgeInsets.only(top: 20, bottom: 10),
              // height: 340.0,
              child: SelectSendContentWidget(
                datas: data,
                title: title,
                callBack: (result) {
                  print("===$result===");
                },
              ));
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomInset: false, //底部不被顶起
        appBar: AppBar(
            title: Text(
              "发布工作信息",
              style: TextStyles.textBold15.copyWith(color: Colours.text),
            ),
            centerTitle: true,
            elevation: 0.3 //阴影
            ),
        body: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand, //未定位widget占满Stack整个空间
            children: <Widget>[
              ListView(
                 padding: EdgeInsets.only(bottom: 140),
                  children: [
                    new TextFieldWidget(
                      "标题",
                      "请输入标题",
                      maxLength: 30,
                      controller: textOneController,
                      focusNode: textONeFocusNode,
                      // callBack: (value) {
                      //   print("===返回输入了$value===");
                      //
                      // },
                    ),
                    new TextFieldWidget(
                      "内容",
                      "请输入内容",
                      maxLength: 100,
                      controller: textTwoController,
                      focusNode: textTwoFocusNode,
                      // callBack: (value) {
                      //   print("===返回输入了$value===");
                      // },
                    ),

                    SelectResultWidget(
                      title: "类型",
                      holder: "请选择工作类型",
                      datas: [
                        "全职",
                        "兼职",
                        "小时工",
                        "学徒",
                        "其他",
                      ],
                      callBack: (result) {
                        if (result != null) {
                          print("返回了$result");
                        }
                      },
                    ),

                    SelectResultWidget(
                      title: "薪资",
                      holder: "请选择薪资范围",
                      datas: [
                        "1000以下",
                        "1000-3000",
                        "3000-5000",
                        "5000-8000",
                        "8000-10000",
                        "1w-2w",
                        "2w-3w",
                        "3w以上"
                      ],
                      callBack: (result) {
                        if (result != null) {
                          print("返回了$result");
                        }
                      },
                    ),
                    SelectResultWidget(
                      title: "经验",
                      holder: "请选择工作经验",
                      datas: ["1年以下", "1-3年", "3-5年", "5年以上", "不限"],
                      callBack: (result) {
                        if (result != null) {
                          print("返回了$result");
                        }
                      },
                    ),
                    SelectResultWidget(
                      title: "学历",
                      holder: "请选择学历",
                      datas: ["初中", "高中", "大专", "本科", "研究生", "不限"],
                      callBack: (result) {
                        if (result != null) {
                          print("返回了$result");
                        }
                      },
                    ),

                    new TextFieldWidget(
                      "单位",
                      "请输入单位名称",
                      controller: textThreeController,
                      focusNode: textThreeFocusNode,
                      // callBack: (value) {
                      //   print("===返回输入了$value===");
                      // },
                    ),

                    SelectResultWidget(
                      title: "人数",
                      holder: "请选择单位人数",
                      datas: [
                        "0-100人",
                        "100-200人",
                        "300-500人",
                        "500-1000人",
                        "1000人以上"
                      ],
                      callBack: (result) {
                        if (result != null) {
                          print("返回了$result");
                        }
                      },
                    ),

                    InkWell(
                      child: SwitchPhoneWidget(title: "手机号是否作为联系方式"),
                    ),

                  ]),
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
                      text: "立即发布",
                      onTap: () {
                        textONeFocusNode.unfocus();
                        textTwoFocusNode.unfocus();
                        print(
                            "===获取数据：text1:${textOneController.text} text2:${textTwoController.text}");
                        Toast.show(
                            "===获取数据：text1:${textOneController.text} text2:${textTwoController.text}");
                      },
                    ),
                  ),
                ),
              )
            ]));
  }
}
