import 'package:flutter/material.dart';
import '../checkbox/checkbox.dart' as AntCheckbox;

class Menu extends StatefulWidget {
  Menu(
      {Key key,
      this.data,
      this.multiSelect = false,
      this.level = 2,
      this.height,
      this.onOk,
      this.onCancel,
      this.value,
      @required this.onChange})
      : assert(level == 1 || level == 2),
        assert((onOk != null && multiSelect == true) ||
            (onOk == null || onOk != null) && multiSelect == false),
        assert((onCancel != null && multiSelect == true) ||
            (onCancel == null || onCancel != null) && multiSelect == false),
        assert((value == null) || (value != null && value is List<dynamic>)),
        super(key: key);
  final List<Map<String, dynamic>> data;
  final bool multiSelect;
  final int level;
  final double height;
  final List<dynamic> value;
  final ValueChanged<List<dynamic>> onChange;
  final VoidCallback onOk;
  final VoidCallback onCancel;

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  Map<String, dynamic> selectedParentMenu;
  List<dynamic> multiSelectedParentMenu = [];
  List<List<dynamic>> multiSelectedChilrenMenu = [];
  int selectedMenuIndex = 0;
  List<Map<String, dynamic>> _data = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedParentMenu = widget.data[0];
    });

    widget.data.asMap().forEach((int index, Map<String, dynamic> menu) {
      this.multiSelectedChilrenMenu.add([]);
      List<Map<String, dynamic>> _children = [];
      if (menu['children'] != null && menu['children'].length > 0) {
        if (menu['isLeaf'] != null && menu['isLeaf'] == true) {
          _data.add({
            'value': menu['value'],
            'label': menu['label'],
            'children': [],
          });
        } else {
          menu['children']
              .asMap()
              .forEach((int index, Map<String, dynamic> child) {
            _children.add({
              'value': child['value'],
              'label': child['label'],
              'disabled': child['disabled'],
              'selected': false,
            });
          });
          _data.add({
            'value': menu['value'],
            'label': menu['label'],
            'children': _children,
          });
        }
      } else {
        _data.add({'value': menu['value'], 'label': menu['label']});
      }
    });

    if (widget.value != null && widget.value.length > 0) {
      List<dynamic> _valueArray = [];
      bool _flag = false;
      widget.data.asMap().forEach((int index, Map<String, dynamic> menu) {
        _valueArray.add(menu['value']);
      });

      if (widget.level == 1 && !widget.multiSelect) {
        for (var i = 0, l = widget.value.length; i < l; i++) {
          if (widget.value[i] is List) continue;
          if (_valueArray.indexOf(widget.value[i]) != -1) {
            setState(() {
              this.selectedParentMenu =
                  widget.data[_valueArray.indexOf(widget.value[i])];
            });
            break;
          }
        }
      } else if (widget.level == 1 && widget.multiSelect) {
        for (var i = 0, l = widget.value.length; i < l; i++) {
          if (widget.value[i] is List) continue;
          if (_valueArray.indexOf(widget.value[i]) != -1) {
            setState(() {
              this.multiSelectedParentMenu.add(
                  widget.data[_valueArray.indexOf(widget.value[i])]['value']);
            });
          }
        }
      } else if (widget.level == 2 && !widget.multiSelect) {
        var _value = [];
        widget.value.asMap().forEach((int i, dynamic v) {
          _value.add(v);
        });
        for (var i = 0, l = widget.value.length; i < l; i++) {
          if (widget.value[i] is List) continue;
          if (_valueArray.indexOf(widget.value[i]) != -1) {
            _value.removeAt(i);
            setState(() {
              this.selectedMenuIndex = _valueArray.indexOf(widget.value[i]);
            });
            break;
          }
        }
        for (var i = 0, l = _value.length; i < l; i++) {
          if (_flag == true) break;
          if (_value[i] is List) continue;
          if (this._data[this.selectedMenuIndex]['children'] != null &&
              this._data[this.selectedMenuIndex]['children'].length > 0) {
            this
                ._data[this.selectedMenuIndex]['children']
                .asMap()
                .forEach((int index, Map<String, dynamic> child) {
              if (child['value'] == _value[i]) {
                _flag = true;
                setState(() {
                  this._data[this.selectedMenuIndex]['children'][index]
                      ['selected'] = true;
                });
              }
            });
          }
        }
      } else if (widget.level == 2 && widget.multiSelect) {
        for (var i = 0, l = widget.value.length; i < l; i++) {
          if (widget.value[i] is List) continue;
          if (_valueArray.indexOf(widget.value[i]) != -1) {
            setState(() {
              this.selectedMenuIndex = _valueArray.indexOf(widget.value[i]);
            });
            break;
          }
        }
        for (var i = 0, l = widget.value.length; i < l; i++) {
          if (!(widget.value[i] is List)) continue;
          for (var j = 0, jl = widget.value[i].length; j < jl; j++) {
            if (this._data[this.selectedMenuIndex]['children'] != null &&
                this._data[this.selectedMenuIndex]['children'].length > 0) {
              this
                  ._data[this.selectedMenuIndex]['children']
                  .asMap()
                  .forEach((int index, Map<String, dynamic> child) {
                if (child['value'] == widget.value[i][j]) {
                  multiSelectedChilrenMenu[this.selectedMenuIndex]
                      .add(child['value']);
                  setState(() {
                    this._data[this.selectedMenuIndex]['children'][index]
                        ['selected'] = true;
                  });
                }
              });
            }
          }
          break;
        }
      }
    }
  }

  Widget _buildOneLevelMenuContent() {
    List<Widget> _children = [];

    widget.data.asMap().forEach((int index, Map<String, dynamic> menu) {
      widget.multiSelect == true
          ? _children.add(MenuItemCheckbox(
              label: menu['label'],
              disabled: menu['disabled'],
              selected: multiSelectedParentMenu.indexOf(menu['value']) != -1,
              onTap: () {
                if (multiSelectedParentMenu.indexOf(menu['value']) == -1) {
                  setState(() {
                    multiSelectedParentMenu.add(menu['value']);
                  });
                } else {
                  var _current = multiSelectedParentMenu.indexOf(menu['value']);
                  setState(() {
                    multiSelectedParentMenu.removeAt(_current);
                  });
                }
                widget.onChange(multiSelectedParentMenu);
              },
              onCheckbox: (bool value) {
                if (value == true) {
                  setState(() {
                    multiSelectedParentMenu.add(menu['value']);
                  });
                } else {
                  var _current = multiSelectedParentMenu.indexOf(menu['value']);
                  setState(() {
                    multiSelectedParentMenu.removeAt(_current);
                  });
                }
                widget.onChange(multiSelectedParentMenu);
              },
            ))
          : _children.add(MenuItem(
              label: menu['label'],
              disabled: menu['disabled'],
              selected: menu == this.selectedParentMenu,
              onTap: () {
                setState(() {
                  this.selectedParentMenu = menu;
                });
                widget.onChange([menu['value']]);
              },
            ));
    });
    return widget.data.length > 0
        ? widget.multiSelect == true
            ? Stack(
                children: <Widget>[
                  Container(
                    height: widget.height != null
                        ? widget.height
                        : MediaQuery.of(context).size.height / 2,
                    child: SingleChildScrollView(
                      child: Column(
                        children: _children,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0.0,
                    right: 0.0,
                    bottom: 0.0,
                    child: MultiSelectButtonContainer(
                      onOk: widget.onOk,
                      onCancel: widget.onCancel,
                    ),
                  )
                ],
              )
            : Container(
                height: widget.height != null
                    ? widget.height
                    : MediaQuery.of(context).size.height / 2,
                child: SingleChildScrollView(
                  child: Column(
                    children: _children,
                  ),
                ),
              )
        : Center();
  }

  Widget _buildTwoLevelMenuContent() {
    List<Widget> _menuParent = [];
    List<List<Widget>> _children = [];

    this._data.asMap().forEach((int index, Map<String, dynamic> menu) {
      List<Widget> _menuChildren = [];
      if (menu['children'] != null && menu['children'].length > 0) {
        menu['children']
            .asMap()
            .forEach((int sort, Map<String, dynamic> child) {
          widget.multiSelect == true
              ? _menuChildren.add(MenuItemCheckbox(
                  label: child['label'],
                  disabled: child['disabled'],
                  onTap: () {
                    this
                        ._data
                        .asMap()
                        .forEach((int _index, Map<String, dynamic> _menu) {
                      if (_data[_index]['children'] != null &&
                          _data[_index]['children'].length > 0 &&
                          index != _index) {
                        _data[_index]['children']
                            .asMap()
                            .forEach((int count, Map<String, dynamic> a) {
                          _data[_index]['children'][count]['selected'] = false;
                        });
                      }
                    });
                    this
                        .multiSelectedChilrenMenu
                        .asMap()
                        .forEach((int _k, dynamic _s) {
                      if (_k != index) {
                        this.multiSelectedChilrenMenu[_k].clear();
                      }
                    });
                    if (this
                            .multiSelectedChilrenMenu[index]
                            .indexOf(child['value']) ==
                        -1) {
                      this.multiSelectedChilrenMenu[index].add(child['value']);
                    } else {
                      var _current = this
                          .multiSelectedChilrenMenu[index]
                          .indexOf(child['value']);
                      this.multiSelectedChilrenMenu[index].removeAt(_current);
                    }

                    setState(() {
                      this._data[index]['children'][sort]['selected'] =
                          !this._data[index]['children'][sort]['selected'];
                    });
                    var filteredSelected = [];
                    this
                        .multiSelectedChilrenMenu
                        .asMap()
                        .forEach((int t, List<dynamic> f) {
                      if (f.length > 0) filteredSelected = f;
                    });
                    widget.onChange(
                        [_data[selectedMenuIndex]['value'], filteredSelected]);
                  },
                  onCheckbox: (bool value) {
                    this
                        ._data
                        .asMap()
                        .forEach((int _index, Map<String, dynamic> _menu) {
                      if (_data[_index]['children'] != null &&
                          _data[_index]['children'].length > 0 &&
                          index != _index) {
                        _data[_index]['children']
                            .asMap()
                            .forEach((int count, Map<String, dynamic> a) {
                          _data[_index]['children'][count]['selected'] = false;
                        });
                      }
                    });
                    this
                        .multiSelectedChilrenMenu
                        .asMap()
                        .forEach((int _k, dynamic _s) {
                      if (_k != index) {
                        this.multiSelectedChilrenMenu[_k].clear();
                      }
                    });
                    if (this
                            .multiSelectedChilrenMenu[index]
                            .indexOf(child['value']) ==
                        -1) {
                      this.multiSelectedChilrenMenu[index].add(child['value']);
                    } else {
                      var _current = this
                          .multiSelectedChilrenMenu[index]
                          .indexOf(child['value']);
                      this.multiSelectedChilrenMenu[index].removeAt(_current);
                    }

                    setState(() {
                      this._data[index]['children'][sort]['selected'] =
                          !this._data[index]['children'][sort]['selected'];
                    });
                    var filteredSelected = [];
                    this
                        .multiSelectedChilrenMenu
                        .asMap()
                        .forEach((int t, List<dynamic> f) {
                      if (f.length > 0) filteredSelected.add(f);
                    });
                    widget.onChange(
                        [_data[selectedMenuIndex]['value'], filteredSelected]);
                  },
                  selected: this._data[index]['children'][sort]['selected'],
                ))
              : _menuChildren.add(MenuItem(
                  onTap: () {
                    setState(() {
                      this
                          ._data
                          .asMap()
                          .forEach((int _index, Map<String, dynamic> _menu) {
                        if (_data[_index]['children'] != null &&
                            _data[_index]['children'].length > 0) {
                          _data[_index]['children']
                              .asMap()
                              .forEach((int count, Map<String, dynamic> a) {
                            _data[_index]['children'][count]['selected'] =
                                false;
                          });
                        }
                      });
                      _data[index]['children'][sort]['selected'] = true;
                      widget.onChange(
                          [_data[selectedMenuIndex]['value'], child['value']]);
                    });
                  },
                  selected: child['selected'],
                  disabled: child['disabled'],
                  label: child['label'],
                  bottom: true));
        });
        _children.add(_menuChildren);
        _menuParent.add(MenuItem(
          onTap: () {
            setState(() {
              selectedParentMenu = menu;
            });
            selectedMenuIndex = index;
          },
          parent: true,
          selected: selectedMenuIndex == index,
          label: menu['label'],
        ));
      } else {
        _children.add(_menuChildren);
        _menuParent.add(MenuItem(
          onTap: () {
            setState(() {
              selectedParentMenu = menu;
            });
            selectedMenuIndex = index;
            widget.onChange([menu['value']]);
          },
          parent: true,
          selected: selectedMenuIndex == index,
          label: menu['label'],
        ));
      }
    });

    return widget.data.length > 0
        ? widget.multiSelect == true
            ? Stack(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: Container(
                          height: widget.height != null
                              ? widget.height
                              : MediaQuery.of(context).size.height / 2,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: _menuParent,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          height: widget.height != null
                              ? widget.height
                              : MediaQuery.of(context).size.height / 2,
                          decoration: BoxDecoration(color: Colors.white),
                          child: SingleChildScrollView(
                            padding: EdgeInsets.only(bottom: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: _children[selectedMenuIndex].length > 0
                                  ? _children[selectedMenuIndex]
                                  : [],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    left: 0.0,
                    right: 0.0,
                    bottom: 0.0,
                    child: MultiSelectButtonContainer(
                      onOk: widget.onOk,
                      onCancel: widget.onCancel,
                    ),
                  )
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Container(
                      height: widget.height != null
                          ? widget.height
                          : MediaQuery.of(context).size.height / 2,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _menuParent,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      height: widget.height != null
                          ? widget.height
                          : MediaQuery.of(context).size.height / 2,
                      decoration: BoxDecoration(color: Colors.white),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: _children[selectedMenuIndex].length > 0
                              ? _children[selectedMenuIndex]
                              : [],
                        ),
                      ),
                    ),
                  ),
                ],
              )
        : Center();
  }

  @override
  Widget build(BuildContext context) {
    Color _bgColor = (widget.data.length == 0 || widget.level == 1)
        ? Colors.white
        : Color(0XFFF5F5F9);
    return Container(
      height: widget.height != null
          ? widget.height
          : MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(color: _bgColor),
      child: widget.level == 1
          ? _buildOneLevelMenuContent()
          : _buildTwoLevelMenuContent(),
    );
  }
}

class MenuItemCheckbox extends StatelessWidget {
  MenuItemCheckbox(
      {Key key,
      this.disabled = false,
      @required this.label,
      @required this.selected,
      @required this.onTap,
      @required this.onCheckbox})
      : assert(onTap != null),
        assert(onCheckbox != null),
        super(key: key);
  final String label;
  final VoidCallback onTap;
  final ValueChanged<bool> onCheckbox;
  final bool selected;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled == true ? null : onTap,
      child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 44.0),
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(0.0),
                    padding: EdgeInsets.symmetric(vertical: 7.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          label,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: disabled == true
                                  ? Color(0XFFBBBBBB)
                                  : selected
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context)
                                          .textTheme
                                          .body1
                                          .color),
                        ),
                        AntCheckbox.Checkbox(
                          disabled: disabled,
                          checked: selected,
                          onChange: (value) {
                            this.onCheckbox(value);
                          },
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      left: 0.0,
                      right: 0.0,
                      bottom: 0.0,
                      child: Divider(
                        color: Color(0XFFDDDDDD),
                        height: 1.0,
                      ))
                ],
              ))),
    );
  }
}

class MenuItem extends StatelessWidget {
  MenuItem(
      {Key key,
      this.bottom = false,
      this.parent = false,
      this.disabled = false,
      @required this.label,
      @required this.selected,
      @required this.onTap})
      : super(key: key);
  final String label;
  final VoidCallback onTap;
  final bool selected;
  final bool disabled;
  final bool bottom;
  final bool parent;

  @override
  Widget build(BuildContext context) {
    Color _themeColor = Theme.of(context).primaryColor;
    return GestureDetector(
      onTap: parent == true ? onTap : disabled == true ? null : onTap,
      child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 44.0),
          child: Container(
            decoration: BoxDecoration(
              color: this.parent == true
                  ? this.selected == true ? Colors.white : Colors.transparent
                  : Colors.white,
            ),
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: this.bottom == true
                ? Stack(
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(0.0),
                        padding: EdgeInsets.symmetric(vertical: 7.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              label,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: disabled == true
                                      ? Color(0XFFBBBBBB)
                                      : selected
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context)
                                              .textTheme
                                              .body1
                                              .color),
                            ),
                            RotationTransition(
                              turns: AlwaysStoppedAnimation(45 / 360),
                              child: Container(
                                width: 7.0,
                                height: 14.0,
                                decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            width: 0.0,
                                            color: Colors.transparent),
                                        right: BorderSide(
                                            width: 1.5,
                                            color: disabled == true
                                                ? Colors.transparent
                                                : selected
                                                    ? _themeColor
                                                    : Colors.transparent),
                                        bottom: BorderSide(
                                            width: 1.5,
                                            color: disabled == true
                                                ? Colors.transparent
                                                : selected
                                                    ? _themeColor
                                                    : Colors.transparent),
                                        left: BorderSide(
                                            width: 0.0,
                                            color: Colors.transparent))),
                                child: Container(),
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                          left: 0.0,
                          right: 0.0,
                          bottom: 0.0,
                          child: Divider(
                            color: Color(0XFFDDDDDD),
                            height: 1.0,
                          ))
                    ],
                  )
                : this.parent == true
                    ? Container(
                        padding: EdgeInsets.symmetric(vertical: 7.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              label,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: selected
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context)
                                          .textTheme
                                          .body1
                                          .color),
                            )
                          ],
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.symmetric(vertical: 7.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              label,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: disabled == true
                                      ? Color(0XFFBBBBBB)
                                      : selected
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context)
                                              .textTheme
                                              .body1
                                              .color),
                            ),
                            RotationTransition(
                              turns: AlwaysStoppedAnimation(45 / 360),
                              child: Container(
                                width: 7.0,
                                height: 14.0,
                                decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            width: 0.0,
                                            color: Colors.transparent),
                                        right: BorderSide(
                                            width: 1.5,
                                            color: disabled == true
                                                ? Colors.transparent
                                                : selected
                                                    ? _themeColor
                                                    : Colors.transparent),
                                        bottom: BorderSide(
                                            width: 1.5,
                                            color: disabled == true
                                                ? Colors.transparent
                                                : selected
                                                    ? _themeColor
                                                    : Colors.transparent),
                                        left: BorderSide(
                                            width: 0.0,
                                            color: Colors.transparent))),
                                child: Container(),
                              ),
                            )
                          ],
                        ),
                      ),
          )),
    );
  }
}

class MultiSelectButtonContainer extends StatelessWidget {
  MultiSelectButtonContainer(
      {Key key, @required this.onOk, @required this.onCancel})
      : assert(onOk != null),
        assert(onCancel != null),
        super(key: key);
  final VoidCallback onOk;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 5,
          // child: FlatButton(
          //   child: Text('取消'),
          //   color: Colors.white,
          //   onPressed: () {},
          // ),
          child: DecoratedBox(
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Color(0XFFDDDDDD), width: 0.5),
                ),
                color: Colors.white),
            child: Theme(
              data: Theme.of(context).copyWith(
                  buttonTheme: ButtonTheme.of(context).copyWith(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap)),
              child: OutlineButton(
                child: Text('取消'),
                onPressed: this.onCancel,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          // child: FlatButton(
          //   child: Text('确定'),
          //   color: Theme.of(context).primaryColor,
          //   onPressed: () {},
          // ),
          child: DecoratedBox(
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide.none,
                ),
                color: Theme.of(context).primaryColor),
            child: Theme(
              data: Theme.of(context).copyWith(
                  buttonTheme: ButtonTheme.of(context).copyWith(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap)),
              child: OutlineButton(
                child: Text('确定'),
                onPressed: this.onOk,
              ),
            ),
          ),
        )
      ],
    );
  }
}
