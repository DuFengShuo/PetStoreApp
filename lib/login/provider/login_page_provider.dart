import 'package:flutter/material.dart';
import 'package:local_life_app/login/models/captcha_image_bean.dart';
import 'package:local_life_app/login/models/captcha_sms_bean.dart';
import 'package:rxdart/rxdart.dart';

class LoginPageProvider extends ChangeNotifier {
  // ignore: close_sinks
  PublishSubject<bool> _smsSubject = PublishSubject<bool>();
  PublishSubject get smsSubject => _smsSubject;

  // bool _sendSmsCode = false;
  // bool get sendSmsCode => _sendSmsCode;

  // void setSendSmsCode(bool sendSmsCode) {
  //   _sendSmsCode = sendSmsCode;
  //   notifyListeners();
  // }

  CaptchaImageBean _captchaImageBean;
  CaptchaImageBean get captchaImageBean => _captchaImageBean;
  setCaptchaImageBean(CaptchaImageBean captchaImageBean) {
    _captchaImageBean = captchaImageBean;
    notifyListeners();
  }

  CaptchaSmsBean _captchaSmsBean;
  CaptchaSmsBean get captchaSmsBean => _captchaSmsBean;
  setCaptchaSmsBean(CaptchaSmsBean captchaSmsBean) {
    _captchaSmsBean = captchaSmsBean;
    notifyListeners();
  }
}
