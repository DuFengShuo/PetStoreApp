//import 'package:amap_location/amap_location.dart';
//import 'package:easy_alert/easy_alert.dart';
//import 'package:easy_alert/easy_alert.dart';
import 'package:flutter/material.dart';
import 'package:local_life_app/res/resources.dart';

//import 'package:simple_permissions/simple_permissions.dart';
//import 'package:simple_permissions/simple_permissions.dart';
//import 'package:simple_permissions/simple_permissions.dart';

class SwitchCityPage extends StatefulWidget {
  @override
  _SwitchCityPageState createState() => _SwitchCityPageState();
}

class _SwitchCityPageState extends State<SwitchCityPage> {
  List historyCity = [
    "邓州",
    "南阳",
    "新野",
    "镇平",
    "内乡",
    "淅川",
  ];
  List canUseCity = [
    "唐河",
    "南阳",
    "新野",
    "镇平",
    "内乡",
    "淅川",
  ];
  int _selectHIndex = 0;
  int _selectDIndex = 0;
//  AMapLocation _loc;
//
//  void _checkPersmission() async {
//    bool hasPermission =
//        await SimplePermissions.checkPermission(Permission.WhenInUseLocation);
//    if (!hasPermission) {
//      PermissionStatus requestPermissionResult =
//          await SimplePermissions.requestPermission(
//              Permission.WhenInUseLocation);
//      if (requestPermissionResult != PermissionStatus.authorized) {
//        Alert.alert(context, title: "申请定位权限失败");
//        return;
//      }
//    }
//    AMapLocation loc = await AMapLocationClient.getLocation(true);
//    setState(() {
//      _loc = loc;
//    });
//  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_checkPersmission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colours.app_main,
        elevation: 0.5,
        title: Text(
          "选择城市",
          style: TextStyles.textBold16.copyWith(color: Colours.material_bg),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  "当前/定位城市:",
                  style: TextStyles.textBold14,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child:
                  new Text(
                    "正在定位",
                    style: TextStyles.text,
                  )
//                  _loc == null
//                      ? new Text(
//                          "正在定位",
//                          style: TextStyles.textSize14,
//                        )
//                      : new Text(
//                          "定位成功:${_loc.formattedAddress}",
//                          style: TextStyles.textSize14,
//                        ),
               ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "历史访问",
                style: TextStyles.textBold14,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Wrap(
                    spacing: 15,
                    children: List.generate(historyCity.length, (index) {
                      return ChoiceChip(
                        backgroundColor: Colors.grey[200],
                        selectedColor: Colours.dark_unselected_item_color,
                        label: Text(
                          '${historyCity[index]}',
                          style: TextStyles.textSize12,
                        ),
                        selected: _selectHIndex == index,
                        onSelected: (v) {
                          setState(() {
                            _selectHIndex = index;
                          });
                        },
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
            Text(
              "当前开通服务城市",
              style: TextStyles.textBold14,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Wrap(
                    spacing: 15,
                    children: List.generate(canUseCity.length, (index) {
                      return SizedBox(
                        child: ChoiceChip(
                          backgroundColor: Colors.grey[200],
                          selectedColor: Colours.dark_unselected_item_color,
                          label: Text(
                            '${canUseCity[index]}',
                            style: TextStyles.textSize12,
                          ),
                          selected: _selectDIndex == index,
                          onSelected: (v) {
                            setState(() {
                              _selectDIndex = index;
                            });
                          },
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//String getLocationStr(AMapLocation loc) {
//  if (loc == null) {
//    return "正在定位";
//  }
//
//  if (loc.isSuccess()) {
//    if (loc.hasAddress()) {
//      return "定位成功: \n时间${loc.timestamp}\n经纬度:${loc.latitude} ${loc.longitude}\n 地址:${loc.formattedAddress} 城市:${loc.city} 省:${loc.province}";
//    } else {
//      return "定位成功: \n时间${loc.timestamp}\n经纬度:${loc.latitude} ${loc.longitude}\n ";
//    }
//  } else {
//    return "定位失败: \n错误:{code=${loc.code},description=${loc.description}";
//  }
//}
