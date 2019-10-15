import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:material_antd/material/list/list.dart' as prefix0;
import 'package:material_antd/material/steps/steps.dart' as prefix1;
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
import './material/list/list.dart' as AntList;
import './material/steps/steps.dart';
import './material/actionSheet/actionSheet.dart';
import './material/modal/modal.dart';
import './material/activityIndicator/activityIndicator.dart';

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
      home: Scaffold(
        appBar: AppBar(
          title: Text('widget.title'),
        ),
        body: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
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
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }
}
