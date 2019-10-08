import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class NoticeBar extends StatefulWidget {
  NoticeBar(
      {Key key,
      @required this.noticeText,
      this.mode,
      this.icon = Icons.volume_up,
      this.onClick,
      this.action,
      this.duration,
      this.loop = false})
      : assert(mode == null || (mode == 'closable' || mode == 'link')),
        super(key: key);
  final String mode;
  final IconData icon;
  final VoidCallback onClick;
  final Widget action;
  final String noticeText;
  final int duration;
  final bool loop;

  @override
  _NoticeBarState createState() => _NoticeBarState();
}

class _NoticeBarState extends State<NoticeBar>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;
  double _currentBegin = 0.0;
  double _currentEnd = 0.0;
  GlobalKey _containerKey = GlobalKey();
  GlobalKey _contentKey = GlobalKey();
  Size _containerSize = Size(0, 0);
  Size _contentSize = Size(0, 0);
  bool visible = true;
  VisibleNotifier _visible;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: Duration(
            milliseconds: widget.duration != null
                ? widget.duration
                : (_contentSize.width - _containerSize.width + 20.0).toInt() *
                    500),
        vsync: this);
    _animation = Tween<double>(begin: _currentBegin, end: _currentEnd)
        .animate(_controller);
    _controller.addListener(() {
      if ((_contentSize.width - _containerSize.width + 20) ==
          _animation.value) {
        if (widget.loop == true) {
          Future.delayed(Duration(milliseconds: 500), () {
            _controller.reset();
            _controller.forward();
          });
        } else {
          _controller.stop();
        }
      }
    });
    WidgetsBinding.instance.addPostFrameCallback(_onBuildCompleted);
    super.initState();
  }

  _onBuildCompleted(_) {
    _getContainerSize();
    _getContentSize();
  }

  _getContainerSize() {
    final RenderBox containerRenderBox =
        _containerKey.currentContext.findRenderObject();
    final containerSize = containerRenderBox.size;
    _containerSize = containerSize;
  }

  _getContentSize() {
    // _visible.addListener(_handleVisibleChange);
    _visible = VisibleNotifier(true);
    _visible.addListener(_handleVisibleChange);
    final RenderBox containerRenderBox =
        _contentKey.currentContext.findRenderObject();
    final contentSize = containerRenderBox.size;
    _contentSize = contentSize;
    if (_contentSize.width > _containerSize.width) {
      setState(() {
        _animation = Tween<double>(
                begin: _currentBegin,
                end: _contentSize.width - _containerSize.width + 20.0)
            .animate(_controller);
        _controller.forward();
      });
    }
  }

  void _handleVisibleChange() {
    setState(() {
      visible = _visible.value;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: AnimatedNoticeBar(
          animation: _animation,
          vd: _visible,
          widget: widget,
          containerKey: _containerKey,
          contentKey: _contentKey),
    );
  }
}

class AnimatedNoticeBar extends AnimatedWidget {
  AnimatedNoticeBar({
    Key key,
    Animation<double> animation,
    this.containerKey,
    this.contentKey,
    this.widget,
    this.vd,
  }) : super(key: key, listenable: animation);
  final widget;
  final GlobalKey containerKey;
  final GlobalKey contentKey;
  final VisibleNotifier vd;

  Widget buildTail() {
    Widget tail;
    if (widget.mode == null) {
      tail = Container(
        width: 0.0,
        height: 0.0,
      );
    } else if (widget.mode == 'closable') {
      tail = GestureDetector(
          child: Container(
            padding: EdgeInsets.only(left: 4.0),
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(color: Color(0xfffefcec)),
            child: widget.action == null ? Icon(Icons.close) : widget.action,
          ),
          onTap: widget.onClick == null
              ? () {
                  vd.value = false;
                }
              : () {
                  widget.onClick();
                  vd.value = false;
                });
    } else if (widget.mode == 'link') {
      tail = GestureDetector(
          child: Container(
            padding: EdgeInsets.only(left: 4.0),
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(color: Color(0xfffefcec)),
            child: widget.action == null
                ? Icon(Icons.chevron_right)
                : widget.action,
          ),
          onTap: widget.onClick == null
              ? null
              : () {
                  widget.onClick();
                });
    }
    return tail;
  }

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Theme(
      data: Theme.of(context).copyWith(
          iconTheme: Theme.of(context)
              .iconTheme
              .copyWith(color: Color(0xfff76a24), size: 17.0)),
      child: Container(
        height: 36.0,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          color: Color(0xfffefcec),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            widget.icon == null
                ? Container(
                    width: 0.0,
                    height: 0.0,
                  )
                : Container(
                    padding: EdgeInsets.only(right: 6.0),
                    decoration: BoxDecoration(color: Color(0xfffefcec)),
                    child: Icon(widget.icon),
                  ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Container(
                    key: containerKey,
                    height: 36.0,
                    child: Text(
                      widget.noticeText,
                      style: TextStyle(color: Colors.transparent),
                    ),
                  ),
                  Positioned(
                    left: -animation.value,
                    top: 0.0,
                    key: contentKey,
                    child: Text(
                      widget.noticeText,
                      style: TextStyle(
                          height: 2.4,
                          color: Color(0xfff76a24),
                          fontSize: 12.0),
                    ),
                  )
                ],
              ),
            ),
            buildTail(),
          ],
        ),
      ),
    );
  }
}

class VisibleNotifier extends ValueNotifier<bool> {
  VisibleNotifier(value) : super(value);
}
