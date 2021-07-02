import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:local_life_app/center/send_input_page.dart';
import 'package:local_life_app/center/widget/select_cell.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/widgets/my_button.dart';
class SendYhWidget extends StatefulWidget {
  const SendYhWidget({Key key}) : super(key: key);

  @override
  _SendYhWidgetState createState() => _SendYhWidgetState();
}

class _SendYhWidgetState extends State<SendYhWidget> {

  // final TextEditingController _titleController = TextEditingController();
  // final TextEditingController _contentController = TextEditingController();
  // final FocusNode _nodeText1 = FocusNode();
  // final FocusNode _nodeText2 = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand, //未定位widget占满Stack整个空间
          children: <Widget>[
            SingleChildScrollView(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Column(
                  //动态创建一个List<Widget>
                  children: <Widget>[
                    new TextFieldWidget(
                      "标题",
                      "请输入标题",

                    ),

                    TextFieldWidget(
                      "介绍",
                      "请输入介绍",

                    ),
//              new GestureDetector(
//                onTap: () => showSelectServiceBottom(context, jyData,"单位"),
//                child: SwitchCell("单位", "${_jyType}"),
//              ),
//                       new GestureDetector(
//                         // onTap: () => Navigator.push(
//                         //     context, animation_route(SelectHouseTagPage()))
//                         //     .then((value) {
//                         //   if (value != null) {
//                         //     setState(() {
//                         //       __houseTig = value;
//                         //     });
//                         //   }
//                         // }),
//                         child: SwitchCell("房产标签", "${__houseTig}"),
//                       ),
                    TextFieldWidget(
                      "地址",
                      "请输地址",

                    ),

                    TextFieldWidget(
                      "联系电话",
                      "请输联系电话",

                    ),

                  ],
                ),
              ),
            ),
            // Positioned(
            //   bottom: 0,
            //   child: Container(
            //     width: ScreenUtil.getScreenW(context),
            //     height: 60,
            //     decoration: new BoxDecoration(
            //       boxShadow: [BoxShadow(color: Colours.line, blurRadius: 20.0)],
            //       color: Colors.white,
            //     ),
            //     child: Padding(
            //       padding: const EdgeInsets.only(
            //           left: 10, right: 10, top: 10, bottom: 10),
            //       child: MyButton(
            //         minHeight: 40,
            //         fontSize: 14,
            //         textColor: Colours.material_bg,
            //         onPressed: () {},
            //         backgroundColor: Colours.app_main,
            //         text: "发布",
            //       ),
            //     ),
            //   ),
            // )
          ]),
    );
  }
}
