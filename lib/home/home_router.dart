import 'package:fluro/fluro.dart';
import 'package:local_life_app/home/home_search_page.dart';
import 'package:local_life_app/main_message/detail_page.dart';
import 'package:local_life_app/routers/i_router.dart';

class HomeRouter implements IRouterProvider {
  static String search = '/search';
  static String detail = '/detail';

  // static String registerPage = '/login/register';
  // static String smsLoginPage = '/login/smsLogin';
  // static String resetPasswordPage = '/login/resetPassword';
  // static String updatePasswordPage = '/login/updatePassword';
  // static String areaCodePage = '/login/areaCode';

  @override
  void initRouter(FluroRouter router) {
    router.define(search,
        handler: Handler(handlerFunc: (_, __) => HomeSearch()));
    router.define(detail,
        handler: Handler(handlerFunc: (_, __) => DetailsPage("详情", "介绍", )));
  }
}
