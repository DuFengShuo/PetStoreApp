import 'package:flutter/material.dart';
import 'package:local_life_app/home/home_page.dart';
import 'package:local_life_app/login/page/phone_fast_login_page.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/scroll_views/header_stop_page.dart';
import 'package:local_life_app/scroll_views/sliver_appbar_page.dart';
import 'package:local_life_app/scroll_views/top_bottom_allscroll_page.dart';
import 'package:local_life_app/scroll_views/top_list_allscroll_page.dart';
import 'package:local_life_app/util/device_utils.dart';

class ScrollListPage extends StatefulWidget {
  const ScrollListPage({Key key}) : super(key: key);

  @override
  _ScrollListPageState createState() => _ScrollListPageState();
}

class _ScrollListPageState extends State<ScrollListPage> {
  List datas = ["头部停靠","渐变导航栏","头部底部联动","头部自定义底部联动", "pageview联动","每栏头部悬浮","折叠table","拉拽效果"];
  List<Widget> allWidget = [HeaderStopPage(),SliverAppBarPage(),ScrollablePositionedListPage(),ScrollableTabView(),PageTabView(),HeaderStopPage(),HeaderStopPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.app_main,
        brightness: Brightness.dark,
        centerTitle: true,
        title: Text(
          "滚动效果",
          style: TextStyles.textSize16,
        ),
      ),
      body: ListView.separated(
          itemCount: datas.length,
          separatorBuilder: (BuildContext context,int index){
            return Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Gaps.line,
            );
          },
          itemBuilder: (BuildContext context, int index) {
            return
              InkWell(
                splashColor: Colours.dark_text_disabled,
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return allWidget[index];
                      },
                    ),
                  );
                },
                child:  ListTile(
                  contentPadding: EdgeInsets.only(left: 20),
                  title: Text(
                    "${datas[index]}",
                    style: TextStyles.text,
                  ),
                  trailing: Icon(Icons.navigate_next_outlined,color: Colours.text,),

                ) ,
              );


          }),
    );
  }
}
