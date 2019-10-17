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
import './material/result/result.dart';
import './material/searchbar/searchbar.dart';

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
        children: <Widget>[
          SearchBar(),
          SizedBox(
            height: 10.0,
          ),
          SearchBar(
            defaultValue: 'defaultValue1',
          ),
          SizedBox(
            height: 10.0,
          ),
          SearchBar(
            onCancel: (String value) {
              print(value);
            },
            defaultValue: 'defaultValue2',
          ),
          SizedBox(
            height: 10.0,
          ),
          SearchBar(
            showCancelButton: true,
            defaultValue: 'default',
            maxLength: 8,
            onChange: (String change) {
              print(change);
            },
            onCancel: (String value) {
              print(value);
            },
            onFocus: () {
              print('focus');
            },
            onBlur: () {
              print('blur');
            },
          ),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }
}
