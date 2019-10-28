import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_antd/material/button/button.dart';
import '../../material/swipeAction/swipeAction.dart';

class PageSwipeAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SwipeAction'),
        ),
        body: Center(
          child: Container(
            // width: 100.0,
            // height: 50.0,
            child: SwipeAction(
              autoClose: true,
              left: [
                {'text': 'Cancel'},
                {'text': 'Delete'}
              ],
            ),
          ),
        ));
  }
}
