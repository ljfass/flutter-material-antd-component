import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../material/badge/badge.dart';

class PageBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Badge'),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          child: Column(
            children: <Widget>[
              Badge(
                text: 122,
                dot: true,
                hot: true,
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(color: Colors.grey),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Badge(
                text: 60,
                overflowCount: 55,
              ),
              SizedBox(
                height: 10.0,
              ),
              Badge(
                text: '促',
                corner: true,
                child: Container(
                  width: 50,
                  height: 200,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Text('Use corner prop'),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Badge(
                text: '促',
                corner: true,
                child: Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Text('Use corner prop'),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Badge(
                text: 'new',
              ),

              SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  Badge(
                    text: '减',
                    hot: true,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Badge(
                    text: '惠',
                    hot: true,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Badge(
                    text: '免',
                    hot: true,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Badge(
                    text: '反',
                    hot: true,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Badge(
                    text: 'Hot',
                    hot: true,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                ],
              )

              // SizedBox(
              //   height: 20.0,
              // ),
              // Badge(
              //   text: 122,
              //   hot: true,
              //   corner: true,
              //   child: Container(
              //     width: 200,
              //     height: 50,
              //     decoration: BoxDecoration(color: Colors.white),
              //   ),
              // ),
              // SizedBox(
              //   height: 20.0,
              // ),
              // Badge(
              //   text: 122,
              //   hot: false,
              //   corner: true,
              //   child: Container(
              //     width: 200,
              //     height: 50,
              //     decoration: BoxDecoration(color: Colors.white),
              //   ),
              // ),
            ],
          ),
        ));
  }
}
