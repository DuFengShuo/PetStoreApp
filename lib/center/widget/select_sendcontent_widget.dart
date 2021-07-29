import 'package:flutter/material.dart';
import 'package:local_life_app/res/colors.dart';
import 'package:local_life_app/res/gaps.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_life_app/util/screen_utils.dart';
import 'package:local_life_app/widgets/grade_button.dart';

class SelectSendContentWidget extends StatefulWidget {
  final Function callBack;
  final List datas;
  final title;

  const SelectSendContentWidget({
    Key key,
    this.callBack,
    this.datas,
    this.title,
  }) : super(key: key);

  @override
  _SelectSendContentWidgetState createState() =>
      _SelectSendContentWidgetState();
}

class _SelectSendContentWidgetState extends State<SelectSendContentWidget> {
  double conWidth = double.infinity;

  // String title = "选择发布的信息类型";
  bool _checkboxSelected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int oneIndex = 0; //一级分类下标 记录选中的下表，给选中的样式

  Widget getRow(int i, String title) {
    return InkWell(
      onTap: () {
        setState(() {
          setState(() {
            oneIndex = i; //记录选中的下标
            // textColor = Colours.app_main;
          });
        });
      },
      child: Container(
        // height: 45,
        margin: EdgeInsets.only(left: 10),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: TextStyles.textSize12,
                ),
                Expanded(child: Container()),
                Padding(
                  padding: EdgeInsets.only(right: 0),
                  child: Checkbox(
                    // tristate: true,
                    value: i == oneIndex,
                    activeColor: Colours.app_main, //选中时的颜色
                    onChanged: (value) {
                      setState(() {
                        oneIndex = i; //记录选中的下标
                        // textColor = Colours.app_main;
                      });
                    },
                  ),
                ),
              ],
            ),
            // Expanded(child: Container()),
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Gaps.line,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colours.bg_color,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 10.h, left: 15.w,bottom: 10.h,right: 5.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${widget.title}",
                    style: TextStyles.textBold15,
                  ),
                  Expanded(child: Container()),
                  SizedBox(
                    width: 55,
                    height: 35,
                    child: IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: Colours.text,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  )
                ],
              ),
            ),
          ),
          Gaps.vGap15,
          Expanded(
            child: Container(

                margin: EdgeInsets.only(
                  left: 10.w,
                  right: 10.w,
                ),
                child: ListView.builder(
                    itemCount: widget.datas.length,
                    // itemExtent: 45,
                    shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(top: 0, bottom: 0),
                    itemBuilder: (BuildContext context, int index) {
                      return getRow(index, widget.datas[index]);
                    })),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Container(
              width: Screen.width(context),
              height: 60.h,
              decoration: BoxDecoration(
                  border: Border(
                top: Divider.createBorderSide(context, width: 0.6),
              )),
              child: Padding(
                padding: EdgeInsets.only(
                    left: 20.w, right: 20.w, top: 10.h, bottom: 5.h),
                child: GradeButtonWidget(
                  text: "确定",
                  onTap: () {
                    widget.callBack(widget.datas[oneIndex]);
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
