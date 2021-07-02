import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/util/input_formatter/number_text_input_formatter.dart';

/// 封装输入框

class TextFieldItem extends StatefulWidget {
  const TextFieldItem({
    Key key,
    this.controller,
    @required this.title,
    this.keyboardType = TextInputType.text,
    this.hintText = '',
    this.focusNode,
    this.isEnable = true,
  }) : super(key: key);

  final TextEditingController controller;
  final String title;
  final String hintText;
  final TextInputType keyboardType;
  final FocusNode focusNode;
  final bool isEnable;

  @override
  _TextFieldItemState createState() => _TextFieldItemState();
}

class _TextFieldItemState extends State<TextFieldItem> {
  bool isGart = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      isGart = widget.controller.text.isEmpty ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Column child = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          widget.title,
          style: isGart
              ? TextStyles.textBlo.copyWith(fontSize: Dimens.font_sp15.sp)
              : Theme.of(context)
                  .textTheme
                  .subtitle2
                  .copyWith(fontSize: Dimens.font_sp15.sp),
        ),
        TextField(
          enabled: widget.isEnable,
          focusNode: widget.focusNode,
          keyboardType: widget.keyboardType,
          inputFormatters: _getInputFormatters(),
          controller: widget.controller,
          style: TextStyles.textBlo.copyWith(fontSize: Dimens.font_sp15.sp),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: Theme.of(context)
                .textTheme
                .subtitle2
                .copyWith(fontSize: Dimens.font_sp15.sp),
            border: InputBorder.none, //去掉下划线
            //hintStyle: TextStyles.textGrayC14
          ),
          onChanged: (value) {
            setState(() {
              isGart = value.isEmpty ? true : false;
            });
          },
        ),
      ],
    );

    return Container(
      height: 68.0.h,
      margin: EdgeInsets.only(top: 10.0.h),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: Divider.createBorderSide(context, width: 0.6.h),
        ),
      ),
      child: child,
    );
  }

  List<TextInputFormatter> _getInputFormatters() {
    if (widget.keyboardType ==
        const TextInputType.numberWithOptions(decimal: true)) {
      return <TextInputFormatter>[UsNumberTextInputFormatter()];
    }
    if (widget.keyboardType == TextInputType.number ||
        widget.keyboardType == TextInputType.phone) {
      return <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly];
    }
    return null;
  }
}
