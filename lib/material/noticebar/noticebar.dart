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
  final double duration;
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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(
            milliseconds:
                (_contentSize.width - _containerSize.width + 20.0).toInt() *
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
    final RenderBox containerRenderBox =
        _contentKey.currentContext.findRenderObject();
    final contentSize = containerRenderBox.size;
    _contentSize = contentSize;
    if (_contentSize.width > _containerSize.width) {
      _animation = Tween<double>(
              begin: _currentBegin,
              end: _contentSize.width - _containerSize.width + 20.0)
          .animate(_controller);
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedNoticeBar(
        animation: _animation,
        widget: widget,
        containerKey: _containerKey,
        contentKey: _contentKey);
  }
}

class AnimatedNoticeBar extends AnimatedWidget {
  AnimatedNoticeBar({
    Key key,
    Animation<double> animation,
    this.containerKey,
    this.contentKey,
    this.widget,
  }) : super(key: key, listenable: animation);
  final widget;
  final GlobalKey containerKey;
  final GlobalKey contentKey;

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Theme(
      data: Theme.of(context).copyWith(
          iconTheme: Theme.of(context)
              .iconTheme
              .copyWith(color: Color(0xfff76a24), size: 18.0)),
      child: Container(
        height: 36.0,
        decoration: BoxDecoration(
          color: Color(0xfffefcec),
        ),
        child: Row(
          children: <Widget>[
            widget.icon == null
                ? Container(
                    width: 0.0,
                    height: 0.0,
                  )
                : Container(
                    width: 22.0,
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
            widget.mode == null
                ? Container(
                    width: 0.0,
                    height: 0.0,
                  )
                : Container(
                    width: 40.0,
                    padding: EdgeInsets.only(right: 6.0),
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(color: Color(0xfffefcec)),
                    child: widget.mode == 'closable'
                        ? Icon(Icons.close)
                        : Icon(Icons.chevron_right),
                  ),
          ],
        ),
      ),
    );
  }
}
