import 'package:flutter/material.dart';
import './material/radio/radio.dart' as AntRadio;
import './material/checkbox/checkbox.dart' as AntCheckbox;
import 'package:flutter/cupertino.dart';
import './material/menu/menu.dart';
import './material/radio/radioItem.dart';
import './material/card/card.dart' as AntCard;

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
  int value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        // height: 200.0,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        // decoration: BoxDecoration(color: Colors.grey[200]),
        // child: Card(
        //   color: Colors.white,
        //   borderOnForeground: false,
        //   elevation: 0.0,
        //   child: Text('data'),
        // )
        child: AntCard.Card(
          full: true,
          headerTitle: Text(
            'This is title',
            style: TextStyle(color: Colors.black),
          ),
          headerExtra: 'this is extra',
          headerThumb:
              'https://gw.alipayobjects.com/zos/rmsportal/MRhHctKOineMbKAZslML.jpg',
          body: Column(
            children: <Widget>[
              Text('Th is content of `Card`'),
              Text('Th is content of `Card`'),
              Text('Th is content of `Card`'),
              Text('Th is content of `Card`')
            ],
          ),
          footerContent: 'footerContent',
          footerExtra: 'footerExtra',
          height: 170.0,
        ),
      ),
    );
  }
}
