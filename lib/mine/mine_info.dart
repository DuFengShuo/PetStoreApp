import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:convert' as convert;

import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/util/toast_utils.dart';

class MineInfo extends StatefulWidget {
  String phone;

  MineInfo(this.phone);

  @override
  _MineInfoState createState() => _MineInfoState();
}

class _MineInfoState extends State<MineInfo> {
  String _sex = "请选择性别";
  var _imgPath; //头像图片地址 上传可以用到
  String logoUrl;
  String nameText; //姓名
  String ageText = "请选择年龄"; //年龄
  String tigeText; //签名
  List alogList; //弹框提示
  bool isShowLoading = true;
  // 修改contentText参数
  _nameData(editText) {
    setState(() {
      nameText = editText;
      print("姓名参数" + nameText);
    });
  }

  _ageData(editText) {
    setState(() {
      ageText = editText;
      print("年龄参数" + ageText);
    });
  }

  _tigeData(editText) {
    setState(() {
      tigeText = editText;
      print("签名参数" + tigeText);
    });
  }

  /*拍照*/
  _takePhoto() async {
    var image = await ImagePicker.platform.pickImage(source:ImageSource.camera );
    setState(() {
      _imgPath = image;
    });
    Navigator.pop(context);
  }

  /*相册*/
  _openGallery() async {
    var image = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    setState(() {
      _imgPath = image;
    });
    Navigator.pop(context);
  }

  showBottom(BuildContext context, List data) {
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
            padding: EdgeInsets.only(top: 20),
            height: 180.0,
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Center(
                      child: Container(
                        //    padding: EdgeInsets.only(top: 10),
                        width: MediaQuery.of(context).size.width - 40,
                        height: 40,
                        child: FlatButton.icon(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          color: Colours.app_main,
                          highlightColor: Colors.orangeAccent,
                          colorBrightness: Brightness.dark,
                          splashColor: Colors.grey,
                          icon: index == 0
                              ? Icon(
                                  Icons.person,
                                  color: Colors.black,
                                )
                              : Icon(
                                  Icons.person_outline,
                                  color: Colors.black,
                                ),
                          label: Text(
                            "${data[index]}",
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                          onPressed: () {
                            setState(() {
                              _sex = data[index];
                              Navigator.pop(context);
                            });
                          },
                        ),
                      ),
                    ),
                  );
                }),
          );
        });
  }

  showBottomDialog(BuildContext context, List data) {
    showModalBottomSheet(

        ///底部弹框
        context: context,
        builder: (BuildContext context) {
          return new Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: 100,
                height: 50,
                margin: EdgeInsets.only(top: 10),
                child: FlatButton.icon(
                  icon: Icon(Icons.photo_camera),
                  label: Text(
                    "拍照",
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () => _takePhoto(),
                ),
              ),
              Divider(
                color: Colors.black12,
              ),
              Container(
                alignment: Alignment.center,
                width: 100,
                height: 55,
                child: FlatButton.icon(
                  icon: Icon(Icons.photo_library),
                  label: Text(
                    "相册",
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () => _openGallery(),
                ),
              ),
            ],
          );
        });
  }

  Future<void> showListDialog() async {
    if (_imgPath == null) {
      Toast.show( "请选择图片！");
    }
    if (nameText == null) {
      Toast.show("请输入姓名！");
    } else if (ageText == null) {
      Toast.show( "请输入年龄！");
    } else if (tigeText == null) {
      Toast.show("请输入签名！");
    } else if (_sex == null) {
      Toast.show("请选择性别！");
    } else {
      registerMyUserInfo(
        nameText,
        _sex,
        tigeText,
        _imgPath.path,
      );
    }
  }

  registerMyUserInfo(
    String name,
    String sex,
    String js,
    String imgPath,
  ) async {
    // FormData formData = FormData.fromMap({
    //   "file1": await MultipartFile.fromFile(imgPath, filename: "logo"),
    //   "userName": name,
    //   "sex": sex,
    //   "js": js,
    // });
    //
    // Dio dio = new Dio();
    // var respone = await dio.post<String>(
    //   "${Dimens.base_url}/my_user/registerUserInfo/",
    //   data: formData,
    // );
    // Map jsonStr = convert.jsonDecode(respone.data);
    // print(jsonStr.toString());
    // if (jsonStr["statusCode"] == 200) {
    //   Navigator.pop(context);
    // } else {}
  }

  getUsrInfo() {
    // MineRequestDao.getMyUserInfo(widget.phone, (data) async {
    //   print(data);
    //   Map jsonStr = convert.jsonDecode(data);
    //   await Future.delayed(Duration(seconds: 1), () {
    //     setState(() {
    //       isShowLoading = false; //隐藏加载
    //       print(jsonStr["user_name"]);
    //       logoUrl = Dimens.base_url+jsonStr["photoUrl"].toString();
    //       nameText = jsonStr["user_name"];
    //       tigeText = jsonStr["user_qm"];
    //       _sex = jsonStr["userSex"];
    //     });
    //   });
    //
    // });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsrInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
          actions: <Widget>[
            //导航栏右侧菜单
            IconButton(
                icon: Icon(Icons.save,color: Colours.material_bg,), onPressed: () => showListDialog())
          ],
          backgroundColor: Colours.app_main,
          title: Text(
            '个人中心',
            style: TextStyles.textBold16.copyWith(color: Colours.material_bg),
          ),
          centerTitle: true,
          elevation: 1 ,//阴影
        brightness: Brightness.dark,
          ),
      //preferredSize: Size.fromHeight(80)
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            //动态创建一个List<Widget>
            children: <Widget>[
              InkWell(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                splashColor: Theme.of(context).primaryColor,
                //按下去的颜色
                child: SwitchPhotoCell("头像", _imgPath,logoUrl),
                onTap: () => showBottomDialog(context, ["拍照", "相册"]),
              ),
              new InputItem(
                "姓名",
                " ${nameText != null ? nameText : "请输入姓名"}",
                nameData: (editText) => _nameData(editText),
              ),
//              InfoItem("性别"),
              InkWell(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                splashColor: Theme.of(context).primaryColor,
                //按下去的颜色
                child: SwitchCell("性别", "${_sex != null ? _sex : "请选择性别"}"),
                onTap: () => showBottom(context, ["男", "女"]),
              ),
              InputItem(
                "签名",
                "${tigeText != null ? tigeText : "请输入签名"}",
                tigData: (editText) => _tigeData(editText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SwitchPhotoCell extends StatelessWidget {
  String title;
  var imgPath;
  String imgUrl;
  SwitchPhotoCell(this.title, this.imgPath,this.imgUrl);

  /*图片控件*/
  Widget _ImageView(imgPath) {
    if (imgPath == null) {
      return Container(
        // width: 50,
        // color: Colors.red,
        alignment: Alignment.centerRight,
        margin: EdgeInsets.only(right: 0),
        child: new CircleAvatar(
          radius: 20.0,
          backgroundColor: Colours.app_main_light,
          backgroundImage: imgUrl==null? AssetImage("images/niao.png"):NetworkImage(imgUrl),
        ),
      );
    } else {
      return Container(
        alignment: Alignment.centerRight,
        margin: EdgeInsets.only(right: 0),
        child: new CircleAvatar(
          radius: 20.0,
          backgroundImage: FileImage(imgPath),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      constraints: BoxConstraints.tightFor(height: 70.0),
      //卡片大小
      decoration: BoxDecoration(

          ///背景装饰 ,特别注意设置阴影的时候，container不能设置颜色
          borderRadius: new BorderRadius.all(Radius.elliptical(3, 3)),
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

      margin: EdgeInsets.all(5),
      // color: Colors.red,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              // width: 50,
              // color: Colors.red,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(right: 10),
              child: Container(
                padding: EdgeInsets.only(left: 10),
                width: 60,
                child: Text(title),
              ),
            ),
            flex: 8,
          ),
          Expanded(
            child: _ImageView(imgPath),
            flex: 2,
          ),
          Expanded(
            child: Container(
              // width: 50,
              //  color: Colors.red,
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.navigate_next,
                color: Colors.black38,
              ),
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }
}

class SwitchCell extends StatelessWidget {
  String title;
  String hoder;

  SwitchCell(
    String title,
    this.hoder,
  ) {
    this.title = title;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      constraints: BoxConstraints.tightFor(height: 70.0),
      //卡片大小
      decoration: BoxDecoration(

          ///背景装饰 ,特别注意设置阴影的时候，container不能设置颜色
          borderRadius: new BorderRadius.all(Radius.elliptical(3, 3)),
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

      margin: EdgeInsets.all(5),
      // color: Colors.red,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              // width: 50,
              // color: Colors.red,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(right: 10),
              child: Container(
                padding: EdgeInsets.only(left: 10),
                width: 60,
                child: Text(title),
              ),
            ),
            flex: 6,
          ),
          Expanded(
            child: Container(
              // width: 50,;'
              // color: Colors.red,
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: 7),
              child: Text(
                "${hoder}",
                style: TextStyles.text,
              ),
            ),
            flex: 3,
          ),
          Expanded(
            child: Container(
              // width: 50,
              //  color: Colors.red,
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.navigate_next,
                color: Colors.black38,
              ),
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }
}

class InputItem extends StatelessWidget {
  String title;
  String hoder;
  final nameData; //父控件获取值方法
  final ageData;
  final tigData;

  InputItem(this.title, this.hoder,
      {Key key, this.nameData, this.ageData, this.tigData})
      : super(key: key); //添加key可以让其控件与父级对应，setstate的时候不用重新创建

  void inputContent(int index, String context) {
    if (title == "姓名") {
      nameData(context); //赋值
    }
    if (title == "年龄") {
      ageData(context);
    }
    if (title == "签名") {
      tigData(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      constraints: BoxConstraints.tightFor(height: 70.0),
      //卡片大小
      decoration: BoxDecoration(

          ///背景装饰 ,特别注意设置阴影的时候，container不能设置颜色
          borderRadius: new BorderRadius.all(Radius.elliptical(3, 3)),
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
      margin: EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              // width: 50,
              // color: Colors.red,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(right: 10),
              child: Container(
                width: 60,
                padding: EdgeInsets.only(left: 10),
                child: Text(title),
              ),
            ),
            flex: 2,
          ),
          Expanded(
            child: Container(
              // width: 50,
              // color: Colors.red,
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: 0),
              child: CupertinoTextField(
                onChanged: (v) => inputContent(0, v),
                style: TextStyles.text,
                placeholder: "${hoder}",
                textAlign: TextAlign.right,
                placeholderStyle: TextStyle(
                  fontSize: 14,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: Colors.white,
                      style: BorderStyle.solid,
                      width: 0,
                    )),
              ),
            ),
            flex: 7,
          ),
          Expanded(
            child: Container(
              // width: 50,
              //  color: Colors.red,
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.navigate_next,
                color: Colors.black38,
              ),
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }
}
