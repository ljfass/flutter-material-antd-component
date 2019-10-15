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
          Result(
            imgUrl:
                'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1571138078130&di=71ed99ebc2a07e373a3789f998f5d9bb&imgtype=0&src=http%3A%2F%2Fwww.xdowns.com%2Fattachment%2Fsyapp%2Flogo%2F201807191532012573.jpg',
            title: '验证成功',
            message: '所提交内容已完成验证',
            buttonType: 'primary',
            buttonText: '按钮',
            onButtonClick: () {
              print('hahha');
            },
          )
        ],
      ),
    );
  }
}
