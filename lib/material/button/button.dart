import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button<T> extends StatefulWidget {
  Button({
    Key key,
    @required this.buttonText,
    this.buttonTextColor,
    this.type,
    this.size = 'large',
    this.disabled = false,
    this.onClick,
    this.loading = false,
    this.icon,
    this.radius = 5.0,
  })  : assert(buttonText is String || buttonText is Widget),
        assert(type == null ||
            (type != null &&
                (type == 'primary' || type == 'ghost' || type == 'warning'))),
        assert(type == null || (size == 'small' || size == 'large')),
        assert(icon == null || (icon is IconData || icon is Icon)),
        assert(radius == null ||
            (radius != null && (0.0 <= radius && radius <= 100.0))),
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

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool buttonActived = false;

  Widget buildButtonText<T>(buttonText, String type) {
    if (buttonText is String) {
      switch (type) {
        case 'primay':
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
            Text(
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
      DefaultTextStyle(
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
                    side: BorderSide(color: Color(0XFF108EE9), width: 0.5),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: widget.size == 'small' ? 15.0 : 18.0,
                            height: widget.size == 'small' ? 15.0 : 18.0,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.0,
                              backgroundColor: Colors.grey.withOpacity(0.3),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white.withOpacity(0.2)),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          buildButtonText(widget.buttonText, widget.type)
                        ],
                      )
                    : widget.icon != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              buildButtonText(widget.buttonText, widget.type)
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
                  side: BorderSide(
                      color: widget.disabled == true
                          ? Color(0XFF000000).withOpacity(0.1)
                          : buttonActived == true
                              ? Color(0XFF108EE9).withOpacity(0.6)
                              : Color(0XFF108EE9),
                      width: 0.5),
                  borderRadius: BorderRadius.circular(widget.radius)),
              elevation: 0.0,
              highlightElevation: 0.0,
              highlightColor: Colors.transparent,
              fillColor: widget.disabled == true
                  ? Colors.transparent
                  : Colors.transparent,
              child: widget.loading == true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: widget.size == 'small' ? 15.0 : 18.0,
                          height: widget.size == 'small' ? 15.0 : 18.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 1.0,
                            backgroundColor: Colors.grey.withOpacity(0.3),
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0XFF108EE9)),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        buildButtonText(widget.buttonText, widget.type)
                      ],
                    )
                  : widget.icon != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
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
                            buildButtonText(widget.buttonText, widget.type)
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
                    side: BorderSide(color: Color(0XFFDDDDDD), width: 0.5),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: widget.size == 'small' ? 15.0 : 18.0,
                            height: widget.size == 'small' ? 15.0 : 18.0,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.0,
                              backgroundColor: Colors.grey.withOpacity(0.3),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0XFF108EE9)),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          buildButtonText(widget.buttonText, widget.type)
                        ],
                      )
                    : widget.icon != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              buildButtonText(widget.buttonText, widget.type)
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
                    side: BorderSide(color: Color(0XFFDDDDDD), width: 0.5),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: widget.size == 'small' ? 15.0 : 18.0,
                            height: widget.size == 'small' ? 15.0 : 18.0,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.0,
                              backgroundColor: Colors.grey.withOpacity(0.3),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0XFF108EE9)),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          buildButtonText(widget.buttonText, widget.type)
                        ],
                      )
                    : widget.icon != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              buildButtonText(widget.buttonText, widget.type)
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
