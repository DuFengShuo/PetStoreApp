import 'package:flutter/material.dart';
import 'package:local_life_app/res/resources.dart';
class TabPages extends StatefulWidget {
  const TabPages({Key key}) : super(key: key);

  @override
  _TabPagesState createState() => _TabPagesState();
}

class _TabPagesState extends State<TabPages> {
  List datas = ["顶部","底部",];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.app_main,
        brightness: Brightness.dark,
        centerTitle: true,
        title: Text(
          "Tab效果",
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
