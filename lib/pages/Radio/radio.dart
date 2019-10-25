import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../material/radio/radioItem.dart';
import '../../material/radio/radio.dart' as AntRadio;

class PageRadio extends StatefulWidget {
  @override
  _PageRadioState createState() => _PageRadioState();
}

class _PageRadioState extends State<PageRadio> {
  int value1 = 1;
  int value2 = 1;
  int value3 = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Radio'),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                RadioItem(
                  data: [
                    {
                      'title': 'doctor',
                      'disabled': false,
                      'checked': this.value1 == 1,
                      'onChange': () {
                        setState(() {
                          value1 = 1;
                        });
                      }
                    },
                    {
                      'title': 'bachelor',
                      'disabled': false,
                      'checked': this.value1 == 2,
                      'onChange': () {
                        setState(() {
                          value1 = 2;
                        });
                      }
                    },
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                RadioItem(
                  data: [
                    {
                      'title': 'basketball',
                      'subTitle': 'details',
                      'disabled': false,
                      'checked': this.value2 == 1,
                      'onChange': () {
                        setState(() {
                          value2 = 1;
                        });
                      }
                    },
                    {
                      'title': 'football',
                      'subTitle': 'details',
                      'disabled': false,
                      'checked': this.value2 == 2,
                      'onChange': () {
                        setState(() {
                          value2 = 2;
                        });
                      }
                    },
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                RadioItem(
                  data: [
                    {
                      'title': 'doctor',
                      'disabled': true,
                      'checked': true,
                      'onChange': () {}
                    },
                    {
                      'title': 'bachelor',
                      'disabled': true,
                      'checked': false,
                      'onChange': () {}
                    },
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                RadioItem(
                  data: [
                    {
                      'title': 'doctor',
                      'subTitle': 'details',
                      'disabled': true,
                      'checked': true,
                      'onChange': () {}
                    },
                    {
                      'title': 'bachelor',
                      'subTitle': 'details',
                      'disabled': true,
                      'checked': false,
                      'onChange': () {}
                    },
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 4.0,
                    ),
                    AntRadio.Radio(
                      checked: true,
                      onChange: (bool value) {},
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text('Agree')
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
