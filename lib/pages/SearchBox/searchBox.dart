import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../material/searchbar/searchbar.dart';

class PageSearchBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SearchBox'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SearchBar(),
              SizedBox(
                height: 10.0,
              ),
              SearchBar(
                defaultValue: 'defaultValue1',
              ),
              SizedBox(
                height: 10.0,
              ),
              SearchBar(
                onCancel: (String value) {
                  print(value);
                },
                defaultValue: 'defaultValue2',
              ),
              SizedBox(
                height: 10.0,
              ),
              SearchBar(
                showCancelButton: true,
                defaultValue: 'maxlength',
                maxLength: 10,
                onChange: (String change) {
                  print(change);
                },
                onCancel: (String value) {
                  print(value);
                },
                onFocus: () {
                  print('focus');
                },
                onBlur: () {
                  print('blur');
                },
              )
            ],
          ),
        ));
  }
}
