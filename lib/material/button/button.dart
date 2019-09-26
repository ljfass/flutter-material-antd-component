import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button<T> extends StatefulWidget {
  Button(
      {Key key,
      @required this.buttonText,
      this.type,
      this.size = 'large',
      this.disabled = false,
      this.onClick,
      this.loading = false,
      this.icon})
      : assert(type == null ||
            (type != null &&
                (type == 'primary' || type == 'ghost' || type == 'warning'))),
        assert(size == 'small' || size == 'large'),
        assert(icon == null || (icon is Icon || icon is Widget)),
        super(key: key);
  final String buttonText;
  final String type;
  final String size;
  final bool disabled;
  final VoidCallback onClick;
  final bool loading;
  final T icon;

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  Widget buildContent() {
    switch (widget.type) {
      case 'primary':
        {}
        break;
      case 'ghost':
        {}
        break;
      case 'warning':
        {}
        break;
      default:
        {
          return DecoratedBox(
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide.none,
                ),
                color: widget.disabled == true
                    ? Colors.white.withOpacity(0.3)
                    : Colors.white),
            child: Theme(
              data: Theme.of(context).copyWith(
                  buttonTheme: ButtonTheme.of(context).copyWith(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap)),
              child: OutlineButton(
                onPressed: widget.disabled == true
                    ? null
                    : widget.onClick == null ? () {} : widget.onClick,
                textColor: Colors.black,
                highlightColor: Color(0XFFDDDDDD),
                highlightedBorderColor: Color(0XFFDDDDDD),
                child: widget.loading == true
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 18.0,
                            height: 18.0,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.0,
                              backgroundColor: Colors.grey.withOpacity(0.3),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            widget.buttonText,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: widget.disabled != true
                                    ? Colors.black
                                    : Color(0XFF000000).withOpacity(0.3),
                                fontSize: 18.0),
                          )
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            widget.buttonText,
                            style: TextStyle(
                              color: widget.disabled != true
                                  ? Colors.black
                                  : Color(0XFF000000).withOpacity(0.3),
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                borderSide: BorderSide(color: Color(0XFFDDDDDD), width: 0.5),
              ),
            ),
          );
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildContent();
  }
}
