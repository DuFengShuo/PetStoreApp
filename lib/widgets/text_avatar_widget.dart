import 'dart:math';

import 'package:flutter/material.dart';
import 'package:local_life_app/res/colors.dart';
import 'package:local_life_app/res/resources.dart';

const double ta_radius = 20.0;
class TextAvatarWidget extends StatefulWidget {
  final  title;
  const TextAvatarWidget({Key key, this.title}) : super(key: key);
  @override
  _TextAvatarWidgetState createState() => _TextAvatarWidgetState();
}

class _TextAvatarWidgetState extends State<TextAvatarWidget> {
  Color getRandomColor({int r = 255, int g = 105, int b = 255, a = 255}) {
    if (r == 0 || g == 0 || b == 0) return Colors.black;
    if (a == 0) return Colors.white;
    return Color.fromARGB(
      a,
      r != 255 ? r : Random.secure().nextInt(r),
      g != 255 ? g : Random.secure().nextInt(g),
      b != 255 ? b : Random.secure().nextInt(b),
    );
  }
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: ta_radius,
      backgroundColor: Colours.app_main_light,
      child: Center(
        child: Text(widget.title,style: TextStyles.textBold14.copyWith(color: Colours.material_bg),),
      ),
      // backgroundImage: ImageUtils.getAssetImage(iconArray[index]),
    );
  }
}
