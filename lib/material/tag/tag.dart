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
                      left: -10.0,
                      top: -7.0,
                     
                      child: TagCloseButton(
                        onClick: widget.onClose == null
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

class TagCloseButton extends StatelessWidget {
  TagCloseButton({Key key, this.onClick}) : super(key: key);
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        width: 16.0,
        height: 16.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color(0xffbbbbbb), width: 1),
            shape: BoxShape.circle),
        child: RotationTransition(
          turns: AlwaysStoppedAnimation(45 / 360),
          child: Container(
            width: 9.0,
            height: 9.0,
            child: CustomPaint(
              painter: CrossPainter(),
            ),
          ),
        ),
      ),
    );
  }
}

class CrossPainter extends CustomPainter {
  CrossPainter({this.size});

  final String size;

  @override
  void paint(Canvas canvas, Size size) {
    final p1 = Offset(4.5, 0.0);
    final p2 = Offset(4.5, 9.0);
    final paint = Paint()
      ..color = Color(0xffbbbbbb)
      ..strokeWidth = 1.2;
    canvas.drawLine(p1, p2, paint);

    final _p1 = Offset(0.0, 4.5);
    final _p2 = Offset(9.0, 4.5);
    final _paint = Paint()
      ..color = Color(0xffbbbbbb)
      ..strokeWidth = 1.2;
    canvas.drawLine(_p1, _p2, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
