import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:local_life_app/common/common.dart';
import 'package:local_life_app/mine/clean_data.dart';
import 'package:local_life_app/mine/update_page.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/routers/fluro_navigator.dart';
import 'package:local_life_app/util/global_eventbus.dart';
import 'package:local_life_app/widgets/click_item.dart';
import 'package:local_life_app/widgets/grade_button.dart';


/// design/8设置/index.html
class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String _cacheSize;

//  void openApp() async {
//    const url = 'flutter://hyrz:8088/main?activityId=100&&userId==330';
//    if (await canLaunch(url)) {
//      await launch(url);
//    } else {
//      const url = 'flutter://hyrz:8088/main?activityId=100&&userId==300';
//      if (await canLaunch(url)) {
//        await launch(url);
//      } else {
//        throw 'Could not launch $url';
//      }
//    }
//  }
  void _showUpdateDialog(String dl, String detail) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => UpdateDialog(dl, detail));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CleanAppData().loadCache().then((value) => setState(() {
          _cacheSize = value;
        }));
  }

  String isCleanOver;

  @override
  Widget build(BuildContext context) {
    // 修改contentText参数
    _isCleanOVer(editText) {
      setState(() {
        isCleanOver = editText;
      });
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colours.material_bg,
        title: Text(
          "设置",
          style: TextStyles.textBold16,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
//          ClickItem(
//            title: '账号管理',
//           // onTap: () => NavigatorUtils.push(context, SettingRouter.accountManagerPage)
//          ),
          ClickItem(
              title: '清除缓存',
              content: isCleanOver ?? '${_cacheSize}',
              onTap: () {
                CleanAppData(cleanOver: (cleanOver) => _isCleanOVer(cleanOver))
                    .clearCache();
              }),
          ClickItem(title: '检查更新', onTap: () => _showUpdateDialog("http://hcm2q.gyxza3.yjruhu.com/a31/rj_cf1/juyc.apk","版本内容")),
//          ClickItem(
//              title: '关于我们',
//              onTap: () {
//                Navigator.push(context, MaterialPageRoute(builder: (context){return AboutUsPage();}));
//              }
//          ),

          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Center(
              child: Container(
                //    padding: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width - 20,
                height: 40,
                child: GradeButtonWidget(
                  text: "退出登录",
                  onTap: () async {
                   await SpUtil.remove(Constant.phone);
                   GlobalEventBus().event.fire('logout');
                   NavigatorUtils.goBack(context);
                  },
                )
              ),
            ),
          )
//          ClickItem(
//            title: '退出当前账号',
//            onTap: () => _showExitDialog(),
//          ),
        ],
      ),
    );
  }

  // void _showExitDialog() {
  //   showDialog(context: context, builder: (_) => ExitDialog());
  // }

  // void _showUpdateDialog() {
  //   showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (_) => UpdateDialog());
  // }
}
