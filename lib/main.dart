import 'package:flutter/material.dart';
import './material/radio/radio.dart' as AntRadio;
import './material/checkbox/checkbox.dart' as AntCheckbox;
import 'package:flutter/cupertino.dart';
import './material/menu/menu.dart';
import './material/radio/radioItem.dart';
import './material/card/card.dart' as AntCard;
import './material/button/button.dart';
import './material/badge/badge.dart';
import './material/toast/toast.dart';
import './material/progress/progress.dart';
import './material/tag/tag.dart';
import './material/noticebar/noticebar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double percent = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
          // padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Badge(
            text: 190,
          ),
          SizedBox(
            height: 20.0,
          ),
          Badge(
            text: 122,
            dot: true,
            size: 'large',
            hot: true,
            child: Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(color: Colors.white),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Badge(
            text: 'contentcontentcontentcontent',
            child: Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(color: Colors.white),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Badge(
            text: 'content',
            hot: true,
            corner: true,
            child: Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(color: Colors.white),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Badge(
            text: 122,
            hot: true,
            corner: true,
          ),
          SizedBox(
            height: 20.0,
          ),
          Badge(
            text: 122,
            hot: true,
            corner: true,
            child: Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(color: Colors.white),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Badge(
            text: 122,
            hot: false,
            corner: true,
            child: Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(color: Colors.white),
            ),
          ),
          SizedBox(
            height: 20.0,
          )
        ],
      )),
    );
  }
}
