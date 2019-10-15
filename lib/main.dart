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
              child: Text('^basic^'),
              onPressed: () {
                Modal.show(context,
                    title: Text('title'),
                    transparent: true,
                    child: Container(
                      height: 100.0,
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Text('scoll content...'),
                            Text('scoll content...'),
                            Text('scoll content...'),
                            Text('scoll content...'),
                            Text('scoll content...'),
                            Text('scoll content...'),
                            Text('scoll content...'),
                            Text('scoll content...'),
                          ],
                        ),
                      ),
                    ),
                    footer: [
                      {
                        'text': 'Ok',
                        'onPress': () {
                          return Future.delayed(Duration(milliseconds: 2000),
                              () {
                            print('promise');
                          });
                        }
                      }
                    ]);
              }),
          RaisedButton(
              child: Text('popup'),
              onPressed: () {
                Modal.show(
                  context,
                  popup: true,
                  animationType: 'slide-up',
                  transparent: true,
                  maskClosable: true,
                  child: AntList.List(
                    header: Align(
                      alignment: Alignment.center,
                      child: Text('委托买入'),
                    ),
                    itemContent: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Text('股票名称'),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Text('股票代码'),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Text('买入价格'),
                        ),
                        Button(
                          type: 'primary',
                          buttonText: '买入',
                        )
                      ],
                    ),
                  ),
                );
              }),
          RaisedButton(
            child: Text('prompt-promise'),
            onPressed: () {
              Modal.prompt(context,
                  title: 'input name',
                  message: 'please input your name',
                  placeholders: [
                    'input your name'
                  ],
                  callbackOrActions: [
                    {
                      'text': 'Close',
                      'onPress': (value) {
                        Toast.showToast(context,
                            type: 'info', content: 'onPress Promise');
                        return Future.delayed(Duration(milliseconds: 2000), () {
                          Toast.hide();
                        });
                      }
                    },
                    {'text': 'Hold on', 'onPress': (value) {}}
                  ]);
            },
          ),
          RaisedButton(
            child: Text('prompt-defaultValue'),
            onPressed: () {
              Modal.prompt(context,
                  title: 'defaultValue',
                  message: 'defaultValue for prompt',
                  placeholders: ['input your name'],
                  defaultValue: '100',
                  callbackOrActions: [
                    {'text': 'Cancel'},
                    {
                      'text': 'Submit',
                      'onPress': (value) {
                        return Future.delayed(Duration(milliseconds: 2000), () {
                          print('value:$value');
                        });
                      }
                    }
                  ]);
            },
          ),
          RaisedButton(
            child: Text('prompt-secure-text'),
            onPressed: () {
              Modal.prompt(context,
                  title: 'Password',
                  type: 'secure-text',
                  message: 'Password Message',
                  callbackOrActions: (valu1) {});
            },
          ),
          RaisedButton(
            child: Text('prompt-custom buttons'),
            onPressed: () {
              Modal.prompt(context,
                  title: 'Password',
                  type: 'secure-text',
                  message: 'You can custom buttons',
                  callbackOrActions: [
                    {
                      'text': '取消',
                    },
                    {'text': '提交'}
                  ]);
            },
          ),
          RaisedButton(
            child: Text('prompt-login-password'),
            onPressed: () {
              Modal.prompt(context,
                  title: 'Login',
                  type: 'login-password',
                  placeholders: ['Please input name', 'Please input password'],
                  message: 'Please input login information',
                  callbackOrActions: (value1, value2) {});
            },
          ),
          RaisedButton(
            child: Text('alert-customized buttons'),
            onPressed: () {
              Modal.alert(context,
                  title: 'Delete',
                  message: 'Are you sure???',
                  actions: [
                    {'text': 'Cancel'},
                    {'text': 'OK'},
                  ]);
            },
          ),
          RaisedButton(
            child: Text('alert-more than two buttons'),
            onPressed: () {
              Modal.alert(context,
                  title: 'Much Buttons',
                  message: 'More than two buttons',
                  actions: [
                    {'text': 'Button1'},
                    {'text': 'Button2'},
                    {'text': 'Button3'}
                  ]);
            },
          ),
          RaisedButton(
            child: Text('alert-promise'),
            onPressed: () {
              Modal.alert(context,
                  title: 'Delete',
                  message: 'Are you sure???',
                  actions: [
                    {'text': 'Cancel'},
                    {
                      'text': 'Ok',
                      'onPress': () {
                        Toast.showToast(context,
                            type: 'info', content: 'onPress Promise');
                        return Future.delayed(Duration(milliseconds: 2000), () {
                          Toast.hide();
                        });
                      }
                    },
                  ]);
            },
          ),
          RaisedButton(
            child: Text('operation'),
            onPressed: () {
              Modal.operation(context, actions: [
                {'text': '标为未读'},
                {'text': '置顶聊天'}
              ]);
            },
          ),
        ],
      ),
    );
  }
}
