import 'package:flutter/material.dart';
import './material/radio/radio.dart' as AntRadio;
import './material/checkbox/checkbox.dart' as AntCheckbox;
import 'package:flutter/cupertino.dart';
import './material/menu/menu.dart';
import './material/radio/radioItem.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
            // height: 44.0,
            width: MediaQuery.of(context).size.width,
            // padding: EdgeInsets.symmetric(horizontal: 15.0),
            // child: AntRadio.Radio(
            //   checked: _checked,
            //   disabled: true,
            //   onChange: (bool value) {
            //     setState(() {
            //       _checked = !_checked;
            //     });
            //   },
            // ),
            child: Column(
              children: <Widget>[
                RadioItem(
                  title: 'Radio',
                  checked: true,
                  disabled: false,
                  onChange: (bool value) {},
                ),
                RadioItem(
                  title: 'Radio',
                  checked: true,
                  disabled: false,
                  onChange: (bool value) {},
                )
              ],
            )

            // child: Menu(
            //   value: [
            //     '1',
            //     '2',
            //     ['5', '6'],
            //     '1',
            //     ['1', '2'],
            //   ],
            //   multiSelect: true,
            //   onOk: () {
            //     print('ok button');
            //   },
            //   onCancel: () {
            //     print('cancel button');
            //   },
            //   level: 2,
            //   data: [
            //     {
            //       'value': '1',
            //       'label': 'food',
            //       'children': [
            //         {'value': '1', 'label': '1'},
            //         {'value': '2', 'label': '2'},
            //         {'value': '3', 'label': '3'},
            //         {'value': '4', 'label': '4'},
            //         {'value': '5', 'label': '5'},
            //         {'value': '6', 'label': '6'},
            //         {'value': '7', 'label': '7'},
            //         {'value': '8', 'label': '8'},
            //         {'value': '9', 'label': '9'},
            //         {'value': '10', 'label': '10'},
            //         {'value': '11', 'label': '11'},
            //         {
            //           'value': '12',
            //           'label': '12',
            //         },
            //       ]
            //     },
            //     {
            //       'value': '2',
            //       'label': 'market',
            //       'isLeaf': false,
            //       'children': [
            //         {'value': '1', 'label': '1'},
            //         {'value': '2', 'label': '2'}
            //       ]
            //     },
            //     {
            //       'value': '3',
            //       'label': 'love1',
            //       'children': [
            //         {'value': '1', 'label': '1'},
            //         {'value': '2', 'label': '2'}
            //       ]
            //     },
            //     {
            //       'value': '4',
            //       'label': 'love2',
            //       'children': [
            //         {'value': '1', 'label': '1'},
            //         {'value': '2', 'label': '2'}
            //       ]
            //     },
            //     {
            //       'value': '5',
            //       'label': 'love3',
            //       'children': [
            //         {'value': '1', 'label': '1'},
            //         {'value': '2', 'label': '2'}
            //       ]
            //     },
            //     {
            //       'value': '6',
            //       'label': 'love4',
            //       'children': [
            //         {'value': '1', 'label': '1'},
            //         {'value': '2', 'label': '2'}
            //       ]
            //     },
            //     {
            //       'value': '7',
            //       'label': 'love5',
            //       'children': [
            //         {'value': '1', 'label': '1'},
            //         {'value': '2', 'label': '2'}
            //       ]
            //     },
            //     {
            //       'value': '8',
            //       'label': 'love6',
            //       'children': [
            //         {'value': '1', 'label': '1'},
            //         {'value': '2', 'label': '2'}
            //       ]
            //     },
            //     {
            //       'value': '9',
            //       'label': 'love7',
            //       'children': [
            //         {'value': '1', 'label': '1'},
            //         {'value': '2', 'label': '2'}
            //       ]
            //     },
            //     {
            //       'value': '10',
            //       'label': 'love8',
            //     },
            //   ],
            //   onChange: (value) {
            //     print(value);
            //   },
            // ),
            ),
      ),
    );
  }
}
