import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Tag extends StatefulWidget {
  Tag(
      {Key key,
      this.small = false,
      this.disabled = false,
      this.closable = false,
      this.selected = false,
      this.onChange,
      this.onClose,
      this.afterClose,
      @required this.child})
      : super(key: key);

  final bool small;
  final bool disabled;
  final bool closable;
  final bool selected;
  final ValueChanged<bool> onChange;
  final VoidCallback onClose;
  final VoidCallback afterClose;
  final Widget child;

  @override
  _TagState createState() => _TagState();
}

class _TagState extends State<Tag> {
  bool _selected;
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    _selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    BoxDecoration boxDecoration = widget.disabled == true
        ? BoxDecoration(
            color: Color(0xffdddddd),
            border: Border.all(color: Color(0xffdddddd), width: 0.5),
            borderRadius: BorderRadius.circular(3.0))
        : BoxDecoration(
            border: Border.all(
                width: 0.5,
                color: _selected == true
                    ? Theme.of(context).primaryColor
                    : Color(0xffdddddd)),
            borderRadius: BorderRadius.circular(3.0));

    return widget.small == true
        ? Container(
            decoration: boxDecoration,
            height: 15.0,
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
            child: DefaultTextStyle(
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xff888888), fontSize: 10.0, height: 1.4),
              child: widget.child,
            ),
          )
        : widget.closable == true
            ? Visibility(
                visible: _visible,
                child: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    GestureDetector(
                      onTap:
                          (widget.disabled == true || widget.closable == true)
                              ? null
                              : () {
                                  setState(() {
                                    _selected = !_selected;
                                  });
                                  widget.onChange(_selected);
                                },
                      child: Container(
                        decoration: boxDecoration,
                        height: 25.0,
                        padding: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 15.0),
                        child: DefaultTextStyle(
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: widget.disabled == true
                                  ? Color(0xffbbbbbb)
                                  : _selected == true
                                      ? Theme.of(context).primaryColor
                                      : Color(0xff888888),
                              fontSize: 14.0,
                              height: 1.5),
                          child: widget.child,
                        ),
                      ),
                    ),
                    Positioned(
                      left: -22.0,
                      top: -22.0,
                      child: IconButton(
                        icon: Icon(
                          Icons.cancel,
                          color: Color(0xffbbbbbb),
                        ),
                        onPressed: widget.onClose == null
                            ? () {
                                setState(() {
                                  _visible = false;
                                });
                                if (widget.afterClose != null)
                                  widget.afterClose();
                              }
                            : () {
                                setState(() {
                                  _visible = false;
                                });
                                widget.onClose();
                                if (widget.afterClose != null)
                                  widget.afterClose();
                              },
                      ),
                    )
                  ],
                ),
              )
            : GestureDetector(
                onTap: widget.disabled == true
                    ? null
                    : () {
                        setState(() {
                          _selected = !_selected;
                        });
                        widget.onChange(_selected);
                      },
                child: Container(
                  decoration: boxDecoration,
                  height: 25.0,
                  padding:
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
                  child: DefaultTextStyle(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: widget.disabled == true
                            ? Color(0xffbbbbbb)
                            : _selected == true
                                ? Theme.of(context).primaryColor
                                : Color(0xff888888),
                        fontSize: 14.0,
                        height: 1.5),
                    child: widget.child,
                  ),
                ),
              );
  }
}
