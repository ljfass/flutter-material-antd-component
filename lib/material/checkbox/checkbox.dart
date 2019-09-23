import 'package:flutter/material.dart';

class Checkbox extends StatefulWidget {
  Checkbox(
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
  _CheckboxState createState() => _CheckboxState();
}

class _CheckboxState extends State<Checkbox> {
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
              color: Color(0xff888888).withOpacity(0.2),
            ),
            color: Colors.white,
            shape: BoxShape.circle)
        : _checked == true
            ? BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                ),
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle)
            : BoxDecoration(
                border: Border.all(color: Color(0xffCCCCCC)),
                color: Colors.transparent,
                shape: BoxShape.circle);
    var checkDecoration = widget.disabled == true
        ? _checked == true
            ? BoxDecoration(
                border: Border(
                    top: BorderSide(width: 0.0, color: Colors.transparent),
                    right: BorderSide(
                        width: 1.0, color: Color(0xff888888).withOpacity(0.2)),
                    bottom: BorderSide(
                        width: 1.0, color: Color(0xff888888).withOpacity(0.2)),
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
                    right: BorderSide(width: 1.0, color: Colors.white),
                    bottom: BorderSide(width: 1.0, color: Colors.white),
                    left: BorderSide(width: 0.0, color: Colors.transparent)))
            : BoxDecoration(
                border: Border(
                    top: BorderSide(width: 0.0, color: Colors.transparent),
                    right: BorderSide(width: 1.0, color: Colors.white),
                    bottom: BorderSide(width: 1.0, color: Colors.white),
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
      child: Stack(
        children: <Widget>[
          Container(
            width: 20.0,
            height: 20.0,
            decoration: boxDecoration,
          ),
          Positioned(
            top: 3.0,
            right: 7.0,
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(45 / 360),
              child: Container(
                width: 5.0,
                height: 11.0,
                decoration: checkDecoration,
                child: Container(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
