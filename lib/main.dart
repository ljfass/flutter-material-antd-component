import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './pages/Menu/menu.dart';
import './pages/SegmentedControl/segmentedControl.dart';
import './pages/TabBar/tabBar.dart';
import './pages/Tabs/tabs.dart';

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
      home: Scaffold(
        appBar: AppBar(
          title: Text('widget.title'),
        ),
        body: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
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
  int content;
  bool navigation = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  navigation = !navigation;
                });
              },
              children: [
                ExpansionPanel(
                    headerBuilder: (_, __) {
                      return Text('Navigation');
                    },
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return PageMenu();
                            }));
                          },
                          child: ListTile(
                            title: Text('Menu'),
                            trailing: Container(
                              child: Icon(Icons.chevron_right),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return PageSegmentedControl();
                            }));
                          },
                          child: ListTile(
                            title: Text('SegmentedControl'),
                            trailing: Container(
                              child: Icon(Icons.chevron_right),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return PageTabBar();
                            }));
                          },
                          child: ListTile(
                            title: Text('TabBar'),
                            trailing: Container(
                              child: Icon(Icons.chevron_right),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return PageTabs();
                            }));
                          },
                          child: ListTile(
                            title: Text('Tabs'),
                            trailing: Container(
                              child: Icon(Icons.chevron_right),
                            ),
                          ),
                        )
                      ],
                    ),
                    isExpanded: navigation)
              ],
            ),
          ],
        ));
  }
}
