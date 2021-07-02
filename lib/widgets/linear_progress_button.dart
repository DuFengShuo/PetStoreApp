import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_life_app/res/resources.dart';
class LinearProgressButton extends StatefulWidget {
  final double progress;
  final int valueInt;
  const LinearProgressButton({Key key, this.progress, this.valueInt}) : super(key: key);

  @override
  _LinearProgressButtonState createState() => _LinearProgressButtonState();
}

class _LinearProgressButtonState extends State<LinearProgressButton> {
  String resultProgress;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
   // double result = NumUtil.getNumByValueDouble(widget.progress, 3);
    int result = widget.progress.toInt();

    return new Container(
       margin: EdgeInsets.only(left: 40.w,right: 40.w),
      color: Colors.white,
      height: 40.h,
      width:  MediaQuery.of(context).size.width-40,
      child: Stack(
        alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
        children: <Widget>[
          Container(
            child: ClipRRect(
              //剪裁为圆角矩形
              borderRadius: BorderRadius.circular(25.0),
              child: LinearProgressIndicator(
                backgroundColor:
                 Colours.dark_text,
                valueColor:
                AlwaysStoppedAnimation<Color>(Colours.app_main_light),
                value: widget.progress,
              ),
            ),
            height: 45,
            width:  MediaQuery.of(context).size.width-40,
          ),
          new Positioned(
            child: Container(
              alignment: Alignment.center,
              child: Text("${(widget.valueInt)} " +"%",style: TextStyles.textBold12.copyWith(color: Colours.material_bg),),
              width:  MediaQuery.of(context).size.width-40,
              height: 45,
            ),
          )
        ],
      ),
    );
  }
}
