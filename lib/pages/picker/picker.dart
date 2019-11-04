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
                      // 'children': [
                      //   {
                      //     'label': '红色-child',
                      //     // 'children': [
                      //     //   {'label': '红色-child-child'}
                      //     // ]
                      //   }
                      // ]
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
                      'children': [
                        {
                          'label': '绿色-child',
                          'children': [
                            {
                              'label': '绿色-child-child',
                              'children': [
                                {'label': '绿色-child-child-child'}
                              ]
                            }
                          ]
                        }
                      ]
                    },
                    {
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
                      )
                    }
                  ]);
                },
              )
            ],
          ),
        ));
  }
}
