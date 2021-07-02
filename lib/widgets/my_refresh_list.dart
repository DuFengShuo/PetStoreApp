import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:local_life_app/res/resources.dart';

import 'Layout/state_layout.dart';

/// 封装下拉刷新与加载更多
class DeerListView extends StatefulWidget {
  const DeerListView({
    Key key,
    @required this.itemCount,
    @required this.itemBuilder,
    @required this.onRefresh,
    this.loadMore,
    this.hasMore = false,
    this.stateType = StateType.empty,
    this.pageSize = 10,
    this.childLayout,
  }) : super(key: key);

  final RefreshCallback onRefresh;
  final LoadMoreCallback loadMore;
  final int itemCount;
  final bool hasMore;
  final IndexedWidgetBuilder itemBuilder;
  final StateType stateType;
  final Widget childLayout;

  /// 一页的数量，默认为20
  final int pageSize;

  @override
  _DeerListViewState createState() => _DeerListViewState();
}

typedef RefreshCallback = Future<void> Function();
typedef LoadMoreCallback = Future<void> Function();

class _DeerListViewState extends State<DeerListView> {
  /// 是否正在加载数据
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: widget.itemCount == 0
          ? (widget.childLayout != null
              ? widget.childLayout
              : StateLayout(
                  type: widget.stateType, onRefresh: widget.onRefresh))
          : EasyRefresh(
              // header: ClassicalHeader(
              //     extent: 50,
              //     triggerDistance: 50,
              //
              //     refreshText: "下拉刷新",
              //     refreshReadyText: "松开刷新",
              //     refreshingText: "刷新中...",
              //     refreshedText: "刷新成功",
              //     refreshFailedText: "刷新失败",
              //     textColor: Colours.text,
              //     // infoText: "更新于",
              //     showInfo: false,
              //     //infoColor: Colours.app_main
              // ),
              footer: ClassicalFooter(
                  infoColor: Colours.app_main,
                  loadingText: "努力加载中...",
                  loadReadyText: "上拉加载",
                  loadFailedText: "加载失败",
                  showInfo: false),
              header: BallPulseHeader(
                  color: Colours.app_main
              ),
              // footer: BallPulseFooter(
              //   color: Colours.app_main
              // ),
              onRefresh: widget.onRefresh,
              onLoad: widget.hasMore
                  ? () async {
                      await _loadMore();
                    }
                  : null,
              child: ListView.builder(
                  padding: EdgeInsets.only(
                    top: 4,
                  ),
                  itemCount: widget.itemCount,
                  itemBuilder: (BuildContext context, int index) {
                    return widget.itemBuilder(context, index);
                    // if (widget.loadMore == null) {
                    //
                    // } else {
                    //   return index < widget.itemCount
                    //       ? widget.itemBuilder(context, index)
                    //       : MoreWidget(widget.itemCount, widget.hasMore,
                    //           widget.pageSize);
                    //}
                  }),
              // slivers: <Widget>[
              //   SliverList(
              //
              //     delegate: SliverChildBuilderDelegate(
              //       (context, index) {
              //         /// 不需要加载更多则不需要添加FootView
              //         if (widget.loadMore == null) {
              //           return widget.itemBuilder(context, index);
              //         } else {
              //           return index < widget.itemCount
              //               ? widget.itemBuilder(context, index)
              //               : MoreWidget(widget.itemCount, widget.hasMore,
              //                   widget.pageSize);
              //         }
              //       },
              //       childCount: widget.loadMore == null
              //           ? widget.itemCount
              //           : widget.itemCount + 1,
              //     ),
              //   ),
              // ],
            ),
    );
  }

  Future<void> _loadMore() async {
    if (widget.loadMore == null) {
      return;
    }
    if (_isLoading) {
      return;
    }
    if (!widget.hasMore) {
      return;
    }
    _isLoading = true;
    await widget.loadMore();
    _isLoading = false;
  }
}

class MoreWidget extends StatelessWidget {
  const MoreWidget(this.itemCount, this.hasMore, this.pageSize);

  final int itemCount;
  final bool hasMore;
  final int pageSize;

  @override
  Widget build(BuildContext context) {
    final TextStyle style = const TextStyle(color: Color(0x8A000000));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // if (hasMore) const CupertinoActivityIndicator(),
          // if (hasMore) Gaps.hGap5,

          /// 只有一页的时候，就不显示FooterView了
          Text(
              hasMore
                  ? ''
                  : (itemCount % pageSize > 0
                      ? 'Oops, no more information!'
                      : ''),
              style: style),
        ],
      ),
    );
  }
}
