import 'package:flutter/material.dart';
import './material/navbar.dart';
import './material/checkbox/checkbox.dart' as AntCheckbox;
import './material/checkbox/checkboxItem.dart';
import './material/popover.dart';
import './material/menu.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                multiSelect: true,
                level: 2,
                data: [
                  {
                    'value': '1',
                    'label': 'food',
                    'children': [
                      {'value': 'sdf1sf', 'label': 'asdfsdf'},
                      {'value': 'sdf2sf', 'label': 'hxcvxcv'},
                      {'value': 'sdf3sf', 'label': 'asdfsdf'},
                      {'value': 'sdf4sf', 'label': 'hxcvxcv'},
                      {'value': 'sdf5sf', 'label': 'asdfsdf'},
                      {'value': 'sd6fsf', 'label': 'hxcvxcv'},
                      {'value': 'sdf7sf', 'label': 'asdfsdf'},
                      {'value': 'sdf8sf', 'label': 'hxcvxcv'},
                      {'value': 'sdf9sf', 'label': 'asdfsdf'},
                      {'value': 'sdf20sf', 'label': 'hxcvxcv'},
                      {'value': 'sdf11sf', 'label': 'asdfsdf'},
                      {'value': 'sdfs12f', 'label': 'hxcvxcv'},
                    ]
                  },
                  {
                    'value': '2',
                    'label': 'market',
                    'isLeaf': false,
                    'children': [
                      {'value': 'sdfsf', 'label': 'wertr'},
                      {'value': 'sdfsf', 'label': 'jghjgj'}
                    ]
                  },
                  {
                    'value': '3',
                    'label': 'love',
                  },
                  {
                    'value': '3',
                    'label': 'love',
                  },
                  {
                    'value': '3',
                    'label': 'love',
                  },
                  {
                    'value': '3',
                    'label': 'love',
                  },
                  {
                    'value': '3',
                    'label': 'love',
                  },
                  {
                    'value': '3',
                    'label': 'love',
                  },
                  {
                    'value': '3',
                    'label': 'love',
                  },
                  {
                    'value': '3',
                    'label': 'love',
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
