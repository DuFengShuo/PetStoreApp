import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/util/image_utils.dart';
import 'package:local_life_app/util/screen_utils.dart';


class PageTabView extends StatefulWidget {
  final companyId;

  const PageTabView({Key key, this.companyId}) : super(key: key);

  @override
  _PageTabViewState createState() => _PageTabViewState();
}

class _PageTabViewState extends State<PageTabView>with SingleTickerProviderStateMixin {
  TabController tabController;
  PageController controller = new PageController();
  ScrollController tableController;

  bool isTabToTop = false;
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
  var pageList;
  int pageNum = 0;
  List pageHeight =[0.8,0.3,0.3,0.4,0.4,0.4,0.4,0.9];

  FlexibleSpaceBar buildFlexibleSpaceBar() {
    return FlexibleSpaceBar(
//                title: Text("FlexibleSpaceBar title"),
      collapseMode: CollapseMode.pin,
      centerTitle: true,
      background: Container(
        height: 235.h,

      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tableController= new ScrollController();
    tabController = new TabController(length: contentTabData.length, vsync: this);
    // controller = new PageController(
    //   keepPage: false,
    //   viewportFraction: pageHeight[pageNum],
    // );
  }

  @override
  Widget build(BuildContext context) {
    // controller = new PageController(
    //   keepPage: false,
    //   viewportFraction: pageHeight[pageNum],
    // );
    return Scaffold(
      appBar: new AppBar(
        brightness: Brightness.dark,
        centerTitle: true,
        backgroundColor: Colours.app_main,
        title: Text(
          "整页联动",
          style: TextStyles.textSize16,
        ),
        bottom:
        PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: Container(
            color: Colours.material_bg,
            child: TabBar(
              // indicatorPadding: EdgeInsets.only(left: 8, right: 8),
                controller: tabController,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colours.dark_app_main,
                indicatorWeight: 2,
                unselectedLabelColor: Colours.dark_text_gray,
                labelColor: Colours.app_main,
                // indicator:BoxDecoration(
                //   color: Colours.red
                //
                // ),
                isScrollable: true,
                onTap: (value) {
                  print("点了第$value个");
                  controller.jumpToPage(value);
                },
                tabs: contentTabData.map((e) => Tab(text: "$e")).toList()),
          ),
        )

      ),
        body: PageView.builder(
          pageSnapping: true,
          scrollDirection: Axis.vertical,
          // physics: NeverScrollableScrollPhysics(),
          onPageChanged: (int index) {
            setState(() {
              pageNum = index;
              tabController.index=index;
            });

          },

          controller: controller,
          itemCount: contentTabData.length,
          itemBuilder: (context, index) {
            return Container(
              width: Screen.width(context),

              decoration: BoxDecoration(
                  color: Colours.bg_color,
                  // border: Border(bottom: BorderSide(width: 1,color: Colours.red))
              ),

              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.vGap15,
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text("${contentTabData[index]}",style: TextStyles.textBold20,),
                  ),
                  Expanded(child: Container(
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ImageUtils.getAssetImage("none")
                      )
                    ),
                  ))
                ],
              )            );
          },
        ),
    );
  }
}
