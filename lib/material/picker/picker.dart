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
  int _childCount = 0;
  double _squeeze = 1.0;
  double _magnification = 1.2;
  Color _background = Colors.white;
  List<Map<String, dynamic>> _data = [];
  List<List<dynamic>> _groupList = [];
  List<Flexible> _flexibleList = [];
  List<Map<String, dynamic>> _childrenList = [];
  int flag = 0;
  int _count = 0;

  @override
  void initState() {
    super.initState();
    _childCount = widget.data != null ? widget.data.length : 0;
    if (widget.data != null && widget.data.length > 0) {
      _buildItems();
    }
    for (int i = 0; i < widget.cols; i++) {
      _groupList.add([]);
    }

    a();
    print(_groupList);
    _buildPickerCols();
  }

  void _buildItems() {
    widget.data.asMap().forEach((int index, Map<String, dynamic> item) {
      _data.add({
        'label':
            (item['label'] != null && item['label'] != '') ? item['label'] : '',
        'value':
            (item['value'] != null && item['value'] != '') ? item['value'] : '',
        'children': (item['children'] != null && item['children'].length > 0)
            ? item['children']
            : null,
      });
    });
  }

  void _buildChildren(List<Map<String, dynamic>> children, int index) {
    flag++;
    if (flag >= _childCount) return;
    if (children.length == 0) {
      _groupList[flag].add({'label': null, 'value': null, 'index': index});
      return;
    }
    for (int i = 0; i < children.length; i++) {
      var _value = children[i]['value'];
      var _label = children[i]['label'];
      var _children = children[i]['children'];
      _groupList[flag].add(
          {'label': _label ?? null, 'value': _value ?? null, 'index': index});
      if (_children != null && _children.length > 0) {
        _buildChildren(_children, index);
      } else {
        _buildChildren([], index);
      }
    }
  }

  void a() {
    for (int j = 0, l = widget.data.length; j < l; j++) {
      var _value = widget.data[j]['value'];
      var _label = widget.data[j]['label'];
      var _children = widget.data[j]['children'];
      _groupList[0].add(Flexible(
        flex: 1,
        child: CupertinoPicker.builder(
          scrollController: FixedExtentScrollController(initialItem: 0),
          backgroundColor: _background,
          itemExtent: _itemExtent, // 高度
          childCount: _childCount,
          squeeze: _squeeze,
          magnification: _magnification,
          itemBuilder: (BuildContext context, int index) {
            return _buildLabel(_label);
          },
          onSelectedItemChanged: (int index) {
            print(index);
          },
        ),
      ));
      if (_children != null && _children.length > 0) {
        flag = 0;
        _buildChildren(_children, j);
      } else {
        flag = 0;
        _buildChildren([], j);
      }
    }
  }

  void _buildPickerCols() {
    _flexibleList.length = 0;
    for (int i = 0; i < widget.cols; i++) {
      if (i == 0) {
        _flexibleList.add(Flexible(
          flex: 1,
          child: CupertinoPicker.builder(
            scrollController: FixedExtentScrollController(initialItem: 0),
            backgroundColor: _background,
            itemExtent: _itemExtent, // 高度
            childCount: _childCount,
            squeeze: _squeeze,
            magnification: _magnification,
            itemBuilder: (BuildContext context, int index) {
              return _buildLabel(widget.data[index]['label']);
            },
            onSelectedItemChanged: (int index) {
              _count = _groupList[index].length;
              setState(() {
                _buildPickerCols();
              });
            },
          ),
        ));
      } else {
        _flexibleList.add(Flexible(
          flex: 1,
          child: CupertinoPicker.builder(
            scrollController: FixedExtentScrollController(initialItem: 0),
            backgroundColor: _background,
            itemExtent: _itemExtent, // 高度
            childCount: _groupList[i].length,
            squeeze: _squeeze,
            magnification: _magnification,
            itemBuilder: (BuildContext context, int index) {
              return _buildLabel(_groupList[i][index]['label']);
            },
            onSelectedItemChanged: (int index) {
              print(index);
            },
          ),
        ));
      }
    }
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
