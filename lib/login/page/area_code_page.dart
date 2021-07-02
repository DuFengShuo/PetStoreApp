import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_life_app/login/models/area_code_model.dart';
import 'package:local_life_app/routers/fluro_navigator.dart';
import 'package:local_life_app/widgets/my_app_bar.dart';

/// design/6店铺-账户/index.html#artboard34
class AreaCodePage extends StatefulWidget {
  const AreaCodePage({Key key}) : super(key: key);

  @override
  _AreaCodePageState createState() => _AreaCodePageState();
}

class _AreaCodePageState extends State<AreaCodePage> {
  List<AreaCodeModel> _cityList = <AreaCodeModel>[];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    String jsonStr = await _loadString('assets/data/code.json');
    final List<dynamic> list = json.decode(jsonStr) as List<dynamic>;
    List<AreaCodeModel> _cList = <AreaCodeModel>[];
    list.forEach((dynamic value) {
      _cList.add(AreaCodeModel.fromJson(value as Map<String, dynamic>));
    });
    setState(() {
      _cityList = _cList;
    });
  }

  /// rootBundle.loadString源码修改
  Future<String> _loadString(String key) async {
    final ByteData data = await rootBundle.load(key);
    if (data == null) {
      throw FlutterError('Unable to load asset: $key');
    }
    return utf8.decode(data.buffer.asUint8List());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        centerTitle: 'The area code',
      ),
      body: SafeArea(
        child: ListView.separated(
          itemCount: _cityList.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (_, int index) {
            AreaCodeModel model = _cityList[index];
            print(model);
            return InkWell(
              onTap: () {
                NavigatorUtils.goBackWithParams(context, model);
              },
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                height: 40.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(model.nameEn),
                    Text(model.code.toString()),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
