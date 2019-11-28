import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../material/listView/listviewIndexedList.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class PageListviewIndexedList extends StatefulWidget {
  @override
  _PageListviewIndexedListState createState() =>
      _PageListviewIndexedListState();
}

class _PageListviewIndexedListState extends State<PageListviewIndexedList> {
  List _data = new List();
  bool _loading = false;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    setState(() {
      _loading = true;
    });
    rootBundle.loadString('assets/data/china.json').then((value) {
      Map countyMap = json.decode(value);
      List list = countyMap['china'];
      setState(() {
        _loading = false;
        _data = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SegmentedControl'),
        ),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: ListviewIndexedList(
              initialListSize: 50,
              data: _data,
              listviewHeader: _loading == true
                  ? Container(
                      child: Text('loading...'),
                      alignment: Alignment.center,
                    )
                  : Text('header'),
            ),
          ),
        ));
  }
}
