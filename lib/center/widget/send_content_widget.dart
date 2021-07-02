import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_life_app/center/send_input_page.dart';
import 'package:local_life_app/res/colors.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/widgets/base_dialog.dart';

class SendContentWidget extends StatefulWidget {
  const SendContentWidget({Key key}) : super(key: key);

  @override
  _SendContentWidgetState createState() => _SendContentWidgetState();
}

class _SendContentWidgetState extends State<SendContentWidget> {
  final FocusNode _nodeText1 = FocusNode();
  final TextEditingController _nameController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nodeText1.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
        // onPressed: () {
        //   if (_nameController.text.length > 0) {
        //     addGroupRequest(_nameController.text).then((value) {
        //       Toast.show("create success");
        //       Navigator.pop(context);
        //     });
        //   }
        // },
        cancelPressed: () {
          Navigator.pop(context);
        },
        // title: "",
        title: "请输入标题",
        // leftBtnText: "Done",
        // rightBtnText: "Cancel",
        child: Container(
          child: ListView(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              Container(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Gaps.vGap20,
                    Container(
                      // width: 200,
                        height: 40,
                        margin: EdgeInsets.only(left: 30, right: 30),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          //背景装饰
                          border: Border.all(
                              color: Colours.text_field_border,
                              width: 0.5,
                              style: BorderStyle.solid),
                        ),
                        child: CupertinoTextField(
                          focusNode: _nodeText1,
                          controller: _nameController,
                          onEditingComplete: () {
                            // widget.callBack(_nameController.text);
                            _nodeText1.unfocus();
                          },
                          style: TextStyle(fontSize: 12, color: Colours.text),
                          placeholder: "请输入标题",
                          maxLength: 14,
                          textAlign: TextAlign.left,
                          padding: EdgeInsets.only(left: 5),
                          placeholderStyle: TextStyle(
                            fontSize: 12,
                            color: Colours.text_gray_holder,
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.transparent,
                                style: BorderStyle.solid,
                                width: 1,
                              )),
                        )),
                    Gaps.vGap20,
                  ],
                ),
              )
            ],
          ),
        )

      // TagWidget(
      //   callBack: (value) {
      //     if (value != null && value.toString().length > 0) {
      //       WidgetsBinding.instance.addPostFrameCallback(
      //             (_) {
      //               if(value!=null){
      //                 print(value);
      //                 setState(() {
      //                    groupName = value;
      //                 });
      //               }
      //
      //         },
      //       );
      //     }
      //   },
      // )

    );
  }
}
