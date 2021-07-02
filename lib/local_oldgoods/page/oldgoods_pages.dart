import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:local_life_app/local_discount/iview/dicount_iview.dart';
import 'package:local_life_app/local_oldgoods/iview/oldgoods_iview.dart';
import 'package:local_life_app/local_oldgoods/presenter/oldgoods_presenter.dart';
import 'package:local_life_app/mvp/base_page.dart';
import 'package:local_life_app/mvp/power_presenter.dart';
import 'package:local_life_app/provider/base_list_provider.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/util/device_utils.dart';
import 'package:local_life_app/util/screen_utils.dart';
import 'package:local_life_app/widgets/Layout/state_layout.dart';
import 'package:provider/provider.dart';

class OldGoodsPage extends StatefulWidget {
  OldGoodsPage({Key key}) : super(key: key);

  @override
  _OldGoodsPageState createState() => _OldGoodsPageState();
}

class _OldGoodsPageState extends State<OldGoodsPage>
    with
        AutomaticKeepAliveClientMixin<OldGoodsPage>,
        BasePageMixin<OldGoodsPage, PowerPresenter>
    implements OldGoodsIView {
  @override
  BaseListProvider<dynamic> oldGoodsListProvider = BaseListProvider<dynamic>();

  OldGoodsPresenter _oldPresenter;

  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _oldPresenter = OldGoodsPresenter();

    powerPresenter.requestPresenter([_oldPresenter]);
    return powerPresenter;
  }

  @override
  void initState() {
    super.initState();
    if (Device.isAndroid || Device.isIOS) {
      //首页事件
      // _sendAnalyticsEvent();
    }
    oldGoodsListProvider.setStateTypeNotNotify(StateType.listLayout);
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
            create: (_) => oldGoodsListProvider),
      ],
      child: Consumer<BaseListProvider<dynamic>>(
        builder: (_, companyListProvider, __) {
          return
            oldGoodsListProvider.stateType==StateType.listLayout?StateLayout(type: StateType.listLayout):
            RefreshIndicator(
              displacement: 5,
              onRefresh: _oldPresenter.onRefresh,
              color: Theme.of(context).primaryColor,
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return StaggeredGridView.countBuilder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.only(left: 8,right: 8,top: 4,bottom: 4),
                    crossAxisCount: 4,
                    itemCount: companyListProvider.list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return new GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                              ///背景装饰 ,特别注意设置阴影的时候，container不能设置颜色
                              borderRadius:
                                  new BorderRadius.all(Radius.elliptical(5, 5)),
                              gradient: RadialGradient(
                                  //背景径向渐变
                                  colors: [Colors.white, Colors.white],
                                  center: Alignment.topLeft,
                                  radius: 5),
                              boxShadow: [
                                //卡片阴影
                                BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(2.0, 2.0),
                                    blurRadius: 8.0)
                              ]),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ClipRRect(
                                //剪裁为圆角矩形
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5)),
                                child: Image.network(
                                  oldGoodsListProvider.list[index],
                                  height: 120 *
                                      ((Screen.width(context) / 2 - 12) / 100),
                                  width: Screen.width(context)/2,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              new Container(
                                  padding: EdgeInsets.only(left: 5,top: 5),
                                  child: new Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Text(
                                        "介绍费电视卡法撒旦",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyles.textBold13.copyWith(color: Colors.black,fontWeight: FontWeight.w400),
                                      ),
                                      new Container(
                                        padding: EdgeInsets.only(
                                            top: 10.0, bottom: 10.0),
                                        child: new Row(
                                          children: <Widget>[
                                            new Expanded(
                                              child: new Row(
                                                children: <Widget>[
                                                  new CircleAvatar(
                                                    radius: 12.0,
                                                    backgroundImage:
                                                        NetworkImage(
                                                      oldGoodsListProvider
                                                          .list[index],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10,
                                                              right: 5),
                                                      child: new Text(
                                                        "我是晓东",
                                                        style: TextStyles
                                                            .textBold12,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      );
                    },
                    staggeredTileBuilder: (int index) =>
                        new StaggeredTile.fit(2),
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                  );
                },
                itemCount: 20,
              ));
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
