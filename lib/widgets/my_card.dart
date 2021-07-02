
import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {

  const MyCard({
    Key key,
    @required this.child,
    this.color,
    this.shadowColor
  }): super(key: key);
  
  final Widget child;
  final Color color;
  final Color shadowColor;

  @override
  Widget build(BuildContext context) {
    Color _backgroundColor;
    Color _shadowColor;

    if (color == null) {
      _backgroundColor = Colors.white;
    } else {
      _backgroundColor = color;
    }

    if (shadowColor == null) {
      _shadowColor =  const Color(0x80DCE7FA);
    } else {
      _shadowColor =  shadowColor;
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          BoxShadow(color: _shadowColor, offset: const Offset(0.0, 2.0), blurRadius: 8.0, spreadRadius: 0.0),
        ],
      ),
      child: child,
    );
  }
}
