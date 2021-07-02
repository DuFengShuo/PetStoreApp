import 'dart:io';
import 'package:flutter/material.dart';
import 'package:local_life_app/util/toast_utils.dart';
import 'package:path_provider/path_provider.dart';

class CleanAppData {

  var _tempDir;
  final cleanOver;

  CleanAppData({this.cleanOver});
  //加载缓存

  Future<String> loadCache() async {
    String _cacheSize;

    try {
      _tempDir = await getTemporaryDirectory();

      double value = await _getTotalSizeOfFilesInDir(_tempDir);

      /*tempDir.list(followLinks: false,recursive: true).listen((file){

          //打印每个缓存文件的路径

        print(file.path);

      });*/

      _cacheSize = _renderSize(value);
      print('临时目录大小: ' + value.toString());
//      setState(() {
//
//      });
      return _cacheSize ?? "暂无缓存";
    } catch (err) {
      print(err);
    }
  }

  /// 递归方式 计算文件的大小

  Future<double> _getTotalSizeOfFilesInDir(final FileSystemEntity file) async {
    try {
      if (file is File) {
        int length = await file.length();

        return double.parse(length.toString());
      }

      if (file is Directory) {
        final List<FileSystemEntity> children = file.listSync();

        double total = 0;

        if (children != null)
          for (final FileSystemEntity child in children)
            total += await _getTotalSizeOfFilesInDir(child);

        return total;
      }


      return 0;
    } catch (e) {
      print(e);

      return 0;
    }
  }

  ///递归方式删除目录
  Future<Null> delDir(FileSystemEntity file) async {
    try {
      if (file is Directory) {
        final List<FileSystemEntity> children = file.listSync();

        for (final FileSystemEntity child in children) {
          await delDir(child);
        }
      }
      await file.delete();
    } catch (e) {
      print(e);
    }
  }

  ///格式化文件大小

  _renderSize(double value) {
    if (null == value) {
      return 0;
    }

    List<String> unitArr = List()..add('MB')..add('KM')..add('M')..add('G');

    int index = 0;

    while (value > 1024) {
      index++;

      value = value / 1024;
    }

    String size = value.toStringAsFixed(2);

    return size + unitArr[index];
  }

  Future clearCache() async {
    //此处展示加载loading

    try {
      _tempDir = await getTemporaryDirectory();

      double value = await _getTotalSizeOfFilesInDir(_tempDir);

      print("$value");

      if (value <= 0) {
        Toast.show('暂无缓存');
        // ToastUtil.showText(context, msg: '暂无缓存');

      } else if (value >= 0) {
        Toast.show('清理中...');
        //  var hide = ToastUtil.showLoadingText_iOS(context, msg: "正在清理中...");
        Future.delayed(Duration(seconds: 2), () async {
          //删除缓存目录
          await delDir(_tempDir);
          await loadCache();
          // ToastUtil.showSuccess(context, msg: '清理完成');
          cleanOver("0.00MB");
          Toast.show('清理完成');

        });
      }
    } catch (e) {
      print(e);
      Toast.show('清理失败');
    } finally {}
  }
}

class CleanData extends StatefulWidget {
  @override
  _CleanDataState createState() => _CleanDataState();
}

class _CleanDataState extends State<CleanData> {
  String _cacheSize;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CleanAppData().loadCache().then((value) => setState(() {
          _cacheSize = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("清理缓存"),
      ),
      body: Center(
        child: FlatButton(
          onPressed: () {
            CleanAppData().clearCache().then((value) => setState(() {
                  _cacheSize = "0.00MB";
                }));
          },
          child: Text("${_cacheSize ?? "暂无缓存"}"),
        ),
      ),
    );
  }
}
