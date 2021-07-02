import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/widgets/load_image.dart';


class MySearchWidget extends StatelessWidget {
  final Function callBack;
  final type;
  const MySearchWidget({Key key, @required this.callBack, this.type})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        // onTap: ()=> Navigator.push(context, animation_route(SearchPage())),
        onTap: () => this.callBack(),
        child: Container(
          alignment: Alignment.centerLeft,
          width: double.infinity,
          height: 32.h,
          decoration: BoxDecoration(
            color: Colours.search_bg,
            borderRadius: BorderRadius.all(Radius.circular(17.r)),
          ),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: SizedBox(
                  width: 14.w,
                  height: 14.w,
                  child: LoadAssetImage(
                    'search/order_search',
                    color: Colours.unselected_item_color,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w),
                child: Text(
                  "搜索你想要的功能",
                  style: TextStyles.textGray12,
                ),
              ),
            ],
          ),
        ));
  }
}
