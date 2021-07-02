import 'package:flutter/material.dart';
import 'package:local_life_app/home/home_router.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/routers/fluro_navigator.dart';
import 'package:local_life_app/util/image_utils.dart';
import 'package:local_life_app/widgets/my_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocalWorkCellWidget extends StatefulWidget {
  @override
  _LocalWorkCellWidgetState createState() => _LocalWorkCellWidgetState();
}

class _LocalWorkCellWidgetState extends State<LocalWorkCellWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigatorUtils.push(context, HomeRouter.detail);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 4,top: 4),
        child: MyCard(
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(
                top: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //排除colum居中对齐干扰
                children: <Widget>[
              Row(
              children: <Widget>[

              Expanded(
              child: Padding(
              padding: EdgeInsets.only(
                top: 5,
                right: 5,
                left: 10,
              ),
              child:
              Row(children: <Widget>[
                Expanded(child: Text(
                  "单位招聘大堂经理",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.textBold14.copyWith(color: Colors.black,fontWeight: FontWeight.w400),
                ),),

                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    "全职",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colours.app_main),
                  ),
                ),
              ],),

            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, right: 10, left: 5),
            child: Text(
              "${88}元/月",
              style: TextStyles.text,
            ),

          ),
              ]),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
            child: Row(
              children: <Widget>[
                ChoiceChip(
                  backgroundColor: Colors.grey[100],
                  label: Text(
                      '经验${4}年',
                      style: TextStyles.textSize12),
                  selected: false,
                ),


                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: ChoiceChip(
                    backgroundColor: Colors.grey[100],
                    label: Text(
                      '${"标签1"}',
                      style: TextStyles.textSize12,
                    ),
                    selected: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: ChoiceChip(
                    backgroundColor: Colors.grey[100],
                    label: Text(
                      '${"经验"}',
                      style: TextStyles.textSize12,
                    ),
                    selected: false,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 2, right: 5, left: 13),
            child: Text(
              "${"科技公司"} ${"33"}人",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.text,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 0, right: 0),
            child: Divider(
              color: Colors.grey[200],
            ),
          ),
          Gaps.vGap8,
          Padding(
            padding: const EdgeInsets.only(
                top: 2, bottom: 10, left: 10, right: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          left: 0,
                        ),
                        child: new CircleAvatar(
                          radius: 15.0,
                          backgroundImage: NetworkImage(
                             "${"http://img.kaiyanapp.com/07e2d9c0ab6c5bb98649673f38fa1d23.png?imageMogr2/quality/60/format/jpg"}"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          "ddd",
                          maxLines: 3,
                          style: TextStyles.textSize12,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "${"上海"}",
                  maxLines: 3,
                  style: TextStyles.textSize12,
                ),
              ],
            ),
          ),
          ],
        ),
      ),
    ),)
    ,
    )
    );
  }
}
