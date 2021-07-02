import 'package:flutter/material.dart';
import 'package:local_life_app/home/city_page.dart';
import 'package:local_life_app/home/home_router.dart';
import 'package:local_life_app/local_discount/page/discount_pages.dart';
import 'package:local_life_app/local_find/page/localfind_pages.dart';
import 'package:local_life_app/local_house/page/localhouse_pages.dart';
import 'package:local_life_app/local_oldgoods/page/oldgoods_pages.dart';
import 'package:local_life_app/local_use_car/page/usecar_pages.dart';
import 'package:local_life_app/local_work/page/local_work_pages.dart';
import 'package:local_life_app/main_message/drage_switch_page.dart';
import 'package:local_life_app/res/colors.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/routers/fluro_navigator.dart';
import 'package:local_life_app/util/toast_utils.dart';
import 'package:local_life_app/widgets/my_search_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_life_app/local_recommend/page/recommend_pages.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:local_life_app/local_message/page/local_message_pages.dart';

class MainMessagePage extends StatefulWidget {
  @override
  _MainMessagePageState createState() => _MainMessagePageState();
}

class _MainMessagePageState extends State<MainMessagePage>
    with SingleTickerProviderStateMixin {
  List tabs = [
    "推荐",
    "优惠活动",
    "拼车用车",
    "二手交易",
    "本地房产",
    "招聘招工",
    "寻人寻物",
    "相亲交友",
    "果蔬到家",
    "上门回收",
    "本地事",
    "闪电服务",
    // "闪电寻味",
    // "本地市场",
  ];

  List<Map> titles = [];
  List<String> tabTitle = [];

  TabController _tabController;
  PopupMenu menu;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    titles = [
      {
        "title": "推荐",
        "img": "use_icon/13",
      },
      {
        "title": "优惠活动",
        "img": "use_icon/1",
      },
      {"title": "拼车用车", "img": "use_icon/8"},
      {"title": "二手交易", "img": "use_icon/7"},
      {"title": "本地房产", "img": "use_icon/5"},
      {"title": "招聘招工", "img": "use_icon/6"},
      {"title": "寻人寻物", "img": "use_icon/2"},
      {"title": "相亲交友", "img": "use_icon/3"},
      {"title": "果蔬到家", "img": "use_icon/2"},
      {"title": "上门回收", "img": "use_icon/9"},
      {
        "title": "本地事",
        "img": "use_icon/11",
      },
      {"title": "闪电服务", "img": "use_icon/3"},
      // {"title": "本地市场", "img": "use_icon/2"},
      // {"title": "闪电寻味", "img": "use_icon/14"},
    ];
    for (Map title in titles) {
      tabTitle.add(title["title"]);
    }
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  void onClickMenu(MenuItemProvider item) {
    print('Click menu -> ${item.menuTitle}');
  }

  void onDismiss() {
    print('Menu is dismiss');
  }

  GlobalKey btnKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colours.bg_color,
        appBar: AppBar(
          brightness: Brightness.dark,
          backgroundColor: Colours.app_main,
          elevation: 0.4,
          titleSpacing: 5,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [
                  Colours.app_main_light_text,
                  // Colours.app_main_light_text,
                  Colours.app_main,
                  // Colours.dark_app_main,
                ]),
                // borderRadius: BorderRadius.circular(ScreenUtil().setHeight(44.0)),
              ),
            ),

          leading: ButtonBar(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) {
                    return SwitchCityPage();
                  }));
                },
                child: Text(
                  "上海",
                  style: TextStyles.textBold14
                      .copyWith(color: Colours.material_bg),
                ),
              ),
            ],
          ),
          title: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 10.w),
            child: MySearchWidget(
              callBack: () {
                NavigatorUtils.push(context, HomeRouter.search);
              },
            ),
            decoration: BoxDecoration(
              //背景装饰
              gradient: RadialGradient(
                  //背景径向渐变
                  colors: [Colors.white, Colors.white],
                  center: Alignment.topLeft,
                  radius: .80),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            width: MediaQuery.of(context).size.width - 20,
            height: 30,
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: Material(
              color: Colors.white,
              child: Container(
                padding: EdgeInsets.only(right: 5),
                height: 40,
                child: Stack(
                  alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      padding: EdgeInsets.only(right: 15),
                      height: 40,
                      child: TabBar(
                          isScrollable: true,
                          labelPadding:
                              EdgeInsets.only(top: 1, left: 10, right: 10),
                          indicatorSize: TabBarIndicatorSize.label,
                          labelStyle: TextStyles.textBold13,
                          labelColor: Colours.app_main,
                          indicatorColor: Colours.app_main,
                          unselectedLabelColor: Colors.black87,
                          indicatorWeight: 2,
                          unselectedLabelStyle: TextStyles.textSize13,
                          controller: _tabController,
                          automaticIndicatorColorAdjustment:false,
                          indicatorPadding: EdgeInsets.only(left: 8.w, right: 8.w),
                          onTap: (value){
                            print("点了$value");
                          },
                          tabs: tabTitle.map((e) => Tab(text: e)).toList()
                          // tabs: data ==null ? tabs.map((e) => Tab(text: e)).toList():data.map((e) => Tab(text: e["title"])).toList()
                          ),
                    ),
                    Positioned(
                      right: 0,
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colours.material_bg,
                            // boxShadow: [ //卡片阴影
                            //   BoxShadow(
                            //       color: Colors.red,
                            //       offset: Offset(0.0, 0.0),
                            //       blurRadius: 1.0
                            //   )
                            // ]
                        ),
                        child: new GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return DrageSwitchPage(titles);
                            })).then((value) {
                              if (value != null) {
                                Map datas = value as Map;
                                if (datas["titleList"] != null) {
                                  setState(() {
                                    titles = datas["titleList"];
                                    List<String> newTab = [];
                                    for (Map title in titles) {
                                      newTab.add(title["title"]);
                                    }
                                    tabTitle = newTab;
                                  });
                                  Toast.show("首页已重新排布");
                                }
                                if (datas["selectIndex"] != null) {
                                  String values = datas["selectIndex"];
                                  int index = tabTitle.indexOf(values);
                                  _tabController.animateTo(index);
                                }
                              }
                            });
                          },
                          child: Icon(
                            Icons.menu,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: tabTitle.map((e) {
            // return RecommendsPage();
            if (e == "推荐") {
              return RecommendsPage();
            } else if (e == "优惠活动") {
              return DiscountsPage();
            } else if (e == "拼车用车") {
              return UseCarPage();
            } else if (e == "二手交易") {
              return OldGoodsPage();
            }else if (e == "本地房产") {
              return LocalHousePage();
            }else if (e == "招聘招工") {
              return LocalWorkPage();
            }else if (e == "寻人寻物") {
              return LocalFindPage();
            }else if (e == "本地事") {
              return LocalMessagePage();
            }else {
              //创建3个Tab页
              return Container(
                alignment: Alignment.center,
                child: Text(e, textScaleFactor: 5),
              );
            }
          }).toList(),
        ));
  }
}
