import 'package:flutter/material.dart';
import './material/radio/radio.dart' as AntRadio;
import './material/checkbox/checkbox.dart' as AntCheckbox;
import 'package:flutter/cupertino.dart';
import './material/menu/menu.dart';
import './material/radio/radioItem.dart';
import './material/card/card.dart' as AntCard;
import './material/button/button.dart';
import './material/badge/badge.dart';
import './material/toast/toast.dart';

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
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          children: <Widget>[
            Button(
              buttonText: 'text only',
              onClick: () {
                Toast.showToast(context,
                    content: 'This is a toast tips!!',
                    type: 'info',
                    duration: 10000,
                    mask: false, onClose: () {
                  // Toast.hide();
                });
              },
            ),
            Button(
              buttonText: 'without mask',
              onClick: () {
                Toast.showToast(context,
                    content: 'Toast without mask!!',
                    type: 'info',
                    mask: false, onClose: () {
                  print('done toast');
                });
              },
            ),
            Button(
              buttonText: 'custom icon',
              onClick: () {
                Toast.showToast(context,
                    content: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                    mask: false,
                    type: 'info');
              },
            ),
            Button(
              buttonText: 'success',
              onClick: () {
                Toast.showToast(context,
                    content: 'Load success!!', mask: false, type: 'success');
              },
            ),
            Button(
              buttonText: 'fail',
              onClick: () {
                Toast.showToast(context,
                    content: 'Load failed!!', mask: false, type: 'fail');
              },
            ),
            Button(
              buttonText: 'network failure',
              onClick: () {
                Toast.showToast(context,
                    content: 'Network conntection failed!!',
                    mask: false,
                    type: 'offline');
              },
            ),
            Button(
              buttonText: 'loading',
              onClick: () {
                Toast.showToast(context,
                    content: 'Loading...', mask: false, type: 'loading');
              },
            )
          ],
        ),
      ),
    );
  }
}
