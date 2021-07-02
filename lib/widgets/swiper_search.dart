import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


class SwiperSearchPage extends StatefulWidget {
  Map<String,dynamic> data;

  SwiperSearchPage(this.data);

  @override
  _SwiperSearchPageState createState() => _SwiperSearchPageState();
}

class _SwiperSearchPageState extends State<SwiperSearchPage> {
  List data = [
    "会生活app正式上线了",
    "优惠活动，卖二手，家政，寻人寻物",
    "闪电外卖，最快十五分钟送达",
    "买房|租房|卖房，拼车租车",
    "兴趣交友，农业相关"
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          print("点我了");
          // showSearch(context: context, delegate: searchBarDelegate());
          // Navigator.push(context, animation_route(SearchContentPage(widget.data)));
        },
        child: Container(
          child: Swiper(
            itemBuilder: _swiperBuilder,
            itemCount: data.length,
            scrollDirection: Axis.vertical,
            autoplay: true,
            //  onTap: (index) => print('点击了第$index个'),
          ),
        ));
  }

  Widget _swiperBuilder(BuildContext context, int index) {
    return Center(child: (Text("${data[index]}", style: TextStyle(fontSize: 12, color: Colors.black54),)));
  }
}
