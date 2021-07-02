
import 'package:flutter/material.dart';
import 'package:local_life_app/local_discount/iview/dicount_iview.dart';
import 'package:local_life_app/local_discount/iview/discount_cell.dart';
import 'package:local_life_app/local_discount/presenter/discount_presenter.dart';
import 'package:local_life_app/local_use_car/iview/local_use_car_cell.dart';
import 'package:local_life_app/local_use_car/page/usecar_pages.dart';
import 'package:local_life_app/main_message/view/use_car_cell.dart';
import 'package:local_life_app/mvp/base_page.dart';
import 'package:local_life_app/provider/base_list_provider.dart';
import 'package:local_life_app/util/device_utils.dart';
import 'package:local_life_app/widgets/Layout/state_layout.dart';
import 'package:local_life_app/widgets/my_refresh_list.dart';
import 'package:provider/provider.dart';
import 'package:local_life_app/mvp/power_presenter.dart';
import 'package:local_life_app/local_recommend/iview/recommend_iview.dart';
import 'package:local_life_app/local_recommend/presenter/recommend_presenter.dart';
import 'package:local_life_app/local_recommend/iview/recommend_cell.dart';

class DiscountsPage extends StatefulWidget {
  DiscountsPage({Key key}) : super(key: key);

  @override
  _DiscountsPageState createState() => _DiscountsPageState();
}

class _DiscountsPageState extends State<DiscountsPage>
    with
        AutomaticKeepAliveClientMixin<DiscountsPage>,
        BasePageMixin<DiscountsPage, PowerPresenter>
    implements Discountview {
  @override
  BaseListProvider<dynamic> discountListProvider = BaseListProvider<dynamic>();

  DiscountPresenter _discountPresenter;

  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _discountPresenter = DiscountPresenter();

    powerPresenter.requestPresenter([_discountPresenter]);
    return powerPresenter;
  }



  @override
  void initState() {
    super.initState();
    if (Device.isAndroid || Device.isIOS) {
      //首页事件
      // _sendAnalyticsEvent();
    }
    discountListProvider.setStateTypeNotNotify(StateType.listLayout);
    WidgetsBinding.instance.addPostFrameCallback(
          (_) async {
        // GlobalEventBus().event.on<String>().listen((event) async {
        //   if (event == 'login' || event == "logout") {
        //     await _recommendPresenter.getRecommendList(1, true);
        //   }
        // });
      },
    );

  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BaseListProvider<dynamic>>(
            create: (_) => discountListProvider),
      ],
      child: Consumer<BaseListProvider<dynamic>>(
        builder: (_, discountListProvider, __) {
          return DeerListView(
              key: const Key('discount_list'),
              itemCount: discountListProvider.list.length,
              stateType: discountListProvider.stateType,
              onRefresh: _discountPresenter.onRefresh,
              loadMore: _discountPresenter.loadMore,
              pageSize: _discountPresenter.page,
              hasMore:true,
              itemBuilder: (_, index) {
                // CompanyModel model = companyListProvider.list[index];
                  return DiscountCellWidget();

              });
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;


}
