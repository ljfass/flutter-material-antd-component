import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../material/actionSheet/actionSheet.dart';
import '../../material/toast/toast.dart';

class PageActionSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ActionSheet'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                      destructiveButtonIndex: 6,
                      cancelButtonIndex: 5,
                      badges: [
                        {
                          'index': 1,
                          'text': 66,
                          'dot': true,
                        },
                        {
                          'index': 2,
                          'overflowCount': 98,
                          'text': 99,
                          'hot': true
                        },
                        {'index': 3, 'text': '推荐', 'hot': true},
                        {'index': 4, 'text': '...', 'hot': true}
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
        ));
  }
}
