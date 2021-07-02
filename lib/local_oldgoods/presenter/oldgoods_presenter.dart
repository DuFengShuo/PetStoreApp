import 'package:flutter/material.dart';
import 'package:local_life_app/local_discount/iview/dicount_iview.dart';
import 'package:local_life_app/local_oldgoods/iview/oldgoods_iview.dart';
import 'package:local_life_app/mvp/base_page_presenter.dart';
import 'package:local_life_app/local_recommend/iview/recommend_iview.dart';
import 'package:local_life_app/widgets/Layout/state_layout.dart';
class OldGoodsPresenter extends BasePagePresenter<OldGoodsIView> {
  int _page = 1;
  List imgUrl = [
    "http://img.kaiyanapp.com/07e2d9c0ab6c5bb98649673f38fa1d23.png?imageMogr2/quality/60/format/jpg",
    "http://img.kaiyanapp.com/09a56fd20390dbb16e646573ec387de1.png?imageMogr2/quality/60/format/jpg",
    "http://img.kaiyanapp.com/0-c986cf4a0141fa9d60198d8a92290d7f.jpeg?imageMogr2/quality/60/format/jpg",
    "http://img.kaiyanapp.com/0-49d6c740a3378d24cb21fd714bb42ccf.jpeg?imageMogr2/quality/60/format/jpg",
    "http://img.kaiyanapp.com/0-1e1a8279772bd5cd722a09ebd589a35d.jpeg?imageMogr2/quality/60/format/jpg",
    "http://img.kaiyanapp.com/0-9492e0da2c172d65df352bce6d01583b.jpeg?imageMogr2/quality/60/format/jpg",
    "http://img.kaiyanapp.com/68441d5aa983978b3377acf2e4ed3c07.png?imageMogr2/quality/60/format/jpg",
    "http://img.kaiyanapp.com/09a56fd20390dbb16e646573ec387de1.png?imageMogr2/quality/60/format/jpg",
    "http://img.kaiyanapp.com/0-c986cf4a0141fa9d60198d8a92290d7f.jpeg?imageMogr2/quality/60/format/jpg",
    "http://img.kaiyanapp.com/0-49d6c740a3378d24cb21fd714bb42ccf.jpeg?imageMogr2/quality/60/format/jpg",
    "http://img.kaiyanapp.com/0-1e1a8279772bd5cd722a09ebd589a35d.jpeg?imageMogr2/quality/60/format/jpg",
    "http://img.kaiyanapp.com/0-9492e0da2c172d65df352bce6d01583b.jpeg?imageMogr2/quality/60/format/jpg",
    "http://img.kaiyanapp.com/68441d5aa983978b3377acf2e4ed3c07.png?imageMogr2/quality/60/format/jpg",
    "http://img.kaiyanapp.com/68441d5aa983978b3377acf2e4ed3c07.png?imageMogr2/quality/60/format/jpg",
  ];

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

  //请求数据
   getRecommendList() async {
     await  Future.delayed(Duration(seconds: 2), () {
       List datas = ["dsf","afasd","fasdf"];
       view.oldGoodsListProvider.clear();
       view.oldGoodsListProvider.addAll(imgUrl);
       view.oldGoodsListProvider.setStateType(StateType.empty);
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
   // List datas = ["333","afasrasdd","dfasfasdf","asdfasd","333","afasrasdd","dfasfasdf","asdfasd","333","afasrasdd","dfasfasdf","asdfasd"];
    view.oldGoodsListProvider.clear();
    view.oldGoodsListProvider.addAll(imgUrl);
  }

  //公司上拉加载
  Future loadMore() async {
    List datas = ["333","afasrasdd","dfasfasdf","asdfasd","333",];
    view.oldGoodsListProvider.clear();
    view.oldGoodsListProvider.addAll(datas);
  }
}
