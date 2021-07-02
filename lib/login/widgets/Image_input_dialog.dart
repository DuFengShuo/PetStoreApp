import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_life_app/login/iview/login_iview.dart';
import 'package:local_life_app/login/presenter/login_presenter.dart';
import 'package:local_life_app/login/provider/login_page_provider.dart';
import 'package:local_life_app/mvp/base_page.dart';
import 'package:local_life_app/mvp/power_presenter.dart';
import 'package:local_life_app/res/gaps.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/util/theme_utils.dart';
import 'package:local_life_app/util/toast_utils.dart';
import 'package:local_life_app/widgets/base_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../routers/fluro_navigator.dart';

class ImageInputDialog extends StatefulWidget {
  const ImageInputDialog({
    Key key,
    this.title,
    this.inputMaxImage = 100000,
    this.onImgPressed,
    this.imageBase64,
    this.phoneString = '',
    this.provider,
    this.areaCode,
  }) : super(key: key);

  final String imageBase64;
  final String title;
  final double inputMaxImage;
  final Function(bool) onImgPressed;
  final String phoneString;
  final LoginPageProvider provider;
  final String areaCode;

  @override
  _ImageInputDialog createState() => _ImageInputDialog();
}

class _ImageInputDialog extends State<ImageInputDialog>
    with BasePageMixin<ImageInputDialog, PowerPresenter>
    implements SmsLoginIMvpView {
  final TextEditingController _controller = TextEditingController();
  String imageBase64 = '';
  @override
  LoginPageProvider provider = LoginPageProvider();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    provider = widget.provider;
    imageBase64 = widget.imageBase64;
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: widget.title,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Gaps.vGap10,
          InkWell(
            onTap: () async {
              final Map<String, String> params = <String, String>{};
              params['account'] = widget.phoneString;
              await _smsLoginPresenter.captchaImage(params);
            },
            child: imageBase64.isNotEmpty
                ? Image.memory(Base64Decoder().convert(imageBase64))
                : Gaps.empty,
          ),
          Gaps.vGap10,
          Container(
            height: 34.0.h,
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(16.0.w, 8.0.h, 16.0.w, 0.0),
            decoration: BoxDecoration(
              color: ThemeUtils.getDialogTextFieldColor(context),
              borderRadius: BorderRadius.circular(2.0),
            ),
            child: TextField(
              key: const Key('Image_input'),
              autofocus: true,
              controller: _controller,
              maxLines: 1,
              maxLength: 8,
              //style: TextStyles.textDark14,
              keyboardType: TextInputType.visiblePassword,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp('[\u4e00-\u9fa5]')),
              ],
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0.w),
                border: InputBorder.none,
                hintText: 'Please enter the ${widget.title}',
                counterText: '',
                hintStyle: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(fontSize: Dimens.font_sp15.sp),
                //hintStyle: TextStyles.textGrayC14,
              ),
            ),
          )
        ],
      ),
      onPressed: () async {
        if (_controller.text.trim().isEmpty) {
          Toast.show('Please enter the ${widget.title}');
          return;
        }
        final Map<String, String> params = <String, String>{};
        params['captcha_image_key'] = provider.captchaImageBean.captchaImageKey;
        params['captcha_image_code'] = _controller.text.trim().toString();
        params['area_code'] = widget.areaCode;
        await _smsLoginPresenter.captchaSms(params);
      },
    );
  }

  SmsLoginPresenter _smsLoginPresenter;
  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _smsLoginPresenter = SmsLoginPresenter();
    powerPresenter.requestPresenter([_smsLoginPresenter]);
    return powerPresenter;
  }

  @override
  void showHintDialog(String base64Img) {
    setState(() {
      imageBase64 = base64Img;
      provider = widget.provider;
    });
  }

  @override
  void setSemSuccess(bool onSuccess) async {
    if (onSuccess) {
      NavigatorUtils.goBack(context);
      widget.onImgPressed(true);
    } else {
      final Map<String, String> params = <String, String>{};
      params['account'] = widget.phoneString;
      await _smsLoginPresenter.captchaImage(params);
    }
  }
}
