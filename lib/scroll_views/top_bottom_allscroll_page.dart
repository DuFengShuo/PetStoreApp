import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/util/screen_utils.dart';
import 'package:scrollable_list_tabview/scrollable_list_tabview.dart';

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

// scrollable_positioned_list: ^0.1.10
const numberOfItems = 8;
const minItemHeight = 100.0;
const maxItemHeight = 1000.0;
const scrollDuration = Duration(milliseconds: 700);
const randomMax = 1 << 32;

class ScrollablePositionedListPage extends StatefulWidget {
  final companyId;

  const ScrollablePositionedListPage({
    Key key,
    this.companyId,
  }) : super(key: key);

  @override
  _ScrollablePositionedListPageState createState() =>
      _ScrollablePositionedListPageState();
}

class _ScrollablePositionedListPageState
    extends State<ScrollablePositionedListPage>
    with SingleTickerProviderStateMixin {
  /// Controller to scroll or jump to a particular item.
  final ItemScrollController itemScrollController = ItemScrollController();

  /// Listener that reports the position of items when the list is scrolled.
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  List<double> itemHeights;
  List<Color> itemColors;
  bool reversed = false;

  /// The alignment to be used next time the user scrolls or jumps to an item.
  double alignment = 0;
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
//                title: Text("FlexibleSpaceBar title"),
      collapseMode: CollapseMode.pin,
      centerTitle: true,
      background: Container(
        color: Colours.material_bg,
        height: 300,
      ),
    );
  }

  int minIndex = 0;

  @override
  void initState() {
    super.initState();
    final heightGenerator = Random(328902348);
    final colorGenerator = Random(42490823);
    itemHeights = List<double>.generate(
        numberOfItems,
        (int _) =>
            heightGenerator.nextDouble() * (maxItemHeight - minItemHeight) +
            minItemHeight);
    itemColors = List<Color>.generate(numberOfItems,
        (int _) => Color(colorGenerator.nextInt(randomMax)).withOpacity(1));
    tabController =
        new TabController(length: contentTabData.length, vsync: this);
    nestScroll = new ScrollController();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: new AppBar(
        brightness: Brightness.dark,
        centerTitle: true,
        backgroundColor: Colours.app_main,
        title: Text(
          "联动",
          style: TextStyles.textSize16,
        ),
        bottom:PreferredSize(
          preferredSize: Size.fromHeight(45.h),
          child: MyTabWidget(
            tabDatas: contentTabData,
            itemPositionsListener: itemPositionsListener,
            callBack: (value) {
              if (value != null) {
                jumpTo(value);
              }
            },
          ),
        ) ,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) => list(orientation),
      ));

  Widget list(Orientation orientation) => ScrollablePositionedList.builder(
        itemCount: 8,
        // physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => item(index, orientation),
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
        reverse: reversed,
        scrollDirection: orientation == Orientation.portrait
            ? Axis.vertical
            : Axis.horizontal,
      );

  void scrollTo(int index) => itemScrollController.scrollTo(
      index: index,
      duration: scrollDuration,
      curve: Curves.easeInOutCubic,
      alignment: alignment);

  void jumpTo(int index) =>
      itemScrollController.jumpTo(index: index, alignment: alignment);

  /// Generate item number [i].
  Widget item(int i, Orientation orientation) {
    return Container(
      height: 200,
      color: Colours.bg_color,
      child: ListTile(
        title: Text("$i"),
      ),
    );
  }
}

class MyTabWidget extends StatefulWidget {
  final List tabDatas;

  final Function callBack;
  final ItemPositionsListener itemPositionsListener;

  const MyTabWidget(
      {Key key, this.tabDatas, this.itemPositionsListener, this.callBack})
      : super(key: key);

  @override
  _MyTabWidgetState createState() => _MyTabWidgetState();
}

class _MyTabWidgetState extends State<MyTabWidget> {
  ScrollController tableScroll;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tableScroll = new ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Iterable<ItemPosition>>(
      valueListenable: widget.itemPositionsListener.itemPositions,
      builder: (context, positions, child) {
        int tabIndex = 0;

        int min = 0;
        int max;
        if (positions.isNotEmpty) {
          min = positions
              .where((ItemPosition position) => position.itemTrailingEdge > 0)
              .reduce((ItemPosition min, ItemPosition position) =>
                  position.itemTrailingEdge < min.itemTrailingEdge
                      ? position
                      : min)
              .index;
          tabIndex = min;

          max = positions
              .where((ItemPosition position) => position.itemLeadingEdge < 1)
              .reduce((ItemPosition max, ItemPosition position) =>
                  position.itemLeadingEdge > max.itemLeadingEdge
                      ? position
                      : max)
              .index;
        }
        return Container(
          height: 45.h,
          width: Screen.width(context),
          color: Colours.material_bg,
          child: ListView.builder(
            controller: tableScroll,
            scrollDirection: Axis.horizontal,
            itemCount: widget.tabDatas.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 17.h,
                  ),
                  child: GestureDetector(
                      onTap: () {
                        widget.callBack(index);
                      },
                      child: Column(
                        children: [
                          Text(
                            "${widget.tabDatas[index]}",
                            style: TextStyles.textSize12.copyWith(
                                color: min == index
                                    ? Colours.app_main
                                    : Colours.text,
                                fontWeight:
                                    min == index ? FontWeight.w600 : null),
                          ),
                          Gaps.vGap5,
                          Container(
                            width: 20,
                            height: 2,
                            color: min == index
                                ? Colours.app_main
                                : Colors.transparent,
                          )
                        ],
                      )));
            },
          ),
        );
      },
    );
  }
}



class ScrollableTabView extends StatefulWidget {
  const ScrollableTabView({Key key}) : super(key: key);

  @override
  _ScrollableTabViewState createState() => _ScrollableTabViewState();
}

class _ScrollableTabViewState extends State<ScrollableTabView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colours.app_main,
        title: Text(
          "自定义联动",
          style: TextStyles.textSize16,
        ),
      ),
      body: ScrollableListTabView(
        tabHeight: 48,
        tabs: [
          ScrollableListTab(
              tab: ListTab(
                  label: Text('Label 1'),
                  // icon: Icon(Icons.group),
                  borderColor: Colors.transparent),
              body: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (_, index) => ListTile(
                  leading: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey),
                    alignment: Alignment.center,
                    child: Text(index.toString()),
                  ),
                  title: Text('List element $index'),
                ),
              )),
          ScrollableListTab(
              tab: ListTab(
                  label: Text('Label 2'),
                  // icon: Container(),
                  borderColor: Colors.red),
              body: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (_, index) => ListTile(
                  leading: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey),
                    alignment: Alignment.center,
                    child: Text(index.toString()),
                  ),
                  title: Text('List element $index'),
                ),
              )),
          ScrollableListTab(
              tab: ListTab(
                  label: Text('Label3'),
                  // icon: Icon(Icons.group),
                  borderColor: Colors.transparent),
              body: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (_, index) => ListTile(
                  leading: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey),
                    alignment: Alignment.center,
                    child: Text(index.toString()),
                  ),
                  title: Text('List element $index'),
                ),
              )),
          ScrollableListTab(
              tab: ListTab(
                  label: Text('Label4'),
                  // icon: Icon(Icons.group),
                  borderColor: Colors.transparent),
              body: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (_, index) => ListTile(
                  leading: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey),
                    alignment: Alignment.center,
                    child: Text(index.toString()),
                  ),
                  title: Text('List element $index'),
                ),
              ))
        ],
      ),
    );
  }
}
