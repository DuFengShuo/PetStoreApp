import 'package:flutter/material.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListAnimationLayout extends StatelessWidget {
  const ListAnimationLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
      itemBuilder: (_, __) {
        return Shimmer.fromColors(
          baseColor: Colours.bg_layout,
          highlightColor: Colours.bg_layout_f5,
          child: AnimationItem(),
        );
      },
    );
  }
}

class AnimationItem extends StatelessWidget {
  const AnimationItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity - 20,
      height: 160.0.h,
      margin: EdgeInsets.only(top: 5.h, bottom: 5.h, left: 10, right: 10),
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Color(0x80DCE7FA), offset: const Offset(0.0, 2.0), blurRadius: 8.0, spreadRadius: 0.0),
        ],
      ),
      child: Row(
        children: [
          // Gaps.hGap16,
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 13.0.h,
                  width: double.infinity,
                  color: Colours.bg_layout),
              Container(
                  height: 10.0.h, width: 200.0.w, color: Colours.bg_layout),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      height: 80.0.h, width: 80.0.w, color: Colours.bg_layout),
                  Container(
                      height: 80.0.h, width: 80.0.w, color: Colours.bg_layout),
                  Container(
                      height: 80.0.h, width: 80.0.w, color: Colours.bg_layout),
                ],
              ),

              Container(
                  height: 13.0.h,
                  width: double.infinity,
                  color: Colours.bg_layout),
              // Container(
              //     height: 10.0.h, width: 200.0.w, color: Colours.bg_layout),
            ],
          ))
        ],
      ),
    );
  }
}
