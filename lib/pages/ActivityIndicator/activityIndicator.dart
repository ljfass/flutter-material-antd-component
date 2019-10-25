import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../material/activityIndicator/activityIndicator.dart';

class PageActivityIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ActivityIndicator'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
                child: Text('Without text'),
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0),
                child: ActivityIndicator(
                  animating: true,
                  toast: false,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
                child: Text('With text'),
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0),
                child: ActivityIndicator(
                  text: 'Loading...',
                  animating: true,
                  toast: false,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
                child: Text('With large size and customized text style'),
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0),
                child: ActivityIndicator(
                  size: 'large',
                  animating: true,
                ),
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 20.0,
                  ),
                  Text('Loading...'),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
                child: Text('toast'),
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0),
                child: ActivityIndicator(
                  size: 'large',
                  animating: true,
                  text: 'Loading...',
                  toast: true,
                ),
              ),
            ],
          ),
        ));
  }
}
