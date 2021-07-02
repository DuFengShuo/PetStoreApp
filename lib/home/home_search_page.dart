import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_life_app/local_recommend/iview/recommend_cell.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeSearch extends StatefulWidget {
  // Map<String,dynamic>  datas;
  // HomeSearch(this.datas);

  @override
  State<StatefulWidget> createState() => new _HomeSearchState();
}

class _HomeSearchState extends State<HomeSearch> {
  final controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool flag; //判断搜索框内输入的内容是否存在于数据列表里
  List searchResultList = []; //搜索结果存储
  List<String> _keyList = []; //搜索历史存储
  SharedPreferences _sharedPreferences;
  List dataList = [];
  //搜索相关内容
  searchGame(String name) {
    _searchSave(name); //存储搜索内容
    print("搜索"+name);
    searchResultList.clear();
  }

  ///点击搜索的时候把搜索词添加到数据库中存储
  void _searchSave(String key) {
    if (key == null || key.isEmpty) return;
    if (!_keyList.contains(key)) {
      _keyList.add(key);
      setState(() {
        _keyList = _keyList;
      });
      _sharedPreferences.setString("save_search", _keyList.join("##"));
    }
  }

  // 获取存储的历史搜索数据
  void _getKeysStr() {
    SharedPreferences.getInstance().then((sp) {
      _sharedPreferences = sp;
      setState(() {
        String str = _sharedPreferences.getString("save_search");
        print("str:$str");
        if (str != null) {
          setState(() {
            _keyList = str.split("##");
          });
        }
      });
    });
  }

  ///创建搜索历史widget
  getSearchKeyViews() {
    List<Widget> keysView = [];
    _keyList.forEach((value) {
      keysView.add(
        GestureDetector(
          onTap: () {
            controller.text = value;
            // searchGame(value);
          },
          child: ChoiceChip(
              selected: false,
              backgroundColor: Colors.grey[100],
              label: Text(
                "${value}",
                style: TextStyles.textSize12,
              )),
        ),
      );
    });
    return keysView;
  }

  @override
  void initState() {
    super.initState();
    // print(widget.datas);
    _getKeysStr(); //获取搜索历史记录

  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colours.app_main,
        titleSpacing: 0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              searchGame(controller.text); //搜索
              focusNode.unfocus();
            }, //取消焦点
            child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Text(
                    "搜索",
                    style: TextStyles.textBold14.copyWith(color: Colours.material_bg),
                  ),
                )),
          ),
        ],
        centerTitle: true,
        title: Container(
          margin: EdgeInsets.only(right: 15),
          height: 42.0,
          //width: ScreenUtil.getScreenW(context),
          child: new Padding(
              padding:
              const EdgeInsets.only(bottom: 2, top: 5, left: 0, right: 0),
              child: new Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 5.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, top: 2),
                      child: Icon(
                        Icons.search,
                        color: Colors.grey,
                        size: 15,
                      ),
                    ),
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.only(left: 1),
                          child: CupertinoTextField(
                            focusNode: focusNode,
                            controller: controller,
                            // onChanged: (v) => inputContent(0, v),
                            style:
                            TextStyle(fontSize: 12, color: Colors.black87),
                            placeholder: "请输入搜索内容",
                            textAlign: TextAlign.left,
                            placeholderStyle:
                            TextStyle(fontSize: 12, color: Colors.grey),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(
                                  color: Colors.white,
                                  style: BorderStyle.solid,
                                  width: 0,
                                )),
                          )),
                    ),
                    new IconButton(
                      icon: new Icon(Icons.cancel),
                      color: Colors.grey,
                      iconSize: 16.0,
                      onPressed: () {
                        controller.clear();
                        setState(() {
                          searchResultList.clear();
                        });
                        // onSearchTextChanged('');
                        _getKeysStr(); //获取历史记录
                      },
                    ),
                  ],
                ),
              )),
        ),
      ),
      body: searchResultList.length == 0
          ? _keyList.length == 0
          ? Gaps.empty
          : Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 15,
                left: 10,
              ),
              child: Text(
                "搜索历史",
                style: TextStyles.textBold14,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 5, bottom: 10),
              child: Wrap(
                spacing: 10, //主轴上子控件的间距
                runSpacing: 10, //交叉轴上子控件之间的间距
                children: getSearchKeyViews(), //要显示的子控件集合
              ),
            ),
          ],
        ),
      )
          : ListView.builder(
          itemCount: searchResultList.length,
          itemBuilder: (BuildContext context, int index) {
            // return ListTile( title:  Text("dd"),);
            Map data = searchResultList[index];
            String mType = data["m_type"];
           return RecommendCellWidget();
          }),
    );
  }
}
