import 'package:fluro/fluro.dart';
import 'package:local_life_app/routers/i_router.dart';
import 'package:local_life_app/mine/mine_info.dart';

class MineRouter implements IRouterProvider {
  static String mineInfo = '/mineInfo';
  // static String registerPage = '/login/register';
  // static String smsLoginPage = '/login/smsLogin';
  // static String resetPasswordPage = '/login/resetPassword';
  // static String updatePasswordPage = '/login/updatePassword';
  // static String areaCodePage = '/login/areaCode';

  @override
  void initRouter(FluroRouter router) {
    router.define(mineInfo,
        handler: Handler(handlerFunc: (_, __) => MineInfo("18801114226")));
    // router.define(areaCodePage,
    //     handler: Handler(handlerFunc: (_, __) => AreaCodePage()));
  }
}
