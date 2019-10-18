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
import './material/tabs/tabs.dart';

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
    return Column(
      children: <Widget>[
        Expanded(
          child: Tabs(
            initialPage: 1,
            tabs: [
              {'title': Text('Third Tab')},
              {'title': Text('Third Tab')},
              {
                'title': Badge(
                  dot: true,
                  child: Text('Third Tab'),
                )
              },
              {'title': Text('Third Tab')},
              {'title': Text('Third Tab')},
              {'title': Text('Third Tab')}
            ],
            tabBarView: <Widget>[
              Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(color: Colors.white),
                child: Text('1'),
              ),
              Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(color: Colors.white),
                child: Text('2'),
              ),
              Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(color: Colors.white),
                child: Text('3'),
              ),
              Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(color: Colors.white),
                child: Text('1'),
              ),
              Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(color: Colors.white),
                child: Text('2'),
              ),
              Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(color: Colors.white),
                child: Text('3'),
              )
            ],
            onChange: (int q) {},
            swipeable: false,
          ),
        ),
      ],
    );
  }
}
