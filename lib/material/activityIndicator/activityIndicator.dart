import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math';

class ActivityIndicator extends StatefulWidget {
  ActivityIndicator(
      {Key key,
      this.animating = true,
      this.toast = false,
      this.size = 'small',
      this.text})
      : assert(size == 'small' || size == 'large'),
        super(key: key);
  final bool animating;
  final bool toast;
  final String size;
  final String text;

  @override
  _ActivityIndicatorState createState() => _ActivityIndicatorState();
}

class _ActivityIndicatorState extends State<ActivityIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController rotationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    rotationController = AnimationController(
        duration: const Duration(milliseconds: 4000), vsync: this);
    _animation =
        Tween<double>(begin: 11.0, end: 36.0).animate(rotationController);

    rotationController.forward();
    rotationController.addListener(() {
      if (rotationController.status == AnimationStatus.completed) {
        rotationController.repeat();
      }
    });
  }

  @override
  void dispose() {
    rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.animating == false
        ? Container()
        : widget.text == null
            ? widget.toast == true
                ? Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xff3a3a3a).withOpacity(0.9),
                            borderRadius: BorderRadius.circular(7.0)),
                        padding: EdgeInsets.all(15.0),
                        child: Container(
                            width: widget.size == 'small' ? 22.0 : 32.0,
                            height: widget.size == 'small' ? 22.0 : 32.0,
                            decoration:
                                BoxDecoration(color: Colors.transparent),
                            child: ActivityIndicatorAnimation(
                              animation: _animation,
                              size: widget.size,
                            )),
                      )
                    ],
                  )
                : Container(
                    width: widget.size == 'small' ? 22.0 : 32.0,
                    height: widget.size == 'small' ? 22.0 : 32.0,
                    decoration: BoxDecoration(color: Colors.transparent),
                    child: ActivityIndicatorAnimation(
                      animation: _animation,
                      size: widget.size,
                    ))
            : widget.toast == true
                ? Container(
                    decoration: BoxDecoration(
                        color: Color(0xff3a3a3a).withOpacity(0.9),
                        borderRadius: BorderRadius.circular(7.0)),
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                            width: widget.size == 'small' ? 22.0 : 32.0,
                            height: widget.size == 'small' ? 22.0 : 32.0,
                            decoration:
                                BoxDecoration(color: Colors.transparent),
                            child: ActivityIndicatorAnimation(
                              animation: _animation,
                              size: widget.size,
                            )),
                        Padding(
                          padding: EdgeInsets.only(top: 4.0),
                          child: Text(
                            widget.text,
                            style: TextStyle(
                                color: Color(0xffffffff), fontSize: 14.0),
                          ),
                        )
                      ],
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                          width: widget.size == 'small' ? 22.0 : 32.0,
                          height: widget.size == 'small' ? 22.0 : 32.0,
                          decoration: BoxDecoration(color: Colors.transparent),
                          child: ActivityIndicatorAnimation(
                            animation: _animation,
                            size: widget.size,
                          )),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          widget.text,
                          style: TextStyle(
                              color: Color(0xff000000).withOpacity(0.4),
                              fontSize: 14.0),
                        ),
                      )
                    ],
                  );
  }
}

num degToRad(num deg) => deg * (pi / 180.0);

class ProgressPainter extends CustomPainter {
  ProgressPainter({this.startAngle, this.size});
  final double startAngle;
  final String size;
  double strokeWidth;
  double radiusSize;

  @override
  void paint(Canvas canvas, Size size) {
    this.size == 'small' ? radiusSize = 9.0 : radiusSize = 14.0;
    final Offset offsetCenter =
        this.size == 'small' ? Offset(11.5, 11.5) : Offset(15.5, 15.5);

    this.strokeWidth = this.size == 'small' ? 1.2 : 1.5;
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Color(0xffd2d2d2)
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(offsetCenter, radiusSize, ringPaint);

    final angle = 360 * 0.2;
    final Rect arcRect = Rect.fromCircle(
        center: this.size == 'small' ? Offset(11.5, 11.5) : Offset(15.5, 15.5),
        radius: radiusSize);
    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..color = Colors.blue
      ..strokeWidth = strokeWidth;
    canvas.drawArc(arcRect, startAngle, degToRad(angle), false, progressPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class ActivityIndicatorAnimation extends AnimatedWidget {
  ActivityIndicatorAnimation(
      {Key key, Animation<double> animation, this.widget, this.size})
      : super(key: key, listenable: animation);

  final widget;
  final String size;

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return CustomPaint(
      painter: ProgressPainter(startAngle: animation.value, size: size),
    );
  }
}
