import 'package:local_life_app/provider/base_list_provider.dart';
import 'package:local_life_app/mvp/mvps.dart';

abstract class RecommendIview implements IMvpView {
  BaseListProvider<dynamic> get companyListProvider;
}
