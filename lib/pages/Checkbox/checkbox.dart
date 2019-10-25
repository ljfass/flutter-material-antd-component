import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../material/checkbox/checkbox.dart' as AntCheckbox;
import '../../material/checkbox/checkboxItem.dart';

class PageCheckbox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Checkbox'),
        ),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: <Widget>[
                CheckboxItem(
                  title: 'PH.D.',
                  onChange: (value) {},
                ),
                CheckboxItem(
                  title: 'Bachelor',
                  onChange: (value) {},
                ),
                CheckboxItem(
                  title: 'College diploma',
                  onChange: (value) {},
                ),
                CheckboxItem(
                  title: 'Undergradute',
                  subTitle: 'Auxiliary text',
                  disabled: true,
                  defaultChecked: true,
                  checked: true,
                  onChange: (value) {},
                ),
                CheckboxItem(
                  title: 'Agree agreement',
                  onChange: (value) {},
                ),
              ],
            ),
          ),
        ));
  }
}
