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
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class SendYhPage extends StatefulWidget {
  const SendYhPage({
    Key key,
  }) : super(key: key);

  @override
  _SendYhPageState createState() => _SendYhPageState();
}

class _SendYhPageState extends State<SendYhPage> {
  String _imgPath;
  List imgList;
  String startTime = "";
  String endTime = "";
  TextEditingController textOneController = new TextEditingController();
  FocusNode textONeFocusNode = new FocusNode();
  TextEditingController textTwoController = new TextEditingController();
  FocusNode textTwoFocusNode = new FocusNode();

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
              padding: EdgeInsets.only(top: 20, bottom: 10),
              height: 340.0,
              child: SelectSendContentWidget(
                datas: data,
              ));
        });
  }

  void getState(String type) {
    DatePicker.showDateTimePicker(context,
        // 是否展示顶部操作按钮
        theme: DatePickerTheme(
            doneStyle: TextStyles.textBold14.copyWith(color: Colours.app_main),
            backgroundColor: Colours.material_bg),
        showTitleActions: true,
        // change事件
        onChanged: (date) {
      print('change $date');
    },
        // 确定事件
        onConfirm: (date) {
      print('confirm $date');
      setState(() {
        if (type == "start") {
          startTime = date.toString();
        } else {
          endTime = date.toString();
        }
      });
    },
        // 当前时间
        currentTime: DateTime.now(),
        // 语言
        locale: LocaleType.zh);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: Text(
              "发布优惠信息",
              style: TextStyles.textBold15.copyWith(color: Colours.text),
            ),
            centerTitle: true,
            elevation: 0.3 //阴影
            ),
        body: Column(
          children: [
            new TextFieldWidget(
              "标题",
              "请输入标题",
              maxLength: 30,
              controller: textOneController,
              focusNode: textONeFocusNode,
            ),
            new TextFieldWidget(
              "内容",
              "请输入内容",
              maxLength: 100,
              controller: textTwoController,
              focusNode: textTwoFocusNode,
            ),
            InkWell(
              onTap: () {
                textTwoFocusNode.unfocus();
                textTwoFocusNode.unfocus();
                getState("start");
              },
              child: SwitchDatePage(
                title: "开始日期",
                content: startTime,
              ),
            ),
            InkWell(
              onTap: () {
                textTwoFocusNode.unfocus();
                textTwoFocusNode.unfocus();
                getState("end");
              },
              child: SwitchDatePage(
                title: "结束日期",
                content: endTime,
              ),
            ),
            InkWell(
              child: SwitchPhoneWidget(title: "手机号是否作为联系方式"),
            ),

            imgList != null
                ? Expanded(
                    child: ShowSelectImages(
                    imgLists: imgList,
                  ))
                : InkWell(
                    child: SwitchPhotoCell("图片", _imgPath),
                    onTap: () {
                      textTwoFocusNode.unfocus();
                      textONeFocusNode.unfocus();
                      Navigator.push(context,
                          new MaterialPageRoute(builder: (context) {
                        return MySelectImage();
                      })).then((value) {
                        setState(() {
                          imgList = value;
                        });
                      });
                    },
                  ),
            imgList == null
                ? Expanded(
                    child: Container(
                        // color: Colours.app_main_light,
                        ))
                : Gaps.empty,

            Container(
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
                    print(
                        "===获取数据：text1:${textOneController.text} text2:${textTwoController.text}");
                    Toast.show(
                        "===获取数据：text1:${textOneController.text} text2:${textTwoController.text}");
                  },
                ),
              ),
            )
          ],
        )

        // Padding(
        //   padding: const EdgeInsets.only(bottom: 0),
        //   child: Container(
        //     width: Screen.width(context),
        //     height: 60.h,
        //     decoration: BoxDecoration(
        //         border: Border(
        //       top: Divider.createBorderSide(context, width: 0.6),
        //     )),
        //     child: Padding(
        //       padding: EdgeInsets.only(
        //           left: 20.w, right: 20.w, top: 10, bottom: 10),
        //       child: GradeButtonWidget(
        //         text: "立即发布",
        //         onTap: () {
        //           print(
        //               "===获取数据：text1:${textOneController.text} text2:${textTwoController.text}");
        //           Toast.show(
        //               "===获取数据：text1:${textOneController.text} text2:${textTwoController.text}");
        //         },
        //       ),
        //     ),
        //   ),
        // )

        // Stack(
        //  alignment: Alignment.center,
        //  fit: StackFit.expand, //未定位widget占满Stack整个空间
        //  children: <Widget>[
        //    SingleChildScrollView(
        //      child: Center(
        //          child: Column(
        //              crossAxisAlignment: CrossAxisAlignment.start,
        //              children: [
        //            new TextFieldWidget(
        //              "标题",
        //              "请输入标题",
        //              controller: textOneController,
        //              focusNode: textONeFocusNode,
        //            ),
        //            new TextFieldWidget(
        //              "内容",
        //              "请输入内容",
        //              controller: textTwoController,
        //              focusNode: textTwoFocusNode,
        //            ),
        //            InkWell(
        //              onTap: () {
        //                getState("start");
        //              },
        //              child: SwitchDatePage(
        //                title: "开始日期",
        //                content: startTime,
        //              ),
        //            ),
        //            InkWell(
        //              onTap: () {
        //                getState("end");
        //              },
        //              child: SwitchDatePage(
        //                title: "结束日期",
        //                content: endTime,
        //              ),
        //            ),
        //            InkWell(
        //              child: SwitchTimeWidget("手机号是否作为联系方式", ""),
        //            ),
        //            imgList != null
        //                ? ThreeImgCell(imgList)
        //                : InkWell(
        //                    child: SwitchPhotoCell("图片", _imgPath),
        //                    onTap: () => {
        //                      Navigator.push(context,
        //                          new MaterialPageRoute(builder: (context) {
        //                        return SelectImage();
        //                      })).then((value) {
        //                        setState(() {
        //                          imgList = value;
        //                        });
        //                      })
        //                    },
        //                  )
        //          ])),
        //    ),
        //    Positioned(
        //      bottom: 0,
        //      child: Container(
        //        width: Screen.width(context),
        //        height: 60.h,
        //        decoration: BoxDecoration(
        //            border: Border(
        //          top: Divider.createBorderSide(context, width: 0.6),
        //        )),
        //        child: Padding(
        //          padding: EdgeInsets.only(
        //              left: 20.w, right: 20.w, top: 10, bottom: 10),
        //          child: GradeButtonWidget(
        //            text: "立即发布",
        //            onTap: () {
        //              print(
        //                  "===获取数据：text1:${textOneController.text} text2:${textTwoController.text}");
        //              Toast.show(
        //                  "===获取数据：text1:${textOneController.text} text2:${textTwoController.text}");
        //            },
        //          ),
        //        ),
        //      ),
        //    )
        //  ])
        );
  }
}
