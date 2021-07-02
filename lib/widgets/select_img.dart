import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_life_app/res/resources.dart';
import 'package:local_life_app/widgets/my_button.dart';
import 'dart:io';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';



class MySelectImage extends StatefulWidget {
  final  List<AssetEntity> imageList;
  const MySelectImage({Key key, this.imageList}) : super(key: key);

  @override
  _MySelectImageState createState() => _MySelectImageState();
}

class _MySelectImageState extends State<MySelectImage> {

  List<AssetEntity> assets = <AssetEntity>[]; //选择的图片
  bool isShowEdit = false;
  bool isDisplayingDetail = false;
  Color themeColor = Colours.app_main;
  int maxImageCount = 3; //最大选择数量



  //选择图片
  Future<void> selectAssets(int maxAssetsCount) async {
    final List<AssetEntity> result = await AssetPicker.pickAssets(context,
        maxAssets: maxAssetsCount,
        selectedAssets: assets,
        requestType: RequestType.image,
        useRootNavigator: false,

        themeColor: Colours.app_main);
    if (result != null) {
      if (mounted) {
        setState(() {
          assets = List<AssetEntity>.from(result);
          if (assets.length == maxImageCount) {
            isShowEdit = !isShowEdit;
          }
        });
      }
    }
  }

  //上传图片
  _upLoadImage(File image) async {
    String path = image.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    FormData formdata = FormData.fromMap(
        {"file": await MultipartFile.fromFile(path, filename: name)});
    Dio dio = new Dio();
    var respone = await dio
        .post<String>("http://192.168.9.67:8081/home/addImg/", data: formdata);
    if (respone.statusCode == 200) {
      print("上传成功");
    }
  }

  void removeAsset(int index) {
    setState(() {
      assets.removeAt(index);
      if (assets.isEmpty) {
        isDisplayingDetail = false;
        isShowEdit = !isShowEdit;
      }
    });
  }

  Widget _selectedAssetDeleteButton(int index) {
    return GestureDetector(
      onTap: () => removeAsset(index),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Colours.text_gray.withOpacity(0.5),
        ),
        child: Icon(
          Icons.close,
          color: Theme.of(context).iconTheme.color,
          size: 22.0,
        ),
      ),
    );
  }

  showBigImage(int index) async {
    final List<AssetEntity> result = await AssetPickerViewer.pushToViewer(
      context,
      currentIndex: index,
      previewAssets: assets,
      themeData: AssetPicker.themeData(themeColor),
    );
    if (result != null && result != assets) {
      assets = List<AssetEntity>.from(result);
      if (mounted) {
        setState(() {});
      }
    }
  }

  Widget _intoAssetWidget() {
    return new GestureDetector(
      onTap: () => selectAssets(maxImageCount), //最大图片选择个数
      child: Container(
          alignment: Alignment.center,
          color: Colors.white,
          child: Center(
            child: Icon(
              Icons.add,
              color: Colors.black45,
            ),
          )),
    );
  }

  dynamic getBody() {
    return Container(
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                //  physics: NeverScrollableScrollPhysics(),
                  padding:
                  EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //确定个数的方法
                      crossAxisCount: 3, //每行三列
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 1.0 //显示区域宽高相等
                  ),
                  itemCount: assets.length==maxImageCount ? assets.length : assets.length + 1,
                  itemBuilder: (context, index) {
                    if (assets.length == 0) {
                      return _intoAssetWidget();
                    } else {
                      if (index == assets.length) {
                        return _intoAssetWidget();
                      } else {
                        return new GestureDetector(
                          onTap: () => showBigImage(index),
                          onLongPress: () =>  setState(() {
                            isDisplayingDetail = !isDisplayingDetail;
                          }),
                          child: Container(
                              margin: EdgeInsets.all(0),
                              color: Colors.white,
                              child: AspectRatio(
                                aspectRatio: 1.0,
                                child: Stack(
                                  children: <Widget>[
                                    Positioned.fill(
                                        child: _imageAssetWidget(assets[index])),
                                    AnimatedPositioned(
                                      duration: kThemeAnimationDuration,
                                      top: isDisplayingDetail ? 1.0 : -30.0,
                                      right: isDisplayingDetail ? 1.0 : -30.0,
                                      child: _selectedAssetDeleteButton(index),
                                    ),
                                  ],
                                ),
                              )),
                          // onTap : () => readArticle(index),
                        );
                      }
                    }
                  }),
            ),
            assets.length==maxImageCount
                ? Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: new BoxDecoration(
                  boxShadow: [
                    BoxShadow(color: Colours.line, blurRadius: 20.0)
                  ],
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  child: MyButton(
                    minHeight: 40,
                    fontSize: 14,
                    textColor: Colours.material_bg,
                    onPressed: () {
                      Navigator.pop(context,assets);
                    },
                    backgroundColor: Colours.app_main,
                    text: "确定",
                  ),
                ),
              ),
            )
                : Gaps.empty
          ],
        ));
  }

  Widget _imageAssetWidget(AssetEntity asset) {
    //显示选择的图片
    return Image(
      image: AssetEntityImageProvider(asset, isOriginal: false),
      fit: BoxFit.cover,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    assets = widget.imageList?? <AssetEntity>[];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.bg_gray,
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        brightness: Brightness.dark,
        centerTitle: true,
        backgroundColor: Colours.app_main,
        title: Text(
          '选择图片',
          style: TextStyles.textBold16.copyWith(color: Colours.material_bg),
        ),
        actions: <Widget>[
          //导航栏右侧菜单
          assets.length !=0
              ? new GestureDetector(
            onTap: () {
              setState(() {
                isDisplayingDetail = !isDisplayingDetail;
              });
            },
            child: Center(
              child: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Text(
                    isDisplayingDetail ? "取消编辑" : "编辑",
                    style: TextStyles.textSize13
                        .copyWith(color: Colours.material_bg),
                  )),
            ),
          )
              : Gaps.empty,
          //IconButton(icon: Icon(Icons.file_upload), onPressed: ()=>showAlter("上传成功！"),),
        ],
      ),
      body: getBody(),
    );
  }
}


//
//
// class SelectImage extends StatefulWidget {
//
//
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return MySelectImage();
//   }
// }
//
// class MySelectImage extends State {
//   List<AssetEntity> assets =  <AssetEntity>[]; //选择的图片
//   bool isShowEdit = false;
//   bool isDisplayingDetail = false;
//   Color themeColor = Colours.app_main;
//   int maxImageCount = 3; //最大选择数量
//
//   //选择图片
//   Future<void> selectAssets(int maxAssetsCount) async {
//     final List<AssetEntity> result = await AssetPicker.pickAssets(context,
//         maxAssets: maxAssetsCount,
//         selectedAssets: assets,
//         requestType: RequestType.image,
//         themeColor: Colours.app_main);
//     if (result != null) {
//       if (mounted) {
//         setState(() {
//           assets = List<AssetEntity>.from(result);
//           if (assets.length == maxImageCount) {
//             isShowEdit = !isShowEdit;
//           }
//         });
//       }
//     }
//   }
//
//   //上传图片
//   _upLoadImage(File image) async {
//     String path = image.path;
//     var name = path.substring(path.lastIndexOf("/") + 1, path.length);
//     FormData formdata = FormData.fromMap(
//         {"file": await MultipartFile.fromFile(path, filename: name)});
//     Dio dio = new Dio();
//     var respone = await dio
//         .post<String>("http://192.168.9.67:8081/home/addImg/", data: formdata);
//     if (respone.statusCode == 200) {
//       print("上传成功");
//     }
//   }
//
//   void removeAsset(int index) {
//     setState(() {
//       assets.removeAt(index);
//       if (assets.isEmpty) {
//         isDisplayingDetail = false;
//         isShowEdit = !isShowEdit;
//       }
//     });
//   }
//
//   Widget _selectedAssetDeleteButton(int index) {
//     return GestureDetector(
//       onTap: () => removeAsset(index),
//       child: DecoratedBox(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(4.0),
//           color: Colours.text_gray.withOpacity(0.5),
//         ),
//         child: Icon(
//           Icons.close,
//           color: Theme.of(context).iconTheme.color,
//           size: 22.0,
//         ),
//       ),
//     );
//   }
//
//   showBigImage(int index) async {
//     final List<AssetEntity> result = await AssetPickerViewer.pushToViewer(
//       context,
//       currentIndex: index,
//       previewAssets: assets,
//       themeData: AssetPicker.themeData(themeColor),
//     );
//     if (result != null && result != assets) {
//       assets = List<AssetEntity>.from(result);
//       if (mounted) {
//         setState(() {});
//       }
//     }
//   }
//
//   Widget _intoAssetWidget() {
//     return new GestureDetector(
//       onTap: () => selectAssets(maxImageCount), //最大图片选择个数
//       child: Container(
//           alignment: Alignment.center,
//           color: Colors.white,
//           child: Center(
//             child: Icon(
//               Icons.add,
//               color: Colors.black45,
//             ),
//           )),
//     );
//   }
//
//   dynamic getBody() {
//     return Container(
//         child: Column(
//       children: [
//         Expanded(
//           child: GridView.builder(
//             //  physics: NeverScrollableScrollPhysics(),
//               padding:
//                   EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   //确定个数的方法
//                   crossAxisCount: 3, //每行三列
//                   crossAxisSpacing: 5,
//                   mainAxisSpacing: 5,
//                   childAspectRatio: 1.0 //显示区域宽高相等
//                   ),
//               itemCount: assets.length==maxImageCount ? assets.length : assets.length + 1,
//               itemBuilder: (context, index) {
//                 if (assets.length == 0) {
//                   return _intoAssetWidget();
//                 } else {
//                   if (index == assets.length) {
//                     return _intoAssetWidget();
//                   } else {
//                     return new GestureDetector(
//                       onTap: () => showBigImage(index),
//                       onLongPress: () =>  setState(() {
//                         isDisplayingDetail = !isDisplayingDetail;
//                       }),
//                       child: Container(
//                           margin: EdgeInsets.all(0),
//                           color: Colors.white,
//                           child: AspectRatio(
//                             aspectRatio: 1.0,
//                             child: Stack(
//                               children: <Widget>[
//                                 Positioned.fill(
//                                     child: _imageAssetWidget(assets[index])),
//                                 AnimatedPositioned(
//                                   duration: kThemeAnimationDuration,
//                                   top: isDisplayingDetail ? 1.0 : -30.0,
//                                   right: isDisplayingDetail ? 1.0 : -30.0,
//                                   child: _selectedAssetDeleteButton(index),
//                                 ),
//                               ],
//                             ),
//                           )),
//                       // onTap : () => readArticle(index),
//                     );
//                   }
//                 }
//               }),
//         ),
//         assets.length==maxImageCount
//             ? Padding(
//                 padding: const EdgeInsets.only(bottom: 0),
//                 child: Container(
//                   width: double.infinity,
//                   height: 60,
//                   decoration: new BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(color: Colours.line, blurRadius: 20.0)
//                     ],
//                     color: Colors.white,
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         left: 10, right: 10, top: 10, bottom: 10),
//                     child: MyButton(
//                       minHeight: 40,
//                       fontSize: 14,
//                       textColor: Colours.material_bg,
//                       onPressed: () {
//                         Navigator.pop(context,assets);
//                       },
//                       backgroundColor: Colours.app_main,
//                       text: "确定",
//                     ),
//                   ),
//                 ),
//               )
//             : Gaps.empty
//       ],
//     ));
//   }
//
//   Widget _imageAssetWidget(AssetEntity asset) {
//     //显示选择的图片
//     return Image(
//       image: AssetEntityImageProvider(asset, isOriginal: false),
//       fit: BoxFit.cover,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colours.bg_gray,
//       appBar: AppBar(
//         leading: new IconButton(
//           icon: new Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//         brightness: Brightness.dark,
//         centerTitle: true,
//         backgroundColor: Colours.app_main,
//         title: Text(
//           '选择图片',
//           style: TextStyles.textBold16.copyWith(color: Colours.material_bg),
//         ),
//         actions: <Widget>[
//           //导航栏右侧菜单
//           assets.length !=0
//               ? new GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       isDisplayingDetail = !isDisplayingDetail;
//                     });
//                   },
//                   child: Center(
//                     child: Padding(
//                         padding: EdgeInsets.only(right: 20),
//                         child: Text(
//                           isDisplayingDetail ? "取消编辑" : "编辑",
//                           style: TextStyles.textSize13
//                               .copyWith(color: Colours.material_bg),
//                         )),
//                   ),
//                 )
//               : Gaps.empty,
//           //IconButton(icon: Icon(Icons.file_upload), onPressed: ()=>showAlter("上传成功！"),),
//         ],
//       ),
//       body: getBody(),
//     );
//   }
// }
