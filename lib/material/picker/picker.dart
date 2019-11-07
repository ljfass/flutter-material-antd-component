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
  Map<String, dynamic> _infos = {};
  Map<String, int> _colCount = {};
  int currentIndex = 0;
  int activeIndex = 0;
  int currentCol = 0;
  List<FixedExtentScrollController> _scrollController = [];
  List<GlobalKey> _keyCupertinoList = [];
  List<int> currentIndexList = [];

  @override
  void initState() {
    super.initState();

    init();
    _renderPickerCols();
  }

  void _buildChildren(List<Map<String, dynamic>> children, int index,
      {int loop = 0, int limit = 2, int parentSort}) {
    List<dynamic> a = [];
    //只需要第i-1=0层children
    if (loop >= limit) {
      return;
    } else {
      loop++;
    }
    for (int i = 0; i < children.length; i++) {
      var _value = children[i]['value'];
      var _label = children[i]['label'];
      var _children = children[i]['children'];

      a.add({
        'value': _value,
        'label': _label,
        'index': index,
        'sort': i,
        'parentSort': parentSort ?? null
      });
      if (_infos['$loop'] == null) {
        _infos['$loop'] = [];
        _infos['$loop'].addAll(a);
      } else {
        _infos['$loop'].addAll(a);
      }
      if (_children != null && _children.length > 0 && loop != 0) {
        _buildChildren(_children, index, loop: loop, parentSort: i);
      }
    }
  }

  void init() {
    for (int j = 0, l = widget.data.length; j < l; j++) {
      var _children = widget.data[j]['children'];
      if (_children != null && _children.length > 0) {
        _buildChildren(_children, j, limit: widget.cols - 1);
      }
    }

    // 开始初始化数据
    _childCount = widget.data != null ? widget.data.length : 0;
    _infos.forEach((k, v) {
      _infos['$k'] = v.toSet().toList();
    });
    for (int i = 0; i < widget.cols; i++) {
      _scrollController.add(FixedExtentScrollController(initialItem: 0));
      _keyCupertinoList.add(GlobalKey());
      if (i != 0) _colCount['$i'] = 0;
    }

    _colCount.forEach((k, v) {
      List<Map<String, dynamic>> _temp = [];
      _infos['$k'].asMap().forEach((int index, item) {
        if (item['index'] == currentIndex) _temp.add(item);
      });
      _colCount['$k'] = _temp.length;
    });
  }

  List<Flexible> _renderPickerCols() {
    List<Flexible> _flexibleList = [];
    for (int i = 0; i < widget.cols; i++) {
      if (i == 0) {
        _flexibleList.add(Flexible(
          flex: 1,
          child: CupertinoPicker.builder(
            key: _keyCupertinoList[i],
            scrollController: _scrollController[i],
            backgroundColor: _background,
            itemExtent: _itemExtent, // 高度
            childCount: _childCount,
            squeeze: _squeeze,
            magnification: _magnification,
            itemBuilder: (BuildContext context, int index) {
              return _buildLabel(widget.data[index]['label']);
            },
            onSelectedItemChanged: (int index) {
              currentIndex = index;
              currentCol = i;
              setState(() {
                _colCount.forEach((k, v) {
                  List<Map<String, dynamic>> _temp = [];
                  _infos['$k'].asMap().forEach((int index, item) {
                    if (item['index'] == currentIndex) _temp.add(item);
                  });
                  _colCount['$k'] = _temp.length;
                });

                _keyCupertinoList.asMap().forEach((int index, GlobalKey key) {
                  if (index != 0) _keyCupertinoList[index] = GlobalKey();
                });
              });
            },
          ),
        ));
      } else {
        List<Map<String, dynamic>> _temp = [];
        if (_colCount['${i + 1}'] != null) {
          // 中间列
          _infos['$i'].asMap().forEach((int j, item) {
            var parentSort = item['parentSort'];
            if (parentSort == null) {
              // 第2列
              var index = item['index'];
              if (index == currentIndex) {
                _temp.add(item);
              }
            } else {
              // todo

            }
          });
        } else {
          // 最后列
          _infos['$i'].asMap().forEach((int index, item) {
            var parentSort = item['parentSort'];

            _infos['${i - 1}'].asMap().forEach((int j, t) {
              var sort = t['sort'];
              var index = t['index'];
              if (sort == parentSort && currentIndex == index) {
                _temp.add(item);
              }
            });
            // if (item['parentSort'] == activeIndex &&
            //     item['index'] == currentIndex) _temp.add(item);
          });
          _colCount['$i'] = _temp.length;
        }
        _flexibleList.add(Flexible(
          flex: 1,
          child: CupertinoPicker.builder(
            key: _keyCupertinoList[i],
            scrollController: _scrollController[i],
            backgroundColor: _background,
            itemExtent: _itemExtent, // 高度
            childCount: _colCount['$i'],
            squeeze: _squeeze,
            magnification: _magnification,
            itemBuilder: (BuildContext context, int index) {
              return Text(
                '${_temp[index]['label']}',
              );
            },
            onSelectedItemChanged: (int index) {
              var sort = _temp[index]['sort']; //记录当前选择item的sort
              activeIndex = sort;
              currentCol = i;
              if (_infos['${i + 1}'] != null) {
                setState(() {
                  _keyCupertinoList[index + 1] = GlobalKey();
                });
              }
            },
          ),
        ));
      }
    }
    return _flexibleList;
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
              children: _renderPickerCols(),
            ),
          )
        ],
      ),
    );
  }
}
