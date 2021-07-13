import 'package:flutter/material.dart';
import 'package:local_life_app/res/resources.dart';
class TextFieldPages extends StatefulWidget {
  const TextFieldPages({Key key}) : super(key: key);

  @override
  _TextFieldPagesState createState() => _TextFieldPagesState();
}

class _TextFieldPagesState extends State<TextFieldPages> {
  List datas = ["密码输入","文字输入","数字输入","输入效果"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.app_main,
        brightness: Brightness.dark,
        centerTitle: true,
        title: Text(
          "输入选择",
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
