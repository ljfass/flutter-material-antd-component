import 'package:flutter/material.dart';
import './material/radio/radio.dart' as AntRadio;
import './material/checkbox/checkbox.dart' as AntCheckbox;
import 'package:flutter/cupertino.dart';
import './material/menu/menu.dart';
import './material/radio/radioItem.dart';
import './material/card/card.dart' as AntCard;
import './material/button/button.dart';
import './material/badge/badge.dart';

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
  int value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          children: <Widget>[
            Badge(
              text: '测试',
              dot: false,
              child: Container(
                width: 26.0,
                height: 26.0,
                decoration: BoxDecoration(color: Color(0xffdddddd)),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Badge(
              text: '优惠优惠优惠优惠优惠',
              corner: true,
              dot: false,
              child: Container(
                width: 200.0,
                height: 50.0,
                decoration: BoxDecoration(color: Color(0xffffffff)),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Badge(
              text: '测试',
            ),
            SizedBox(
              height: 20.0,
            ),
            Badge(
              overflowCount: 30,
              text: 66,
            ),
            SizedBox(
              height: 20.0,
            ),
            Badge(
              dot: true,
            ),
            SizedBox(
              height: 20.0,
            ),
            Badge(
              text: 0,
            ),
            SizedBox(
              height: 20.0,
            ),
            Badge(
              text: 66,
              dot: true,
              child: Text('123'),
            )
          ],
        ),
      ),
    );
  }
}
