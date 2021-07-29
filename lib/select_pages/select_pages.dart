import 'package:flutter/material.dart';
import 'package:local_life_app/res/resources.dart';
class SelectPages extends StatefulWidget {
  const SelectPages({Key key}) : super(key: key);

  @override
  _SelectPagesState createState() => _SelectPagesState();
}

class _SelectPagesState extends State<SelectPages> {
  List datas = ["单选","多选",];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.app_main,
        brightness: Brightness.dark,
        centerTitle: true,
        title: Text(
          "选择",
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
