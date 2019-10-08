import 'package:flutter/material.dart';
import 'package:material_antd/material/list/list.dart' as prefix0;
import './material/radio/radio.dart' as AntRadio;
import './material/checkbox/checkbox.dart' as AntCheckbox;
import 'package:flutter/cupertino.dart';
import './material/menu/menu.dart';
import './material/radio/radioItem.dart';
import './material/card/card.dart' as AntCard;
import './material/button/button.dart';
import './material/badge/badge.dart';
import './material/toast/toast.dart';
import './material/progress/progress.dart';
import './material/tag/tag.dart';
import './material/noticebar/noticebar.dart';
import './material/list/list.dart' as AntList;

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
  double percent = 0;
  bool disabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AntList.List(
                itemContent: Text('Title'),
                header: 'Basic Style',
                onClick: () {},
                extra: Text('extra content')),
            SizedBox(
              height: 20.0,
            ),
            AntList.List(
              itemContent: Text('ListItem（Android）'),
              // arrow: 'horizontal',
              onClick: null,
              thumb:
                  'https://zos.alipayobjects.com/rmsportal/dNuvNrtqUztHCwM.png',
              brief: Text(
                  'There may have water ripple effect of material if you set the click event.'),
            ),
            SizedBox(
              height: 20.0,
            ),
            AntList.List(
              itemContent: Text('Title'),
              onClick: null,
            ),
            SizedBox(
              height: 20.0,
            ),
            AntList.List(
              itemContent: Text('Title'),
              arrow: 'horizontal',
              onClick: null,
            ),
            SizedBox(
              height: 20.0,
            ),
            AntList.List(
              itemContent: Text('Title'),
              arrow: 'horizontal',
              extra: 'extra content',
              onClick: null,
            ),
            SizedBox(
              height: 20.0,
            ),
            AntList.List(
              itemContent: Text('Title'),
              extra: '10:30',
              thumb:
                  'https://zos.alipayobjects.com/rmsportal/dNuvNrtqUztHCwM.png',
              brief: 'subtitle',
              onClick: null,
            ),
            SizedBox(
              height: 20.0,
            ),
            AntList.List(
              itemContent: Text('My wallet'),
              arrow: 'horizontal',
              thumb:
                  'https://zos.alipayobjects.com/rmsportal/dNuvNrtqUztHCwM.png',
              onClick: null,
            ),
            SizedBox(
              height: 20.0,
            ),
            AntList.List(
              itemContent: Text('My Cost Ratio'),
              arrow: 'horizontal',
              thumb:
                  'https://zos.alipayobjects.com/rmsportal/UmbJMbWOejVOpxe.png',
              onClick: null,
            ),
            SizedBox(
              height: 20.0,
            ),
            AntList.List(
              header: 'Text Wrapping',
              itemContent: Text(
                  'Single line，long text will be hidden with ellipsisSingle line，long text will be hidden with ellipsis；'),
            ),
            SizedBox(
              height: 20.0,
            ),
            AntList.List(
              header: 'Text Wrapping',
              itemContent: Text(
                  'Multiple line，long text will wrap；Long Text Long Text Long Text Long Text Long Text Long Text'),
            ),
            SizedBox(
              height: 20.0,
            ),
            AntList.List(
              header: 'Text Wrapping',
              extra: 'extra content',
              // arrow: 'empty',
              align: 'top',
              itemContent: Text(
                  ' Multiple line and long text will wrap. Long Text Long Text Long Text.Long Text Long Text Long Text.Long Text Long Text Long Text'),
            ),
            SizedBox(
              height: 20.0,
            ),
            AntList.List(
              header: 'Text Wrapping',
              extra: Switch(
                value: true,
                onChanged: (bool value) {},
              ),
              itemContent: Text('Confirm Information'),
            ),
            SizedBox(
              height: 20.0,
            ),
            AntList.List(
              itemContent: Slider(
                value: 0.5,
                onChanged: (double value) {},
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            AntList.List(
              itemContent: 'Click to disable',
              disabled: disabled,
              onClick: () {
                setState(() {
                  disabled = true;
                });
              },
            ),
          ],
        ),
      )),
    );
  }
}
