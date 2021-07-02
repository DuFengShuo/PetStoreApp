import 'package:flutter/foundation.dart';

class Constant {
  /// debug开关，上线需要关闭
  /// App运行在Release环境时，inProduction为true；当App运行在Debug和Profile环境时，inProduction为false
  static const bool inProduction = kReleaseMode;
  static const String debugUrl = 'http://172.31.3.209:8001/api/'; //开发环境
  static const String testUrl = 'http://172.31.3.209:8003/api/'; //测试环境
  static const String mastOnLineUrl = 'http://pre.api.myflashinfo.com/'; //预发布
  static const String onLineUrl = 'http://api.myflashinfo.com/'; //线上环境

  ///总api
  static const String baseUrl =
      kReleaseMode ? testUrl : mastOnLineUrl; //release包时为true

  ///是否对数据加密 kReleaseMode
  static const bool acceptDebug = kReleaseMode; //线上环境必须加密

  ///数据加密KEY
  static const String dataKey = '5vA6au7Z';

  ///是否登录状态
  static const String isLogin = 'isLogin';
  static const String checkboxSelected = 'checkboxSelected';

  static bool isDriverTest = false;
  static bool isUnitTest = false;

  static const String data = 'data';
  static const String message = 'message';
  static const String code = 'code';

  static const String keyGuide = 'keyGuide';
  static const String phone = 'phone';
  static const String accessToken = 'accessToken';
  static const String registerTime = 'registerTime';

  ///刷新token时间
  // static const String loginTime = 'loginTime';
  // static const String expiresIn = 'expires_in';

  static const String theme = 'AppTheme';
  static const String locale = 'locale';

  ///搜索历史记录
  static const String localList = 'localList'; //所有
  static const String localCompanyList = 'companyList'; //企业
  static const String localpersonnelList = 'personnelList'; //联系人
  static const String localproductList = 'productList'; //产品
  static const String localLeadsList = 'leadsList'; //商机

  ///版本信息
  static const String version = 'version';
  static const String userInfo = 'userInfo'; //用户信息
  static const String newsDashboard = 'newsDashboard'; //Dashboard新闻数据
  static const String recommendDashboard =
      'recommendDashboard'; //Dashboard推荐公司数据
  static const String companyDashboard = 'companyDashboard'; //Dashboard公司数据
  static const String personnelDashboard = 'personnelDashboard'; //Dashboard人员数据
  static const String productDashboard = 'productDashboard'; //Dashboard产品数据
}
