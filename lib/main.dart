import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jpush/flutter_jpush.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_life_app/common/common.dart';
import 'package:local_life_app/home/home_list_page.dart';
import 'package:local_life_app/util/device_utils.dart';
import 'package:local_life_app/util/log_utils.dart';
import 'package:local_life_app/util/sp_utils.dart';
import 'package:oktoast/oktoast.dart';
import 'package:local_life_app/routers/routers.dart';
import 'package:provider/provider.dart';
import 'package:local_life_app/net/intercept.dart';
import 'package:local_life_app/net/dio_utils.dart';
import 'package:local_life_app/provider/locale_provider.dart';
import 'package:local_life_app/provider/theme_provider.dart';
import 'package:local_life_app/provider/user_info_provider.dart';
import 'package:local_life_app/routers/not_found_page.dart';
import 'package:local_life_app/home/splash_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  runApp(MyApp());
  if (Device.isAndroid) {
    //透明状态栏
    const SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}




class MyApp extends StatelessWidget {
  MyApp({this.home, this.theme}) {
    Log.init();
    initDio();
    Routes.initRoutes();
    jpshLession();

  }
  void _startupJpush() async {
    print("初始化jpush");
    await FlutterJPush.startup();
    print("初始化jpush成功");
  }

  // _initFluwx() async {
  //   await registerWxApi(
  //       appId: "wxd930ea5d5a258f4f",
  //       doOnAndroid: true,
  //       doOnIOS: true,
  //       universalLink: "https://your.univerallink.com/link/");
  //   var result = await isWeChatInstalled;
  //   print("is installed $result");
  // }
  // //微信支付分享等
  // _register() async {
  //   bool result = await SyFlutterWechat.register('wxf9909bde17439ac2');
  //   print(result);
  // }
  void jpshLession(){
    FlutterJPush.addConnectionChangeListener((bool connected) {
      print("连接状态改变:$connected");
      // setState(() {
      //   /// 是否连接，连接了才可以推送
      //   print("连接状态改变:$connected");
      //   this.isConnected = connected;
      //   if (connected) {
      //     FlutterJPush.getRegistrationID().then((String regId) {
      //       print("主动获取设备号:$regId");
      //       setState(() {
      //         this.registrationId = regId;
      //       });
      //     });
      //   }
      // });
    });

    FlutterJPush.addnetworkDidLoginListener((String registrationId) {
      print("收到设备号:$registrationId");
      // setState(() {
      //   /// 用于推送
      //   print("收到设备号:$registrationId");
      //   this.registrationId = registrationId;
      // });
    });

    FlutterJPush.addReceiveNotificationListener(
            (JPushNotification notification) {
              print("收到推送提醒: $notification");
          // setState(() {
          //   /// 收到推送
          //   print("收到推送提醒: $notification");
          //   notificationList.add(notification);
          // });
        });

    FlutterJPush.addReceiveOpenNotificationListener(
            (JPushNotification notification) {
              print("打开了推送提醒: $notification");
          // setState(() {
          //   print("打开了推送提醒: $notification");
          //
          //   /// 打开了推送提醒
          //   notificationList.add(notification);
          // });
        });

    FlutterJPush.addReceiveCustomMsgListener((JPushMessage msg) {
      print("收到推送消息提醒: $msg");
      // setState(() {
      //   print("收到推送消息提醒: $msg");
      //
      //   /// 打开了推送提醒
      //   notificationList.add(msg);
      // });
    });
  }



  final Widget home;
  final ThemeData theme;

  void initDio() {
    final List<Interceptor> interceptors = <Interceptor>[];

    /// 统一添加身份验证请求头
    interceptors.add(AuthInterceptor());

    /// 刷新Token
    interceptors.add(TokenInterceptor());

    /// 打印Log(生产模式去除)
    if (!Constant.inProduction) {
      interceptors.add(LoggingInterceptor());
    }

    /// 适配数据(根据自己的数据结构，可自行选择添加)
    interceptors.add(AdapterInterceptor());
    configDio(
      baseUrl: Constant.baseUrl,
      interceptors: interceptors,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget app = MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => UserInfoProvider()),
      ],
      child: Consumer3<ThemeProvider, LocaleProvider, UserInfoProvider>(
        builder: (_, ThemeProvider provider, LocaleProvider localeProvider,
            UserInfoProvider userInfoProvider, __) {
          return _buildMaterialApp(provider, localeProvider);
        },
      ),
    );
   _startupJpush();//注册极光推送
    /// Toast 配置
    return OKToast(
        child: app,
        backgroundColor: Colors.black54,
        textPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        radius: 20.0,
        position: ToastPosition.bottom);
  }

  Widget _buildMaterialApp(
      ThemeProvider provider, LocaleProvider localeProvider) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      // allowFontScaling: false,

      builder: () => MaterialApp(

        title: 'LocalLife',
        // showPerformanceOverlay: true, //
        // 显示性能标签
        debugShowCheckedModeBanner: false, // 去除右上角debug的标签
        // checkerboardRasterCacheImages: true,
        // showSemanticsDebugger: true, // 显示语义视图
        // checkerboardOffscreenLayers: true, // 检查离屏渲染
        // navigatorObservers: <NavigatorObserver>[observer], //加入google路由统计
        theme: theme ?? provider.getTheme(),
        darkTheme: provider.getTheme(isDarkMode: true),
        themeMode: provider.getThemeMode(),
        // home: home ?? SplashPage(),
        home: HomeListPage(),
        onGenerateRoute: Routes.router.generator,
        supportedLocales: localeProvider.supportedLocales,
        locale: localeProvider.locale,
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        builder: (BuildContext context, Widget child) {
          /// 保证文字大小不受手机系统设置影响 https://www.kikt.top/posts/flutter/layout/dynamic-text/
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child,
          );
        },

        /// 因为使用了fluro，这里设置主要针对Web
        onUnknownRoute: (_) {
          return MaterialPageRoute<void>(
            builder: (BuildContext context) => NotFoundPage(),
          );
        },
      ),
    );
  }
}
