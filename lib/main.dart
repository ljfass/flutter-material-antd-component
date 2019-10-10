import 'package:flutter/material.dart';
import 'package:material_antd/material/list/list.dart' as prefix0;
import 'package:material_antd/material/steps/steps.dart' as prefix1;
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
import './material/steps/steps.dart';

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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Steps(
                direction: 'horizontal',
                current: 1,
                size: 'small',
                steps: [
                  StepItem(
                    title: 'Finished',
                    description: 'This is description',
                  ),
                  StepItem(
                    title: 'In Progress',
                    description: 'This is description',
                  ),
                  StepItem(
                    title: 'Waiting',
                    description: 'This is description',
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Steps(
                direction: 'horizontal',
                current: 1,
                steps: [
                  StepItem(
                    title: 'Finished',
                    description: 'This is description',
                  ),
                  StepItem(
                    title: 'In Progress',
                    description: 'This is description',
                  ),
                  StepItem(
                    title: 'Waiting',
                    description: 'This is description',
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Steps(
                direction: 'horizontal',
                current: 1,
                steps: [
                  StepItem(
                    title: 'Step 1',
                    icon: Icons.access_alarm,
                  ),
                  StepItem(
                    title: 'Step 2',
                    status: 'error',
                    icon: Icons.access_alarm,
                  ),
                  StepItem(
                    title: 'Step 3',
                    icon: Icons.access_alarm,
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ));
  }
}
