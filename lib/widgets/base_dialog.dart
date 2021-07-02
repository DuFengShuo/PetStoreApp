import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/routers/fluro_navigator.dart';
import 'package:local_life_app/util/image_utils.dart';

/// 自定义dialog的模板

class BaseDialog extends StatefulWidget {
  const BaseDialog(
      {Key key,
      this.title,
      this.onPressed,
      this.hiddenTitle = false,
      this.leftBtnText = '取消',
      this.rightBtnText = '确定',
      @required this.child,
      this.cancelPressed})
      : super(key: key);

  final String title;
  final VoidCallback onPressed;
  final VoidCallback cancelPressed;
  final Widget child;
  final bool hiddenTitle;
  final String leftBtnText;
  final String rightBtnText;

  @override
  _BaseDialogState createState() => _BaseDialogState();
}

class _BaseDialogState extends State<BaseDialog> {
  bool _isClickBtn = true;
  @override
  Widget build(BuildContext context) {
    final Widget dialogTitle = Visibility(
      visible: !widget.hiddenTitle,
      child: Padding(
          padding: EdgeInsets.only(left: 23.w, bottom: 8.0.h, right: 10.w),
          child: Row(
            children: [
              Expanded(child: Container()),
              Text(
                widget.hiddenTitle ? '' : widget.title,
                style: TextStyles.textSize16,
              ),
              Expanded(child: Container()),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Image(
                    width: 14.w,
                    height: 14.h,
                    image: ImageUtils.getAssetImage("cancle"),
                  ),
                ),
              )
            ],
          )),
    );

    final Widget bottomButton = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _DialogButton(
          text: widget.leftBtnText,
          textColor: Colours.text_gray_c,
          onPressed: () {
            if (widget.cancelPressed == null) {
               NavigatorUtils.goBack(context);
            } else {
              if (_isClickBtn) {
                widget.cancelPressed();
                _isClickBtn = false;
                // 500 毫秒内 不能多次点击
                Future.delayed(Duration(milliseconds: 2000), () {
                  _isClickBtn = true;
                });
              }
            }
          },
        ),
        _DialogButton(
          text: widget.rightBtnText,
          textColor: Theme.of(context).primaryColor,
          onPressed: widget.onPressed,
        ),

        // const SizedBox(
        //   height: 48.0,
        //   width: ,
        //   child: VerticalDivider(),
        // ),
      ],
    );

    final Widget body = Material(
      borderRadius: BorderRadius.circular(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Gaps.vGap24,
          dialogTitle,
          Gaps.line,
          Center(
            child: widget.child,
          ),
          Gaps.vGap24,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
            child: bottomButton,
          ),
          Gaps.vGap20,
        ],
      ),
    );

    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets +
          EdgeInsets.symmetric(horizontal: 40.0.w, vertical: 24.0.h),
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeInCubic,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: SizedBox(
            width: double.infinity - 30.w,
            child: body,
          ),
        ),
      ),
    );
  }
}

class _DialogButton extends StatelessWidget {
  const _DialogButton({
    Key key,
    this.text,
    this.textColor,
    this.onPressed,
  }) : super(key: key);

  final String text;
  final Color textColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: 30.0.h,
        width: 100.w,
        decoration: BoxDecoration(
            color: textColor,
            borderRadius: BorderRadius.all(Radius.circular(10.w))),
        child: Text(
          text,
          style:
              const TextStyle(fontSize: Dimens.font_sp14, color: Colors.white),
        ),
      ),
    );
  }
}
