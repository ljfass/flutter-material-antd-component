import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Button<T> extends StatefulWidget {
  Button(
      {Key key,
      @required this.buttonText,
      this.buttonTextColor,
      this.type = 'default',
      this.size = 'large',
      this.disabled = false,
      this.onClick,
      this.loading = false,
      this.icon,
      this.radius = 5.0,
      this.showBorder = true,
      this.textAlign = 'center'})
      : assert(buttonText is String || buttonText is Widget),
        assert(type == 'default' ||
            type == 'primary' ||
            type == 'ghost' ||
            type == 'warning'),
        assert(type == null || (size == 'small' || size == 'large')),
        assert(icon == null || (icon is IconData || icon is Icon)),
        assert(radius == null ||
            (radius != null && (0.0 <= radius && radius <= 100.0))),
        assert(
            textAlign == null || textAlign == 'left' || textAlign == 'center'),
        super(key: key);
  final T buttonText;
  final String type;
  final String size;
  final bool disabled;
  final VoidCallback onClick;
  final bool loading;
  final T icon;
  final double radius;
  final Color buttonTextColor;
  final bool showBorder;
  final String textAlign;

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool buttonActived = false;

  Widget buildButtonText<T>(buttonText, String type) {
    if (buttonText is String) {
      switch (type) {
        case 'primary':
          {
          
            return Text(
              widget.buttonText,
              style: TextStyle(
                color: widget.buttonTextColor != null
                    ? widget.buttonTextColor
                    : widget.disabled != true
                        ? buttonActived == false
                            ? Color(0XFFFFFFFF)
                            : HSLColor.fromAHSL(0.3, 0.0, 0.0, 1.0).toColor()
                        : HSLColor.fromAHSL(0.6, 0.0, 0.0, 1.0).toColor(),
                fontSize: widget.size == 'large' ? 16.0 : 13.0,
                fontWeight: FontWeight.w400,
              ),
            );
          }
          break;
        case 'ghost':
          {
            return Text(
              widget.buttonText,
              style: TextStyle(
                color: widget.buttonTextColor != null
                    ? widget.buttonTextColor
                    : widget.disabled != true
                        ? buttonActived == false
                            ? Color(0XFF108ee9)
                            : Color(0XFF108ee9).withOpacity(0.6)
                        : Color(0XFF000000).withOpacity(0.1),
                fontSize: widget.size == 'large' ? 16.0 : 13.0,
                fontWeight: FontWeight.w400,
              ),
            );
          }
          break;
        case 'warning':
          {
            return Text(
              widget.buttonText,
              style: TextStyle(
                color: widget.buttonTextColor != null
                    ? widget.buttonTextColor
                    : widget.disabled != true
                        ? buttonActived == false
                            ? Color(0XFFFFFFFF)
                            : HSLColor.fromAHSL(0.3, 0.0, 0.0, 1.0).toColor()
                        : HSLColor.fromAHSL(0.6, 0.0, 0.0, 1.0).toColor(),
                fontSize: widget.size == 'large' ? 16.0 : 13.0,
                fontWeight: FontWeight.w400,
              ),
            );
          }
          break;
        default:
          {
            return Text(
              widget.buttonText,
              style: TextStyle(
                color: widget.buttonTextColor != null
                    ? widget.buttonTextColor
                    : widget.disabled != true
                        ? Color(0XFF000000)
                        : Color(0XFF000000).withOpacity(0.3),
                fontSize: widget.size == 'large' ? 16.0 : 13.0,
                fontWeight: FontWeight.w400,
              ),
            );
          }
      }
    } else {
      switch (type) {
        case 'primary':
          {
            return DefaultTextStyle(
              style: TextStyle(
                color: widget.buttonTextColor != null
                    ? widget.buttonTextColor
                    : widget.disabled != true
                        ? buttonActived == false
                            ? Color(0XFFFFFFFF)
                            : HSLColor.fromAHSL(0.3, 0.0, 0.0, 1.0).toColor()
                        : HSLColor.fromAHSL(0.6, 0.0, 0.0, 1.0).toColor(),
                fontSize: widget.size == 'large' ? 16.0 : 13.0,
                fontWeight: FontWeight.w400,
              ),
              child: buttonText,
            );
          }
          break;
        case 'ghost':
          {
            return DefaultTextStyle(
              style: TextStyle(
                color: widget.buttonTextColor != null
                    ? widget.buttonTextColor
                    : widget.disabled != true
                        ? buttonActived == false
                            ? Color(0XFF108ee9)
                            : Color(0XFF108ee9).withOpacity(0.6)
                        : Color(0XFF000000).withOpacity(0.1),
                fontSize: widget.size == 'large' ? 16.0 : 13.0,
                fontWeight: FontWeight.w400,
              ),
              child: buttonText,
            );
          }
          break;
        case 'warning':
          {
            return DefaultTextStyle(
              style: TextStyle(
                color: widget.buttonTextColor != null
                    ? widget.buttonTextColor
                    : widget.disabled != true
                        ? buttonActived == false
                            ? Color(0XFFFFFFFF)
                            : HSLColor.fromAHSL(0.3, 0.0, 0.0, 1.0).toColor()
                        : HSLColor.fromAHSL(0.6, 0.0, 0.0, 1.0).toColor(),
                fontSize: widget.size == 'large' ? 16.0 : 13.0,
                fontWeight: FontWeight.w400,
              ),
              child: buttonText,
            );
          }
          break;
        default:
          {
            return DefaultTextStyle(
              style: TextStyle(
                color: widget.buttonTextColor != null
                    ? widget.buttonTextColor
                    : widget.disabled != true
                        ? Color(0XFF000000)
                        : Color(0XFF000000).withOpacity(0.3),
                fontSize: widget.size == 'large' ? 16.0 : 13.0,
                fontWeight: FontWeight.w400,
              ),
              child: buttonText,
            );
          }
      }
    }
  }

  Widget buildContent() {
    switch (widget.type) {
      case 'primary':
        {
          return Opacity(
            opacity: widget.disabled == true ? 0.4 : 1.0,
            child: RawMaterialButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                constraints: BoxConstraints(
                    maxHeight: widget.size == 'small' ? 30.0 : double.infinity,
                    minHeight: widget.size == 'small' ? 30.0 : 42.0),
                onPressed: widget.disabled == true
                    ? null
                    : widget.onClick == null
                        ? () {}
                        : () {
                            widget.onClick();
                          },
                splashColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                    side: widget.showBorder == true
                        ? BorderSide(color: Color(0XFF108EE9), width: 0.5)
                        : BorderSide.none,
                    borderRadius: BorderRadius.circular(widget.radius)),
                elevation: 0.0,
                highlightElevation: 0.0,
                fillColor: widget.disabled == true
                    ? Color(0XFF108EE9)
                    : buttonActived == false
                        ? Color(0XFF108EE9)
                        : Color(0XFF0E80D2),
                child: widget.loading == true
                    ? Row(
                        mainAxisAlignment: widget.textAlign == 'center'
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: widget.textAlign == 'center' ? 0.0 : 15.0,
                          ),
                          Container(
                              alignment: Alignment.topCenter,
                            padding: EdgeInsets.only(top: widget.size == 'small' ? 4.0:1.0),
                            child: ActivityIndicator(
                              size: widget.size,
                            ),
                          ),
                          SizedBox(
                            width: widget.size == 'small' ? 4.0 : 1.0,
                          ),
                          buildButtonText(widget.buttonText, widget.type)
                        ],
                      )
                    : widget.icon != null
                        ? Row(
                            mainAxisAlignment: widget.textAlign == 'center'
                                ? MainAxisAlignment.center
                                : MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width:
                                    widget.textAlign == 'center' ? 0.0 : 15.0,
                              ),
                              Theme(
                                  data: Theme.of(context).copyWith(
                                      iconTheme: Theme.of(context)
                                          .iconTheme
                                          .copyWith(
                                              size: widget.size == 'small'
                                                  ? 18.0
                                                  : Theme.of(context)
                                                      .iconTheme
                                                      .size,
                                              color: widget.disabled != true
                                                  ? buttonActived == false
                                                      ? Color(0XFFFFFFFF)
                                                      : HSLColor.fromAHSL(0.3,
                                                              0.0, 0.0, 1.0)
                                                          .toColor()
                                                  : HSLColor.fromAHSL(
                                                          0.6, 0.0, 0.0, 1.0)
                                                      .toColor())),
                                  child: widget.icon is Icon
                                      ? widget.icon
                                      : Icon(widget.icon)),
                              SizedBox(
                                width: 4.0,
                              ),
                              buildButtonText(widget.buttonText, widget.type)
                            ],
                          )
                        : Row(
                            mainAxisAlignment: widget.textAlign == 'center'
                                ? MainAxisAlignment.center
                                : MainAxisAlignment.start,
                            children: <Widget>[
                              widget.textAlign == 'center'
                                  ? buildButtonText(
                                      widget.buttonText, widget.type)
                                  : Padding(
                                      padding: EdgeInsets.only(left: 15.0),
                                      child: buildButtonText(
                                          widget.buttonText, widget.type),
                                    )
                            ],
                          ),
                onHighlightChanged: (bool value) {
                  setState(() {
                    buttonActived = value;
                  });
                }),
          );
        }
        break;
      case 'ghost':
        {
          return RawMaterialButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              constraints: BoxConstraints(
                  maxHeight: widget.size == 'small' ? 30.0 : double.infinity,
                  minHeight: widget.size == 'small' ? 30.0 : 42.0),
              onPressed: widget.disabled == true
                  ? null
                  : widget.onClick == null ? () {} : widget.onClick,
              splashColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  side: widget.showBorder == true
                      ? BorderSide(
                          color: widget.disabled == true
                              ? Color(0XFF000000).withOpacity(0.1)
                              : buttonActived == true
                                  ? Color(0XFF108EE9).withOpacity(0.6)
                                  : Color(0XFF108EE9),
                          width: 0.5)
                      : BorderSide.none,
                  borderRadius: BorderRadius.circular(widget.radius)),
              elevation: 0.0,
              highlightElevation: 0.0,
              highlightColor: Colors.transparent,
              fillColor: widget.disabled == true
                  ? Colors.transparent
                  : Colors.transparent,
              child: widget.loading == true
                  ? Row(
                      mainAxisAlignment: widget.textAlign == 'center'
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: widget.textAlign == 'center' ? 0.0 : 15.0,
                        ),
                        Container(
                            alignment: Alignment.topCenter,
                            padding: EdgeInsets.only(top: widget.size == 'small' ? 4.0:1.0),
                            child: ActivityIndicator(
                              size: widget.size,
                            ),
                          ),
                        SizedBox(
                          width: widget.size == 'small' ? 4.0 : 1.0,
                        ),
                        buildButtonText(widget.buttonText, widget.type)
                      ],
                    )
                  : widget.icon != null
                      ? Row(
                          mainAxisAlignment: widget.textAlign == 'center'
                              ? MainAxisAlignment.center
                              : MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: widget.textAlign == 'center' ? 0.0 : 15.0,
                            ),
                            Theme(
                              data: Theme.of(context).copyWith(
                                  iconTheme: Theme.of(context)
                                      .iconTheme
                                      .copyWith(
                                          size: widget.size == 'small'
                                              ? 18.0
                                              : Theme.of(context)
                                                  .iconTheme
                                                  .size,
                                          color: widget.disabled != true
                                              ? buttonActived == false
                                                  ? Color(0XFF108ee9)
                                                  : Color(0XFF108ee9)
                                                      .withOpacity(0.6)
                                              : Color(0XFF000000)
                                                  .withOpacity(0.1))),
                              child: widget.icon is Icon
                                  ? widget.icon
                                  : Icon(widget.icon),
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            buildButtonText(widget.buttonText, widget.type)
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            widget.textAlign == 'center'
                                ? buildButtonText(
                                    widget.buttonText, widget.type)
                                : Padding(
                                    padding: EdgeInsets.only(left: 15.0),
                                    child: buildButtonText(
                                        widget.buttonText, widget.type),
                                  )
                          ],
                        ),
              onHighlightChanged: (bool value) {
                setState(() {
                  buttonActived = value;
                });
              });
        }
        break;
      case 'warning':
        {
          return Opacity(
            opacity: widget.disabled == true ? 0.4 : 1.0,
            child: RawMaterialButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                constraints: BoxConstraints(
                    maxHeight: widget.size == 'small' ? 30.0 : double.infinity,
                    minHeight: widget.size == 'small' ? 30.0 : 42.0),
                onPressed: widget.disabled == true
                    ? null
                    : widget.onClick == null ? () {} : widget.onClick,
                splashColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                    side: widget.showBorder == true
                        ? BorderSide(color: Color(0XFFDDDDDD), width: 0.5)
                        : BorderSide.none,
                    borderRadius: BorderRadius.circular(widget.radius)),
                elevation: 0.0,
                highlightElevation: 0.0,
                fillColor: widget.disabled == true
                    ? Color(0XFFE94F4F)
                    : buttonActived == false
                        ? Color(0XFFE94F4F)
                        : Color(0XFFD24747),
                child: widget.loading == true
                    ? Row(
                        mainAxisAlignment: widget.textAlign == 'center'
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: widget.textAlign == 'center' ? 0.0 : 15.0,
                          ),
                          Container(
                              alignment: Alignment.topCenter,
                            padding: EdgeInsets.only(top: widget.size == 'small' ? 4.0:1.0),
                            child: ActivityIndicator(
                              size: widget.size,
                            ),
                          ),
                          SizedBox(
                           width: widget.size == 'small' ? 4.0 : 1.0,
                          ),
                          buildButtonText(widget.buttonText, widget.type)
                        ],
                      )
                    : widget.icon != null
                        ? Row(
                            mainAxisAlignment: widget.textAlign == 'center'
                                ? MainAxisAlignment.center
                                : MainAxisAlignment.start,
                            children: <Widget>[
                                SizedBox(
                                  width:
                                      widget.textAlign == 'center' ? 0.0 : 15.0,
                                ),
                                Theme(
                                    data: Theme.of(context).copyWith(
                                        iconTheme:
                                            Theme.of(context).iconTheme.copyWith(
                                                size: widget.size == 'small'
                                                    ? 18.0
                                                    : Theme.of(context)
                                                        .iconTheme
                                                        .size,
                                                color: widget.disabled != true
                                                    ? buttonActived == false
                                                        ? Color(0XFFFFFFFF)
                                                        : HSLColor.fromAHSL(0.3,
                                                                0.0, 0.0, 1.0)
                                                            .toColor()
                                                    : HSLColor.fromAHSL(
                                                            0.6, 0.0, 0.0, 1.0)
                                                        .toColor())),
                                    child: widget.icon is Icon
                                        ? widget.icon
                                        : Icon(widget.icon)),
                                SizedBox(
                                  width: 4.0,
                                ),
                                buildButtonText(widget.buttonText, widget.type)
                              ])
                        : Row(
                            mainAxisAlignment: widget.textAlign == 'center'
                                ? MainAxisAlignment.center
                                : MainAxisAlignment.start,
                            children: <Widget>[
                              widget.textAlign == 'center'
                                  ? buildButtonText(
                                      widget.buttonText, widget.type)
                                  : Padding(
                                      padding: EdgeInsets.only(left: 15.0),
                                      child: buildButtonText(
                                          widget.buttonText, widget.type),
                                    )
                            ],
                          ),
                onHighlightChanged: (bool value) {
                  setState(() {
                    buttonActived = value;
                  });
                }),
          );
        }
        break;
      default:
        {
          return Opacity(
            opacity: widget.disabled == true ? 0.6 : 1.0,
            child: RawMaterialButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                constraints: BoxConstraints(
                    maxHeight: widget.size == 'small' ? 30.0 : double.infinity,
                    minHeight: widget.size == 'small' ? 30.0 : 42.0),
                onPressed: widget.disabled == true
                    ? null
                    : widget.onClick == null ? () {} : widget.onClick,
                splashColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                    side: widget.showBorder == true
                        ? BorderSide(color: Color(0XFFDDDDDD), width: 0.5)
                        : BorderSide.none,
                    borderRadius: BorderRadius.circular(widget.radius)),
                highlightElevation: 0.0,
                elevation: 0.0,
                fillColor: widget.disabled == true
                    ? Color(0XFFFFFFFF)
                    : buttonActived == false
                        ? Color(0XFFFFFFFF)
                        : Color(0XFFDDDDDD),
                child: widget.loading == true
                    ? Row(
                        mainAxisAlignment: widget.textAlign == 'center'
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: widget.textAlign == 'center' ? 0.0 : 15.0,
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            padding: EdgeInsets.only(top: widget.size == 'small' ? 4.0:1.0),
                            child: ActivityIndicator(
                              size: widget.size,
                            ),
                          ),
                          SizedBox(
                             width: widget.size == 'small' ? 4.0 : 1.0,
                          ),
                          buildButtonText(widget.buttonText, widget.type)
                        ],
                      )
                    : widget.icon != null
                        ? Row(
                            mainAxisAlignment: widget.textAlign == 'center'
                                ? MainAxisAlignment.center
                                : MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width:
                                    widget.textAlign == 'center' ? 0.0 : 15.0,
                              ),
                              Theme(
                                  data: Theme.of(context).copyWith(
                                      iconTheme: Theme.of(context)
                                          .iconTheme
                                          .copyWith(
                                              size: widget.size == 'small'
                                                  ? 22.0
                                                  : Theme.of(context)
                                                      .iconTheme
                                                      .size,
                                              color: widget.disabled != true
                                                  ? Color(0XFF000000)
                                                  : Color(0XFF000000)
                                                      .withOpacity(0.3))),
                                  child: widget.icon is Icon
                                      ? widget.icon
                                      : Icon(widget.icon)),
                              SizedBox(
                                width: 4.0,
                              ),
                              buildButtonText(widget.buttonText, widget.type)
                            ],
                          )
                        : Row(
                            mainAxisAlignment: widget.textAlign == 'center'
                                ? MainAxisAlignment.center
                                : MainAxisAlignment.start,
                            children: <Widget>[
                              widget.textAlign == 'center'
                                  ? buildButtonText(
                                      widget.buttonText, widget.type)
                                  : Padding(
                                      padding: EdgeInsets.only(left: 15.0),
                                      child: buildButtonText(
                                          widget.buttonText, widget.type),
                                    )
                            ],
                          ),
                onHighlightChanged: (bool value) {
                  setState(() {
                    buttonActived = value;
                  });
                }),
          );
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildContent();
  }
}

class ActivityIndicator extends StatefulWidget {
  ActivityIndicator({
    Key key,
    this.size = 'small',
  })  : assert(size == 'small' || size == 'large'),
        super(key: key);
  final String size;

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
    return Container(
        width: widget.size == 'small' ? 20.0 : 32.0,
        height: widget.size == 'small' ? 20.0 : 32.0,
        decoration: BoxDecoration(color: Colors.transparent),
        child: ActivityIndicatorAnimation(
          animation: _animation,
          size: widget.size,
        ));
  }
}

num degToRad(num deg) => deg * (pi / 180.0);

class ProgressPainter extends CustomPainter {
  ProgressPainter({this.startAngle, this.size, this.context});
  final double startAngle;
  final String size;
  final BuildContext context;
  double strokeWidth;
  double radiusSize;

  @override
  void paint(Canvas canvas, Size size) {
    this.size == 'small' ? radiusSize = 6.0 : radiusSize = 9.0;
    final Offset offsetCenter =
        this.size == 'small' ? Offset(11.5, 11.5) : Offset(15.5, 15.5);

    this.strokeWidth = this.size == 'small' ? 0.8 : 1.1;
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
      ..color = Theme.of(context).primaryColor
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
      painter: ProgressPainter(
          startAngle: animation.value, size: size, context: context),
    );
  }
}
