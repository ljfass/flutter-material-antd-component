import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwipeAction extends StatefulWidget {
  SwipeAction(
      {Key key,
      @required this.child,
      this.left,
      this.right,
      this.autoClose = false,
      this.disdabled = false,
      this.onClose,
      this.onOpen,
      this.controller,
      this.swipeoutColor = Colors.white})
      : assert(child != null),
        super(key: key);
  final Widget child;
  final bool autoClose;
  final List<Map<String, dynamic>> left;
  final List<Map<String, dynamic>> right;
  final bool disdabled;
  final Color swipeoutColor;
  final VoidCallback onOpen;
  final VoidCallback onClose;
  final SlidableController controller;

  _SwipeActionState myState;

  @override
  _SwipeActionState createState() {
    myState = _SwipeActionState();
    return myState;
  }
}

class _SwipeActionState extends State<SwipeAction>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Offset> _animation;

  Curve _kResizeTimeCurve = Curves.decelerate;
  Duration _duration = Duration(milliseconds: 200);
  GlobalKey _leftActionsKey = GlobalKey();
  GlobalKey _rightActionsKey = GlobalKey();
  Size _leftActionsSize = Size(0, 0);
  Size _rightActionsSize = Size(0, 0);
  double initial = 0.0;
  double distance = 0.0;
  bool isOpen = false;

  Color _color = Colors.yellow;
  Color get color => _color;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_onBuildCompleted);
    _animationController =
        AnimationController(duration: _duration, vsync: this);
    _animation = Tween<Offset>(begin: Offset.zero, end: Offset(0.5, 0.0))
        .animate(CurvedAnimation(
            parent: _animationController, curve: _kResizeTimeCurve));
  }

  void _onBuildCompleted(_) {
    if (widget.right != null && widget.right.length > 0)
      _getRightActionsContainerSize();
    if (widget.left != null && widget.left.length > 0)
      _getLeftActionsContainerSize();
  }

  void _getRightActionsContainerSize() {
    final RenderBox containerRenderBox =
        _rightActionsKey.currentContext.findRenderObject();
    final containerSize = containerRenderBox.size;
    _rightActionsSize = containerSize;
  }

  void _getLeftActionsContainerSize() {
    final RenderBox containerRenderBox =
        _leftActionsKey.currentContext.findRenderObject();
    final containerSize = containerRenderBox.size;
    _leftActionsSize = containerSize;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  //build 右边按钮组
  List<Widget> _buildRightActions() {
    List<Widget> _actions = [];
    if (widget.right == null || widget.right.length == 0) return [];
    widget.right.asMap().forEach((int index, button) {
      _actions.add(DefaultTextStyle(
        style: TextStyle(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        child: GestureDetector(
          onTap: (button['onPress'] == null && widget.autoClose == false)
              ? null
              : () {
                  if (button['onPress'] != null) button['onPress']();
                  if (widget.autoClose == true)
                    _animationController.animateTo(.0);
                },
          child: button['text'] is String
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(color: widget.swipeoutColor),
                  alignment: Alignment.center,
                  child: Text(
                    button['text'],
                  ),
                )
              : button['text'],
        ),
      ));
    });
    return _actions;
  }

  // build 左边按钮组
  List<Widget> _buildLeftActions() {
    List<Widget> _actions = [];
    if (widget.left == null || widget.left.length == 0) return [];
    widget.left.asMap().forEach((int index, button) {
      _actions.add(DefaultTextStyle(
        style: TextStyle(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        child: GestureDetector(
          onTap: (button['onPress'] == null && widget.autoClose == false)
              ? null
              : () {
                  if (button['onPress'] != null) button['onPress']();
                  if (widget.autoClose == true)
                    _animationController.animateTo(.0);
                },
          child: button['text'] is String
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(color: widget.swipeoutColor),
                  alignment: Alignment.center,
                  child: Text(
                    button['text'],
                  ),
                )
              : button['text'],
        ),
      ));
    });
    return _actions;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (TapUpDetails details) {
        isOpen = false;
      },
      onTapCancel: () {
        isOpen = false;
      },
      onTapDown: (TapDownDetails details) {
        widget.controller?._activeState = this;
        if (isOpen == true) {
          setState(() {
            _animationController.animateTo(.0);
          });
          if (widget.onClose != null) widget.onClose();
        }
      },
      onHorizontalDragStart: (DragStartDetails details) {
        widget.controller?.activeState = this;
        initial = details.globalPosition.dx;
      },
      onHorizontalDragUpdate: (widget.left == null && widget.right == null)
          ? null
          : (DragUpdateDetails detials) {
              // if (_animationController.value > 0.65) return;
              if (widget.disdabled == true) return;
              if (isOpen == true) return;
              distance = detials.globalPosition.dx - initial;
              if (widget.left == null || widget.left.length == 0) {
                if (distance > 0) return;
              }
              if (widget.right == null || widget.right.length == 0) {
                if (distance < 0) return;
              }

              if (detials.globalPosition.dx - initial > 0) {
                //drag from left to right
                _animation = Tween<Offset>(
                        begin: Offset.zero,
                        end: Offset(
                            (_leftActionsSize.width / context.size.width), 0.0))
                    .animate(CurvedAnimation(
                        parent: _animationController,
                        curve: _kResizeTimeCurve));
                setState(() {
                  _animationController.value +=
                      detials.primaryDelta / context.size.width;
                });
              } else {
                _animation = Tween<Offset>(
                        begin: Offset.zero,
                        end: Offset(
                            (-_rightActionsSize.width / context.size.width),
                            0.0))
                    .animate(CurvedAnimation(
                        parent: _animationController,
                        curve: _kResizeTimeCurve));
                setState(() {
                  _animationController.value -=
                      detials.primaryDelta / context.size.width;
                });
              }
            },
      onHorizontalDragEnd: (widget.left == null && widget.right == null)
          ? null
          : (DragEndDetails details) {
              if (widget.disdabled == true) return;
              if (details.primaryVelocity > 2000) {
                _animationController.animateTo(.0);
                if (widget.onClose != null) widget.onClose();
              } else if (details.primaryVelocity < -2000 ||
                  _animationController.value > 0.28) {
                if (widget.onOpen != null) widget.onOpen();
                _animationController.animateTo(1.0);

                isOpen = true;
              } else // close if none of above
                _animationController.animateTo(.0);
              // if (widget.onClose != null) widget.onClose();
            },
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            right: 0.0,
            top: 0.0,
            child: LayoutBuilder(
              builder: (_, constraint) {
                return Stack(
                  children: <Widget>[
                    Positioned(
                      right: .0,
                      top: .0,
                      bottom: .0,
                      child: Container(
                        key: _rightActionsKey,
                        child: Row(
                          children: _buildRightActions(),
                        ),
                      ),
                    ),
                    Positioned(
                      left: .0,
                      top: .0,
                      bottom: .0,
                      child: Container(
                        key: _leftActionsKey,
                        child: Row(
                          children: _buildLeftActions(),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          SlideTransition(
              position: _animation,
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: widget.child,
              )),
        ],
      ),
    );
  }
}

class MyChildWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SwipeAction widget = context.ancestorWidgetOfExactType(SwipeAction);
    final _SwipeActionState state = widget?.myState;

    return new Container(
      width: 100.0,
      height: 100.0,
      color: state == null ? Colors.blue : state.color,
    );
  }
}

class SlidableController {
  SlidableController();

  _SwipeActionState _activeState;

  _SwipeActionState get activeState => _activeState;

  set activeState(_SwipeActionState value) {
    _activeState = value;
  }
}
