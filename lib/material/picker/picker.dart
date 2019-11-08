import 'dart:wasm';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Picker {
  static showPicker(BuildContext context,
      {Key key,
      List<dynamic> data,
      List<String> value,
      int cols = 3,
      String okText = '确定',
      String dismissText = '取消',
      String title,
      ValueChanged<String> onChange,
      bool cascade = true}) {
    return showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          assert(cols > 0);
          if (cascade == false) {
            if (data.length > 0) {
              for (int i = 0; i < data.length; i++) {
                assert(data[i] is List);
              }
            }
          } else {
            for (int i = 0; i < data.length; i++) {
              if (!(data[i] is Map)) {
                data.removeAt(i);
              }
            }
          }
          return PickerContainer(
              data: data,
              value: value ?? [],
              cols: cols,
              okText: okText,
              dismissText: dismissText,
              title: title,
              cascade: cascade,
              onChange: onChange);
        });
  }
}

class PickerContainer extends StatefulWidget {
  PickerContainer(
      {Key key,
      this.data,
      this.value,
      this.cols,
      this.okText,
      this.dismissText,
      this.title,
      this.cascade,
      this.onChange})
      : super(key: key);
  final List<dynamic> data;
  final List<String> value;
  final int cols;
  final String okText;
  final String dismissText;
  final String title;
  final bool cascade;
  final ValueChanged<String> onChange;

  @override
  _PickerContainerState createState() => _PickerContainerState();
}

class _PickerContainerState extends State<PickerContainer> {
  double _containerHeight;
  double _itemExtent = 25.0;
  double _squeeze = 1.0;
  double _magnification = 1.2;
  Color _background = Colors.white;

  List<FixedExtentScrollController> _scrollControllerList = [];
  List<List<Map<String, dynamic>>> _colDataValueList = [];
  List<String> initialValueList = [];
  int loopTime = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  void _buildChildren(
    List<Map<String, dynamic>> children,
    int index,
  ) {
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
          initialValueList[_colDataValueList.length] = _value;
          _colDataValueList.add(children);
          _scrollControllerList
              .add(FixedExtentScrollController(initialItem: 0));
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
        for (int i = 0, l = widget.data.length; i < l; i++) {
          var _value = widget.data[i]['value'];
          var _children = widget.data[i]['children'];
          if (i + 1 >= widget.cols) break;
          if (initialValueList.contains(_value) &&
              initialValueList[0] == _value) {
            _scrollControllerList
                .add(FixedExtentScrollController(initialItem: i));
            if (_children != null && _children.length > 0) {
              loopTime++;
              _buildChildren(_children, loopTime);
            }

            break;
          } else {
            initialValueList[i] = firstColumnData[0]['value'];
            _scrollControllerList
                .add(FixedExtentScrollController(initialItem: 0));
            if (_children != null && _children.length > 0) {
              loopTime++;
              _buildChildren(_children, loopTime);
            }
            break;
          }
        }
      }
    } else {
      if (widget.data != null && widget.data.length > 0) {
        widget.data.asMap().forEach((int index, item) {
          if (index >= widget.cols) return false;
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
              initialValueList[index] = colData[0]['value'];
            } else {
              if (index >= initialValueList.length) {
                initialValueList.add(colData[0]['value']);
              } else {
                initialValueList[index] = colData[0]['value'];
              }
            }
          }

          _colDataValueList.add(colData);
        });
      }
    }
  }

  Widget _buildLabel(label) {
    if (label is String) {
      return DefaultTextStyle(
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 17.0, fontWeight: FontWeight.w500, color: Colors.black),
        child: Text(label),
      );
    } else {
      return DefaultTextStyle(
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 17.0, fontWeight: FontWeight.w500, color: Colors.black),
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
            child: CupertinoPicker.builder(
              key: ValueKey('$_index'),
              scrollController: _scrollControllerList[_index],
              backgroundColor: _background,
              itemExtent: _itemExtent, // 高度
              childCount: item.length,
              squeeze: _squeeze,
              magnification: _magnification,
              itemBuilder: (BuildContext context, int index) {
                return _buildLabel(item[index]['label']);
              },
              onSelectedItemChanged: (int index) {
                var selectedItemValue = item[index]['value'];

                // 如何知第几个controller
                var keyIndex = _index; // 滚动第几个controller
                if (keyIndex + 1 >= _colDataValueList.length) return;
                if (_colDataValueList[keyIndex].length == 0) return;

                for (int j = 0; j < widget.cols; j++) {
                  if (j < keyIndex) continue;
                  if (j + 1 >= _colDataValueList.length) break;
                  if (_colDataValueList[j].length == 0) {
                    _colDataValueList[j + 1] = [];
                    continue;
                  }
                  for (int i = 0, l = _colDataValueList[j].length; i < l; i++) {
                    var _value = _colDataValueList[j][i]['value'];
                    var _children = _colDataValueList[j][i]['children'];
                    if (selectedItemValue == _value) {
                      if (_children != null && _children.length > 0) {
                        if (j + 1 >= _colDataValueList.length) break;
                        _colDataValueList[j + 1] = _buildColData(_children);

                        selectedItemValue = _children[0]['value'];
                        _scrollControllerList[j + 1].jumpToItem(0);
                        setState(() {});
                        break;
                      } else {
                        if (j + 1 >= _colDataValueList.length) break;
                        _colDataValueList[j + 1] = [];

                        setState(() {});
                      }
                    }
                  }
                }
              },
            ),
          ));
        } else {
          widgetList.add(Flexible(
            child: CupertinoPicker.builder(
              backgroundColor: _background,
              itemExtent: _itemExtent,
              squeeze: _squeeze,
              magnification: _magnification,
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
            child: CupertinoPicker.builder(
              scrollController: _scrollControllerList[_index],
              backgroundColor: _background,
              itemExtent: _itemExtent,
              squeeze: _squeeze,
              magnification: _magnification,
              childCount: item.length,
              itemBuilder: (_, int index) {
                return _buildLabel(item[index]['label']);
              },
              onSelectedItemChanged: null,
            ),
          ));
        } else {
          widgetList.add(Flexible(
            child: CupertinoPicker.builder(
              backgroundColor: _background,
              itemExtent: _itemExtent,
              squeeze: _squeeze,
              magnification: _magnification,
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

    _containerHeight = MediaQuery.of(context).size.height * 0.35;
    return Container(
      height: _containerHeight,
      decoration: BoxDecoration(color: _background),
      child: Column(
        children: <Widget>[
          Material(
            color: _background,
            textStyle: TextStyle(
                color: Theme.of(context).primaryColor, fontSize: 16.0),
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
                  Text(
                    widget.title ?? '',
                    style: TextStyle(color: Colors.black),
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
              children: widgetList,
            ),
          )
        ],
      ),
    );
  }
}
