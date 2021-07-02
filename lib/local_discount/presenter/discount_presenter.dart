import 'package:flutter/material.dart';
import 'package:local_life_app/local_discount/iview/dicount_iview.dart';
import 'package:local_life_app/mvp/base_page_presenter.dart';
import 'package:local_life_app/local_recommend/iview/recommend_iview.dart';
import 'package:local_life_app/res/colors.dart';
import 'package:local_life_app/res/resources.dart';
class DiscountPresenter extends BasePagePresenter<Discountview> {
  int page = 1;
  List datas = ["333","afasrasdd","dfasfasdf","asdfasd","333","afasrasdd","dfasfasdf","asdfasd","333","afasrasdd","dfasfasdf","asdfasd"];
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
       List datas = ["333","afasrasdd","dfasfasdf","asdfasd","333","afasrasdd","dfasfasdf","asdfasd","333","afasrasdd","dfasfasdf","asdfasd"];
       view.discountListProvider.clear();
       view.discountListProvider.addAll(datas);
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

  // void showAchievementView(BuildContext context){
  //   AchievementView(
  //       context,
  //       title: "本地头条引擎已有199条更新!",
  //     //  subTitle: "",
  //
  //       //onTab: _onTabAchievement,
  //       //icon: Icon(Icons.insert_emoticon, color: Colors.white,),
  //       //typeAnimationContent: AnimationTypeAchievement.fadeSlideToUp,
  //       borderRadius: 25.0,
  //       color: Colours.bg_gray,
  //       textStyleTitle: TextStyles.textSize12.copyWith(color: Colours.text),
  //       //textStyleSubTitle: TextStyle(),
  //       //alignment: Alignment.topCenter,
  //       duration: Duration(seconds: 1),
  //       isCircle: false,
  //       listener: (status){
  //         print(status);
  //         //AchievementState.opening
  //         //AchievementState.open
  //         //AchievementState.closing
  //         //AchievementState.closed
  //       }
  //   )..show();
  // }

  //公司下拉刷新
  Future<void> onRefresh() async {
    view.discountListProvider.clear();
    view.discountListProvider.addAll(datas);
    // showAchievementView(view.getContext());
    // Scaffold.of(view.getContext()).showSnackBar(//不能直接在Scaffold里使用
    //     SnackBar(
    //       content: Text('已为您刷新99条数据！'),
    //       action: SnackBarAction(
    //        // label: "关闭",
    //         onPressed: (){
    //           print('撤回');
    //         },
    //       ),
    //     )
    // );
  }

  //公司上拉加载
  Future loadMore() async {
    page++;
    await  Future.delayed(Duration(seconds: 2), () async {
      List addDatas = ["addOne","addTwo","dfasfasdf","asdfasd","333","afasrasdd","dfasfasdf","asdfasd","333","dfa","dfasfasdf","bbbb"];
      // view.oldGoodsListProvider.clear();
      // datas.addAll(addDatas);
      await view.discountListProvider.addAll(addDatas);
    });

  }
}
