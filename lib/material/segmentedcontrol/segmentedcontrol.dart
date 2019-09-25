import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Segment {
  final String text;
  Segment(this.text);
}

class SegmentedControl extends StatefulWidget {
  final Color tintColor;
  final bool disabled;
  final int selectedIndex;
  final List<String> values;
  final ValueChanged<int> onChange;
  final ValueChanged<dynamic> onValueChange;

  SegmentedControl(
      {Key key,
      this.tintColor,
      this.selectedIndex = 0,
      this.disabled = false,
      @required this.values,
      this.onChange,
      this.onValueChange})
      : assert(selectedIndex is int),
        assert(values is List),
        super(key: key);

  @override
  _SegmentControlState createState() => new _SegmentControlState();
}

class _SegmentControlState extends State<SegmentedControl> {
  int activeIndex;
  Map<int, Widget> _children = new HashMap();
  void _handleSegmentSelect(int newValue) {
    if (widget.onChange != null) widget.onChange(newValue);
    if (widget.onValueChange != null)
      widget.onValueChange(widget.values[newValue]);

    setState(() {
      activeIndex = newValue;
    });
  }

  @override
  void initState() {
    super.initState();
    activeIndex = widget.selectedIndex != null ? widget.selectedIndex : 0;
    widget.values.asMap().forEach((int index, String text) {
      _children[index] = Text(text);
    });
  }

  Widget build(BuildContext context) {
    Color _color = widget.tintColor != null
        ? widget.tintColor.withOpacity(0.5)
        : Theme.of(context).primaryColor.withOpacity(0.5);
    return CupertinoSegmentedControl(
      children: _children,
      selectedColor: widget.disabled == true
          ? _color
          : widget.tintColor != null
              ? widget.tintColor
              : Theme.of(context).primaryColor,
      borderColor: widget.disabled == true
          ? _color
          : widget.tintColor != null
              ? widget.tintColor
              : Theme.of(context).primaryColor,
      pressedColor: widget.disabled == true
          ? widget.tintColor != null ? Colors.white : Colors.white
          : widget.tintColor != null
              ? widget.tintColor.withOpacity(0.2)
              : Theme.of(context).primaryColor.withOpacity(0.2),
      onValueChanged: widget.disabled == true
          ? (int newValue) {}
          : (int newValue) {
              _handleSegmentSelect(newValue);
            },
      groupValue: activeIndex,
    );
  }
}
