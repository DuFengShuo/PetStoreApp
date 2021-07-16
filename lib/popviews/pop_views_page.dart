import 'package:flutter/material.dart';
import 'package:local_life_app/center/widget/select_sendcontent_widget.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopViewPages extends StatefulWidget {
  const PopViewPages({Key key}) : super(key: key);

  @override
  _PopViewPagesState createState() => _PopViewPagesState();
}

class _PopViewPagesState extends State<PopViewPages> {
  List datas = ["底部弹出","顶部弹出","中间提示框",];

  showSelectServiceBottom(BuildContext context, List data, String title) {
    showModalBottomSheet(
      //带背景的弹框
        backgroundColor: Colors.transparent, //重点
        context: context,
        builder: (BuildContext context) {
          return new Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              //  padding: EdgeInsets.only(top: 20, bottom: 10),
               height: 340.0.h,
              child: SelectSendContentWidget(
                datas: data,
                title: title,
                callBack: (result) {
                  print("===$result===");
                },
              ));
        });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.app_main,
        brightness: Brightness.dark,
        centerTitle: true,
        title: Text(
          "弹出效果",
          style: TextStyles.textSize16,
        ),
      ),
      body: ListView.separated(
          itemCount: datas.length,
          separatorBuilder: (BuildContext context,int index){
            return Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Gaps.line,
            );
          },
          itemBuilder: (BuildContext context, int index) {
            return
              InkWell(
                splashColor: Colours.dark_text_disabled,
                onTap: (){
                  switch(index){
                    case 0:
                      showSelectServiceBottom(context, ["one","two","three"], "底部弹出单选");
                      return;
                    case 1:
                      showSelectServiceBottom(context, ["one","two","three"], "底部弹出单选");
                      return;
                  }
                },
                child:  ListTile(
                  contentPadding: EdgeInsets.only(left: 20),
                  title: Text(
                    "${datas[index]}",
                    style: TextStyles.text,
                  ),
                  trailing: Icon(Icons.navigate_next_outlined,color: Colours.text,),

                ) ,
              );


          }),
    );
  }
}
