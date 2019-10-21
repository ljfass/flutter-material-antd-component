import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../material/segmentedcontrol/segmentedcontrol.dart';

class PageSegmentedControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SegmentedControl'),
        ),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            height: 400.0,
            child: SegmentedControl(
              values: ['Segment1', 'Segment2', 'Segment3'],
              disabled: false,
            ),
          ),
        ));
  }
}
