import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:local_life_app/common/common.dart';
import 'package:local_life_app/login/iview/login_iview.dart';
import 'package:local_life_app/login/models/area_code_model.dart';
import 'package:local_life_app/login/models/user_bean.dart';
import 'package:local_life_app/login/presenter/login_presenter.dart';
import 'package:local_life_app/login/provider/login_page_provider.dart';
import 'package:local_life_app/login/widgets/Image_input_dialog.dart';
import 'package:local_life_app/mvp/base_page.dart';
import 'package:local_life_app/mvp/power_presenter.dart';
import 'package:local_life_app/net/net.dart';
import 'package:local_life_app/provider/user_info_provider.dart';
import 'package:local_life_app/res/dimens.dart';
import 'package:local_life_app/util/change_notifier_manage.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/routers/fluro_navigator.dart';
import 'package:local_life_app/util/device_utils.dart';
import 'package:local_life_app/util/global_eventbus.dart';
import 'package:local_life_app/util/sp_utils.dart';
import 'package:local_life_app/util/toast_utils.dart';
import 'package:local_life_app/util/other_utils.dart';
import 'package:local_life_app/widgets/icon_font.dart';
import 'package:local_life_app/widgets/my_app_bar.dart';
import 'package:local_life_app/widgets/my_button.dart';
import 'package:local_life_app/widgets/my_scroll_view.dart';
import 'package:local_life_app/login/widgets/my_text_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../login_router.dart';
import 'package:local_life_app/util/screen_utils.dart';

/// design/1注册登录/index.html#artboard4
class SMSLoginPage extends StatefulWidget {
  @override
  _SMSLoginPageState createState() => _SMSLoginPageState();
}

class _SMSLoginPageState extends State<SMSLoginPage>
    with
        ChangeNotifierMixin<SMSLoginPage>,
        BasePageMixin<SMSLoginPage, PowerPresenter>
    implements LoginIMvpView, SmsLoginIMvpView {
  @override
  final LoginPageProvider provider = LoginPageProvider();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _vCodeController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  bool _clickable = false;
  bool _checkboxSelected = false;
  String _areaCode = '1';
  bool _sendSmsCode = false;
  @override
  Map<ChangeNotifier, List<VoidCallback>> changeNotifier() {
    final List<VoidCallback> callbacks = <VoidCallback>[_verify];
    return <ChangeNotifier, List<VoidCallback>>{
      _phoneController: callbacks,
      _vCodeController: callbacks,
      _nodeText1: null,
      _nodeText2: null,
    };
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _checkboxSelected =
            SpUtil.getBool(Constant.checkboxSelected, defValue: false);
      });
    });
  }

  void _verify() {
    final String name = _phoneController.text;
    final String vCode = _vCodeController.text;
    bool clickable = true;
    if (!_checkboxSelected) {
      clickable = false;
    }
    if (!_sendSmsCode) {
      clickable = false;
    }
    if (name.isEmpty) {
      clickable = false;
    }
    if (vCode.isEmpty || vCode.length < 4) {
      clickable = false;
    }else{
      clickable = true;
    }


    if (clickable != _clickable) {
      setState(() {
        _clickable = clickable;
      });
    }
  }

  @override
  void setUser(UserBean user) {
    context.read<UserInfoProvider>().setUserModel(user);
    SpUtil.putString(Constant.phone, _phoneController.text);
    NavigatorUtils.goBack(context);
    GlobalEventBus().event.fire('login');
  }

  void _login() async {
    if (!_sendSmsCode) {
      showToast('请获取验证码！');
      return;
    }
    final Map<String, String> params = <String, String>{};
    params['captcha_key'] = provider?.captchaSmsBean?.captchaSmsKey ?? '';
    params['code'] = _vCodeController.text ?? '';
    params['account'] = _phoneController.text;
    params['area_code'] = _areaCode;
    // await _loginPresenter.mobileLogin(params);
    await SpUtil.putString(Constant.phone, _phoneController.text);
    Navigator.pop(context,"${_phoneController.text}");
  }

  void _launchWebURL(String title, String url) {
    var uels = Constant.baseUrl.replaceAll('api/', '') + url;
    if (Device.isMobile) {
      NavigatorUtils.goWebViewPage(context, title, uels);
    } else {
      Utils.launchWebURL(url);
    }
  }

  @override
  void dispose() {
    super.dispose();
    provider.smsSubject?.close();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginPageProvider>(
      create: (_) => provider,
      child: Scaffold(
        appBar: const MyAppBar(
          isBack: true,
        ),
        body: MyScrollView(
          keyboardConfig: Utils.getKeyboardActionsConfig(
              context, <FocusNode>[_nodeText1, _nodeText2]),
          padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 25.0.h),
          children: _buildBody(),
        ),
      ),
    );
  }

  List<Widget> _buildBody() {
    return <Widget>[
      Text(
       "登录",
        style: TextStyle(
          fontSize: 28.0.sp,
          fontWeight: FontWeight.bold,
          color: Colours.app_main,
        ),
      ),
      Gaps.vGap40,
      Text(
        '手机号',
        style:
            Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 15.0.sp),
      ),
      Row(
        children: [
          // InkWell(
          //   onTap: () {
          //     NavigatorUtils.pushResult(context, LoginRouter.areaCodePage,
          //         (Object result) {
          //       final AreaCodeModel model = result as AreaCodeModel;
          //       setState(() {
          //         _areaCode = model.code.toString();
          //       });
          //     });
          //   },
          //   child: Container(
          //     decoration: BoxDecoration(
          //       border: Border(
          //         bottom: Divider.createBorderSide(context, width: 0.8),
          //       ),
          //     ),
          //     width: 60.0.w,
          //     height: 50.0.h,
          //     // child: Row(
          //     //   children: [
          //     //     Text(_areaCode),
          //     //     Gaps.hGap4,
          //     //     IconFont(name: 0xe61a, size: 6.0.w, color: Colours.text),
          //     //   ],
          //     // ),
          //   ),
          // ),
          ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: context.width - 40.0.w,
                minHeight: 50.h,
                maxHeight: 50.h),
            child: MyTextField(
              focusNode: _nodeText1,
              controller: _phoneController,
              maxLength: 11,
              keyboardType: TextInputType.phone,
              hintText: "请输入手机号",
            ),
          )
        ],
      ),
      Gaps.vGap24,
      Text(
        '验证码',
        style:
            Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 15.0.sp),
      ),
      Consumer<LoginPageProvider>(builder: (_, provider, __) {
        return MyTextField(
          key: const Key('vcode'),
          focusNode: _nodeText2,
          controller: _vCodeController,
          keyboardType: TextInputType.number,
          provider: provider,
          getVCode: () async {
            final String name = _phoneController.text;
            if (name.isEmpty) {
              Toast.show("手机号为空");
              return Future<bool>.value(false);
            } else {
              // Toast.show(AppLocalizations.of(context).verificationButton);
              /// 一般可以在这里发送真正的请求，请求成功返回true
              final Map<String, String> params = <String, String>{};
              params['account'] = _phoneController.text;
              _sendSmsCode = true;
               // await _smsLoginPresenter.captchaImage(params);
              return true;
            }
          },
          maxLength: 4,
          hintText: "验证码",
        );
      }),
      Gaps.vGap50,
      Gaps.vGap10,
      MyButton(
        onPressed: _clickable ? _login : null,
        text: "立即登录",
        fontSize: Dimens.font_sp13,
        textColor: Colours.material_bg,
        disabledBackgroundColor: Colours.app_main_light,

      ),
      Gaps.vGap10,
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 25,
            height: 25,
            child: InkWell(
              onTap: () async {
                setState(() {
                  _checkboxSelected = !_checkboxSelected;
                });
                await SpUtil.putBool(
                    Constant.checkboxSelected, _checkboxSelected);
                _verify();
              },
              child: IconFont(
                  name: _checkboxSelected ? 0xe61b : 0xe61c,
                  size: 13.sp,
                  color: Colours.app_main),
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: RichText(
              maxLines: 2,
              text: TextSpan(
                text: '登录注册代表同意',
                style: Theme.of(context).textTheme.subtitle2,
                children: <TextSpan>[
                  TextSpan(
                    text: '《用户协议》',
                    style: TextStyle(color: Theme.of(context).errorColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        _launchWebURL('User agreement', HttpApi.treatyTerms);
                      },
                  ),
                  TextSpan(text: '和'),
                  TextSpan(
                    text: '《隐私政策》',
                    style: TextStyle(color: Theme.of(context).errorColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        _launchWebURL('User agreement', HttpApi.privacyPolicy);
                      },
                  ),
                  TextSpan(text: Utils.getCurrLocale() == 'zh' ? '。' : '.'),
                ],
              ),
            ),
          ))
        ],
      ),
    ];
  }

  LoginPresenter _loginPresenter;
  SmsLoginPresenter _smsLoginPresenter;
  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _loginPresenter = LoginPresenter();
    _smsLoginPresenter = SmsLoginPresenter();
    // powerPresenter.requestPresenter([_loginPresenter, _smsLoginPresenter]);
    return powerPresenter;
  }

  @override
  void showHintDialog(String base64Img) {
    showElasticDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ImageInputDialog(
          phoneString: _phoneController.text,
          title: 'Picture verification code',
          imageBase64: base64Img,
          provider: provider,
          areaCode: _areaCode,
          onImgPressed: (value) async {
            _sendSmsCode = value;
            _verify();
          },
        );
      },
    );
  }

  @override
  void setSemSuccess(bool onSuccess) async {
    _sendSmsCode = onSuccess;
  }
}
