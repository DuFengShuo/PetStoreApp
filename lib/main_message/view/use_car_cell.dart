import 'package:flutter/material.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/util/image_utils.dart';
import 'package:local_life_app/widgets/my_card.dart';


class UseCarCell extends StatefulWidget {
  Map<String, dynamic> data;

  UseCarCell(this.data);

  @override
  _UseCarCellState createState() => _UseCarCellState();
}

class _UseCarCellState extends State<UseCarCell> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
//        Navigator.push(context, new MaterialPageRoute(builder: (context) {
//          return ComDetail(
//              "详情",
//              "https://img1.gamersky.com/image2019/07/20190725_ll_red_136_2/gamersky_07small_14_201972510258D0.jpg",
//              "发布的内容",
//              widget.data);
//        }));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8,right: 8,bottom: 8),
        child: MyCard(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 15,
                            right: 10,
                            left: 10,
                          ),
                          child: Text(
                            "${widget.data["title"]}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles.text,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 3,
                          left: 10,
                        ),
                        child: SizedBox(
                          child: Icon(
                            Icons.directions_car,
                            color: Colors.green,
                          ),
                          width: 18,
                          height: 18,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 8),
                        child: Text(
                          "${widget.data["startAddress"]}",
                          maxLines: 3,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 15),
                        child: Text(
                          "---",
                          maxLines: 3,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3, left: 10),
                        child: SizedBox(
                          child: Icon(
                            Icons.location_on,
                            color: Colours.app_main,
                          ),
                          width: 18,
                          height: 18,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 5),
                        child: Text(
                          "${widget.data["endAddress"]}",
                          maxLines: 3,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Text(
                      "${widget.data["start_time"]}" + "出发",
                      maxLines: 3,
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 0, right: 0),
                    child: Divider(
                      color: Colors.grey[200],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 1, bottom: 10, left: 10, right: 10),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            left: 0,
                          ),
                          child: new CircleAvatar(
                            backgroundColor: Colours.app_main,
                            radius: 15.0,
                            backgroundImage: ImageUtils.getAssetImage("logo")
                            // NetworkImage(
                            //     NetUtil.HomeUrl + "${widget.data["send_user_logo"]}"),
                          ),
                        ),

                        widget.data["user_car_type_id"]==3?  Expanded(child:   Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            "${widget.data["send_user_name"] ?? "无名"}",
                            maxLines: 3,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ), ) : Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            "${widget.data["send_user_name"] ?? "无名"}",
                            maxLines: 3,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),

                        //人找车不显示车类型
                        widget.data["user_car_type_id"]==3? Container() :Expanded(
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  "${widget.data["car_typ"] ?? "暂无"}",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  '可带${widget.data['kd_num']??"1"}人',
                                  style: TextStyle(fontSize: 12),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          height: 30,
                          child: FlatButton(
                            color: Colours.app_main,
                            //highlightColor: Colors.blue[700],
                            colorBrightness: Brightness.dark,
                            splashColor: Colors.grey,
                            child: Text(
                              "${ widget.data["user_car_type_id"]==3 ?"立即联系":"立即预约"}",
                              style: TextStyle(color: Colors.black87, fontSize: 12),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            onPressed: () {
                              //导航到新路由
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
