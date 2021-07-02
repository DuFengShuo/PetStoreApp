import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/widgets/icon_font.dart';

class ClickItem extends StatelessWidget {
  const ClickItem({
    Key key,
    this.onTap,
    @required this.title,
    this.content = '',
    this.textAlign = TextAlign.start,
    this.maxLines = 1,
    this.iconName = 0,
    this.iconColor,
    this.isBorder = false,
    this.subtitle = '',
    this.isBold = false,
  }) : super(key: key);

  final GestureTapCallback onTap;
  final String title;
  final String content;
  final TextAlign textAlign;
  final int maxLines;
  final int iconName;
  final Color iconColor;
  final bool isBorder;
  final String subtitle;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    Widget subText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyles.text.copyWith(
              fontWeight: isBold ? FontWeight.w500 : FontWeight.normal),
        ),
        Gaps.vGap2,
        Text(
          subtitle,
          style: Theme.of(context)
              .textTheme
              .subtitle2
              .copyWith(fontSize: Dimens.font_sp12),
        ),
      ],
    );

    Widget child = Row(
      //为了数字类文字居中
      crossAxisAlignment:
          maxLines == 1 ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: <Widget>[
        Visibility(
          visible: iconName == 0 ? false : true,
          child: Row(
            children: <Widget>[
              IconFont(name: iconName, size: 24.0.sp, color: iconColor),
              Gaps.hGap8,
            ],
          ),
        ),
        iconName == 0 ? Gaps.empty : Gaps.hGap12,
        subtitle.isEmpty
            ? Text(
                title,
                style: TextStyles.text.copyWith(
                    fontWeight: isBold ? FontWeight.w500 : FontWeight.normal,
                    color: onTap == null ? Colours.text_gray_c : Colours.text),
              )
            : subText,
        const Spacer(),
        Expanded(
          flex: 4,
          child: Text(
            content,
            maxLines: maxLines,
            textAlign: maxLines == 1 ? TextAlign.right : textAlign,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .subtitle2
                .copyWith(fontSize: Dimens.font_sp14),
          ),
        ),
        Gaps.hGap8,
        Opacity(
          // 无点击事件时，隐藏箭头图标
          opacity: onTap == null ? 0 : 1,
          child: Padding(
            padding: EdgeInsets.only(top: maxLines == 1 ? 0.0 : 2.0),
            child: Images.arrowRight,
          ),
        )
      ],
    );

    /// 分隔线
    child = Container(
      margin: EdgeInsets.only(left: 16.0.w),
      padding: EdgeInsets.fromLTRB(0, 5.0.h, 15.0.w, 5.0.h),
      constraints: BoxConstraints(
        maxHeight: double.infinity,
        minHeight: 50.0.h,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom:
              Divider.createBorderSide(context, width: isBorder ? 0.0 : 0.6),
        ),
      ),
      child: child,
    );

    return InkWell(
      onTap: onTap,
      child: child,
    );
  }
}
