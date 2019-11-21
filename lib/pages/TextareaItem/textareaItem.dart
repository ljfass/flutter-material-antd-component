import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../material/textareaItem/textareaItem.dart';
import '../../material/list/list.dart' as AntList;

class PageTextareaItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TextareaItem'),
        ),
        body: SingleChildScrollView(
          child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: <Widget>[
                  AntList.List(
                    itemContent: TextareaItem(
                      clear: true,
                      paddingLeft: 0.0,
                      error: false,
                      title: '标题',
                      placeholder: 'auto focus in Alipay client',
                    ),
                  ),
                  AntList.List(
                    header: Text('Auto / Fixed height'),
                    itemContent: TextareaItem(
                      clear: true,
                      autoHeight: true,
                      paddingLeft: 0.0,
                      title: '高度自适应',
                      placeholder: 'autoheight',
                    ),
                  ),
                  AntList.List(
                    itemContent: TextareaItem(
                      // label: '多行',
                      clear: true,
                      autoHeight: true,
                      paddingLeft: 0.0,
                      rows: 5,
                      placeholder: 'fixed number of lines',
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  AntList.List(
                    header: Text('text / image / empty'),
                    itemContent: TextareaItem(
                      paddingLeft: 0.0,
                      title: Container(
                        width: 25.0,
                        height: 25.0,
                        decoration: BoxDecoration(color: Colors.grey),
                      ),
                      placeholder: 'title can be customized',
                    ),
                  ),
                  AntList.List(
                    header: Text('limited value length'),
                    itemContent: TextareaItem(
                      paddingLeft: 0.0,
                      count: 10,
                      placeholder: 'can enter up to 10 characters',
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  AntList.List(
                    header: Text('Count'),
                    itemContent: TextareaItem(
                      paddingLeft: 0.0,
                      count: 100,
                      defaultValue: '计数功能，我的意见是...',
                      placeholder: 'can enter up to 10 characters',
                      rows: 5,
                      onChange: (String value) {
                        print(value);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  AntList.List(
                    header: Text('Not editable/Disabled'),
                    itemContent: TextareaItem(
                      paddingLeft: 0.0,
                      editable: false,
                      title: '姓名',
                      defaultValue: 'not editable',
                    ),
                  ),
                  AntList.List(
                    itemContent: TextareaItem(
                      paddingLeft: 0.0,
                      disabled: true,
                      title: '姓名',
                      defaultValue: 'disabled style',
                    ),
                  ),
                ],
              )),
        ));
  }
}
