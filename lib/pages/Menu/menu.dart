import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../material/navbar/navbar.dart';
import '../../material/menu/menu.dart';

class PageMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Column(
            children: <Widget>[
              NavBar(
                icon: Icons.menu,
                leftContent: 'Menu',
                onLeftClick: () {},
                title: 'Here is title',
              ),
              Menu(
                value: [
                  '1',
                  '2',
                  ['5', '6'],
                  '1',
                  ['1', '2'],
                ],
                multiSelect: true,
                onOk: () {
                  print('ok button');
                },
                onCancel: () {
                  print('cancel button');
                },
                level: 2,
                data: [
                  {
                    'value': '1',
                    'label': 'food',
                    'children': [
                      {'value': '1', 'label': '1'},
                      {'value': '2', 'label': '2'},
                      {'value': '3', 'label': '3'},
                      {'value': '4', 'label': '4'},
                      {'value': '5', 'label': '5'},
                      {'value': '6', 'label': '6'},
                      {'value': '7', 'label': '7'},
                      {'value': '8', 'label': '8'},
                      {'value': '9', 'label': '9'},
                      {'value': '10', 'label': '10'},
                      {'value': '11', 'label': '11'},
                      {
                        'value': '12',
                        'label': '12',
                      },
                    ]
                  },
                  {
                    'value': '2',
                    'label': 'market',
                    'isLeaf': false,
                    'children': [
                      {'value': '1', 'label': '1'},
                      {'value': '2', 'label': '2'}
                    ]
                  },
                  {
                    'value': '3',
                    'label': 'love1',
                    'children': [
                      {'value': '1', 'label': '1'},
                      {'value': '2', 'label': '2'}
                    ]
                  },
                  {
                    'value': '4',
                    'label': 'love2',
                    'children': [
                      {'value': '1', 'label': '1'},
                      {'value': '2', 'label': '2'}
                    ]
                  },
                  {
                    'value': '5',
                    'label': 'love3',
                    'children': [
                      {'value': '1', 'label': '1'},
                      {'value': '2', 'label': '2'}
                    ]
                  },
                  {
                    'value': '6',
                    'label': 'love4',
                    'children': [
                      {'value': '1', 'label': '1'},
                      {'value': '2', 'label': '2'}
                    ]
                  },
                  {
                    'value': '7',
                    'label': 'love5',
                    'children': [
                      {'value': '1', 'label': '1'},
                      {'value': '2', 'label': '2'}
                    ]
                  },
                  {
                    'value': '8',
                    'label': 'love6',
                    'children': [
                      {'value': '1', 'label': '1'},
                      {'value': '2', 'label': '2'}
                    ]
                  },
                  {
                    'value': '9',
                    'label': 'love7',
                    'children': [
                      {'value': '1', 'label': '1'},
                      {'value': '2', 'label': '2'}
                    ]
                  },
                  {
                    'value': '10',
                    'label': 'love8',
                  },
                ],
                onChange: (value) {
                  print(value);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
