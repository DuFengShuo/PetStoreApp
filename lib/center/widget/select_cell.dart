import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_life_app/center/widget/select_sendcontent_widget.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/util/image_utils.dart';
import 'package:local_life_app/widgets/select_img.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget _imageAssetWidget(AssetEntity asset) {
  //显示选择的图片
  return Image(
    image: AssetEntityImageProvider(asset, isOriginal: false),
    fit: BoxFit.cover,
  );
}

class ShowSelectImages extends StatefulWidget {
  final List imgLists;

  const ShowSelectImages({Key key, this.imgLists}) : super(key: key);

  @override
  _ShowSelectImagesState createState() => _ShowSelectImagesState();
}

class _ShowSelectImagesState extends State<ShowSelectImages> {
  List imgList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imgList = widget.imgLists ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Navigator.push(context, new MaterialPageRoute(builder: (context) {
        return MySelectImage(
          imageList: imgList,
        );
      })).then((value) {
        if (value != null) {
          setState(() {
            imgList = value;
          });
        }
      }),
      child: Container(
        // color: Colors.red,
        // height: 220,
        width: MediaQuery.of(context).size.width,
        child: Padding(
            padding: EdgeInsets.only(top: 15, right: 10, left: 10),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, //每行三列
                  childAspectRatio: 1, //显示区域宽高相等
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: imgList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),

                        ///图片顶部圆角
                        child: _imageAssetWidget(imgList[index])),
                  );
                })),
      ),
    );
  }
}

class ThreeImgCell extends StatelessWidget {
  List imgList;

  ThreeImgCell(this.imgList);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Navigator.push(context, new MaterialPageRoute(builder: (context) {
        return MySelectImage(
          imageList: imgList,
        );
      })),
      child: Container(
        // color: Colors.red,
        height: 120,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.only(top: 15, right: 10, left: 15),
          child: Wrap(
            children: imgList
                .map((e) => Expanded(
                        child: Container(
                      height: 100.0,
                      width: (MediaQuery.of(context).size.width - 35) / 3,
                      padding: EdgeInsets.all(3),
                      color: Colors.white,
                      child: GestureDetector(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(6.0),

                            ///图片顶部圆角
                            child: _imageAssetWidget(e)),
                      ),
                    )))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class SwitchPhotoCell extends StatelessWidget {
  String title;
  var imgPath;

  SwitchPhotoCell(this.title, this.imgPath);

  /*图片控件*/
  Widget _ImageView(imgPath) {
    if (imgPath == null) {
      return Container(
        alignment: Alignment.centerRight,
        margin: EdgeInsets.only(right: 0),
        child: new CircleAvatar(
          radius: 20.0,
          backgroundColor: Colours.app_main_light,
          backgroundImage: ImageUtils.getAssetImage("logo"),
        ),
      );
    } else {
      return Container(
        alignment: Alignment.centerRight,
        margin: EdgeInsets.only(right: 0),
        child: new CircleAvatar(
          radius: 0.0,
          backgroundImage: FileImage(imgPath),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          border: Border(
        bottom: Divider.createBorderSide(context, width: 0.6),
      )),
      child: Padding(
        padding: const EdgeInsets.only(top: 18, bottom: 18),
        child: Row(
          children: <Widget>[
            Text(
              title + "：",
              style: TextStyles.text,
            ),
            Gaps.hGap5,
            Text(
              "请选择三张图片",
              style: TextStyles.textGray12.copyWith(color: Colours.text_gray_c),
            ),
            Expanded(child: Gaps.empty),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Icon(
                Icons.navigate_next,
                color: Colors.black38,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  String title;
  String hoder;
  final maxLength;
  final TextEditingController controller;

  final FocusNode focusNode;
  final Function callBack;

  TextFieldWidget(
    this.title,
    this.hoder, {
    Key key,
    this.callBack,
    this.controller,
    this.focusNode,
    this.maxLength,
  }) : super(key: key); //添加key可以让其控件与父级对应，setstate的时候不用重新创建

  @override
  Widget build(BuildContext context) {
    return Container(
      //卡片大小
      margin: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          border: Border(
        bottom: Divider.createBorderSide(context, width: 0.6),
      )),
      child: Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                title + ":",
                style: TextStyles.text,
              ),
            ),
            Gaps.hGap16,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: TextField(
                  keyboardType: TextInputType.text,
                  maxLines: 5,
                  minLines: 1,
                  maxLength: maxLength ?? null,
                  style: TextStyles.textSize13,
                  controller: controller,
                  focusNode: focusNode,
                  // onChanged: (value){
                  //   print("开始输入了");
                  //   callBack(value);
                  // },
                  // onSubmitted: (value){
                  //   print("点了");
                  //   callBack(value);
                  // },
                  decoration: InputDecoration(
                    hintText: '$hoder',
                    hintStyle:
                        TextStyle(fontSize: 13, color: Colours.text_gray_c),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 5),
                    isDense: true,
                    border: const OutlineInputBorder(
                      gapPadding: 0,
                      // borderRadius: const BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectResultWidget extends StatefulWidget {
  final String title;
  final String holder;
  final List datas;
  final Function callBack;
  const SelectResultWidget({Key key, this.title, this.holder, this.datas, this.callBack})
      : super(key: key);

  @override
  _SelectResultWidgetState createState() => _SelectResultWidgetState();
}

class _SelectResultWidgetState extends State<SelectResultWidget> {
  bool isSelect = false;
  String holderText;
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
                callBack: (result){
                  print("===$result===");
                  if(result!=null){

                    setState(() {
                      isSelect = true;
                      holderText = result;

                    });
                    widget.callBack(result);
                  }
                },
              ));
        });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    holderText = widget.holder ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showSelectServiceBottom(
            context,
           widget.datas??[],
            widget.title??""

        );
      },
      child: Container(
        margin: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            border: Border(
          bottom: Divider.createBorderSide(context, width: 0.6),
        )),
        child: Padding(
          padding: const EdgeInsets.only(top: 18, bottom: 18),
          child: Row(
            children: <Widget>[
              Text(
                widget.title + "：",
                style: TextStyles.text,
              ),
              // Gaps.vGap15,
              Padding(
                padding: EdgeInsets.only(left: 6.w),
                child: Text("$holderText",
                    style: TextStyle(fontSize: 13, color: isSelect?Colours.text :Colours.text_gray_c)),
              ),

              Expanded(child: Gaps.empty),

              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Icon(
                  Icons.navigate_next,
                  color: Colors.black38,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SwitchTextWidget extends StatelessWidget {
  String title;
  String holder;

  SwitchTextWidget(this.title, this.holder);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          border: Border(
        bottom: Divider.createBorderSide(context, width: 0.6),
      )),
      child: Padding(
        padding: const EdgeInsets.only(top: 18, bottom: 18),
        child: Row(
          children: <Widget>[
            Text(
              title + "：",
              style: TextStyles.text,
            ),
            // Gaps.vGap15,
            Padding(
              padding: EdgeInsets.only(left: 6.w),
              child: Text("$holder",
                  style: TextStyle(fontSize: 13, color: Colours.text_gray_c)),
            ),

            Expanded(child: Gaps.empty),

            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Icon(
                Icons.navigate_next,
                color: Colors.black38,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SwitchMenuWidget extends StatelessWidget {
  String title;
  String holder;

  SwitchMenuWidget(this.title, this.holder);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
        bottom: Divider.createBorderSide(context, width: 0.6),
      )),
      child: Padding(
        padding: const EdgeInsets.only(top: 18, bottom: 18),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.end,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title + "：",
              style: TextStyles.text,
            ),
            Expanded(child: Gaps.empty),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: CupertinoSwitch(
                value: true,
                activeColor: Colours.app_main,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SwitchDatePage extends StatefulWidget {
  final String title;
  final String content;

  const SwitchDatePage({Key key, this.title, this.content}) : super(key: key);

  @override
  _SwitchDatePageState createState() => _SwitchDatePageState();
}

class _SwitchDatePageState extends State<SwitchDatePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          border: Border(
        bottom: Divider.createBorderSide(context, width: 0.6),
      )),
      child: Padding(
        padding: const EdgeInsets.only(top: 18, bottom: 18),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.end,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.title + "：",
              style: TextStyles.text,
            ),
            Gaps.hGap5,
            Text(
              "${widget.content}",
              style: TextStyles.text,
            ),
            Expanded(child: Gaps.empty),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Icon(
                Icons.navigate_next,
                color: Colors.black38,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SwitchPhoneWidget extends StatefulWidget {
  final String title;

  const SwitchPhoneWidget({Key key, this.title}) : super(key: key);

  @override
  _SwitchPhoneWidgetState createState() => _SwitchPhoneWidgetState();
}

class _SwitchPhoneWidgetState extends State<SwitchPhoneWidget> {
  bool isChoose = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          border: Border(
        bottom: Divider.createBorderSide(context, width: 0.6),
      )),
      child: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.end,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.title + "：",
              style: TextStyles.text,
            ),
            Expanded(child: Gaps.empty),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: CupertinoSwitch(
                onChanged: (value) {
                  setState(() {
                    isChoose = !isChoose;
                  });
                },
                value: isChoose,
                activeColor: Colours.app_main_light,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SwitchTimeWidget extends StatelessWidget {
  String title;
  String holder;

  SwitchTimeWidget(this.title, this.holder);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          border: Border(
        bottom: Divider.createBorderSide(context, width: 0.6),
      )),
      child: Padding(
        padding: const EdgeInsets.only(top: 18, bottom: 18),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.end,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title + "：",
              style: TextStyles.text,
            ),
            Expanded(child: Gaps.empty),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: CupertinoSwitch(
                value: true,
                activeColor: Colours.app_main,
              ),
            )
          ],
        ),
      ),
    );
  }
}
