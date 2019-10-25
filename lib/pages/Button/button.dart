import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../material/button/button.dart';

class PageButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Button'),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Button(
                  buttonText: 'default',
                  loading: false,
                  disabled: false,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Button(
                  buttonText: 'default disabled',
                  disabled: true,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Button(
                  buttonText: 'primary',
                  type: 'primary',
                ),
                SizedBox(
                  height: 10.0,
                ),
                Button(
                  buttonText: 'primary disabled',
                  type: 'primary',
                  disabled: true,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Button(
                  buttonText: 'warning',
                  type: 'warning',
                ),
                SizedBox(
                  height: 10.0,
                ),
                Button(
                  buttonText: 'warning disabled',
                  type: 'warning',
                  disabled: true,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Button(
                  buttonText: 'loading button',
                  loading: true,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Button(
                  buttonText: 'with icon',
                  icon: Icons.check_circle_outline,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Button(
                  buttonText: 'with custom icon',
                  icon: Icons.refresh,
                ),
              ],
            ),
          ),
        ));
  }
}
