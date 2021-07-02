import 'package:flutter/material.dart';
import 'package:local_life_app/local_use_car/iview/local_use_car_cell.dart';
import 'package:local_life_app/local_use_car/page/usecar_pages.dart';
import 'package:local_life_app/local_work/iview/local_work_cell.dart';
import 'package:local_life_app/local_work/iview/local_work_iview.dart';
import 'package:local_life_app/local_work/presenter/local_work_presenter.dart';
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

class LocalWorkPage extends StatefulWidget {
  LocalWorkPage({Key key}) : super(key: key);

  @override
  _LocalWorkPageState createState() => _LocalWorkPageState();
}

class _LocalWorkPageState extends State<LocalWorkPage>
    with
        AutomaticKeepAliveClientMixin<LocalWorkPage>,
        BasePageMixin<LocalWorkPage, PowerPresenter>
    implements LocalWorkIview {
  @override
  BaseListProvider<dynamic> companyListProvider =
  BaseListProvider<dynamic>();

  LocalWorkPresenter _recommendPresenter;

  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _recommendPresenter = LocalWorkPresenter();

    powerPresenter.requestPresenter([_recommendPresenter]);
    return powerPresenter;
  }


  @override
  void initState() {
    super.initState();
    if (Device.isAndroid || Device.isIOS) {
      //首页事件
      // _sendAnalyticsEvent();
    }
    companyListProvider.setStateTypeNotNotify(StateType.listLayout);
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
            create: (_) => companyListProvider),
      ],
      child: Consumer<BaseListProvider<dynamic>>(
        builder: (_, companyListProvider, __) {
          return DeerListView(
              key: const Key('company_list'),
              itemCount: companyListProvider.list.length,
              stateType: companyListProvider.stateType,
              onRefresh: _recommendPresenter.onRefresh,
              // loadMore: _recommendPresenter.loadMore,
              hasMore: false,
              itemBuilder: (_, index) {
                // CompanyModel model = companyListProvider.list[index];
                  return LocalWorkCellWidget();

              });
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;


}
