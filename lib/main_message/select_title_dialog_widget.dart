import 'package:flutter/material.dart';
import 'package:local_life_app/res/styles.dart';
import 'package:local_life_app/widgets/base_dialog.dart';


class SaveDialog extends StatelessWidget {
  final String title;
  const SaveDialog({Key key, this.onPressed, this.title,this.onCancel}) : super(key: key);
  final VoidCallback onPressed;
  final VoidCallback onCancel;
  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: '提示',
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Text('是否要保存修改？',
            style: TextStyles.textSize16),
      ),
      onPressed: () {
        onPressed();
      },
      cancelPressed: (){
        onCancel();
      },

    );
  }
}
