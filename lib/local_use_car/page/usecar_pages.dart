import 'package:flutter/material.dart';
import 'package:local_life_app/local_use_car/iview/local_use_car_cell.dart';
import 'package:local_life_app/local_use_car/iview/usecar_iview.dart';
import 'package:local_life_app/local_use_car/presenter/usecar_presenter.dart';
import 'package:local_life_app/mvp/base_page.dart';
import 'package:local_life_app/mvp/power_presenter.dart';
import 'package:local_life_app/provider/base_list_provider.dart';
import 'package:local_life_app/util/device_utils.dart';
import 'package:local_life_app/widgets/Layout/state_layout.dart';
import 'package:local_life_app/widgets/my_refresh_list.dart';
import 'package:provider/provider.dart';

class UseCarPage extends StatefulWidget {
  UseCarPage({Key key}) : super(key: key);

  @override
  _UseCarPageState createState() => _UseCarPageState();
}

class _UseCarPageState extends State<UseCarPage>
    with
        AutomaticKeepAliveClientMixin<UseCarPage>,
        BasePageMixin<UseCarPage, PowerPresenter>
    implements UseCarIview {
  @override
  BaseListProvider<dynamic> useCarListProvider =
  BaseListProvider<dynamic>();

  UseCarPresenter _useCarPresenter;

  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _useCarPresenter = UseCarPresenter();

    powerPresenter.requestPresenter([_useCarPresenter]);
    return powerPresenter;
  }


  @override
  void initState() {
    super.initState();
    if (Device.isAndroid || Device.isIOS) {
      //首页事件
      // _sendAnalyticsEvent();
    }
    useCarListProvider.setStateTypeNotNotify(StateType.listLayout);
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
            create: (_) => useCarListProvider),
      ],
      child: Consumer<BaseListProvider<dynamic>>(
        builder: (_, useCarListProvider, __) {
          return DeerListView(
              key: const Key('company_list'),
              itemCount: useCarListProvider.list.length,
              stateType: useCarListProvider.stateType,
              onRefresh: _useCarPresenter.onRefresh,
              // loadMore: _recommendPresenter.loadMore,
              hasMore: false,
              itemBuilder: (_, index) {
                // CompanyModel model = companyListProvider.list[index];
                return LocalCarCellWidget();
              });
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;


}
