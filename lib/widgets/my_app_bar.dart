import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_life_app/res/colors.dart';
import 'package:local_life_app/res/dimens.dart';
import 'package:local_life_app/res/gaps.dart';
import 'package:local_life_app/util/theme_utils.dart';
import 'package:local_life_app/widgets/icon_font.dart';
import 'package:local_life_app/widgets/my_button.dart';

/// 自定义AppBar
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar(
      {Key key,
      this.backgroundColor,
      this.title = '',
      this.centerTitle = '',
      this.actionName = '',
      this.backImg = 'assets/images/ic_back_black.png',
      this.onPressed,
      this.isBack = true,
      this.backOnPressed})
      : super(key: key);

  final Color backgroundColor;
  final String title;
  final String centerTitle;
  final String backImg;
  final String actionName;
  final VoidCallback onPressed;
  final bool isBack;
  final VoidCallback backOnPressed;

  @override
  Widget build(BuildContext context) {
    Color _backgroundColor;

    if (backgroundColor == null) {
      _backgroundColor = context.backgroundColor;
    } else {
      _backgroundColor = backgroundColor;
    }

    final SystemUiOverlayStyle _overlayStyle =
        ThemeData.estimateBrightnessForColor(_backgroundColor) ==
                Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark;

    final Widget back = isBack
        ? IconButton(
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              if (backOnPressed == null) {
                Navigator.maybePop(context);
              } else {
                backOnPressed();
              }
            },
            tooltip: 'Back',
            padding: const EdgeInsets.all(12.0),
            icon: IconFont(
                name: 0xe613,
                size: 16.sp,
                color: ThemeUtils.getIconColor(context))
            // Image.asset(
            //   backImg,
            //   color: ThemeUtils.getIconColor(context),
            // ),

            )
        : Gaps.empty;

    final Widget action = actionName.isNotEmpty
        ? Positioned(
            right: 0.0,
            child: Theme(
              data: Theme.of(context).copyWith(
                buttonTheme: const ButtonThemeData(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  minWidth: 60.0,
                ),
              ),
              child: MyButton(
                key: const Key('actionName'),
                fontSize: Dimens.font_sp14,
                minWidth: null,
                text: actionName,
                textColor:
                    context.isDark ? Colours.dark_text : Colours.app_main,
                backgroundColor: Colors.transparent,
                onPressed: onPressed,
              ),
            ),
          )
        : Gaps.empty;

    final Widget titleWidget = Semantics(
      namesRoute: true,
      header: true,
      child: Container(
        alignment:
            centerTitle.isEmpty ? Alignment.centerLeft : Alignment.center,
        width: double.infinity,
        child: Text(
          title.isEmpty ? centerTitle : title,
          maxLines: 1,
          style: const TextStyle(
            fontSize: Dimens.font_sp18,
            fontWeight: FontWeight.bold,
          ),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 48.0),
      ),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _overlayStyle,
      child: Material(
        color: _backgroundColor,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              titleWidget,
              back,
              action,
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48.0);
}
