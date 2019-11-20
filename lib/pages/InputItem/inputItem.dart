import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../material/inputItem/inputItem.dart';

class PageInputItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('InputItem'),
        ),
        body: Center(
          child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              // height: 400.0,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  InputItem(
                    placeholder: 'start from left',
                    // label: '手机号码',
                    defaultValue: '1508832591aaa',
                    clear: true,
                    editable: true,
                    disabled: false,
                    updatePlaceholder: true,
                    error: false,
                    type: 'phone',
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
                  SizedBox(
                    height: 20.0,
                  ),
                  InputItem(
                    placeholder: 'start from left',
                    label: '银行卡',
                    defaultValue: '默认内容',
                    clear: true,
                    type: 'bankCard',
                    editable: true,
                    disabled: false,
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
                    onVirtualKeyboardConfirm: (v) {},
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  InputItem(
                    placeholder: '****',
                    label: '密码',
                    defaultValue: '',
                    clear: true,
                    type: 'password',
                    editable: true,
                    disabled: false,
                    updatePlaceholder: true,
                    maxLength: 6,
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
                    onVirtualKeyboardConfirm: (v) {},
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  InputItem(
                    placeholder: '',
                    label: '数字键盘',
                    defaultValue: 'f',
                    clear: true,
                    type: 'number',
                    editable: true,
                    disabled: false,
                    updatePlaceholder: true,
                    maxLength: 6,
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
                    onVirtualKeyboardConfirm: (v) {},
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  InputItem(
                    placeholder: '',
                    label: '金额',
                    defaultValue: '',
                    clear: true,
                    type: 'money',
                    editable: true,
                    disabled: false,
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
                    onVirtualKeyboardConfirm: (v) {},
                  ),
                ],
              )),
        ));
  }
}
