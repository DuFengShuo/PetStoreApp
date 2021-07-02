import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/util/theme_utils.dart';
import 'package:local_life_app/widgets/icon_font.dart';
import 'package:local_life_app/widgets/linearGradient_button.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'load_image.dart';

/// 搜索页的AppBar

class SearchBar extends StatefulWidget implements PreferredSizeWidget {
  const SearchBar(
      {Key key,
      this.hintText = 'Search',
      this.backImg = 'assets/images/ic_back_black.png',
      this.onPressed,
      this.onChanged,
      this.defaultTextSubject,
      this.leftTitle = '',
      this.btnLeftTitle,
      this.isShowLedtMenu = false})
      : super(key: key);
  final String backImg; //返回图片
  final String hintText; //输入框提示
  final Function(String) onPressed; //键盘回车键
  final Function(String) onChanged; //监听输入框
  final PublishSubject<String> defaultTextSubject; //输入框订阅

  final String leftTitle;
  final Function btnLeftTitle;
  final bool isShowLedtMenu;
  @override
  _SearchBarState createState() => _SearchBarState();

  @override
  Size get preferredSize => const Size.fromHeight(48.0);
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.defaultTextSubject != null) {
      widget.defaultTextSubject.listen((value) {
        _controller.text = value;
      });
    }
  }

  @override
  void dispose() {
    _focus.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final Color iconColor = Colours.text_gray_c;

    final Widget back = Semantics(
      label: '返回',
      child: SizedBox(
        width: 48.0.w,
        height: 48.0.h,
        child: InkWell(
          onTap: () {
            _focus.unfocus();
            Navigator.maybePop(context);
          },
          borderRadius: BorderRadius.circular(24.0),
          child: Padding(
              key: const Key('search_back'),
              padding: const EdgeInsets.all(12.0),
              child: IconFont(
                  name: 0xe613,
                  size: 16.sp,
                  color: ThemeUtils.getIconColor(context))),
        ),
      ),
    );

    final Widget textField = Expanded(
      child: Container(
        height: 36.0,
        decoration: BoxDecoration(
          color: Colours.bg_gray,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: TextField(
          key: const Key('search_text_field'),
//          autofocus: true,
          controller: _controller,
          focusNode: _focus,
          maxLines: 1,
          textInputAction: TextInputAction.search,
          onSubmitted: (String val) {
            _focus.unfocus();
            // 点击软键盘的动作按钮时的回调
            widget.onPressed(val);
          },
          onChanged: (value) {
            //内容变化事件
            widget.onChanged(value);
          },

          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
                top: 0.0, left: -8.0.w, right: 5.0.w, bottom: 14.0),
            border: InputBorder.none,
            icon: Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0.w),
              child: SizedBox(
                width: widget.leftTitle.length * 8.sp + 48.w,
                child: Row(
                  children: [
                    InkWell(
                      onTap: widget.btnLeftTitle,
                      child: Text(
                        widget.leftTitle,
                        style: TextStyles.textSize13
                            .copyWith(color: Colours.app_main),
                      ),
                    ),
                    Gaps.hGap4,
                    IconFont(
                        name: widget.isShowLedtMenu ? 0xe632 : 0xe633,
                        size: 6.sp,
                        color: Colours.app_main),
                    Gaps.hGap12,
                    Container(
                      width: 1.5.w,
                      height: 12.0.h,
                      color: Color(0xff9FA5B4),
                    ),
                    Gaps.hGap8,
                    LoadAssetImage(
                      'search/order_search',
                      width: 18.w,
                      height: 18.h,
                      color: iconColor,
                    ),
                  ],
                ),
              ),
            ),
            hintText: widget.hintText,
            hintStyle: Theme.of(context).textTheme.subtitle2,
          ),
        ),
      ),
    );

    final Widget search = InkWell(
      onTap: () {
        /// https://github.com/flutter/flutter/issues/35848
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _controller.text = '';
          widget.onChanged('');
        });
      },
      child: LinearGradientButton(
        height: 28.0.h,
        width: 64.w,
        text: "Close",
        textSize: 14.0.sp,
        textColor: Colors.white,
        leftGradientColor: Colours.app_main,
        rightGradientColor: Colours.app_main_light,
        borderRadius: 6.w,
        shadowColor: Colours.material_bg,
        paddingTop: 0.0,
        paddingBottom: 0.0,
        marginLeft: 0,
        marginRight: 0,
      ),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:  SystemUiOverlayStyle.dark,
      child: Material(
        color: context.backgroundColor,
        child: SafeArea(
          child: Row(
            children: <Widget>[
              back,
              textField,
              // Gaps.hGap8,
              // search,
              Gaps.hGap16,
            ],
          ),
        ),
      ),
    );
  }
}
