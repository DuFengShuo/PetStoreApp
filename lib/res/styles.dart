import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors.dart';
import 'dimens.dart';

class TextStyles {
  static TextStyle textSize10 = TextStyle(
    fontSize: Dimens.font_sp10.sp,
  );
  static TextStyle textSize11 = TextStyle(
    fontSize: Dimens.font_sp11.sp,
  );
  static TextStyle textSize12 = TextStyle(
    fontSize: Dimens.font_sp12.sp,
  );
  static TextStyle textSize13 = TextStyle(
    fontSize: Dimens.font_sp13.sp,
  );
  static TextStyle textSize16 = TextStyle(
    fontSize: Dimens.font_sp16.sp,
  );
  static TextStyle textSize20 = TextStyle(
    fontSize: Dimens.font_sp20.sp,
  );
  static TextStyle textBold12 = TextStyle(
    fontSize: Dimens.font_sp12.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle textBold13 = TextStyle(
    fontSize: Dimens.font_sp13.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle textBold14 = TextStyle(
    fontSize: Dimens.font_sp14.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle textBold15 =
      TextStyle(fontSize: Dimens.font_sp15.sp, fontWeight: FontWeight.bold);
  static TextStyle textBold16 = TextStyle(
    fontSize: Dimens.font_sp16.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle textBold18 = TextStyle(
    fontSize: Dimens.font_sp18.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle textBold20 = TextStyle(
    fontSize: Dimens.font_sp20.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle textBold24 = TextStyle(
    fontSize: 24.0.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle textBold26 = TextStyle(
    fontSize: 26.0.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle textBold28 = TextStyle(
    fontSize: 28.0.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle textWhite14 = TextStyle(
    fontSize: Dimens.font_sp14.sp,
    color: Colors.white,
  );

  static TextStyle text = TextStyle(
      fontSize: Dimens.font_sp14.sp,
      color: Colours.text,

      // https://github.com/flutter/flutter/issues/40248
      textBaseline: TextBaseline.alphabetic);
  static TextStyle textBlo = TextStyle(
      fontSize: Dimens.font_sp14.sp,
      color: Colours.text,
      fontWeight: FontWeight.w500);
  static TextStyle textDark = TextStyle(
    fontSize: Dimens.font_sp15.sp,
    color: Colours.dark_text,
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle textGray12 = TextStyle(
    fontSize: Dimens.font_sp12.sp,
    color: Colours.text_gray,
    fontWeight: FontWeight.normal,
  );
  static TextStyle textDarkGray12 = TextStyle(
    fontSize: Dimens.font_sp12.sp,
    color: Colours.dark_text_gray,
    fontWeight: FontWeight.normal,
  );
  static TextStyle textGray14 = TextStyle(
    fontSize: Dimens.font_sp14.sp,
    color: Colours.text_gray,
    fontWeight: FontWeight.normal,
  );
  static TextStyle textDarkGray14 = TextStyle(
    fontSize: Dimens.font_sp14.sp,
    color: Colours.dark_text_gray,
    fontWeight: FontWeight.normal,
  );
  static TextStyle textDarkGray16 = TextStyle(
    fontSize: Dimens.font_sp16.sp,
    color: Colours.dark_text_gray,
    fontWeight: FontWeight.normal,
  );
  static TextStyle textHint14 = TextStyle(
    fontSize: Dimens.font_sp14.sp,
    color: Colours.dark_unselected_item_color,
  );
}
