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
      ValueChanged<String> onPickerChange,
      ValueChanged<String> onOk,
      VoidCallback onDismiss,
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
            onPickerChange: onPickerChange,
            onOk: onOk,
            onDismiss: onDismiss,
          );
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
      this.onPickerChange,
      this.onOk,
      this.onDismiss})
      : super(key: key);
  final List<dynamic> data;
  final List<String> value;
  final int cols;
  final String okText;
  final String dismissText;
  final String title;
  final bool cascade;
  final ValueChanged<String> onPickerChange;
  final ValueChanged<String> onOk;
  final VoidCallback onDismiss;

  @override
  _PickerContainerState createState() => _PickerContainerState();
}

class _PickerContainerState extends State<PickerContainer> {
  double _containerHeight;
  double _itemExtent = 28.0;
  double _squeeze = 1.0;
  double _diameterRatio = 2.0;
  Color _background = Colors.white;
  Color _activeTextColor = Colors.black;
  Color _inActiveTextColor = Colors.grey;

  List<FixedExtentScrollController> _scrollControllerList = [];
  List<List<Map<String, dynamic>>> _colDataValueList = [];
  List<String> initialValueList = [];
  List<List<Map<String, dynamic>>> _data = [];
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
          if (item.length > 0) _data.add(item);
        });

        for (int index = 0; index < _data.length; index++) {
          var item = _data[index];
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
            fontWeight: FontWeight.w400,
            color: active == true ? _activeTextColor : _inActiveTextColor),
        child: Text(label),
      );
    } else {
      return DefaultTextStyle(
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            color: active == true ? _activeTextColor : _inActiveTextColor),
        child: label,
      );
    }
  }

  void handlePickerChange() {
    if (widget.onPickerChange != null) {
      if (initialValueList.length > _colDataValueList.length)
        initialValueList =
            initialValueList.getRange(0, _colDataValueList.length).toList();
      widget.onPickerChange(initialValueList.join(','));
    }
  }

  void handleOnOk() {
    if (widget.onOk != null) {
      if (initialValueList.length > _colDataValueList.length)
        initialValueList =
            initialValueList.getRange(0, _colDataValueList.length).toList();
      widget.onOk(initialValueList.join(','));
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
                backgroundColor: _background,
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
                    handlePickerChange();
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
                          handlePickerChange();
                          _buildChildren(_children, _colDataValueList.length);
                          setState(() {});
                          break;
                        } else {
                          if (j + 1 >= _colDataValueList.length) break;
                          _colDataValueList[j + 1] = [];
                          initialValueList[j + 1] = '';
                          handlePickerChange();
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
              backgroundColor: _background,
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
    } else {
      _colDataValueList.asMap().forEach((int _index, item) {
        if (item.length > 0) {
          widgetList.add(Flexible(
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
              child: CupertinoPicker.builder(
                scrollController: _scrollControllerList[_index],
                backgroundColor: _background,
                itemExtent: _itemExtent,
                squeeze: _squeeze,
                diameterRatio: _diameterRatio,
                childCount: item.length,
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
                  setState(() {
                    _scrollControllerList[keyIndex] =
                        FixedExtentScrollController(initialItem: index);
                  });
                  initialValueList[keyIndex] = selectedItemValue;
                },
              ),
            ),
          ));
        } else {
          widgetList.add(Flexible(
            child: CupertinoPicker.builder(
              backgroundColor: _background,
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
                    onTap: () {
                      Navigator.of(context).pop(true);
                      if (widget.onDismiss != null) widget.onDismiss();
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 9.0, horizontal: 15.0),
                      child: Text(widget.dismissText),
                    ),
                  ),
                  Text(
                    widget.title ?? '',
                    style: TextStyle(color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (widget.onOk != null) handleOnOk();
                      Navigator.of(context).pop(true);
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 9.0, horizontal: 15.0),
                      child: Text(widget.okText),
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
