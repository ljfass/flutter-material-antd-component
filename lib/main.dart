import 'package:flutter/material.dart';
import './material/wingblank.dart';
import './material/navbar.dart';

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
                onLeftClick: () {
                  print('i love you');
                },
                mode: 'dark',
                icon: Icons.chevron_left,
                leftContent: "Back",
                rightContent: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.search,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.more_horiz,
                    ),
                    onPressed: () {},
                  )
                ],
                title: 'NavBar',
              )
            ],
          ),
        ),
      ),
    );
  }
}
