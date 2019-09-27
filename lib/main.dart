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
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Button(
                buttonText: 'default',
                loading: false,
                disabled: false,
                icon: Icons.check_circle_outline,
              ),
              Button(
                buttonText: 'default',
                loading: true,
                disabled: false,
                icon: Icons.refresh,
              ),
              Button(
                buttonText: 'default',
                loading: true,
                disabled: true,
                icon: Icons.refresh,
              ),
              Button(
                buttonText: 'default',
                loading: false,
                disabled: false,
                size: 'small',
                icon: Icons.refresh,
              ),
              Button(
                buttonText: 'default',
                loading: true,
                disabled: false,
                size: 'small',
                icon: Icons.refresh,
              ),
              Button(
                buttonText: 'default',
                loading: true,
                disabled: true,
                size: 'small',
                icon: Icons.refresh,
              ),
              SizedBox(
                height: 40.0,
              ),
              Button(
                type: 'warning',
                buttonText: 'waring',
                icon: Icons.check_circle_outline,
                disabled: false,
              ),
              Button(
                type: 'warning',
                buttonText: 'waring',
                icon: Icons.check_circle_outline,
                disabled: true,
              ),
              Button(
                type: 'warning',
                buttonText: 'waring',
                icon: Icons.check_circle_outline,
                disabled: false,
                loading: true,
              ),
              Button(
                type: 'warning',
                buttonText: 'waring',
                icon: Icons.check_circle_outline,
                disabled: true,
                loading: true,
              ),
              Button(
                type: 'warning',
                buttonText: 'waring',
                icon: Icons.check_circle_outline,
                disabled: false,
                size: 'small',
              ),
              Button(
                type: 'warning',
                buttonText: 'waring',
                icon: Icons.check_circle_outline,
                disabled: true,
                size: 'small',
              ),
              SizedBox(
                height: 40.0,
              ),
              Button(
                type: 'ghost',
                buttonText: 'ghost',
                icon: Icons.check_circle_outline,
                disabled: false,
              ),
              Button(
                type: 'ghost',
                buttonText: 'ghost',
                disabled: true,
                loading: true,
              ),
              Button(
                type: 'ghost',
                buttonText: 'ghost',
                icon: Icons.check_circle_outline,
                disabled: true,
              ),
              Button(
                  type: 'ghost',
                  buttonText: 'ghost',
                  icon: Icons.check_circle_outline,
                  disabled: false,
                  size: 'small'),
              Button(
                  type: 'ghost',
                  buttonText: 'ghost',
                  disabled: true,
                  size: 'small'),
              Button(
                  type: 'ghost',
                  buttonText: 'ghost',
                  icon: Icons.check_circle_outline,
                  disabled: true,
                  size: 'small'),
              Button(
                  type: 'ghost',
                  buttonText: 'ghost',
                  loading: true,
                  disabled: true,
                  size: 'small'),
              SizedBox(
                height: 40.0,
              ),
              Button(
                buttonText: 'primary',
                loading: false,
                icon: Icons.refresh,
                disabled: false,
                type: 'primary',
              ),
              Button(
                buttonText: 'primary',
                loading: false,
                icon: Icons.refresh,
                disabled: true,
                type: 'primary',
              ),
              Button(
                buttonText: 'primary',
                loading: false,
                icon: Icons.refresh,
                disabled: false,
                type: 'primary',
                size: 'small',
              ),
              Button(
                buttonText: 'primary',
                loading: false,
                icon: Icons.refresh,
                disabled: true,
                type: 'primary',
                size: 'small',
              ),
              Button(
                buttonText: 'primary',
                loading: true,
                icon: Icons.refresh,
                disabled: false,
                type: 'primary',
                size: 'small',
              ),
              Button(
                buttonText: 'primary',
                loading: true,
                icon: Icons.refresh,
                disabled: true,
                type: 'primary',
                size: 'small',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
