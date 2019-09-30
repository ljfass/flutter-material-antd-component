import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

class Progress extends StatefulWidget {
  Progress({Key key, this.percent = 0, this.unfilled = true})
      : assert(percent >= 0 && percent <= 100),
        super(key: key);
  final double percent;

  final bool unfilled;

  @override
  _ProgressState createState() => _ProgressState();
}

class _ProgressState extends State<Progress>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;
  double _currentBegin = 0.0;
  double _currentEnd = 0.0;
  int maxValue = 100;

  @override
  void initState() {
    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _animation = Tween<double>(begin: _currentBegin, end: _currentEnd)
        .animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void triggerAnimation() {
    setState(() {
      _currentBegin = _animation.value;
      _currentEnd = widget.percent / maxValue;
      _animation = Tween<double>(begin: _currentBegin, end: _currentEnd)
          .animate(_controller);
    });
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    triggerAnimation();
    return AnimatedProgressBar(
      animation: _animation,
      widget: widget,
    );
  }
}

class AnimatedProgressBar extends AnimatedWidget {
  AnimatedProgressBar({
    Key key,
    Animation<double> animation,
    this.widget,
  }) : super(key: key, listenable: animation);
  final widget;

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    bool unfilled = widget.unfilled;
    return Container(
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            flex: (animation.value * 100).toInt(),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2.0)),
            ),
          ),
          Expanded(
              flex: 100 - (animation.value * 100).toInt(),
              child: Container(
                height: 4.0,
                decoration: BoxDecoration(
                    color: unfilled == false
                        ? Color(0xffdddddd)
                        : Colors.transparent),
              ))
        ],
      ),
    );
  }
}
