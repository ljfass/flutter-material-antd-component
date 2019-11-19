import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../material/inputItem/inputItem.dart';

class PageInputItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('InputItem'),
        ),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            // height: 400.0,
            child: InputItem(
              placeholder: 'start from left',
              child: Text('标题'),
              clear: true,
            ),
          ),
        ));
  }
}
