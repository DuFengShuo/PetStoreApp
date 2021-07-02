import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_life_app/center/widget/select_cell.dart';
import 'package:local_life_app/center/widget/select_sendcontent_widget.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/util/image_utils.dart';
import 'package:local_life_app/util/screen_utils.dart';
import 'package:local_life_app/widgets/grade_button.dart';
import 'package:local_life_app/widgets/select_img.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

//定义枚举类型
enum SendType {
  discount,
  service,
  work,
  house,
  oldGoods,
  find,
  useCar,
  message
}

class SendInputPage extends StatefulWidget {
  final SendType sendType;

  const SendInputPage({Key key, this.sendType}) : super(key: key);

  @override
  _SendInputPageState createState() => _SendInputPageState();
}

class _SendInputPageState extends State<SendInputPage> {
  String nameText; //姓名
  String detailText; //详情
  String priceText; //价格
  String addressText; //地址
  String msText; //描述
  String phoneText; //联系方式
  String phoneNameText; //联系人
  String timeText; //时间段
  List alogList; //弹框提示
  bool isSj = false;

  String _imgPath;
  List serviceData = [
    "优惠活动",
    "拼车用车",
    "二手交易",
    "本地房产",
    "招聘招工",
    "寻人寻物",
    "相亲交友",
    "本地事",
    "其他"
  ];

  List contentList = [
    {"type": "input", "title": "标题"},
    {"type": "input", "title": "内容"},
  ];

  void addContentView() {
    switch (widget.sendType) {
      case SendType.message:
        {
          List addContentList = [
            {
              "type": "selectImage",
              "title": "选择图片",
            },
          ];
          contentList.addAll(addContentList);
        }
        break;
      case SendType.discount:
        {
          List addContentList = [
            {
              "type": "select",
              "title": "开始日期",
              "content": [
                "当前",
              ],
            },
            {
              "type": "select",
              "title": "结束日期",
              "content": [
                "1月以内",
                "3月以内",
                "半年以内",
                "一年以内",
                "长期有效",
                "其他",
              ],
            },
            {
              "type": "selectImage",
              "title": "选择图片",
            },
            {
              "type": "switch",
              "title": "是否可以联系",
            },
          ];
          contentList.addAll(addContentList);
        }
        break;

      case SendType.work:
        {
          //statements;
          List addContentList = [
            {
              "type": "select",
              "title": "工作类型",
              "content": [
                "全职",
                "兼职",
                "小时工",
                "学徒",
                "其他",
              ],
            },
            {
              "type": "select",
              "title": "职位薪资",
              "content": [
                "1000以下",
                "1000-3000",
                "3000-5000",
                "5000-8000",
                "8000-10000",
                "1w-2w",
                "2w-3w",
                "3w以上"
              ],
            },
            {
              "type": "select",
              "title": "经验",
              "content": ["1年以下", "1-3年", "3-5年", "5年以上", "不限"],
            },
            {
              "type": "select",
              "title": "学历",
              "content": ["初中", "高中", "大专", "本科", "研究生", "不限"],
            },
            {
              "type": "input",
              "title": "单位",
            },
            {
              "type": "select",
              "title": "单位人数",
              "content": [
                "0-100人",
                "100-200人",
                "300-500人",
                "500-1000人",
                "1000人以上"
              ]
            },
            {"type": "switch", "title": "是否可以联系",},
          ];
          contentList.addAll(addContentList);
        }
        break;
      case SendType.find:
        {
          List addContentList = [
            {"type": "switch", "title": "是否悬赏",},
            {"type": "input", "title": "悬赏金额",},
            {"type": "switch", "title": "是否可以联系",},
          ];
          contentList.addAll(addContentList);
        }
        break;
      case SendType.house:
        {
          //statements;
          List addContentList = [
            {
              "type": "select",
              "title": "房产类型",
              "content": ["新楼盘", "二手房", "出租房", "门面", "办公", "厂房", "其他"],
            },
            {"type": "input", "title": "价格"},
            {
              "type": "switch",
              "title": "是否可以联系",
            },
            {
              "type": "selectImage",
              "title": "选择图片",
            },
          ];
          contentList.addAll(addContentList);
        }
        break;
      case SendType.oldGoods:
        {
          //statements;
          List addContentList = [
            {"type": "input", "title": "价格"},
            {"type": "switch", "title": "是否可以联系",},
            {"type": "selectImage", "title": "选择图片",},
          ];
          contentList.addAll(addContentList);
        }
        break;
      case SendType.useCar:
        {
          List addContentList = [
            {
              "type": "select",
              "title": "出行类型",
              "content": ["拼车", "租车", "打车", "搬家用车", "其他"],
            },
            {"type": "input", "title": "价格"},
            {"type": "input", "title": "出发地"},
            {"type": "input", "title": "目的地"},
            {"type": "input", "title": "车牌"},
            {
              "type": "switch",
              "title": "是否可以联系",
            },
          ];
          contentList.addAll(addContentList);
        }
        break;
      case SendType.service:
        {
          //statements;
        }
        break;
      default:
        {
          //statements;
        }
        break;
    }
  }

  bool showLoading = false;

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

  //更新用户数据
  updateUserInfo(String name, String avatar) {}
  List imgList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addContentView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              "发布信息",
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
                padding: EdgeInsets.only(left: 15),
                child: Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: contentList.map((e) {
                        Map data = e;
                        if (data["type"] == "input") {
                          return new TextFieldWidget(
                            "${data["title"]}",
                            "请输入${data["title"]}",
                            callBack: (value){
                              print("===返回输入了$value===");
                            },
                          );
                        } else if (data["type"] == "select") {
                          return InkWell(
                            onTap: () {
                              showSelectServiceBottom(
                                  context, data["content"], "选择类型");
                            },
                            child: SwitchTextWidget(
                                "${data["title"]}", "请选择${data["title"]}"),
                          );
                        } else if (data["type"] == "switch") {
                          return InkWell(
                            child: SwitchTimeWidget(
                                "${data["title"]}", "请选择${data["title"]}"),
                          );
                        } else if (data["type"] == "selectImage") {
                          return imgList != null
                              ? ThreeImgCell(imgList)
                              : InkWell(
                                  child: SwitchPhotoCell("图片（大于3张）", _imgPath),
                                  onTap: () => {
                                    Navigator.push(context,
                                        new MaterialPageRoute(
                                            builder: (context) {
                                      return MySelectImage();
                                    })).then((value) {
                                      setState(() {
                                        imgList = value;
                                      });
                                    })
                                  },
                                );
                        } else {
                          return new TextFieldWidget(
                            "标题",
                            "请输入标题",
                          );
                        }
                      }).toList()),
                ),
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
                      onTap: () {},
                    ),
                  ),
                ),
              )
            ]));
  }
}

