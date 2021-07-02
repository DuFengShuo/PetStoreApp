import 'package:flutter/material.dart';
import 'package:local_life_app/home/home_router.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/routers/fluro_navigator.dart';
import 'package:local_life_app/util/image_utils.dart';
import 'package:local_life_app/widgets/my_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecommendCellWidget extends StatefulWidget {
  @override
  _RecommendCellWidgetState createState() => _RecommendCellWidgetState();
}

class _RecommendCellWidgetState extends State<RecommendCellWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          NavigatorUtils.push(context, HomeRouter.detail);
        },
        child: Padding(
          padding:  EdgeInsets.only(left: 8.w,right: 8.w,top: 5.h,bottom: 5.h),
          child: MyCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, //横轴
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Container(
                //   margin: EdgeInsets.only(top: 10, left: 0, right: 0),
                //   color: Colours.line,
                //   height: 0.6,
                // ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, //横轴
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                top: 10.h, left: 10.w, bottom: 10.h, right: 10.w),
                            child: Text(
                              "盛德美五一活动全场八折，先到先得，办卡满1000送1000",
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
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.w,
                    right: 10.w
                  ),
                  child: Text(
                    "活动日期: 2021.03.21-2021.05.21",
                    style:TextStyles.textSize12.copyWith(color: Colours.sub_text_gray),
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
                          padding: EdgeInsets.only(left: 5),
                          color: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6.0),

                            ///图片顶部圆角
                            child: Image(image: ImageUtils.getAssetImage("state/company"),)

                            // CachedNetworkImage(
                            //     fit: BoxFit.cover,
                            //     imageUrl:
                            //     "${NetUtil.HomeUrl + "${widget.data["img_url"][0]}"}"),
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
                              child:  Image(image: ImageUtils.getAssetImage("state/company"),)),
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
                                child:  Image(image: ImageUtils.getAssetImage("state/company"),))),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.w, top: 10.h,bottom: 10.h,right: 10.w),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            new CircleAvatar(
                              radius: 16.0,
                              backgroundColor: Colours.app_main,
                              backgroundImage:ImageUtils.getAssetImage("logo"),
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
                                style: TextStyle(fontSize: 10,color: Colours.text_gray),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(right: 5.w),
                        child: Text(
                          " 已有44人参与 ",
                          style: TextStyle(fontSize: 12,color: Colours.app_main),
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
