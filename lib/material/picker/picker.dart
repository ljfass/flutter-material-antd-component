import 'dart:wasm';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Picker {
  static showPicker(BuildContext context,
      {Key key,
      List<Map<String, dynamic>> data,
      List<dynamic> value,
      int cols = 3,
      String okText = '确定',
      String dismissText = '取消',
      String title}) {
    return showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return PickerContainer(
            data: data,
            value: value,
            cols: cols,
            okText: okText,
            dismissText: dismissText,
            title: title,
          );
        });
  }
}

class PickerContainer extends StatefulWidget {
  PickerContainer(
      {Key key,
      this.data,
      this.cols,
      this.value,
      this.okText,
      this.dismissText,
      this.title})
      : super(key: key);
  final List<Map<String, dynamic>> data;
  final List<dynamic> value;
  final int cols;
  final String okText;
  final String dismissText;
  final String title;

  @override
  _PickerContainerState createState() => _PickerContainerState();
}

class _PickerContainerState extends State<PickerContainer> {
  double _containerHeight;
  double _itemExtent = 30.0;
  double _squeeze = 1.0;
  double _magnification = 1.2;
  Color _background = Colors.white;
  int currentIndex = 0;
  int activeIndex = 0;
  int currentCol = 0;
  List<FixedExtentScrollController> _scrollController = [];
  List<List<Map<String, dynamic>>> _colDataValueList = [];
  List<int> currentIndexList = [];
  List<String> initialValueList = [];
  int loopTime = 0;
  List<Flexible> _flexibleList = [];

  @override
  void initState() {
    super.initState();

    init();
  }

  void _buildChildren(
    List<Map<String, dynamic>> children,
    int index,
  ) {
    _colDataValueList.add(children);
    for (int i = 0; i < children.length; i++) {
      var _value = children[i]['value'];
      var _label = children[i]['label'];
      var _children = children[i]['children'];

      if (loopTime >= initialValueList.length) {
        _renderPickerCols(_buildColData(children), ValueKey('$index'),
            FixedExtentScrollController(initialItem: 0));
        loopTime++;
        if (_children != null && _children.length > 0) {
          _buildChildren(
            _children,
            loopTime,
          );
        }
        break;
      } else {
        if (_value == initialValueList[_flexibleList.length]) {
          _renderPickerCols(_buildColData(children), ValueKey('$index'),
              FixedExtentScrollController(initialItem: i));

          loopTime++;
          if (_children != null && _children.length > 0) {
            _buildChildren(
              _children,
              loopTime,
            );
          }
          break;
        }
      }

      // if (_children != null && _children.length > 0) {
      //   if (loopTime >= initialValueList.length) {
      //     _renderPickerCols(_buildColData(children), GlobalKey(),
      //         FixedExtentScrollController(initialItem: 0));
      //     _buildChildren(_children, index, loop: loop, parentSort: i);
      //     loopTime++;
      //     break;
      //   } else {
      //     if (_value == initialValueList[_flexibleList.length]) {
      //       _renderPickerCols(_buildColData(children), GlobalKey(),
      //           FixedExtentScrollController(initialItem: i));
      //       _buildChildren(_children, index, loop: loop, parentSort: i);
      //       loopTime++;
      //       continue;
      //     } else {}
      //   }
      // }
    }
  }

  List<Map<String, dynamic>> _buildColData(List<Map<String, dynamic>> list) {
    List<Map<String, dynamic>> _tempList = [];
    for (int i = 0, l = list.length; i < l; i++) {
      var _label = list[i]['label'];
      var _value = list[i]['value'];
      _tempList.add({'label': _label, 'value': _value});
    }
    return _tempList;
  }

  void init() {
    var o = _buildColData(widget.data);
    _colDataValueList.add(o);
    if (initialValueList.length == 0) {
      _renderPickerCols(
          o, ValueKey('0'), FixedExtentScrollController(initialItem: 0));

      var _children = widget.data[0]['children'];
      if (_children != null && _children.length > 0) {
        loopTime++;
        _buildChildren(
          _children,
          loopTime,
        );
      }
    } else {
      for (int i = 0, l = widget.data.length; i < l; i++) {
        var _value = widget.data[i]['value'];
        var _children = widget.data[i]['children'];
        if (initialValueList.contains(_value) &&
            initialValueList[0] == _value) {
          _flexibleList.clear();
          _renderPickerCols(
              o, ValueKey('0'), FixedExtentScrollController(initialItem: i));
          if (_children != null && _children.length > 0) {
            loopTime++;
            _buildChildren(_children, loopTime);
          }

          break;
        } else {
          _flexibleList.clear();
          _renderPickerCols(
              o, ValueKey('0'), FixedExtentScrollController(initialItem: 0));
          if (_children != null && _children.length > 0) {
            loopTime++;
            _buildChildren(_children, loopTime);
          }
        }
      }
    }

    // for (int i = 0, l = widget.data.length; i < l; i++) {
    //   // var _label = widget.data[i]['label'];
    //   var _value = widget.data[i]['value'];
    //   var _children = widget.data[i]['children'];

    //   if (_children != null && _children.length > 0) {
    //     // _buildChildren(_children, i, limit: 1000);
    //     loopTime++;
    //     if (initialValueList.length == 0) {
    //       if (i == 0) {
    //         _buildChildren(_children, i, limit: 1000);
    //         break;
    //       }
    //     } else {
    //       if (_value == initialValueList[0]) {
    //         _buildChildren(_children, i, limit: 1000);
    //         break;
    //       } else {
    //         if (i == 0) {
    //           _buildChildren(_children, i, limit: 1000);
    //           break;
    //         }
    //       }
    //     }
    //   }
    // }
  }

  void _renderPickerCols(
      list, ValueKey key, FixedExtentScrollController controller) {
    _scrollController.add(controller);
    _flexibleList.add(Flexible(
      flex: 1,
      child: CupertinoPicker.builder(
        key: key,
        scrollController: controller,
        backgroundColor: _background,
        itemExtent: _itemExtent, // 高度
        childCount: list.length,
        squeeze: _squeeze,
        magnification: _magnification,
        itemBuilder: (BuildContext context, int index) {
          return _buildLabel(list[index]['label']);
        },
        onSelectedItemChanged: (int index) {
          var value = list[index]['value'];
          // 如何知道第几个controller
          var keyIndex = int.parse(key.value);
          // print(int.parse(key.value));
          // print(_colDataValueList[0]);
          // print(_colDataValueList[int.parse(key.value)]);
          if (keyIndex + 1 >= _scrollController.length) return;
          setState(() {
            _scrollController[keyIndex + 1].animateToItem(1,
                duration: Duration(milliseconds: 10), curve: Curves.ease);
          });
        },
      ),
    ));
  }

  Widget _buildLabel(label) {
    if (label is String) {
      return Text(label);
    } else {
      return label;
    }
  }

  @override
  Widget build(BuildContext context) {
    _containerHeight = MediaQuery.of(context).size.height * 0.35;
    return Container(
      height: _containerHeight,
      decoration: BoxDecoration(color: _background),
      child: Column(
        children: <Widget>[
          Material(
            color: _background,
            textStyle: TextStyle(color: Theme.of(context).primaryColor),
            child: Container(
              height: 42.0,
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0xffdddddd)))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 9.0, horizontal: 15.0),
                      child: Text(widget.okText),
                    ),
                  ),
                  GestureDetector(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 9.0, horizontal: 15.0),
                      child: Text(widget.dismissText),
                    ),
                  )
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: _flexibleList,
            ),
          )
        ],
      ),
    );
  }
}
