import 'package:flutter/material.dart';
import 'package:local_life_app/doctor/doctor_login/doctor_pwd_login.dart';
import 'package:local_life_app/login/login_router.dart';
import 'package:local_life_app/login/page/paseword_login_page.dart';
import 'package:local_life_app/res/gaps.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/routers/fluro_navigator.dart';
import 'package:local_life_app/util/image_utils.dart';
import 'package:local_life_app/util/screen_utils.dart';
import 'package:local_life_app/widgets/my_app_bar.dart';
import 'package:local_life_app/widgets/my_button.dart';
import 'package:local_life_app/widgets/my_scroll_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorOnePage extends StatefulWidget {
  const DoctorOnePage({Key key}) : super(key: key);

  @override
  _DoctorOnePageState createState() => _DoctorOnePageState();
}

class _DoctorOnePageState extends State<DoctorOnePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.dark_bg_color,
      body: Container(
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
            image: DecorationImage(
                 fit: BoxFit.fill,
                image: ImageUtils.getAssetImage("doctor_one_bg"))),
        child: MyScrollView(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(height:340.h,width: Screen.width(context),),
            MyButton(
              backgroundColor: Colours.search_txt_bg,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return DoctorPwdLoginPage();
                    },
                  ),
                );
              },
              text: "我是医生",
              fontSize: 20,
              minWidth: 300.w,
              minHeight: 85.h,
              radius: 10.r,
            ),
            Gaps.vGap50,
            Gaps.vGap10,
            MyButton(
              backgroundColor: Colours.colour_3553,
              onPressed: () {},
              text: "我是用户",
              fontSize: 20,
              minWidth: 300.w,
              minHeight: 85.h,
              radius: 10.r,

            ),
          ],
        ),
      ),
    );
  }
}
