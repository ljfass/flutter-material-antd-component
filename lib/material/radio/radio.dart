import 'package:flutter/material.dart';

class Radio extends StatefulWidget {
  Radio(
      {Key key,
      this.defaultChecked,
      this.checked = false,
      this.disabled = false,
      this.onChange})
      : assert(onChange != null),
        super(key: key);
  final bool defaultChecked;
  final bool checked;
  final bool disabled;
  final ValueChanged<bool> onChange;

  @override
  _RadioState createState() => _RadioState();
}

class _RadioState extends State<Radio> {
  bool _checked;

  @override
  Widget build(BuildContext context) {
    if (widget.checked == null && widget.defaultChecked == null) {
      setState(() {
        _checked = false;
      });
    } else if (widget.defaultChecked != null) {
      setState(() {
        _checked = widget.defaultChecked;
      });
    } else {
      setState(() {
        _checked = widget.checked;
      });
    }
    var boxDecoration = widget.disabled == true
        ? BoxDecoration(
            border: Border.all(
              color: Color(0xffCCCCCC),
            ),
            color: Colors.white,
            shape: BoxShape.circle)
        : BoxDecoration(
            border: Border.all(color: Color(0xffCCCCCC)),
            shape: BoxShape.circle);
    var checkDecoration = widget.disabled == true
        ? _checked == true
            ? BoxDecoration(
                border: Border(
                    top: BorderSide(width: 0.0, color: Colors.transparent),
                    right: BorderSide(width: 1.5, color: Color(0XFFBBBBBB)),
                    bottom: BorderSide(width: 1.5, color: Color(0XFFBBBBBB)),
                    left: BorderSide(width: 0.0, color: Colors.transparent)))
            : BoxDecoration(
                border: Border(
                    top: BorderSide(width: 0.0, color: Colors.transparent),
                    right: BorderSide(width: 1.0, color: Colors.transparent),
                    bottom: BorderSide(width: 1.0, color: Colors.transparent),
                    left: BorderSide(width: 0.0, color: Colors.transparent)))
        : _checked == true
            ? BoxDecoration(
                border: Border(
                    top: BorderSide(width: 0.0, color: Colors.transparent),
                    right: BorderSide(
                        width: 1.5, color: Theme.of(context).primaryColor),
                    bottom: BorderSide(
                        width: 1.5, color: Theme.of(context).primaryColor),
                    left: BorderSide(width: 0.0, color: Colors.transparent)))
            : BoxDecoration(
                border: Border(
                    top: BorderSide(width: 0.0, color: Colors.transparent),
                    right: BorderSide(width: 1.5, color: Colors.white),
                    bottom: BorderSide(width: 1.5, color: Colors.white),
                    left: BorderSide(width: 0.0, color: Colors.transparent)));
    return GestureDetector(
      onTap: widget.disabled == true
          ? null
          : () {
              setState(() {
                _checked = !this._checked;
              });
              widget.onChange(_checked);
            },
      child: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: 20.0,
                height: 20.0,
                decoration: boxDecoration,
              ),
              Positioned(
                top: 2.0,
                right: 6.0,
                child: RotationTransition(
                  turns: AlwaysStoppedAnimation(45 / 360),
                  child: Container(
                    width: 8.0,
                    height: 14.0,
                    decoration: checkDecoration,
                    child: Container(),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
