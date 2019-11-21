import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../material/inputItem/inputItem.dart';
import '../../material/list/list.dart' as AntList;
import '../../material/toast/toast.dart';

class PageInputItem extends StatefulWidget {
  @override
  _PageInputItemState createState() => _PageInputItemState();
}

class _PageInputItemState extends State<PageInputItem> {
  bool error = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('InputItem'),
        ),
        body: SingleChildScrollView(
          child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              // height: 400.0,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  AntList.List(
                    itemContent: InputItem(
                      placeholder: 'start from left',
                      defaultValue: '',
                      label: '光标在左',
                      moneyKeyboardAlign: 'left',
                      editable: true,
                      disabled: false,
                      updatePlaceholder: true,
                      error: false,
                      type: 'money',
                      paddingLeft: 0.0,
                      onErrorClick: () {
                        print('error clicked!');
                      },
                      onFocus: (String value) {
                        // print('on focus');
                      },
                      onBlur: (String value) {
                        // print('on blur');
                      },
                      onChange: (String value) {
                        print('on change:$value');
                      },
                      onVirtualKeyboardConfirm: (v) {
                        print('keyboard confimr:$v');
                      },
                    ),
                  ),
                  AntList.List(
                    itemContent: InputItem(
                      placeholder: 'start from right',
                      defaultValue: '',
                      label: '光标在右',
                      editable: true,
                      disabled: false,
                      updatePlaceholder: true,
                      error: false,
                      type: 'money',
                      paddingLeft: 0.0,
                      onErrorClick: () {
                        print('error clicked!');
                      },
                      onFocus: (String value) {
                        // print('on focus');
                      },
                      onBlur: (String value) {
                        // print('on blur');
                      },
                      onChange: (String value) {
                        print('on change:$value');
                      },
                      onVirtualKeyboardConfirm: (v) {
                        print('keyboard confimr:$v');
                      },
                    ),
                  ),
                  AntList.List(
                    itemContent: InputItem(
                      placeholder: 'money format',
                      defaultValue: '',
                      label: '数字键盘',
                      updatePlaceholder: false,
                      clear: true,
                      type: 'money',
                      paddingLeft: 0.0,
                      onErrorClick: () {
                        print('error clicked!');
                      },
                      onFocus: (String value) {
                        // print('on focus');
                      },
                      onBlur: (String value) {
                        // print('on blur');
                      },
                      onChange: (String value) {
                        print('on change:$value');
                      },
                      onVirtualKeyboardConfirm: (v) {
                        print('keyboard confimr:$v');
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  AntList.List(
                    itemContent: InputItem(
                      placeholder: 'auto focus',
                      label: '标题',
                      defaultValue: '',
                      editable: true,
                      disabled: false,
                      updatePlaceholder: true,
                      error: false,
                      paddingLeft: 0.0,
                      onErrorClick: () {
                        print('error clicked!');
                      },
                      onFocus: (String value) {
                        // print('on focus');
                      },
                      onBlur: (String value) {
                        // print('on blur');
                      },
                      onChange: (String value) {
                        print('on change:$value');
                      },
                      onVirtualKeyboardConfirm: (v) {
                        print('keyboard confimr:$v');
                      },
                    ),
                  ),
                  AntList.List(
                    itemContent: InputItem(
                      placeholder: 'displayed clear while typing',
                      label: '标题',
                      defaultValue: '',
                      clear: true,
                      editable: true,
                      disabled: false,
                      paddingLeft: 0.0,
                      updatePlaceholder: true,
                      error: false,
                      onErrorClick: () {
                        print('error clicked!');
                      },
                      onFocus: (String value) {
                        // print('on focus');
                      },
                      onBlur: (String value) {
                        // print('on blur');
                      },
                      onChange: (String value) {
                        print('on change:$value');
                      },
                      onVirtualKeyboardConfirm: (v) {
                        print('keyboard confimr:$v');
                      },
                    ),
                  ),
                  AntList.List(
                    itemContent: InputItem(
                      placeholder: 'limited title length',
                      label: '标题过长超过默认的5个字',
                      updatePlaceholder: false,
                      paddingLeft: 0.0,
                      onErrorClick: () {
                        print('error clicked!');
                      },
                      onFocus: (String value) {
                        // print('on focus');
                      },
                      onBlur: (String value) {
                        // print('on blur');
                      },
                      onVirtualKeyboardConfirm: (v) {},
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  AntList.List(
                    itemContent: InputItem(
                      placeholder: 'no label',
                      updatePlaceholder: false,
                      paddingLeft: 0.0,
                      onErrorClick: () {
                        print('error clicked!');
                      },
                      onFocus: (String value) {
                        // print('on focus');
                      },
                      onBlur: (String value) {
                        // print('on blur');
                      },
                      onVirtualKeyboardConfirm: (v) {},
                    ),
                  ),
                  AntList.List(
                    itemContent: InputItem(
                      placeholder: 'title can be icon，image or text',
                      label: Icon(
                        Icons.supervised_user_circle,
                        color: Colors.blue,
                      ),
                      paddingLeft: 0.0,
                      updatePlaceholder: false,
                      onErrorClick: () {
                        print('error clicked!');
                      },
                      onFocus: (String value) {
                        // print('on focus');
                      },
                      onBlur: (String value) {
                        // print('on blur');
                      },
                      onVirtualKeyboardConfirm: (v) {},
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  AntList.List(
                    itemContent: InputItem(
                      placeholder: '0.0',
                      label: '价格',
                      paddingLeft: 0.0,
                      updatePlaceholder: false,
                      onErrorClick: () {
                        print('error clicked!');
                      },
                      onFocus: (String value) {
                        // print('on focus');
                      },
                      onBlur: (String value) {
                        // print('on blur');
                      },
                      onVirtualKeyboardConfirm: (v) {},
                    ),
                    extra: '¥',
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  AntList.List(
                    itemContent: InputItem(
                      defaultValue: '8888 8888 8888 8888',
                      label: '银行卡',
                      paddingLeft: 0.0,
                      type: 'bankCard',
                      updatePlaceholder: false,
                      onErrorClick: () {
                        print('error clicked!');
                      },
                      onFocus: (String value) {
                        // print('on focus');
                      },
                      onBlur: (String value) {
                        // print('on blur');
                      },
                      onVirtualKeyboardConfirm: (v) {},
                    ),
                  ),
                  AntList.List(
                    itemContent: InputItem(
                      placeholder: '150 8813 2591',
                      label: '手机号码',
                      type: 'phone',
                      updatePlaceholder: false,
                      paddingLeft: 0.0,
                      onErrorClick: () {
                        print('error clicked!');
                      },
                      onChange: (String value) {
                        print(value);
                      },
                      onFocus: (String value) {
                        // print('on focus');
                      },
                      onBlur: (String value) {
                        // print('on blur');
                      },
                      onVirtualKeyboardConfirm: (v) {},
                    ),
                  ),
                  AntList.List(
                    itemContent: InputItem(
                      placeholder: '****',
                      label: '密码',
                      type: 'password',
                      updatePlaceholder: false,
                      paddingLeft: 0.0,
                      onErrorClick: () {
                        print('error clicked!');
                      },
                      onFocus: (String value) {
                        // print('on focus');
                      },
                      onBlur: (String value) {
                        // print('on blur');
                      },
                      onVirtualKeyboardConfirm: (v) {},
                    ),
                  ),
                  AntList.List(
                    itemContent: InputItem(
                      placeholder: 'click to show number keyboard',
                      label: '数字键盘',
                      type: 'number',
                      updatePlaceholder: false,
                      paddingLeft: 0.0,
                      onErrorClick: () {
                        print('error clicked!');
                      },
                      onFocus: (String value) {
                        // print('on focus');
                      },
                      onBlur: (String value) {
                        // print('on blur');
                      },
                      onVirtualKeyboardConfirm: (v) {},
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  AntList.List(
                    itemContent: InputItem(
                      defaultValue: 'not editable',
                      label: '姓名',
                      editable: false,
                      updatePlaceholder: false,
                      paddingLeft: 0.0,
                      onErrorClick: () {
                        print('error clicked!');
                      },
                      onFocus: (String value) {
                        // print('on focus');
                      },
                      onBlur: (String value) {
                        // print('on blur');
                      },
                      onVirtualKeyboardConfirm: (v) {},
                    ),
                  ),
                  AntList.List(
                    itemContent: InputItem(
                      placeholder: 'disable inputItem',
                      label: '姓名',
                      editable: false,
                      updatePlaceholder: false,
                      paddingLeft: 0.0,
                      onErrorClick: () {
                        print('error clicked!');
                      },
                      onFocus: (String value) {
                        // print('on focus');
                      },
                      onBlur: (String value) {
                        // print('on blur');
                      },
                      onVirtualKeyboardConfirm: (v) {},
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  AntList.List(
                    itemContent: InputItem(
                      placeholder: 'error verification',
                      label: '手机号码',
                      type: 'phone',
                      error: error,
                      updatePlaceholder: false,
                      paddingLeft: 0.0,
                      onErrorClick: () {
                        Toast.showToast(context,
                            content: 'please enter 11 digits', type: 'info');
                      },
                      onChange: (String value) {
                        if (value.length == 11) {
                          setState(() {
                            error = false;
                          });
                        }
                      },
                      onFocus: (String value) {
                        // print('on focus');
                        setState(() {
                          error = true;
                        });
                      },
                      onBlur: (String value) {
                        // print('on blur');
                      },
                      onVirtualKeyboardConfirm: (v) {},
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                ],
              )),
        ));
  }
}
