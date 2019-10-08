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
          child: Column(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          NoticeBar(
            loop: true,
            noticeText:
                'Notice: The arrival time of incomes and transfers of Yu &#39;E Bao will be delayed during National Day.',
          ),
          SizedBox(
            height: 20.0,
          ),
          NoticeBar(
            loop: false,
            mode: 'closable',
            noticeText:
                'Notice: The arrival time of incomes and transfers of Yu &#39;E Bao will be delayed during National Day.',
          ),
          SizedBox(
            height: 20.0,
          ),
          NoticeBar(
            loop: false,
            icon: null,
            mode: 'closable',
            noticeText: 'Remove the default icon.',
          ),
          SizedBox(
            height: 20.0,
          ),
          NoticeBar(
            loop: false,
            icon: Icons.check_circle_outline,
            mode: 'closable',
            noticeText: 'Customized icon.',
          ),
          SizedBox(
            height: 20.0,
          ),
          NoticeBar(
            loop: false,
            action: Text(
              '不再提示',
              style: TextStyle(color: Colors.grey),
            ),
            mode: 'closable',
            noticeText: 'Closable demo for `actionText`.',
          ),
          SizedBox(
            height: 20.0,
          ),
          NoticeBar(
            loop: false,
            action: Text(
              '去看看',
              style: TextStyle(color: Color(0xfff76a24)),
            ),
            mode: 'link',
            noticeText: 'Closable demo for `actionText`.',
          )
        ],
      )),
    );
  }
}
