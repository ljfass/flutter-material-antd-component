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
    if ((widget.text is String || widget.text is num) && widget.child != null) {
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
        padding: EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
        decoration: BoxDecoration(color: Color(0XFFff5b05)),
        child: _child,
      ),
    );
  }

  Widget buildHot(content) {
    return Container(
        height: 18.0,
        padding: EdgeInsets.symmetric(horizontal: 9.0, vertical: 1.5),
        decoration: BoxDecoration(
            color: Color(0XFFF96268),
            borderRadius: BorderRadius.circular(12.0)),
        child: content is String
            ? Text('$content',
                style:
                    TextStyle(color: Colors.white, height: 1.2, fontSize: 11.0))
            : buildNumber(content));
  }

  Widget buildNumber(num number) {
    return number > widget.overflowCount
        ? Text('${widget.overflowCount}+',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, height: 1.2, fontSize: 11.0))
        : Text('$number',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, height: 1.2, fontSize: 11.0));
  }

  Widget buildDot() {
    return DecoratedBox(
      decoration:
          BoxDecoration(color: Color(0XFFFF5B05), shape: BoxShape.circle),
      child: Container(
        width: widget.size == 'small' ? 7.5 : 15.5,
        height: widget.size == 'small' ? 7.5 : 15.5,
      ),
    );
  }

  Widget buildTextWithoutChild<T>(text) {
    if (widget.corner == true) {
      return Text('');
    }
    if (widget.dot == true) {
      return buildDot();
    }
    if (text == null) {
      return Text('');
    }
    if (text is num) {
      if (text == 0) {
        return Text('');
      }
      return widget.hot == true
          ? buildHot(text)
          : ConstrainedBox(
              constraints: BoxConstraints(minWidth: 9.0),
              child: Container(
                  height: 18.0,
                  padding: EdgeInsets.symmetric(horizontal: 9.0, vertical: 2.0),
                  decoration: BoxDecoration(
                      color: Color(0XFFFF5B05),
                      borderRadius: BorderRadius.circular(12.0)),
                  child: buildNumber(text)),
            );
    } else {
      return widget.hot == true
          ? buildHot(text)
          : Container(
              height: 18.0,
              padding: EdgeInsets.symmetric(horizontal: 9.0, vertical: 2.0),
              decoration: BoxDecoration(
                  color: Color(0XFFFF5B05),
                  borderRadius: BorderRadius.circular(12.0)),
              child: Text(text,
                  style: TextStyle(
                      color: Colors.white, height: 1.2, fontSize: 12.0)));
    }
  }

  Widget buildUsualContent(content) {
    if (content is num) {
      return Container(
          height: 18.0,
          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.5),
          decoration: BoxDecoration(
              color: Color(0XFFFF5B05),
              borderRadius: BorderRadius.circular(12.0)),
          child: buildNumber(content));
    } else if (content is String) {
      return Container(
          height: 18.0,
          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.5),
          decoration: BoxDecoration(
              color: Color(0XFFFF5B05),
              borderRadius: BorderRadius.circular(12.0)),
          child: Text(content,
              style:
                  TextStyle(color: Colors.white, height: 1.2, fontSize: 11.0)));
    }
  }

  Widget buildTextWithChild<T>(text) {
    if (widget.dot == true && widget.corner == true) {
      return Text('$text');
    }
    if (widget.dot == true) {
      return Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          widget.child,
          Positioned(
            right: -6.0,
            top: -4.0,
            child: buildDot(),
          )
        ],
      );
    }
    if (text == null) {
      return widget.child;
    }
    if (text is num) {
      if (text == 0) {
        return widget.child;
      }
      return Stack(
        overflow: widget.corner == true ? Overflow.clip : Overflow.visible,
        children: <Widget>[
          Container(
            key: _containerKey,
            child: widget.child,
          ),
          widget.corner == true
              ? Positioned(
                  left: -_containerSize.width / 2,
                  top: _containerSize.height / 2,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: 9.0),
                    child: widget.corner == true
                        ? buildBadgeCorner(buildNumber(text))
                        : widget.hot == true
                            ? buildHot(text)
                            : buildUsualContent(text),
                  ),
                )
              : Positioned(
                  left: _containerSize.width - 4,
                  top: -10.0,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: 9.0),
                    child: widget.corner == true
                        ? buildBadgeCorner(buildNumber(text))
                        : widget.hot == true
                            ? buildHot(text)
                            : buildUsualContent(text),
                  ),
                )
        ],
      );
    } else {
      // text is String
      return Stack(
        overflow: widget.corner == true ? Overflow.clip : Overflow.visible,
        children: <Widget>[
          Container(
            key: _containerKey,
            child: widget.child,
          ),
          widget.corner == true
              ? Positioned(
                  left: -_containerSize.width / 2,
                  top: _containerSize.height / 2,
                  child: widget.corner == true
                      ? buildBadgeCorner(Text('$text',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              height: 1.2,
                              fontSize: 12.0)))
                      : widget.hot == true
                          ? buildHot(text)
                          : buildUsualContent(text),
                )
              : Positioned(
                  left: _containerSize.width - 4,
                  top: -10.0,
                  child: widget.corner == true
                      ? buildBadgeCorner(Text('$text',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              height: 1.2,
                              fontSize: 12.0)))
                      : widget.hot == true
                          ? buildHot(text)
                          : buildUsualContent(text),
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
