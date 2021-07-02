import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionContent extends StatelessWidget {
  //动态申请权限
  Future getPermission() async {
    if (await Permission.phone.request().isGranted == false) {
      await Permission.phone.request();
    }

    if (await Permission.storage.request().isGranted == false) {
      await Permission.storage.request();
    }
    SpUtil.putString("hasPermission", "true"); //是否查看过权限
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          height: 320,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Stack(
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 25.0),
                      child: Text('APP需要获取以下权限', style: TextStyles.textBold16),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 29, left: 35),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.message,
                            color: Colours.app_main,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 27),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${"设备信息权限"}',
                                    style: TextStyle(
                                        color: Colours.text,
                                        fontSize: 15,
                                        fontFamily: 'jty'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      '${"基础权限，仅限于统计"}',
                                      style: TextStyle(
                                          color: Colours.text_gray,
                                          fontSize: 12,
                                          fontFamily: 'jty'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15, left: 35, right: 35),
                      child: Gaps.line,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 35, top: 15),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.photo_library_rounded,
                            color: Colours.app_main,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 27),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${"照片相机访问权限"}',
                                    style: TextStyle(
                                        color: Colours.text,
                                        fontSize: 15,
                                        fontFamily: 'jty'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      '${"用于获取相册图片，拍摄照片"}',
                                      style: TextStyle(
                                          color: Colours.text_gray,
                                          fontSize: 12,
                                          fontFamily: 'jty'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                  bottom: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 40,
                      height: 40,
                      child: FlatButton(
                        color: Colours.app_main,
                        highlightColor: Colours.dark_app_main,
                        colorBrightness: Brightness.dark,
                        splashColor: Colors.grey,
                        child: Text(
                          "一键获取",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        onPressed: () {
                          getPermission();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ))
            ],
          )),
    );
  }
}
