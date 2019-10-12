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
        children: <Widget>[
          RaisedButton(
            child: Text('show'),
            onPressed: () {
              Modal.show(context,
                  child: Column(
                    children: <Widget>[
                      Text('show'),
                      Text('show'),
                      Text('show'),
                      Text('show'),
                      Text('show'),
                      Text('show'),
                    ],
                  ),
                  transparent: true,
                  popup: false,
                  animationType: 'slide-up',
                  maskClosable: true,
                  closable: true,
                  title: 'title', afterClose: () {
                print('afterClose');
              }, footer: [
                Button(
                  buttonText: 'OK',
                  radius: 0.0,
                  buttonTextColor: Theme.of(context).primaryColor,
                  // showBorder: false,
                ),
                Button(
                  buttonText: 'cancel',
                  radius: 0.0,
                  buttonTextColor: Theme.of(context).primaryColor,
                  // showBorder: false,
                ),
              ]);
            },
          ),
          RaisedButton(
            child: Text('show'),
            onPressed: () {
              Modal.prompt(context,
                  title: 'input name', message: 'please input your name',
                  callbackOrActions: (value) {
                print(value);
              });
            },
          )
        ],
      ),
    );
  }
}
