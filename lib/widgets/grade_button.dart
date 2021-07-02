import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_life_app/res/resources.dart';

/*
 * 登录注册的绿色长条形按钮
 * text 按钮为文字内容
 * top为按钮距离顶部控件的高度
 */
class GradeButtonWidget extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const GradeButtonWidget({Key key, @required this.text, this.onTap})
      : super(key: key);

  @override
  _GradeButtonWidgetState createState() => _GradeButtonWidgetState();
}

class _GradeButtonWidgetState extends State<GradeButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: 20.w,
        left: 20.w,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(ScreenUtil().setHeight(44.0)),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [
              Colours.app_main_light,
              Colours.app_main,
              Colours.app_main,
            ]),
            borderRadius: BorderRadius.circular(ScreenUtil().setHeight(44.0)),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(ScreenUtil().setHeight(44.0)),
            onTap: widget.onTap,
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().screenWidth,
              height: 40.h,
              child: Text(
                widget.text,
                style:
                    TextStyles.textBold15.copyWith(color: Colours.material_bg),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
