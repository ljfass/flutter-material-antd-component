import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../material/tabBar/tabBar.dart' as AntTarBar;

class PageTabBar extends StatefulWidget {
  @override
  _PageTabBarState createState() => _PageTabBarState();
}

class _PageTabBarState extends State<PageTabBar> {
  int content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TabBar'),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: content == 0
              ? AppTabBar()
              : content == 1
                  ? UseWithListView()
                  : content == 2
                      ? TabBarOnTop()
                      : Column(
                          children: <Widget>[
                            RaisedButton(
                              child: Text('APP Tab Bar'),
                              onPressed: () {
                                setState(() {
                                  content = 0;
                                });
                              },
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            RaisedButton(
                              child: Text('use with ListView'),
                              onPressed: () {
                                setState(() {
                                  content = 1;
                                });
                              },
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            RaisedButton(
                              child: Text('Tabbar on the top'),
                              onPressed: () {
                                setState(() {
                                  content = 2;
                                });
                              },
                            )
                          ],
                        ),
        ));
  }
}

class AppTabBar extends StatefulWidget {
  @override
  _AppTabBarState createState() => _AppTabBarState();
}

class _AppTabBarState extends State<AppTabBar> {
  int selectedIndex = 0;
  String clickedContent = 'Life';
  bool _hidden = false;

  @override
  Widget build(BuildContext context) {
    return AntTarBar.TabBar(
      hidden: _hidden,
      tabBarItem: [
        {
          'title': 'Life',
          'dot': false,
          'badge': 1,
          'selected': selectedIndex == 0,
          'selectedIcon': Icon(
            Icons.dashboard,
            size: 22.0,
            color: Theme.of(context).primaryColor,
          ),
          'icon': Icon(
            Icons.dashboard,
            size: 22.0,
            color: Color(0xff888888),
          ),
          'onPress': (v) {
            setState(() {
              selectedIndex = 0;
              clickedContent = 'Life';
            });
          },
          'child': Container(
              alignment: Alignment.center,
              height: 200.0,
              child: Text(
                  'Clicked "$clickedContent" tab,show "$clickedContent information'))
        },
        {
          'title': 'koubei',
          'badge': 'new',
          'selected': selectedIndex == 1,
          'selectedIcon': Icon(
            Icons.supervised_user_circle,
            size: 22.0,
            color: Theme.of(context).primaryColor,
          ),
          'icon': Icon(
            Icons.supervised_user_circle,
            size: 22.0,
            color: Color(0xff888888),
          ),
          'onPress': (v) {
            setState(() {
              selectedIndex = 1;
              clickedContent = 'koubei';
            });
          },
          'child': Container(
              alignment: Alignment.center,
              height: 200.0,
              child: Text(
                  'Clicked "$clickedContent" tab,show "$clickedContent information'))
        },
        {
          'title': 'Friend',
          'dot': true,
          'selected': selectedIndex == 2,
          'selectedIcon': Icon(
            Icons.language,
            size: 22.0,
            color: Theme.of(context).primaryColor,
          ),
          'icon': Icon(
            Icons.language,
            size: 22.0,
            color: Color(0xff888888),
          ),
          'onPress': (v) {
            setState(() {
              selectedIndex = 2;
              clickedContent = 'Friend';
            });
          },
          'child': Container(
              alignment: Alignment.center,
              height: 200.0,
              child: Text(
                  'Clicked "$clickedContent" tab,show "$clickedContent information'))
        },
        {
          'title': 'My',
          'badge': 100,
          'selected': selectedIndex == 3,
          'selectedIcon': Icon(
            Icons.gps_fixed,
            size: 22.0,
            color: Theme.of(context).primaryColor,
          ),
          'icon': Icon(
            Icons.gps_fixed,
            size: 22.0,
            color: Color(0xff888888),
          ),
          'onPress': (v) {
            setState(() {
              selectedIndex = 3;
              clickedContent = 'My';
            });
          },
          'child': Container(
              alignment: Alignment.center,
              height: 200.0,
              child: Text(
                  'Clicked "$clickedContent" tab,show "$clickedContent information'))
        }
      ],
    );
  }
}

class UseWithListView extends StatefulWidget {
  @override
  _UseWithListViewState createState() => _UseWithListViewState();
}

class _UseWithListViewState extends State<UseWithListView> {
  int selectedIndex = 0;
  String clickedContent = 'Life';
  bool _hidden = false;

  @override
  Widget build(BuildContext context) {
    return AntTarBar.TabBar(
      hidden: _hidden,
      tabBarItem: [
        {
          'title': 'Life',
          'dot': false,
          'badge': 1,
          'selected': selectedIndex == 0,
          'selectedIcon': Icon(
            Icons.dashboard,
            size: 22.0,
            color: Theme.of(context).primaryColor,
          ),
          'icon': Icon(
            Icons.dashboard,
            size: 22.0,
            color: Color(0xff888888),
          ),
          'onPress': (v) {
            setState(() {
              selectedIndex = 0;
              clickedContent = 'Life';
            });
          },
          'child': Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1)),
              alignment: Alignment.center,
              child: ListView.builder(
                  itemCount: 500,
                  itemExtent: 90.0, //强制高度为50.0
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: Colors.white),
                      height: 50.0,
                      margin: EdgeInsets.symmetric(vertical: 4.0),
                      child: ListTile(
                          leading: Container(
                            width: 50.0,
                            height: 50.0,
                            child: Image.network(
                                'https://zos.alipayobjects.com/rmsportal/hfVtzEhPzTUewPm.png'),
                          ),
                          title: Text("$index")),
                    );
                  }))
        },
        {
          'title': 'koubei',
          'badge': 'new',
          'selected': selectedIndex == 1,
          'selectedIcon': Icon(
            Icons.supervised_user_circle,
            size: 22.0,
            color: Theme.of(context).primaryColor,
          ),
          'icon': Icon(
            Icons.supervised_user_circle,
            size: 22.0,
            color: Color(0xff888888),
          ),
          'onPress': (v) {
            setState(() {
              selectedIndex = 1;
              clickedContent = 'koubei';
            });
          },
          'child': Container(
              alignment: Alignment.center,
              height: 200.0,
              child: Text(
                  'Clicked "$clickedContent" tab,show "$clickedContent information'))
        },
        {
          'title': 'Friend',
          'dot': true,
          'selected': selectedIndex == 2,
          'selectedIcon': Icon(
            Icons.language,
            size: 22.0,
            color: Theme.of(context).primaryColor,
          ),
          'icon': Icon(
            Icons.language,
            size: 22.0,
            color: Color(0xff888888),
          ),
          'onPress': (v) {
            setState(() {
              selectedIndex = 2;
              clickedContent = 'Friend';
            });
          },
          'child': Container(
              alignment: Alignment.center,
              height: 200.0,
              child: Text(
                  'Clicked "$clickedContent" tab,show "$clickedContent information'))
        },
        {
          'title': 'My',
          'badge': 100,
          'selected': selectedIndex == 3,
          'selectedIcon': Icon(
            Icons.gps_fixed,
            size: 22.0,
            color: Theme.of(context).primaryColor,
          ),
          'icon': Icon(
            Icons.gps_fixed,
            size: 22.0,
            color: Color(0xff888888),
          ),
          'onPress': (v) {
            setState(() {
              selectedIndex = 3;
              clickedContent = 'My';
            });
          },
          'child': Container(
              alignment: Alignment.center,
              height: 200.0,
              child: Text(
                  'Clicked "$clickedContent" tab,show "$clickedContent information'))
        }
      ],
    );
  }
}

class TabBarOnTop extends StatefulWidget {
  @override
  _TabBarOnTopState createState() => _TabBarOnTopState();
}

class _TabBarOnTopState extends State<TabBarOnTop> {
  int selectedIndex = 0;
  String clickedContent = 'Life';
  bool _hidden = false;

  @override
  Widget build(BuildContext context) {
    return AntTarBar.TabBar(
      tabBarPosition: 'top',
      hidden: _hidden,
      tabBarItem: [
        {
          'title': 'Life',
          'dot': false,
          'badge': 1,
          'selected': selectedIndex == 0,
          'selectedIcon': Icon(
            Icons.dashboard,
            size: 22.0,
            color: Theme.of(context).primaryColor,
          ),
          'icon': Icon(
            Icons.dashboard,
            size: 22.0,
            color: Color(0xff888888),
          ),
          'onPress': (v) {
            setState(() {
              selectedIndex = 0;
              clickedContent = 'Life';
            });
          },
          'child': Container(
              alignment: Alignment.center,
              height: 200.0,
              child: Text(
                  'Clicked "$clickedContent" tab,show "$clickedContent information'))
        },
        {
          'title': 'koubei',
          'badge': 'new',
          'selected': selectedIndex == 1,
          'selectedIcon': Icon(
            Icons.supervised_user_circle,
            size: 22.0,
            color: Theme.of(context).primaryColor,
          ),
          'icon': Icon(
            Icons.supervised_user_circle,
            size: 22.0,
            color: Color(0xff888888),
          ),
          'onPress': (v) {
            setState(() {
              selectedIndex = 1;
              clickedContent = 'koubei';
            });
          },
          'child': Container(
              alignment: Alignment.center,
              height: 200.0,
              child: Text(
                  'Clicked "$clickedContent" tab,show "$clickedContent information'))
        },
        {
          'title': 'Friend',
          'dot': true,
          'selected': selectedIndex == 2,
          'selectedIcon': Icon(
            Icons.language,
            size: 22.0,
            color: Theme.of(context).primaryColor,
          ),
          'icon': Icon(
            Icons.language,
            size: 22.0,
            color: Color(0xff888888),
          ),
          'onPress': (v) {
            setState(() {
              selectedIndex = 2;
              clickedContent = 'Friend';
            });
          },
          'child': Container(
              alignment: Alignment.center,
              height: 200.0,
              child: Text(
                  'Clicked "$clickedContent" tab,show "$clickedContent information'))
        },
        {
          'title': 'My',
          'badge': 100,
          'selected': selectedIndex == 3,
          'selectedIcon': Icon(
            Icons.gps_fixed,
            size: 22.0,
            color: Theme.of(context).primaryColor,
          ),
          'icon': Icon(
            Icons.gps_fixed,
            size: 22.0,
            color: Color(0xff888888),
          ),
          'onPress': (v) {
            setState(() {
              selectedIndex = 3;
              clickedContent = 'My';
            });
          },
          'child': Container(
              alignment: Alignment.center,
              height: 200.0,
              child: Text(
                  'Clicked "$clickedContent" tab,show "$clickedContent information'))
        }
      ],
    );
  }
}
