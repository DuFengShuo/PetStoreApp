import 'package:flutter/material.dart';
import 'package:local_life_app/home/home_router.dart';
import 'package:local_life_app/res/colors.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/routers/fluro_navigator.dart';
import 'package:local_life_app/util/image_utils.dart';
import 'package:local_life_app/widgets/my_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocalCarCellWidget extends StatefulWidget {
  @override
  _LocalCarCellWidgetState createState() => _LocalCarCellWidgetState();
}

class _LocalCarCellWidgetState extends State<LocalCarCellWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8,right: 8,bottom: 4,top: 4),
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
                            "上海出发回老家,私家车，可带两人",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles.textBold14.copyWith(color: Colors.black,fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gaps.vGap8,
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
                          "上海",
                          maxLines: 3,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 10),
                        child: Text(
                          "一一",
                          maxLines: 3,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3, left: 5),
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
                          "老家",
                          maxLines: 3,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                  Gaps.vGap8,
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 0, right: 0),
                    child: Divider(
                      color: Colors.grey[200],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 10, right: 10),
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
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            "无名",
                            maxLines: 3,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only( left: 10),
                          child: Text(
                            "车找人",
                            maxLines: 3,
                            style: TextStyle(fontSize: 12, color: Colours.sub_text_gray),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only( left: 10),
                          child: Text(
                            "2021.02.1" + "出发",
                            maxLines: 3,
                            style: TextStyle(fontSize: 12, color: Colours.sub_text_gray),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only( left: 10),
                          child: Text(
                            "2人",
                            maxLines: 3,
                            style: TextStyle(fontSize: 12, color: Colours.sub_text_gray),
                          ),
                        ),
                        Expanded(child: Gaps.empty),
                        SizedBox(
                          width: 80,
                          height: 30,
                          child: FlatButton(
                            color: Colours.app_main,
                            //highlightColor: Colors.blue[700],
                            colorBrightness: Brightness.dark,
                            splashColor: Colors.grey,
                            child: Text(
                            "立即联系",
                              style: TextStyle(color: Colours.material_bg, fontSize: 12),
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
