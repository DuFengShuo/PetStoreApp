import 'package:flutter/material.dart';
import 'package:local_life_app/doctor/doctor_login/doctor_pwd_login.dart';
import 'package:local_life_app/login/widgets/my_text_field.dart';
import 'package:local_life_app/res/gaps.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/util/image_utils.dart';
import 'package:local_life_app/util/screen_utils.dart';
import 'package:local_life_app/widgets/my_app_bar.dart';
import 'package:local_life_app/widgets/my_button.dart';
import 'package:local_life_app/widgets/my_scroll_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorSmsLoginPage extends StatefulWidget {
  const DoctorSmsLoginPage({Key key}) : super(key: key);

  @override
  _DoctorSmsLoginPageState createState() => _DoctorSmsLoginPageState();
}

class _DoctorSmsLoginPageState extends State<DoctorSmsLoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _vCodeController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colours.dark_bg_color,
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: ImageUtils.getAssetImage("doctor_one_bg"))),
        child: MyScrollView(
          crossAxisAlignment: CrossAxisAlignment.center,
          bottomButton: Container(
            height: 100.h,
            width: Screen.width(context),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                Column(
                  children: [
                    Icon(Icons.book,color: Colours.colour_3ec3,),
                    Gaps.vGap5,
                    Text("本地版登录",style: TextStyles.textSize16.copyWith(color: Colours.colour_3ec3),)
                  ],
                ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return DoctorPwdLoginPage();
                  },
                ),
              );
            },
            child:  Column(
                  children: [
                    Icon(Icons.perm_phone_msg,color: Colours.colour_3ec3,),
                    Gaps.vGap5,
                    Text("密码登录",style: TextStyles.textSize16.copyWith(color: Colours.colour_3ec3),)
                  ],
                ))
              ],
            ),
          ),
          children: [
            Container(
              height: 240.h,
              width: Screen.width(context),
            ),
            Container(
              padding: EdgeInsets.only(left: 15.w, right: 15.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  color: Colours.colour_3553),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: context.width - 60.0.w,
                  // minHeight: 40.h,
                  // maxHeight: 40.h,

                ),
                child: MyTextField(
                  focusNode: _nodeText2,
                  controller: _vCodeController,
                  maxLength: 33,
                  keyboardType: TextInputType.text,
                  // isInputPwd: true,
                  hintText: "用户名",
                ),
              ),
            ),
            Gaps.vGap32,
           Padding(
             padding:  EdgeInsets.only(left: 15.w,right: 15.w),
             child: Row(
               children: [
                 Container(
                   padding: EdgeInsets.only(left: 15.w, right: 15.w),
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.all(Radius.circular(10.r)),
                       color: Colours.colour_3553),
                   child: ConstrainedBox(
                     constraints: BoxConstraints(
                       maxWidth: context.width - 160.0.w,
                       // minHeight: 40.h,
                       // maxHeight: 40.h
                     ),
                     child: MyTextField(
                       focusNode: _nodeText1,
                       controller: _phoneController,
                       maxLength: 33,
                       keyboardType: TextInputType.visiblePassword,
                       isInputPwd: false,
                       hintText: "验证码",
                     ),
                   ),
                 ),
                 Gaps.hGap10,
                 Gaps.hGap10,
                 Text("获取验证码",style: TextStyles.textSize16.copyWith(color: Colours.colour_b4ff),overflow: TextOverflow.ellipsis,)
                 ,Expanded(child: Gaps.empty),
               ],
             ),
           ),

            Gaps.vGap50,
            Gaps.vGap10,
            Gaps.vGap10,
            Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15.w),
              child: MyButton(
                backgroundColor: Colours.search_txt_bg,
                onPressed: () {},
                text: "登录",
                radius: 10.r,

                fontSize: Dimens.font_sp16,
                textColor: Colours.material_bg,

                disabledBackgroundColor: Colours.app_main_light,
                minHeight: 50.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
