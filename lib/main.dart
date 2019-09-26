import 'package:flutter/material.dart';
import './material/radio/radio.dart' as AntRadio;
import './material/checkbox/checkbox.dart' as AntCheckbox;
import 'package:flutter/cupertino.dart';
import './material/menu/menu.dart';
import './material/radio/radioItem.dart';
import './material/card/card.dart' as AntCard;
import './material/button/button.dart';

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
        child: Column(
          children: <Widget>[
            // Container(
            //   child: OutlineButton(
            //     onPressed: () {},
            //     textColor: Colors.black,
            //     highlightColor: Color(0xffdddddd),
            //     highlightedBorderColor: Color(0xffdddddd),
            //     child: Text('Default'),
            //     color: Colors.red,
            //     borderSide: BorderSide(color: Color(0XFFDDDDDD), width: 0.5),
            //   ),
            // ),
            // RaisedButton(
            //   onPressed: () {},
            //   textColor: Colors.white,
            //   color: Colors.red,
            // ),
            Button(
              buttonText: 'default',
              loading: true,
              disabled: false,
            ),
            SizedBox(
              height: 10.0,
            ),
            Button(
              buttonText: 'default',
              loading: false,
              disabled: true,
            )
          ],
        ),
      ),
    );
  }
}
