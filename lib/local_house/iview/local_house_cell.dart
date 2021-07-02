import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:local_life_app/home/home_router.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/routers/fluro_navigator.dart';
import 'package:local_life_app/widgets/my_card.dart';

class LocalHouseCellWidget extends StatefulWidget {
  @override
  _LocalHouseCellWidgetState createState() => _LocalHouseCellWidgetState();
}

class _LocalHouseCellWidgetState extends State<LocalHouseCellWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          NavigatorUtils.push(context, HomeRouter.detail);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 8,right: 8,bottom: 4,top: 4),
          child: GestureDetector(
            child: MyCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                    child: Stack(
                      alignment: Alignment.centerLeft, //指定未定位或部分定位widget的对齐方式
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6.0),
                          ///图片顶部圆角
                          child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl:
                              "http://img.kaiyanapp.com/07e2d9c0ab6c5bb98649673f38fa1d23.png?imageMogr2/quality/60/format/jpg"),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                    child: Text(
                      "房屋标题",
                      style: TextStyles.textBold14.copyWith(color: Colors.black,fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 5),
                    child: Text(
                      "￥${"888888"}",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colours.app_main,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, left: 0, right: 0),
                    color: Colours.line,
                    height: 0.6,
                  ),
                  Padding(
                    padding:
                    EdgeInsets.only(left: 10, right: 10, bottom: 13, top: 13),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              new CircleAvatar(
                                radius: 13.0,
                                backgroundImage: NetworkImage(
                                    "http://img.kaiyanapp.com/07e2d9c0ab6c5bb98649673f38fa1d23.png?imageMogr2/quality/60/format/jpg"),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text(
                                    "小杜",
                                    style: TextStyle(
                                        fontSize: 12, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 1),
                          child: Text(
                            "2021.05.21",
                            softWrap: true,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
