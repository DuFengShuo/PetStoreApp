import 'package:flutter/material.dart';
import 'package:local_life_app/local_use_car/iview/usecar_iview.dart';
import 'package:local_life_app/mvp/base_page_presenter.dart';

class UseCarPresenter extends BasePagePresenter<UseCarIview> {
  int _page = 1;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        // await getLocal();
        //
        await getRecommendList();
      },
    );
  }

  // Future getLocal() async {
  //   if (view.companyListProvider.list == null ||
  //       view.companyListProvider.list.length == 0) {
  //     RecommendBean recommendBean = await SpUtil.getObj(
  //         Constant.recommendDashboard, (v) => RecommendBean.fromJson(v),
  //         defValue: null);
  //     if (recommendBean != null) {
  //       view.companyListProvider.clear();
  //       view.companyListProvider.addAll(recommendBean.companyList);
  //     }
  //   }
  // }
  //
  //请求数据
   getRecommendList() async {
     await  Future.delayed(Duration(seconds: 2), () {
       List datas = ["dsf","afasd","fasdf"];
       view.useCarListProvider.clear();
       view.useCarListProvider.addAll(datas);
     });
  }
  //
  // //请求数据
  // Future getRecommendList(int page, bool isShows) async {
  //   return await requestNetwork<RecommendBean>(Method.get,
  //       url: HttpApi.recommends,
  //       queryParameters: {"page": page},
  //       isShow: isShows, onSuccess: (RecommendBean bean) async {
  //         if (bean.companyList != null) {
  //           view.companyListProvider
  //               .setHasMore(bean.meta.pagination.pagCount == 20);
  //           if (page == 1) {
  //             if (bean.companyList.isEmpty) {
  //               view.companyListProvider.setStateType(StateType.company);
  //             } else {
  //               await SpUtil.putObject(Constant.recommendDashboard, bean);
  //               view.companyListProvider.clear();
  //               view.companyListProvider.addAll(bean.companyList);
  //             }
  //           } else {
  //             view.companyListProvider.addAll(bean.companyList);
  //           }
  //         } else {
  //           /// 加载失败
  //           view.companyListProvider.setHasMore(false);
  //           view.companyListProvider.setStateType(StateType.company);
  //         }
  //       }, onError: (_, __) {
  //         view.companyListProvider.setHasMore(false);
  //         view.companyListProvider.setStateType(StateType.company);
  //       });
  // }

  //公司下拉刷新
  Future<void> onRefresh() async {
    List datas = ["333","afasrasdd","dfasfasdf","asdfasd","333","afasrasdd","dfasfasdf","asdfasd","333","afasrasdd","dfasfasdf","asdfasd"];
    view.useCarListProvider.clear();
    view.useCarListProvider.addAll(datas);
  }

  //公司上拉加载
  Future loadMore() async {
    List datas = ["333","afasrasdd","dfasfasdf","asdfasd","333",];
    view.useCarListProvider.clear();
    view.useCarListProvider.addAll(datas);
  }
}
