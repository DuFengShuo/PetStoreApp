import 'package:flutter/material.dart';
import 'package:local_life_app/doctor/doctor_home/scae_list_page.dart';
import 'package:local_life_app/login/models/icons_bean.dart';
import 'package:local_life_app/res/colors.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/util/screen_utils.dart';
import 'package:local_life_app/widgets/my_app_bar.dart';
import 'package:local_life_app/widgets/my_card.dart';
import 'package:local_life_app/widgets/my_refresh_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorHomeListPage extends StatefulWidget {
  const DoctorHomeListPage({Key key}) : super(key: key);

  @override
  _DoctorHomeListPageState createState() => _DoctorHomeListPageState();
}

class _DoctorHomeListPageState extends State<DoctorHomeListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.card_2e,
      appBar: AppBar(
        title: Text("卡片列表",style: TextStyles.textBold18.copyWith(color: Colours.material_bg),),
        backgroundColor: Colours.card_2e,
        actions: [
           IconButton(icon:   Text("退出",style: TextStyles.textSize13.copyWith(color: Colours.text_gray),), onPressed: (){}),


        ],
      ),
      body: DeerListView(
          itemCount: 10,

          itemBuilder: (BuildContext contex, int index) {
            return

              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ScaeListPage();
                      },
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(left: 15.w,right: 15.w,bottom: 10.h),
                  decoration: BoxDecoration(
                      color: Colours.card_bg
                  ),
                  height: 85.h,
                  width: Screen.width(context),
                  child: Row(
                    children: [
                      Gaps.hGap12,
                      Icon(Icons.local_hospital,color: Colours.colour_b4ff,size:50,),
                      Gaps.hGap12,
                      Text("名字$index",style: TextStyles.textSize16.copyWith(color: Colours.material_bg)),
                      Expanded(child: Gaps.empty),
                      Icon(Icons.navigate_next,color: Colours.bg_layout_f5,),
                      Gaps.hGap12,
                    ],
                  ),
                ),
              )
              ;
          },
          onRefresh: () async {}),
    );
  }
}
