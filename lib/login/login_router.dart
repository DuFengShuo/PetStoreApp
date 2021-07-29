import 'package:fluro/fluro.dart';
import 'package:local_life_app/doctor/doctor_login/doctor_one_page.dart';
import 'package:local_life_app/login/page/phone_fast_login_page.dart';
import 'package:local_life_app/routers/i_router.dart';

import 'page/area_code_page.dart';
import 'page/sms_login_page.dart';

class LoginRouter implements IRouterProvider {
  static String loginPage = '/login';
  static String registerPage = '/login/register';
  static String smsLoginPage = '/login/smsLogin';
  static String resetPasswordPage = '/login/resetPassword';
  static String updatePasswordPage = '/login/updatePassword';
  static String areaCodePage = '/login/areaCode';
  static String phoneOneKeyPage = '/login/phoneOneKeyPage';

  static String doctorOne = '/doctorOne';
  @override
  void initRouter(FluroRouter router) {
    router.define(smsLoginPage,
        handler: Handler(handlerFunc: (_, __) => SMSLoginPage()));
    router.define(areaCodePage,
        handler: Handler(handlerFunc: (_, __) => AreaCodePage()));
    router.define(phoneOneKeyPage,
        handler: Handler(handlerFunc: (_, __) => PhoneOneKeyLoginPage()));

    router.define(doctorOne,
        handler: Handler(handlerFunc: (_, __) => DoctorOnePage()));
  }
}
