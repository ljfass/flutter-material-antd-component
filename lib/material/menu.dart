import 'package:flutter/material.dart';
import './checkbox/checkbox.dart' as AntCheckbox;

class Menu extends StatefulWidget {
  Menu(
      {Key key,
      this.data,
      this.multiSelect = false,
      this.level = 2,
      this.height,
      @required this.onChange})
      : assert(level == 1 || level == 2),
        super(key: key);
  final List<Map<String, dynamic>> data;
  final bool multiSelect;
  final int level;
  final double height;
  final ValueChanged<List<dynamic>> onChange;

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  Map<String, dynamic> selectedParentMenu;
  List<dynamic> multiSelectedParentMenu = [];
  List<dynamic> multiSelectedChilrenMenu = [];
  int selectedMenuIndex = 0;
  List<Map<String, dynamic>> _data = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedParentMenu = widget.data[0];
    });

    widget.data.asMap().forEach((int index, Map<String, dynamic> menu) {
      List<Map<String, dynamic>> _children = [];
      if (menu['children'] != null && menu['children'].length > 0) {
        if (menu['isLeaf'] != null && menu['isLeaf'] == true) {
          _data.add(
              {'value': menu['value'], 'label': menu['label'], 'children': []});
        } else {
          menu['children']
              .asMap()
              .forEach((int index, Map<String, dynamic> child) {
            _children.add({
              'value': child['value'],
              'label': child['label'],
              'selected': false
            });
          });
          _data.add({
            'value': menu['value'],
            'label': menu['label'],
            'children': _children
          });
        }
      } else {
        _data.add({'value': menu['value'], 'label': menu['label']});
      }
    });
  }

  Widget _buildOneLevelMenuContent() {
    List<Widget> _children = [];
    widget.data.asMap().forEach((int index, Map<String, dynamic> menu) {
      widget.multiSelect == true
          ? _children.add(MenuItemCheckbox(
              label: menu['label'],
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
                    child: Row(
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
                                  side: BorderSide(
                                      color: Color(0XFFDDDDDD), width: 0.5),
                                ),
                                color: Colors.white),
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                  buttonTheme: ButtonTheme.of(context).copyWith(
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap)),
                              child: OutlineButton(
                                child: Text('确定'),
                                onPressed: () => {},
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
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap)),
                              child: OutlineButton(
                                child: Text('确定'),
                                onPressed: () => {},
                              ),
                            ),
                          ),
                        )
                      ],
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
                  onTap: () {
                    print(index);
                    print(selectedMenuIndex);
                    if (index != selectedMenuIndex) {
                      multiSelectedChilrenMenu.clear();
                    }
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

                    if (multiSelectedChilrenMenu.indexOf(child['value']) ==
                        -1) {
                      multiSelectedChilrenMenu.add(child['value']);
                    } else {
                      var _current =
                          multiSelectedChilrenMenu.indexOf(child['value']);
                      multiSelectedChilrenMenu.removeAt(_current);
                    }
                    setState(() {
                      this._data[index]['children'][sort]['selected'] =
                          !this._data[index]['children'][sort]['selected'];
                    });
                    widget.onChange(
                        [selectedMenuIndex, multiSelectedChilrenMenu]);
                  },
                  onCheckbox: (bool value) {
                    if (index != selectedMenuIndex) {
                      multiSelectedChilrenMenu.clear();
                    }
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
                    multiSelectedChilrenMenu.clear();
                    if (multiSelectedChilrenMenu.indexOf(child['value']) ==
                        -1) {
                      multiSelectedChilrenMenu.add(child['value']);
                    } else {
                      var _current =
                          multiSelectedChilrenMenu.indexOf(child['value']);
                      multiSelectedChilrenMenu.removeAt(_current);
                    }
                    setState(() {
                      this._data[index]['children'][sort]['selected'] =
                          !this._data[index]['children'][sort]['selected'];
                    });
                    widget.onChange([
                      _data[selectedMenuIndex]['value'],
                      multiSelectedChilrenMenu
                    ]);
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
        ? Row(
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                              color: selected
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).textTheme.body1.color),
                        ),
                        AntCheckbox.Checkbox(
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
      @required this.label,
      @required this.selected,
      @required this.onTap})
      : super(key: key);
  final String label;
  final VoidCallback onTap;
  final bool selected;
  final bool bottom;
  final bool parent;

  @override
  Widget build(BuildContext context) {
    Color _themeColor = Theme.of(context).primaryColor;
    return GestureDetector(
      onTap: onTap,
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
                                  color: selected
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
                                            color: selected
                                                ? _themeColor
                                                : Colors.transparent),
                                        bottom: BorderSide(
                                            width: 1.5,
                                            color: selected
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
                                  color: selected
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
                                            color: selected
                                                ? _themeColor
                                                : Colors.transparent),
                                        bottom: BorderSide(
                                            width: 1.5,
                                            color: selected
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
