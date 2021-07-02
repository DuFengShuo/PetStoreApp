import 'package:flutter/material.dart';
import 'package:local_life_app/widgets/Layout/state_layout.dart';
import 'package:local_life_app/widgets/my_app_bar.dart';


class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: 'Page does not exist',
      ),
      body: StateLayout(
        type: StateType.message,
        hintText: 'Page does not exist',
      ),
    );
  }
}
