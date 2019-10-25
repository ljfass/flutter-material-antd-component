import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../material/card/card.dart' as AntCard;

class PageCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Card'),
        ),
        body: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              height: 178.0,
              child: AntCard.Card(
                headerTitle: Text(
                  'This is title',
                  style: TextStyle(color: Colors.black),
                ),
                headerExtra: 'this is extra',
                headerThumb:
                    'https://gw.alipayobjects.com/zos/rmsportal/MRhHctKOineMbKAZslML.jpg',
                body: Column(
                  children: <Widget>[
                    Text('Th is content of `Card`'),
                    Text('Th is content of `Card`'),
                    Text('Th is content of `Card`'),
                    Text('Th is content of `Card`')
                  ],
                ),
                footerContent: 'footerContent',
                footerExtra: 'footerExtra',
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 180.0,
              child: AntCard.Card(
                full: true,
                headerTitle: Text(
                  'This is title',
                  style: TextStyle(color: Colors.black),
                ),
                headerExtra: 'this is extra',
                headerThumb:
                    'https://gw.alipayobjects.com/zos/rmsportal/MRhHctKOineMbKAZslML.jpg',
                body: Column(
                  children: <Widget>[
                    Text('Th is content of `Card`'),
                    Text('Th is content of `Card`'),
                    Text('Th is content of `Card`'),
                    Text('Th is content of `Card`')
                  ],
                ),
                footerContent: 'footerContent',
                footerExtra: 'footerExtra',
              ),
            )
          ],
        ));
  }
}
