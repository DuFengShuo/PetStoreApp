import 'dart:ui';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/widgets/icon_font.dart';
import 'package:local_life_app/widgets/my_app_bar.dart';

class SliverAppBarPage extends StatefulWidget {
  const SliverAppBarPage({Key key}) : super(key: key);

  @override
  _SliverAppBarPageState createState() => _SliverAppBarPageState();
}

class _SliverAppBarPageState extends State<SliverAppBarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            // floating: true,
            pinned: true,
            delegate: SliverCustomHeaderDelegate(
              title: '渐变导航栏',
              collapsedHeight: 54.h,
              //appbar高度
              expandedHeight: 300.h,
              type: "personnel",
              paddingTop: MediaQuery.of(context).padding.top,
              sliverHeaderWidget: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        "http://img1.mukewang.com/5c18cf540001ac8206000338.jpg"),
                    //背景图片
                    fit: BoxFit.cover,
                  ),
                ),
                height: 240.h,
                child: ClipRRect(
                  // make sure we apply clip it properly
                  child: BackdropFilter(
                    //背景滤镜
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15), //背景模糊化
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.grey.withOpacity(0.1),
                      child: Text(
                        "Header Stop View", //前景文字
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverAnimatedList(
            initialItemCount: 50,
            itemBuilder:
                (BuildContext context, int index, Animation<double> animation) {
              return ListTile(
                title: Text("$index"),
              );
            },
          )
          // SliverFillRemaining(
          //   fillOverscroll:true,
          //   child: PersonDetailContent(
          //     model: model,
          //   ),
          // )
        ],
      ),
    );
  }
}

class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double collapsedHeight;
  final double expandedHeight;
  final double paddingTop;
  final String coverImgUrl;
  final String title;
  final String type;

  final Widget sliverHeaderWidget;

  SliverCustomHeaderDelegate({
    this.collapsedHeight,
    this.expandedHeight,
    this.paddingTop,
    this.coverImgUrl,
    this.title,
    this.type,
    this.sliverHeaderWidget,
  });

  @override
  double get minExtent => this.collapsedHeight + this.paddingTop;

  @override
  double get maxExtent => this.expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  Color makeStickyHeaderBgColor(shrinkOffset, Color color) {
    final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255)
        .clamp(0, 255)
        .toInt();
    return color.withAlpha(alpha);
  }

  Color makeStickyHeaderTextColor(shrinkOffset, isIcon) {
    if (shrinkOffset <= 54.h) {
      return isIcon ? Colors.white : Colors.transparent;
    } else {
      final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255)
          .clamp(0, 255)
          .toInt();
      return Color.fromARGB(alpha, 0, 0, 0);
    }
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: this.maxExtent,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            child: sliverHeaderWidget ??
                Container(
                    child: Image.network(this.coverImgUrl, fit: BoxFit.cover)),
          ),
          // 收起头部
          Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  tooltip: 'icon_back',
                  padding: const EdgeInsets.all(12.0),
                  icon: IconFont(
                      name: 0xe613, size: 16, color: Colours.material_bg),
                ),
                brightness: Brightness.dark,
                backgroundColor: this.makeStickyHeaderBgColor(shrinkOffset, Colours.app_main),
                centerTitle: true,
                // automaticallyImplyLeading: false,
                title: Text(
                  "$title",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: this.makeStickyHeaderBgColor(
                        shrinkOffset, Colours.material_bg), // 标题颜色
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
