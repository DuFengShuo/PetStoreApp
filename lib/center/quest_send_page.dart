import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:local_life_app/center/widget/select_sendcontent_widget.dart';
import 'package:local_life_app/center/widget/send_content_widget.dart';
import 'package:local_life_app/center/widget/send_yh_widget.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/util/other_utils.dart';
class QuestSendPage extends StatefulWidget {
  const QuestSendPage({Key key}) : super(key: key);

  @override
  _QuestSendPageState createState() => _QuestSendPageState();
}

class _QuestSendPageState extends State<QuestSendPage> {
  double _padding = 10;
  var _align = Alignment.topLeft;
  double _height = 100;
  double _left = 0;
  Color _color = Colors.red;
  TextStyle _style = TextStyle(color: Colors.black);
  Color _decorationColor = Colors.blue;
  SwiperController swipController =  SwiperController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if(mounted){
        setState(() {
          _align = Alignment.center;
        });
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    var duration = Duration(seconds: 1);
    return
      Scaffold(
        appBar: AppBar(
            // leading: new IconButton(
            //   icon: new Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
            //   onPressed: () => Navigator.pop(context),
            // ),
            brightness: Brightness.dark,

            backgroundColor: Colours.app_main,
            title: Text(
              "智能发布",
              style: TextStyles.textBold16.copyWith(color: Colours.material_bg),
            ),
            centerTitle: true,
            elevation: 1 //阴影
        ),
        body:
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Swiper(
              controller:swipController ,
              itemBuilder: (BuildContext context,int index){
                if(index==0){
                  return    SelectSendContentWidget(
                    callBack: (e){
                      print("点了"+e.toString());
                      swipController.move(index+1);
                      showElasticDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext contexts) {
                          return SendContentWidget(
                          );
                        },

                      );
                    },
                  );
                }else {
                  return    SendYhWidget();
                }

              },
              itemCount: 2,
              // pagination: new SwiperPagination(
              //     builder: DotSwiperPaginationBuilder(
              //       color: Colors.black54,
              //       activeColor: Colors.white,
              //     )),
              // control: new SwiperControl(),
              scrollDirection: Axis.horizontal,
              // physics: NeverScrollableScrollPhysics(),
              autoplay: false,
               loop: false,
              // onTap: (index) =>    swipController.move(index+1),

            )),



        // SingleChildScrollView(
        //   child: Column(
        //     children: <Widget>[
        //       // RaisedButton(
        //       //   onPressed: () {
        //       //     setState(() {
        //       //       _padding = 20;
        //       //     });
        //       //   },
        //       //   child: AnimatedPadding(
        //       //     duration: duration,
        //       //     padding: EdgeInsets.all(_padding),
        //       //     child: Text("AnimatedPadding"),
        //       //   ),
        //       // ),
        //       AnimatedAlign(
        //         duration: duration,
        //         alignment: _align,
        //         child: RaisedButton(
        //           onPressed: () {
        //             setState(() {
        //               _align = Alignment.center;
        //             });
        //           },
        //           child: Text("AnimatedAlign"),
        //         ),
        //       ),
        //       SizedBox(
        //         height: 50,
        //         child: Stack(
        //           children: <Widget>[
        //             AnimatedPositioned(
        //               duration: duration,
        //               left: _left,
        //               child: RaisedButton(
        //                 onPressed: () {
        //                   setState(() {
        //                     _left = 100;
        //                   });
        //                 },
        //                 child: Text("AnimatedPositioned"),
        //               ),
        //             )
        //           ],
        //         ),
        //       ),
        //       Container(
        //         height: 100,
        //         color: Colors.grey,
        //         child: AnimatedAlign(
        //           duration: duration,
        //           alignment: _align,
        //           child: RaisedButton(
        //             onPressed: () {
        //               setState(() {
        //                 _align = Alignment.center;
        //               });
        //             },
        //             child: Text("AnimatedAlign"),
        //           ),
        //         ),
        //       ),
        //       AnimatedContainer(
        //         duration: duration,
        //         height: _height,
        //         color: _color,
        //         child: FlatButton(
        //           onPressed: () {
        //             setState(() {
        //               _height = 150;
        //               _color = Colors.blue;
        //             });
        //           },
        //           child: Text(
        //             "AnimatedContainer",
        //             style: TextStyle(color: Colors.white),
        //           ),
        //         ),
        //       ),
        //       AnimatedDefaultTextStyle(
        //         child: GestureDetector(
        //           child: Text("hello world"),
        //           onTap: () {
        //             setState(() {
        //               _style = TextStyle(
        //                 color: Colors.blue,
        //                 decorationStyle: TextDecorationStyle.solid,
        //                 decorationColor: Colors.blue,
        //               );
        //             });
        //           },
        //         ),
        //         style: _style,
        //         duration: duration,
        //       ),
        //       // AnimatedDecoratedBox(
        //       //   duration: duration,
        //       //   decoration: BoxDecoration(color: _decorationColor),
        //       //   child: FlatButton(
        //       //     onPressed: () {
        //       //       setState(() {
        //       //         _decorationColor = Colors.red;
        //       //       });
        //       //     },
        //       //     child: Text(
        //       //       "AnimatedDecoratedBox",
        //       //       style: TextStyle(color: Colors.white),
        //       //     ),
        //       //   ),
        //       // )
        //     ].map((e) {
        //       return Padding(
        //         padding: EdgeInsets.symmetric(vertical: 16),
        //         child: e,
        //       );
        //     }).toList(),
        //   ),
        // ),

      );

  }
}
