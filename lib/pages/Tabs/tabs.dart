import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../material/tabs/tabs.dart';
import '../../material/badge/badge.dart';

class PageTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tabs'),
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 200.0,
              child: Tabs(
                initialPage: 1,
                tabs: [
                  {'title': Text('First Tab')},
                  {'title': Text('Second Tab')},
                  {
                    'title': Badge(
                      dot: true,
                      child: Text('Third Tab'),
                    )
                  },
                  {'title': Text('Fourth Tab')},
                  {'title': Text('Fifth Tab')},
                  {'title': Text('Sixth Tab')}
                ],
                tabBarView: <Widget>[
                  Container(
                    width: 50.0,
                    height: 50.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Text('Content of first tab'),
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Text('Content of second tab'),
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Text('Content of third tab'),
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Text('Content of fourth tab'),
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Text('Content of fifth tab'),
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Text('Content of sixth tab'),
                  )
                ],
                onChange: (int q) {},
                swipeable: false,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              height: 200.0,
              child: Tabs(
                tabBarPosition: 'bottom',
                initialPage: 1,
                tabs: [
                  {
                    'title': Badge(
                      text: 2,
                      child: Text('First Tab'),
                    )
                  },
                  {
                    'title': Badge(
                      text: 'new',
                      child: Text('Second Tab'),
                    )
                  },
                  {
                    'title': Badge(
                      dot: true,
                      child: Text('Third Tab'),
                    )
                  },
                  {'title': Text('Fourth Tab')},
                  {'title': Text('Fifth Tab')},
                  {'title': Text('Sixth Tab')}
                ],
                tabBarView: <Widget>[
                  Container(
                    width: 50.0,
                    height: 50.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Text('Content of first tab'),
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Text('Content of second tab'),
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Text('Content of third tab'),
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Text('Content of fourth tab'),
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Text('Content of fifth tab'),
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Text('Content of sixth tab'),
                  )
                ],
                onChange: (int q) {},
                swipeable: true,
              ),
            ),
          ],
        ));
  }
}
