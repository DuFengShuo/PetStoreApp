import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:local_life_app/home/home_router.dart';
import 'package:local_life_app/login/login_router.dart';
import 'package:local_life_app/mine/mine_router.dart';
import 'package:local_life_app/widgets/webview_page.dart';
import 'package:local_life_app/routers/not_found_page.dart';
// ignore: avoid_classes_with_only_static_members
import 'package:local_life_app/home/home_page.dart';
import 'package:local_life_app/routers/i_router.dart';
class Routes {
  static String home = '/home';
  static String webViewPage = '/webView';
  //
  static final List<IRouterProvider> _listRouter = [];

  static final FluroRouter router = FluroRouter();

  static void initRoutes() {
    /// 指定路由跳转错误返回页
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      debugPrint('未找到目标页');
      return NotFoundPage();
    });

    router.define(home,
        handler: Handler(
            handlerFunc:
                (BuildContext context, Map<String, List<String>> params) =>
                HomePage()));

    router.define(webViewPage, handler: Handler(handlerFunc: (_, params) {
      final String title = params['title']?.first;
      final String url = params['url']?.first;
      return WebViewPage(title: title, url: url);
    }));

    _listRouter.clear();

    // 各自路由由各自模块管理，统一在此添加初始化
    _listRouter.add(LoginRouter());

    _listRouter.add(MineRouter());
    _listRouter.add(HomeRouter());
    /// 初始化路由
    _listRouter.forEach((routerProvider) {
      routerProvider.initRouter(router);
    });
  }
}
