import 'package:flutter/material.dart';

class WingBlank extends StatelessWidget {
  WingBlank({Key key, @required this.child, this.size = 'lg'})
      : super(key: key);

  final String size;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    double _margin = 0;
    switch (this.size) {
      case 'lg':
        {
          _margin = 15.0;
          break;
        }
      case 'md':
        {
          _margin = 8.0;
          break;
        }
      case 'sm':
        {
          _margin = 5.0;
          break;
        }
      default:
        {
          _margin = 15.0;
        }
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: _margin),
      child: this.child,
    );
  }
}
