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
            child: Text('showActionSheet'),
            onPressed: () {
              ActionSheet.showActionSheetWithOptions(context,
                  options: [
                    'Opertaion1',
                    'Opertaion2',
                    'Opertaion3',
                    'Cancel',
                    'Delete',
                  ],
                  destructiveButtonIndex: 4,
                  cancelButtonIndex: 3,
                  badges: [
                    {
                      'index': 4,
                      'text': 66,
                      'hot': true,
                      'dot': true,
                      'corner': false,
                    }
                  ],
                  message: 'I am description description description',
                  callback: (int index) {
                Toast.showToast(context,
                    type: 'success', content: 'closed after 1000ms');
                return Future.delayed(Duration(milliseconds: 2000), () {});
              });
            },
          ),
          RaisedButton(
            child: Text('showActionSheet&Badge'),
            onPressed: () {
              ActionSheet.showActionSheetWithOptions(context,
                  options: [
                    'Opertaion1',
                    'Opertaion2',
                    'Opertaion3',
                    'Opertaion4',
                    'Opertaion5',
                    'Cancel',
                    'Delete',
                  ],
                  destructiveButtonIndex: 5,
                  cancelButtonIndex: 5,
                  badges: [
                    {
                      'index': 1,
                      'text': 66,
                      'dot': true,
                    },
                    {
                      'index': 2,
                      'text': 99,
                    },
                    {
                      'index': 3,
                      'text': '推荐',
                    },
                    {
                      'index': 4,
                      'text': '...',
                    }
                  ],
                  message: 'I am description description description',
                  callback: (int index) {
                Toast.showToast(context,
                    type: 'success', content: 'closed after 1000ms');
                return Future.delayed(Duration(milliseconds: 2000), () {});
              });
            },
          ),
          RaisedButton(
            child: Text('showShareActionSheet'),
            onPressed: () {
              ActionSheet.showShareActionSheetWithOptions(context,
                  options: [
                    {
                      'icon': Image.network(
                          'https://gw.alipayobjects.com/zos/rmsportal/OpHiXAcYzmPQHcdlLFrc.png'),
                      'title': '发送给朋友'
                    },
                    {
                      'icon': Image.network(
                          'https://gw.alipayobjects.com/zos/rmsportal/SxpunpETIwdxNjcJamwB.png'),
                      'title': 'QQ'
                    },
                    {
                      'icon': Image.network(
                          'https://gw.alipayobjects.com/zos/rmsportal/wvEzCMiDZjthhAOcwTOu.png'),
                      'title': '新浪微博'
                    },
                    {
                      'icon': Image.network(
                          'https://gw.alipayobjects.com/zos/rmsportal/cTTayShKtEIdQVEMuiWt.png'),
                      'title': '生活圈'
                    },
                    {
                      'icon': Image.network(
                          'https://gw.alipayobjects.com/zos/rmsportal/umnHwvEgSyQtXlZjNJTt.png'),
                      'title': '微信好友'
                    },
                  ],
                  message: Text(
                    'message',
                  ), callback: () async {
                Toast.showToast(context,
                    type: 'success', content: 'closed after 1000ms');
                return Future.delayed(Duration(milliseconds: 2000), () {});
              });
            },
          ),
          RaisedButton(
            child: Text('showShareActionSheetMulpitleLine'),
            onPressed: () {
              ActionSheet.showShareActionSheetWithOptions(context,
                  options: [
                    [
                      {
                        'icon': Image.network(
                            'https://gw.alipayobjects.com/zos/rmsportal/OpHiXAcYzmPQHcdlLFrc.png'),
                        'title': '发送给朋友'
                      },
                      {
                        'icon': Image.network(
                            'https://gw.alipayobjects.com/zos/rmsportal/SxpunpETIwdxNjcJamwB.png'),
                        'title': 'QQ'
                      },
                      {
                        'icon': Image.network(
                            'https://gw.alipayobjects.com/zos/rmsportal/wvEzCMiDZjthhAOcwTOu.png'),
                        'title': '新浪微博'
                      },
                      {
                        'icon': Image.network(
                            'https://gw.alipayobjects.com/zos/rmsportal/cTTayShKtEIdQVEMuiWt.png'),
                        'title': '生活圈'
                      },
                      {
                        'icon': Image.network(
                            'https://gw.alipayobjects.com/zos/rmsportal/umnHwvEgSyQtXlZjNJTt.png'),
                        'title': '微信好友'
                      },
                    ],
                    [
                      {
                        'icon': Image.network(
                            'https://gw.alipayobjects.com/zos/rmsportal/SxpunpETIwdxNjcJamwB.png'),
                        'title': 'QQ'
                      },
                      {
                        'icon': Image.network(
                            'https://gw.alipayobjects.com/zos/rmsportal/umnHwvEgSyQtXlZjNJTt.png'),
                        'title': '微信好友'
                      },
                    ]
                  ],
                  message: Text(
                    'message',
                  ), callback: () async {
                Toast.showToast(context,
                    type: 'success', content: 'closed after 1000ms');
                return Future.delayed(Duration(milliseconds: 2000), () {});
              });
            },
          )
        ],
      ),
    );
  }
}
