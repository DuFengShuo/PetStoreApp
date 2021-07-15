import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/util/image_utils.dart';
import 'package:local_life_app/widgets/my_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class HeaderStopPage extends StatefulWidget {
  const HeaderStopPage({Key key}) : super(key: key);

  @override
  _HeaderStopPageState createState() => _HeaderStopPageState();
}

class _HeaderStopPageState extends State<HeaderStopPage>with SingleTickerProviderStateMixin {
  TabController tabController;
  ScrollController nestScroll;
  List<String> contentTabData = [
    "Summary",
    "Products",
    "Finance",
    "Album",
    "Employee",
    "Recent",
    "Recommand",
    "Reviews"
  ];

  FlexibleSpaceBar buildFlexibleSpaceBar() {
    return FlexibleSpaceBar(
      collapseMode: CollapseMode.pin,
      centerTitle: true,
      background: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("http://img1.mukewang.com/5c18cf540001ac8206000338.jpg"),//背景图片
            fit: BoxFit.cover,
          ),
        ),
        height: 240.h,
        child: ClipRRect( // make sure we apply clip it properly
          child: BackdropFilter( //背景滤镜
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),//背景模糊化
            child: Container(
              alignment: Alignment.center,
              color: Colors.grey.withOpacity(0.1),
              child: Text(
                "Header Stop View",//前景文字
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),

      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = new TabController(length: contentTabData.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.app_main,
        brightness: Brightness.dark,
        centerTitle: true,
        title: Text(
          "头部停靠",
          style: TextStyles.textSize16,
        ),
      ),
      body: NestedScrollView(

          headerSliverBuilder: (BuildContext context, bool b) {
            return [
              SliverAppBar(
                ///true SliverAppBar 不会滑动
                pinned: true,
                automaticallyImplyLeading: false,
                ///是否随着滑动隐藏标题
                floating: true,
                // snap: true,
                forceElevated: true,
                backgroundColor: Colours.material_bg,

                ///SliverAppBar展开的高度
                expandedHeight: 280.h,
                flexibleSpace: buildFlexibleSpaceBar(),
                bottom:
                PreferredSize(
                  preferredSize: Size.fromHeight(50.h),
                  child: Container(
                    color: Colours.material_bg,
                    height: 50.h,
                    child: TabBar(
                      // indicatorPadding: EdgeInsets.only(left: 8, right: 8),
                        controller: tabController,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: Colours.app_main,
                        unselectedLabelColor: Colours.dark_text_gray,
                        labelColor: Colours.app_main,
                        isScrollable: true,
                        onTap: (value) {
                          print("点了第$value个");

                        },
                        tabs: contentTabData.map((e) => Tab(text: "$e")).toList()),
                  ),
                )
              ),
            ];
          },

          ///主体部分
          body:
          TabBarView(
            controller: tabController,
            children: contentTabData.map((e) =>       Container(
              color: Colours.bg_color,
              child: ListView.separated(
                // physics: BouncingScrollPhysics(),
                  itemCount:30,
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
                        },
                        child:  ListTile(
                          contentPadding: EdgeInsets.only(left: 20),
                          title: Text(
                            "${e} $index",
                            style: TextStyles.text,
                          ),
                          trailing: Icon(Icons.navigate_next_outlined,color: Colours.text,),

                        ) ,
                      );


                  }),
            ),).toList() ,
          )


    ),
    );
  }
}
