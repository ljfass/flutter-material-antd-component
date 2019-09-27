import 'package:flutter/material.dart';
import 'dart:math';

class Badge<T> extends StatefulWidget {
  Badge(
      {Key key,
      this.child,
      this.size = 'small',
      this.text,
      this.corner = false,
      this.dot = false,
      this.overflowCount = 99,
      this.hot = false})
      : assert(child == null || child is Widget),
        assert(
            text == null || (text != null && (text is String || text is num))),
        super(key: key);
  final Widget child;
  final String size;
  final T text;
  final bool corner;
  final bool dot;
  final num overflowCount;
  final bool hot;

  @override
  _BadgeState createState() => _BadgeState();
}

class _BadgeState extends State<Badge> {
  GlobalKey _containerKey = GlobalKey();
  Size _containerSize = Size(0, 0);

  @override
  void initState() {
    super.initState();
    if (widget.text is String && widget.child != null) {
      WidgetsBinding.instance.addPostFrameCallback(_onBuildCompleted);
    }
  }

  _onBuildCompleted(_) {
    _getContainerSize();
  }

  _getContainerSize() {
    final RenderBox containerRenderBox =
        _containerKey.currentContext.findRenderObject();
    final containerSize = containerRenderBox.size;
    setState(() {
      _containerSize = containerSize;
    });
  }

  Widget buildBadgeCorner(Widget _child) {
    return RotationTransition(
      turns: AlwaysStoppedAnimation(45 / 360),
      child: Container(
        alignment: Alignment.center,
        width: 80.0,
        height: 16.0,
        padding: EdgeInsets.fromLTRB(16.0, 2.0, 2.0, 2.0),
        decoration: BoxDecoration(color: Color(0XFFff5b05)),
        child: _child,
      ),
    );
  }

  Widget buildDot() {
    return DecoratedBox(
      decoration:
          BoxDecoration(color: Color(0XFFFF5B05), shape: BoxShape.circle),
      child: Container(
        width: 8.0,
        height: 8.0,
      ),
    );
  }

  Widget buildTextWithoutChild<T>(text) {
    if (widget.dot == true) {
      return buildDot();
    }
    if (text is num) {
      if (text == 0) {
        return Text('');
      }
      return ConstrainedBox(
        constraints: BoxConstraints(minWidth: 9.0),
        child: Container(
            height: 18.0,
            padding: EdgeInsets.symmetric(horizontal: 9.0, vertical: 2.0),
            decoration: BoxDecoration(
                color: Color(0XFFFF5B05),
                borderRadius: BorderRadius.circular(12.0)),
            child: text > widget.overflowCount
                ? Text('${widget.overflowCount}+',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, height: 1.2, fontSize: 12.0))
                : Text('$text',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, height: 1.2, fontSize: 12.0))),
      );
    } else {
      return ConstrainedBox(
        constraints: BoxConstraints(minWidth: 9.0),
        child: Container(
            height: 18.0,
            padding: EdgeInsets.symmetric(horizontal: 9.0, vertical: 2.0),
            decoration: BoxDecoration(
                color: Color(0XFFFF5B05),
                borderRadius: BorderRadius.circular(12.0)),
            child: Text(text,
                style: TextStyle(
                    color: Colors.white, height: 1.2, fontSize: 12.0))),
      );
    }
  }

  Widget buildTextWithChild<T>(text) {
    if (widget.dot == true) {
      return Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          widget.child,
          Positioned(
            right: -2.0,
            top: -4.0,
            child: buildDot(),
          )
        ],
      );
    }
    if (text is num) {
      if (text == 0) {
        return widget.child;
      }
      return Stack(
        alignment: Alignment.topRight,
        overflow: widget.corner == true ? Overflow.clip : Overflow.visible,
        children: <Widget>[
          widget.child,
          Positioned(
            right: widget.corner == true ? -32.0 : -9.0,
            top: widget.corner == true ? -0.0 : -6.0,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 9.0),
              child: widget.corner == true
                  ? buildBadgeCorner(text > widget.overflowCount
                      ? Text('${widget.overflowCount}+',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, height: 1.2, fontSize: 10.0))
                      : Text('$text',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              height: 1.2,
                              fontSize: 10.0)))
                  : Container(
                      height: 18.0,
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                      decoration: BoxDecoration(
                          color: Color(0XFFFF5B05),
                          borderRadius: BorderRadius.circular(12.0)),
                      child: text > widget.overflowCount
                          ? Text('${widget.overflowCount}+',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  height: 1.2,
                                  fontSize: 10.0))
                          : Text('$text',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  height: 1.2,
                                  fontSize: 10.0))),
            ),
          )
        ],
      );
    } else {
      return Stack(
        alignment: Alignment.topLeft,
        overflow: widget.corner == true ? Overflow.clip : Overflow.visible,
        children: <Widget>[
          widget.child,
          Positioned(
            right: widget.corner == true
                ? -_containerSize.width + 12
                : -_containerSize.width + 6,
            top: widget.corner == true ? 0.0 : -10.0,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 9.0),
              child: widget.corner == true
                  ? buildBadgeCorner(Text(text,
                      style: TextStyle(
                          color: Colors.white, height: 1.2, fontSize: 12.0)))
                  : Container(
                      key: _containerKey,
                      height: 18.0,
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                      decoration: BoxDecoration(
                          color: Color(0XFFFF5B05),
                          borderRadius: BorderRadius.circular(12.0)),
                      child: Text(text,
                          style: TextStyle(
                              color: Colors.white,
                              height: 1.2,
                              fontSize: 12.0))),
            ),
          )
        ],
      );
    }
  }

  Widget buildContent() {
    return widget.child != null
        ? buildTextWithChild(widget.text)
        : buildTextWithoutChild(widget.text);
  }

  @override
  Widget build(BuildContext context) {
    return buildContent();
  }
}
