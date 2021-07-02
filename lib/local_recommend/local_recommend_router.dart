import 'package:fluro/fluro.dart';
import 'package:local_life_app/routers/i_router.dart';


class RecommendRouter implements IRouterProvider {
  static String homeCompanyPage = '/homeCompanyPage';
  static String companyDetailPage = '/homeCompanyPage/companyDetail';

  @override
  void initRouter(FluroRouter router) {
    // router.define(companyDetailPage, handler: Handler(handlerFunc: (_, params) {
    //   // final String companyId = params['companyId']?.first;
    //   // final String name = params['name']?.first;
    //   // return CompanyDetailPage(companyId: companyId, name: name);
    // }));
  }
}
