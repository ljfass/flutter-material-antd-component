import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../material/tag/tag.dart';

class PageTag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tag'),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Column(
            children: <Widget>[
              Tag(
                child: Text('Basic'),
              ),
              SizedBox(
                height: 10.0,
              ),
              Tag(
                child: Text('Selected'),
                selected: true,
              ),
              SizedBox(
                height: 20.0,
              ),
              Tag(
                child: Text('Disabled'),
                disabled: true,
              ),
              SizedBox(
                height: 10.0,
              ),
              Tag(
                child: Text('Callback'),
              ),
              SizedBox(
                height: 10.0,
              ),
              Tag(
                child: Text('Closable'),
                disabled: false,
                closable: true,
                onClose: () {
                  print('onclose');
                },
                afterClose: () {
                  print('afterclose');
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              Tag(
                child: Text('Small and Readonly'),
                small: true,
              ),
            ],
          ),
        ));
  }
}
