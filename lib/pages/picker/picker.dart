import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_antd/material/button/button.dart';
import '../Button/button.dart';
import '../../material/picker/picker.dart';

class PagePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Picker'),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          height: 400.0,
          child: Column(
            children: <Widget>[
              Button(
                buttonText: 'show',
                onClick: () {
                  Picker.showPicker(context, cols: 3, data: [
                    {
                      'label': Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 22.0,
                            height: 22.0,
                            decoration: BoxDecoration(color: Colors.red),
                          ),
                          Text('红色')
                        ],
                      ),
                      'value': '2013',
                      'children': [
                        {
                          'label': '2016',
                          'value': '2016',
                          'children': [
                            {
                              'label': '2546',
                              'value': '2546',
                              'children': [
                                {'label': '5542', 'value': '5542'},
                                {'label': '8541', 'value': '8541'}
                              ]
                            },
                            {'label': '6542', 'value': '6542'},
                            {'label': '7894', 'value': '7894'}
                          ]
                        },
                        {
                          'label': '2046',
                          'value': '2046',
                          'children': [
                            {
                              'label': '2015',
                              'value': '2015',
                            },
                            {
                              'label': '2014',
                              'value': '2014',
                            }
                          ]
                        },
                      ]
                    },
                    {
                      'label': Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 22.0,
                            height: 22.0,
                            decoration: BoxDecoration(color: Colors.green),
                          ),
                          Text('绿色')
                        ],
                      ),
                      'value': '2012',
                      'children': [
                        {
                          'label': '2222',
                          'value': '2222',
                          'children': [
                            {
                              'label': '6541',
                              'value': '6541',
                            }
                          ]
                        },
                        {
                          'label': '3333',
                          'value': '3333',
                          'children': [
                            {
                              'label': '7845',
                              'value': '7845',
                            }
                          ]
                        },
                      ]
                    },
                    {
                      'value': '2011',
                      'label': Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 22.0,
                            height: 22.0,
                            decoration: BoxDecoration(color: Colors.blue),
                          ),
                          Text('篮色')
                        ],
                      ),
                      // 'children': [
                      //   {'label': 'xx'}
                      // ]
                    }
                  ]);
                },
              )
            ],
          ),
        ));
  }
}
