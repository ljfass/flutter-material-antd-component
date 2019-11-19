import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../material/datePickerView/datePickerView.dart';

class PageDatePickerView extends StatefulWidget {
  @override
  _PageDatePickerViewState createState() => _PageDatePickerViewState();
}

class _PageDatePickerViewState extends State<PageDatePickerView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('DatePickerView'),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: <Widget>[
                Text('Start datetime'),
                Container(
                  height: 200,
                  child: DatePickerView(
                    mode: 'datetime',
                    minDate: DateTime(2016, 11, 25, 7, 0, 0),
                    maxDate: DateTime(2022, 6, 25, 23, 0, 0),
                    onChange: (DateTime datetime) {
                      print(datetime);
                    },
                    onValueChange: (value) {
                      // print(value);
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text('End datetime'),
                Container(
                  height: 200.0,
                  child: DatePickerView(
                    mode: 'datetime',
                    minDate: DateTime(2016, 11, 25, 7, 0, 0),
                    maxDate: DateTime(2022, 6, 25, 23, 0, 0),
                    onValueChange: (value) {
                      print(value);
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  height: 200,
                  child: DatePickerView(
                    mode: 'time',
                    onValueChange: (value) {
                      print(value);
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  height: 200,
                  child: DatePickerView(
                    mode: 'date',
                    minDate: DateTime(2016, 11, 25, 7, 0, 0),
                    maxDate: DateTime(2018, 12, 25, 23, 0, 0),
                    onValueChange: (value) {
                      print(value);
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  height: 200,
                  child: DatePickerView(
                    mode: 'year',
                    minDate: DateTime(2016, 11, 25, 7, 0, 0),
                    maxDate: DateTime(2018, 12, 25, 23, 0, 0),
                    onValueChange: (value) {
                      print(value);
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  height: 200,
                  child: DatePickerView(
                    mode: 'month',
                    minDate: DateTime(2016, 11, 25, 7, 0, 0),
                    maxDate: DateTime(2018, 6, 25, 23, 0, 0),
                    onValueChange: (value) {
                      print(value);
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
