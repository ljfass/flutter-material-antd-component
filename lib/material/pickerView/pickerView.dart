import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PickerView extends StatefulWidget {
  PickerView(
      {Key key, this.data, this.value, this.cascade = true, this.cols = 3})
      : assert(cols > 0),
        assert(() {
          var flag = true;
          if (cascade == false) {
            if (data.length > 0) {
              for (int i = 0; i < data.length; i++) {
                if (!(data[i] is List)) {
                  flag = false;
                  break;
                }
              }
            }
          }

          return flag;
        }()),
        super(key: key);
  final List<dynamic> data;
  final List<String> value;
  final bool cascade;
  final int cols;
  @override
  _PickerViewState createState() => _PickerViewState();
}

class _PickerViewState extends State<PickerView> {
  List<dynamic> _data = [];
  double _itemExtent = 28.0;
  double _squeeze = 1.0;
  double _diameterRatio = 2.0;
  List<FixedExtentScrollController> _scrollControllerList = [];
  List<List<Map<String, dynamic>>> _colDataValueList = [];
  List<String> initialValueList = [];
  List<List<Map<String, dynamic>>> _noCascadeData = [];
  int loopTime = 0;
  Color _activeTextColor = Colors.black;
  Color _inActiveTextColor = Colors.grey.withOpacity(.5);

  @override
  void initState() {
    super.initState();
    if (widget.cascade == true) {
      for (int i = 0; i < widget.data.length; i++) {
        if (widget.data[i] is Map) {
          _data.add(widget.data[i]);
        }
      }
    }
    init();
  }

  void _buildChildren(
    List<Map<String, dynamic>> children,
    int index,
  ) {
    bool flag = false;
    if (loopTime >= widget.cols) return;
    for (int i = 0; i < children.length; i++) {
      var _value = children[i]['value'];
      var _children = children[i]['children'];
      if (loopTime >= initialValueList.length) {
        initialValueList.add(children[0]['value']);
        _colDataValueList.add(children);
        _scrollControllerList.add(FixedExtentScrollController(initialItem: 0));
        loopTime++;
        if (_children != null && _children.length > 0) {
          _buildChildren(
            _children,
            loopTime,
          );
        }
        break;
      } else {
        if (_value == initialValueList[_colDataValueList.length]) {
          flag = true;
          _colDataValueList.add(children);
          _scrollControllerList
              .add(FixedExtentScrollController(initialItem: i));
          loopTime++;
          if (_children != null && _children.length > 0) {
            _buildChildren(
              _children,
              loopTime,
            );
          }
          break;
        } else {
          continue;
        }
      }
    }
    if (flag == false) {
      if (_colDataValueList.length < initialValueList.length) {
        initialValueList[_colDataValueList.length] = children[0]['value'];
        _colDataValueList.add(children);
        _scrollControllerList.add(FixedExtentScrollController(initialItem: 0));
        loopTime++;
        if (children[0]['children'] != null &&
            children[0]['children'].length > 0) {
          _buildChildren(
            children[0]['children'],
            loopTime,
          );
        }
      }
    }
  }

  List<Map<String, dynamic>> _buildColData(List<dynamic> list) {
    List<Map<String, dynamic>> _tempList = [];
    for (int i = 0, l = list.length; i < l; i++) {
      var _label = list[i]['label'];
      var _value = list[i]['value'];
      var _children = list[i]['children'];
      _tempList
          .add({'label': _label, 'value': _value, 'children': _children ?? []});
    }
    return _tempList;
  }

  void init() {
    if (widget.value != null && widget.value.length > 0) {
      widget.value.forEach((value) {
        this.initialValueList.add(value);
      });
    }
    if (widget.cascade == true) {
      var firstColumnData = _buildColData(widget.data);
      _colDataValueList.add(firstColumnData);
      if (initialValueList.length == 0) {
        //没有传入默认数据值
        initialValueList.add(firstColumnData[0]['value']);
        _scrollControllerList.add(FixedExtentScrollController(initialItem: 0));
        var _children = widget.data[0]['children'];
        if (_children != null && _children.length > 0) {
          loopTime++;
          _buildChildren(
            _children,
            loopTime,
          );
        }
      } else {
        bool flag = false;
        for (int i = 0, l = widget.data.length; i < l; i++) {
          var _value = widget.data[i]['value'];
          var _children = widget.data[i]['children'];
          if (initialValueList.contains(_value) &&
              initialValueList[0] == _value) {
            flag = true;
            _scrollControllerList
                .add(FixedExtentScrollController(initialItem: i));
            if (_children != null && _children.length > 0) {
              loopTime++;
              _buildChildren(_children, loopTime);
            }

            break;
          } else {
            continue;
          }
        }
        if (flag == false) {
          initialValueList[0] = firstColumnData[0]['value'];
          _scrollControllerList
              .add(FixedExtentScrollController(initialItem: 0));
          if (firstColumnData[0]['children'] != null &&
              firstColumnData[0]['children'].length > 0) {
            loopTime++;
            _buildChildren(firstColumnData[0]['children'], loopTime);
          }
        }
      }
    } else {
      if (widget.data != null && widget.data.length > 0) {
        widget.data.forEach((item) {
          if (item.length > 0) _noCascadeData.add(item);
        });

        for (int index = 0; index < _noCascadeData.length; index++) {
          var item = _noCascadeData[index];
          if (index >= widget.cols) break;
          if (item.length == 0) continue;
          var colData = _buildColData(item);
          var flag = false;
          for (int i = 0, l = colData.length; i < l; i++) {
            if (initialValueList.length > 0 &&
                index < initialValueList.length &&
                initialValueList.contains(colData[i]['value'])) {
              if (initialValueList[index] == colData[i]['value']) {
                _scrollControllerList
                    .add(FixedExtentScrollController(initialItem: i));
                flag = true;
                break;
              }
            }
          }
          if (flag == false) {
            _scrollControllerList
                .add(FixedExtentScrollController(initialItem: 0));
            if (initialValueList.length == 0) {
              initialValueList.add(colData[0]['value']);
            } else {
              if (index >= initialValueList.length) {
                initialValueList.add(colData[0]['value']);
              } else {
                initialValueList[index] = colData[0]['value'];
              }
            }
          }

          _colDataValueList.add(colData);
        }
      }
    }
  }

  Widget _buildLabel(label, {bool active = true}) {
    if (label is String) {
      return DefaultTextStyle(
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 16.0,
            fontWeight: active == true ? FontWeight.w500 : FontWeight.w400,
            color: active == true ? _activeTextColor : _inActiveTextColor),
        child: Text(label),
      );
    } else {
      return DefaultTextStyle(
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 16.0,
            fontWeight: active == true ? FontWeight.w500 : FontWeight.w400,
            color: active == true ? _activeTextColor : _inActiveTextColor),
        child: label,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Flexible> widgetList = [];
    if (widget.cascade == true) {
      _colDataValueList.asMap().forEach((int _index, item) {
        if (item.length > 0) {
          widgetList.add(Flexible(
            flex: 1,
            child: Container(
              child: CupertinoPicker.builder(
                key: ValueKey('$_index'),
                scrollController: _scrollControllerList[_index],
                backgroundColor: null,
                itemExtent: _itemExtent, // 高度
                childCount: item.length,
                squeeze: _squeeze,
                diameterRatio: _diameterRatio,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: _itemExtent,
                    alignment: Alignment.center,
                    child: _buildLabel(item[index]['label'],
                        active:
                            _scrollControllerList[_index].initialItem == index),
                  );
                },
                onSelectedItemChanged: (int index) {
                  var selectedItemValue = item[index]['value']; // 当前列选中的value值

                  // 如何知第几个controller
                  var keyIndex = _index; // 滚动第几个controller
                  setState(() {
                    _scrollControllerList[keyIndex] =
                        FixedExtentScrollController(initialItem: index);
                  });
                  if (keyIndex + 1 >= _colDataValueList.length) {
                    initialValueList[keyIndex] = selectedItemValue;
                    return;
                  }
                  if (_colDataValueList[keyIndex].length == 0) return;

                  for (int j = 0; j < widget.cols; j++) {
                    if (j < keyIndex) continue;
                    if (j + 1 >= _colDataValueList.length) break;
                    if (_colDataValueList[j].length == 0) {
                      _colDataValueList[j + 1] = [];
                      continue;
                    }
                    for (int i = 0, l = _colDataValueList[j].length;
                        i < l;
                        i++) {
                      var _value = _colDataValueList[j][i]['value'];
                      var _children = _colDataValueList[j][i]['children'];
                      if (selectedItemValue == _value) {
                        initialValueList[j] = selectedItemValue;
                        if (_children != null && _children.length > 0) {
                          if (j + 1 >= _colDataValueList.length) break;
                          _colDataValueList[j + 1] = _buildColData(_children);
                          selectedItemValue = _children[0]['value'];
                          _scrollControllerList[j + 1].jumpToItem(0);
                          initialValueList[j + 1] = _children[0]['value'];
                          loopTime = _colDataValueList.length;
                          _buildChildren(_children, _colDataValueList.length);
                          setState(() {});
                          break;
                        } else {
                          if (j + 1 >= _colDataValueList.length) break;
                          _scrollControllerList.removeAt(j + 1);
                          _colDataValueList.removeAt(j + 1);
                          initialValueList.removeAt(j + 1);
                          setState(() {});
                        }
                      }
                    }
                  }
                },
              ),
            ),
          ));
        } else {
          widgetList.add(Flexible(
            child: CupertinoPicker.builder(
              backgroundColor: null,
              itemExtent: _itemExtent,
              childCount: 0,
              itemBuilder: (_, int index) {
                return Text('');
              },
              onSelectedItemChanged: null,
            ),
          ));
        }
      });
    } else {
      _colDataValueList.asMap().forEach((int _index, item) {
        if (item.length > 0) {
          widgetList.add(Flexible(
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
              child: CupertinoPicker.builder(
                scrollController: _scrollControllerList[_index],
                backgroundColor: null,
                itemExtent: _itemExtent,
                childCount: item.length,
                squeeze: _squeeze,
                diameterRatio: _diameterRatio,
                itemBuilder: (_, int index) {
                  return Container(
                    height: _itemExtent,
                    alignment: Alignment.center,
                    child: _buildLabel(item[index]['label'],
                        active:
                            _scrollControllerList[_index].initialItem == index),
                  );
                },
                onSelectedItemChanged: (int index) {
                  var selectedItemValue = item[index]['value']; // 当前列选中的value值
                  var keyIndex = _index; // 滚动第几个controller
                  initialValueList[keyIndex] = selectedItemValue;
                  setState(() {
                    _scrollControllerList[keyIndex] =
                        FixedExtentScrollController(initialItem: index);
                  });
                },
              ),
            ),
          ));
        } else {
          widgetList.add(Flexible(
            child: CupertinoPicker.builder(
              backgroundColor: null,
              itemExtent: _itemExtent,
              squeeze: _squeeze,
              diameterRatio: _diameterRatio,
              childCount: 0,
              itemBuilder: (_, int index) {
                return Text('');
              },
              onSelectedItemChanged: null,
            ),
          ));
        }
      });
    }

    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        children: widgetList,
      ),
    );
  }
}
