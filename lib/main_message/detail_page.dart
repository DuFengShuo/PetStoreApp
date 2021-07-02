import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/widgets/my_button.dart';
import 'package:share/share.dart';

class DetailsPage extends StatefulWidget {
  String title;
  String des;

  DetailsPage(this.title, this.des, {Key key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  double height = 50;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    var durations = Duration(milliseconds: 300);
    return Scaffold(
        body: ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Stack(
        alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
        children: <Widget>[

          CustomScrollView(
            slivers: <Widget>[
              SliverPersistentHeader(
                pinned: true,

                delegate: SliverCustomHeaderDelegate(
                  title: widget.title,
                  collapsedHeight: 50,
                  expandedHeight: 300,
                  paddingTop: MediaQuery.of(context).padding.top,
                  coverImgUrl: "",
                ),
              ),
              SliverFillRemaining(
                fillOverscroll: true,
                child: FilmContent(
                  widget.des,
                ),
              )
            ],
          ),
          Positioned(
              bottom: 0,
              child: Container(
                decoration: new BoxDecoration(
                  boxShadow: [BoxShadow(color: Colours.line, blurRadius: 20.0)],
                  color: Colors.white,
                ),
                width: ScreenUtil.getScreenW(context),
                height: 60,
                // color: Colours.material_bg,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  child: MyButton(
                    minHeight: 40,
                    fontSize: 14,
                    textColor: Colours.material_bg,
                    onPressed: () {},
                    backgroundColor: Colours.app_main,
                    text: "立即联系",
                  ),
                ),
              )),
        ],
      ),
    ));
  }
}

class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double collapsedHeight;
  final double expandedHeight;
  final double paddingTop;
  final String coverImgUrl;
  final String title;
  String statusBarMode = 'dark';

  SliverCustomHeaderDelegate({
    this.collapsedHeight,
    this.expandedHeight,
    this.paddingTop,
    this.coverImgUrl,
    this.title,
  });

  @override
  double get minExtent => this.collapsedHeight + this.paddingTop;

  @override
  double get maxExtent => this.expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  void updateStatusBarBrightness(shrinkOffset) {
    if (shrinkOffset > 50 && this.statusBarMode == 'dark') {
      this.statusBarMode = 'dark';
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ));
    } else if (shrinkOffset <= 50 && this.statusBarMode == 'light') {
      this.statusBarMode = 'dark';
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ));
    }
  }

  Color makeStickyHeaderBgColor(shrinkOffset) {
    final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255)
        .clamp(0, 255)
        .toInt();
    return Color.fromARGB(alpha, 255, 255, 255);
  }

  Color makeStickyHeaderTextColor(shrinkOffset, isIcon) {
    if (shrinkOffset <= 50) {
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Container(
      height: this.maxExtent,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(child: Image.network(this.coverImgUrl, fit: BoxFit.cover)),
          //这里可以换成轮播图
          Positioned(
            left: 0,
            top: this.maxExtent / 2,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x00000000),
                    Color(0x90000000),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              color: this.makeStickyHeaderBgColor(shrinkOffset),
              child: SafeArea(
                bottom: false,
                child: Container(
                  height: this.collapsedHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text(
                        this.title,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: this
                              .makeStickyHeaderTextColor(shrinkOffset, false),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.share,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Share.share(
                              'check out my website https://example.com',
                              subject: 'Look what I made!');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FilmContent extends StatelessWidget {
  String des;

  FilmContent(this.des);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: ListView(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Text(
            '阿凡达是否',
            style: TextStyles.textBold16,
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          Text(
            "发射点发顺丰打赏",
            textAlign: TextAlign.justify,
            style: TextStyles.text,
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          Padding(padding: EdgeInsets.only(top: 20)),
          Padding(padding: EdgeInsets.only(top: 10)),
          Image(
            height: 240,
            width: ScreenUtil.getScreenW(context) - 40,
            color: Colours.app_main_light,
            image: NetworkImage(""),
            fit: BoxFit.cover,
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          Image(
            height: 240,
            width: ScreenUtil.getScreenW(context) - 40,
            color: Colours.app_main_light,
            image: NetworkImage(""),
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
