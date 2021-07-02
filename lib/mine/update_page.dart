import 'dart:io';
import 'dart:math';
import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/util/image_utils.dart';
import 'package:local_life_app/util/version_utils.dart';
import 'package:local_life_app/widgets/grade_button.dart';
import 'package:local_life_app/widgets/linear_progress_button.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
class UpdateDialog extends StatefulWidget {
  String downloadUrl;
  String versionDetail;

  UpdateDialog(this.downloadUrl, this.versionDetail);

  @override
  _UpdateDialogState createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  CancelToken _cancelToken = CancelToken();
  bool _isDownload = false;
  double _value = 0;
  File _saveFile;
  int _valueInt = 0;
  static final Random random = Random();

  @override
  void dispose() {
    if (!_cancelToken.isCancelled && _value != 1) {
      _cancelToken.cancel();
    }
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // String dirloc = "/sdcard/download/";
   //  File file = File(dirloc);

  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return WillPopScope(
      onWillPop: () async {
        /// 使用false禁止返回键返回，达到强制升级目的
        return false;
      },
      child: Scaffold(
          // resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Center(
              // heightFactor: 10,
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 319.h,
                  margin: EdgeInsets.only(left: 53.5.w, right: 53.5.w),
                  decoration: BoxDecoration(
                    color: Colours.material_bg,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  // width: ,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                          height: 139.0.h,
                          // width: 280.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colours.app_main,
                            borderRadius: BorderRadius.only( topLeft: Radius.circular(12),topRight: Radius.circular(12)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20.w, right: 20.w, top: 21.0.h),
                                child: Text('New version found',
                                    style: TextStyles.textBold16
                                        .copyWith(color: Colours.material_bg)),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20.w, right: 20.w, top: 10.h),
                                child: Text('V1.1.0',
                                    style: TextStyles.text
                                        .copyWith(color: Colours.material_bg)),
                              ),
                            ],
                          )),
                      Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(left: 24.w),
                            child: ListView.builder(
                                padding: EdgeInsets.only(top: 1),
                                shrinkWrap: true,
                                itemCount: 5,
                                itemExtent: 30.h,
                                itemBuilder: (BuildContext context, int index) {
                                  return Text(
                                    widget.versionDetail,
                                    style: TextStyles.text,
                                  );
                                })),
                      ),
                      Gaps.vGap15,
                      Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: _isDownload
                              ? Column(
                                  children: <Widget>[
                                    _value.toInt() != 1
                                        ? LinearProgressButton(
                                      progress: _value,
                                      valueInt: _valueInt,
                                    )
                                        : Container(),
                                    _value.toInt() != 1
                                        ? Container()
                                        : //如果下载完成则显示安装按钮
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: GradeButtonWidget(
                                              text: "Open",
                                              onTap: () => openApk(_saveFile),
                                            ),
                                          )
                                  ],
                                )
                              : GradeButtonWidget(
                                  text: "Update",
                                  onTap: () {
                                    if (defaultTargetPlatform ==
                                        TargetPlatform.iOS) {
                                      //NavigatorUtils.goBack(context);
                                      VersionUtils.jumpAppStore();
                                    } else {
                                      setState(() {
                                        _isDownload = true;
                                      });
                                      _download();
                                    }
                                  },
                                ))
                    ],
                  )),
              Gaps.vGap15,
              IconButton(
                  icon:
                      Icon(Icons.cancel_outlined,color: Colours.material_bg,),

                  // Image(
                  //   image: ImageUtils.getAssetImage("dialog_cancel"),
                  //   width: 28.w,
                  //   height: 28.w,
                  //   fit: BoxFit.fill,
                  // ),
                  onPressed: ()=>Navigator.pop(context))
            ],
          ))),
    );
  }

  void openApk(File file) {
    //  print("安装名称" + info.link);
    //print(_localPath+info.filename);



      OpenFile.open(file.path,
          type: "application/vnd.android.package-archive",
          uti: "public.plain-text").whenComplete(() {
            //检查一下版本，如果版本是最新就取消弹框，如果不是就继续弹框
       // NavigatorUtils.goBack(context);

       //  //安装完删除安装目录
       //  File file = _saveFile;
       //  file.delete();

      });


  }



  // //动态申请权限
  // Future getPermission() async {
  //   if (await Permission.phone.request().isGranted == false) {
  //     await Permission.phone.request();
  //   }
  //
  //   if (await Permission.reminders.request().isGranted == false) {
  //     await Permission.reminders.request();
  //   }
  //
  // }

  ///下载apk
  _download() async {
   // await getPermission();//获取权限
    String dirloc = "";
    if (Platform.isAndroid) {
      dirloc = "/sdcard/download/";
    } else {
      dirloc = (await getApplicationDocumentsDirectory()).path;
    }

    var randid = random.nextInt(10000);
    FileUtils.mkdir([dirloc]);
    try {
      // await DirectoryUtil.getInstance();
      // DirectoryUtil.createStorageDirSync(category: 'apk');
      // String path = DirectoryUtil.getStoragePath(
      //     fileName: 'deer', category: 'apk', format: 'apk');
      // File file = File(path);

      /// 链接可能会失效
      await Dio().download(
        '${widget.downloadUrl}',
        dirloc + randid.toString() + ".apk",
        // cancelToken: _cancelToken,
        onReceiveProgress: (int count, int total) {
          if (total != -1) {
            _value = count / total;
            int resultsInt = NumUtil.getNumByValueDouble(_value * 100, 0);
            _valueInt = resultsInt;
            setState(() {});
            if (count == total) {
              // NavigatorUtils.goBack(context);
              File file = File(dirloc + randid.toString() + ".apk");
              // file.delete();
              openApk(file);
              _saveFile = file;
            }
          }
        },
      );
    } catch (e) {
      //   Toast.show('下载失败!');
      print(e);
      setState(() {
        _isDownload = false;
      });
    }
  }
}
