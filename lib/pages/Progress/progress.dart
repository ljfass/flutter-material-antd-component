import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../material/progress/progress.dart';
import '../../material/button/button.dart';

class PageProgress extends StatefulWidget {
  @override
  _PageProgressState createState() => _PageProgressState();
}

class _PageProgressState extends State<PageProgress> {
  double percent = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Progress'),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Progress(
                percent: 40.0,
                unfilled: true,
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Progress(
                      percent: percent,
                      unfilled: false,
                    ),
                  ),
                  Text('${percent.toInt()}%')
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Button(
                buttonText: 'add',
                onClick: () {
                  setState(() {
                    if (percent == 100) {
                      percent = 0;
                    } else {
                      percent = percent + 10;
                    }
                  });
                },
              )
            ],
          ),
        ));
  }
}
