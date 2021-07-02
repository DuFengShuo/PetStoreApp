import 'package:flutter/material.dart';
import 'package:local_life_app/home/home_router.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/routers/fluro_navigator.dart';
import 'package:local_life_app/util/image_utils.dart';
import 'package:local_life_app/widgets/my_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocalMessageCellWidget extends StatefulWidget {
  @override
  _LocalMessageCellWidgetState createState() => _LocalMessageCellWidgetState();
}

class _LocalMessageCellWidgetState extends State<LocalMessageCellWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          NavigatorUtils.push(context, HomeRouter.detail);
        },
        child: Padding(
          padding:
              EdgeInsets.only(left: 8.w, right: 8.w, top: 5.h, bottom: 5.h),
          child: MyCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, //横轴
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, //横轴
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                top: 10.h,
                                left: 10.w,
                                right: 10.w),
                            child: Text(
                              "最新消息，政府将要拆迁汉城路周边街道",
                              maxLines: 3,
                              style: TextStyles.textBold14.copyWith(color: Colors.black,fontWeight: FontWeight.w400),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Gaps.vGap5,
                Padding(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  child: Text(
                    "2021-02-11",
                    style: TextStyles.textSize12
                        .copyWith(color: Colours.sub_text_gray),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 65.0,
                          color: Colors.white,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(6.0),
                              ///图片顶部圆角
                              child: Image(
                                image: NetworkImage(
                                    "${"http://img.kaiyanapp.com/0-c986cf4a0141fa9d60198d8a92290d7f.jpeg?imageMogr2/quality/60/format/jpg"}"),
                                fit: BoxFit.cover,
                              )
                              ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 65.0,
                          padding: EdgeInsets.only(left: 5),
                          color: Colors.white,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(6.0),
                              ///图片顶部圆角
                              child: Image(
                                image: NetworkImage(
                                    "${"http://img.kaiyanapp.com/07e2d9c0ab6c5bb98649673f38fa1d23.png?imageMogr2/quality/60/format/jpg"}"),
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                            height: 65.0,
                            padding: EdgeInsets.only(left: 5),
                            //height: 100.0,
                            color: Colors.white,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(6.0),
                                ///图片顶部圆角
                                child: Image(
                                  image: NetworkImage(
                                      "${"http://img.kaiyanapp.com/0-49d6c740a3378d24cb21fd714bb42ccf.jpeg?imageMogr2/quality/60/format/jpg"}"),
                                  fit: BoxFit.cover,
                                ))),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 10.w, top: 10.h, bottom: 10.h, right: 10.w),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            new CircleAvatar(
                              radius: 16.0,
                              backgroundColor: Colours.app_main,
                              backgroundImage: ImageUtils.getAssetImage("logo"),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                "小生",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                "最近发布",
                                softWrap: true,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 10, color: Colours.text_gray),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 5.w),
                        child: Text(
                          " 已有44人浏览 ",
                          style:
                              TextStyle(fontSize: 12, color: Colours.app_main),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
