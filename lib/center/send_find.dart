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

class SendFindPage extends StatefulWidget {
  const SendFindPage({
    Key key,
  }) : super(key: key);

  @override
  _SendFindPageState createState() => _SendFindPageState();
}

class _SendFindPageState extends State<SendFindPage> {
  String _imgPath;
  List imgList;
  TextEditingController textOneController=  new TextEditingController();
  FocusNode textONeFocusNode = new FocusNode();
  TextEditingController textTwoController=  new TextEditingController();
  FocusNode textTwoFocusNode= new FocusNode();
  TextEditingController textThreeController=  new TextEditingController();
  FocusNode textThreeFocusNode= new FocusNode();
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       // resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: Text(
              "发布寻找信息",
              style: TextStyles.textBold15.copyWith(color: Colours.text),
            ),
            centerTitle: true,
            elevation: 0.3 //阴影
        ),
        body: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand, //未定位widget占满Stack整个空间
            children: <Widget>[
              SingleChildScrollView(
               // padding: EdgeInsets.only(left: 15),
                child: Center(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          new TextFieldWidget(
                            "标题",
                            "请输入标题",
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
                            controller: textTwoController,
                            focusNode: textTwoFocusNode,
                            // callBack: (value) {
                            //   print("===返回输入了$value===");
                            // },
                          ),
                          InkWell(
                            child: SwitchPhoneWidget(title: "是否悬赏",),
                          ),
                          new TextFieldWidget(
                            "悬赏金额",
                            "请输入悬赏金额",
                            controller: textThreeController,
                            focusNode: textThreeFocusNode,
                            // callBack: (value) {
                            //   print("===返回输入了$value===");
                            // },
                          ),
                          imgList != null
                              ? Container(
                            height: Screen.height(context)-200,
                            child: ShowSelectImages(
                              imgLists: imgList,
                            ),
                          )
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
                        ])),
              ),
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
                        print("===获取数据：text1:${textOneController.text} text2:${textTwoController.text}");
                        Toast.show("===获取数据：text1:${textOneController.text} text2:${textTwoController.text}");
                      },
                    ),
                  ),
                ),
              )
            ]));
  }
}
