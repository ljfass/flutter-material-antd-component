import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../material/modal/modal.dart';
import '../../material/toast/toast.dart';
import '../../material/button/button.dart';
import '../../material/list/list.dart' as AntList;
import 'dart:async';

class PageModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Modal'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('Basic',
                  style:
                      TextStyle(fontSize: 18.0, fontWeight: FontWeight.w800)),
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
                              Modal.show(context,
                                  transparent: true,
                                  child: Column(
                                    children: <Widget>[
                                      Text('https://flutter.dev'),
                                      Text(
                                        'afterclose',
                                        style: TextStyle(color: Colors.black),
                                      )
                                    ],
                                  ),
                                  footer: [
                                    {'text': '确定'}
                                  ]);
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
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Color(0xffdddddd),
                                          width: 0.5))),
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Text('股票名称'),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Color(0xffdddddd),
                                          width: 0.5))),
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Text('股票代码'),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Color(0xffdddddd),
                                          width: 0.5))),
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Text('买入价格'),
                            ),
                            SizedBox(
                              height: 5.0,
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
              Text('Alert',
                  style:
                      TextStyle(fontSize: 18.0, fontWeight: FontWeight.w800)),
              RaisedButton(
                child: Text('customized buttons'),
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
                child: Text('more than two buttons'),
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
                child: Text('promise'),
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
                            return Future.delayed(Duration(milliseconds: 2000),
                                () {
                              Toast.hide();
                            });
                          }
                        },
                      ]);
                },
              ),
              Text('Prompt',
                  style:
                      TextStyle(fontSize: 18.0, fontWeight: FontWeight.w800)),
              RaisedButton(
                child: Text('promise'),
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
                            return Future.delayed(Duration(milliseconds: 2000),
                                () {
                              Toast.hide();
                            });
                          }
                        },
                        {
                          'text': 'Hold on',
                          'onPress': (value) {
                            Toast.showToast(context,
                                type: 'info',
                                content: 'onPress promise reject');
                            var completer = new Completer();
                            Future.delayed(Duration(milliseconds: 2000), () {
                              completer.completeError(() {});
                              // Toast.hide();
                            });
                            return completer.future;
                          }
                        }
                      ]);
                },
              ),
              RaisedButton(
                child: Text('defaultValue'),
                onPressed: () {
                  Modal.prompt(context,
                      title: 'defaultValue',
                      message: 'defaultValue for prompt',
                      defaultValue: '100',
                      placeholders: [
                        'input your name'
                      ],
                      callbackOrActions: [
                        {'text': 'Cancel'},
                        {
                          'text': 'Submit',
                          'onPress': (value) {
                            return Future.delayed(Duration(milliseconds: 2000),
                                () {
                              print('value:$value');
                            });
                          }
                        }
                      ]);
                },
              ),
              RaisedButton(
                child: Text('secure-text'),
                onPressed: () {
                  Modal.prompt(context,
                      title: 'Password',
                      type: 'secure-text',
                      message: 'Password Message',
                      callbackOrActions: (valu1) {});
                },
              ),
              RaisedButton(
                child: Text('custom buttons'),
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
                child: Text('login-password'),
                onPressed: () {
                  Modal.prompt(context,
                      title: 'Login',
                      type: 'login-password',
                      placeholders: [
                        'Please input name',
                        'Please input password'
                      ],
                      message: 'Please input login information',
                      callbackOrActions: (value1, value2) {});
                },
              ),
              Text('Operation',
                  style:
                      TextStyle(fontSize: 18.0, fontWeight: FontWeight.w800)),
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
        ));
  }
}
