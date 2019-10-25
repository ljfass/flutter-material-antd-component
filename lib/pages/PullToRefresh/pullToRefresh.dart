import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../material/pullToRefresh/pullToRefresh.dart';

class PagePullToRefresh extends StatefulWidget {
  @override
  _PagePullToRefreshState createState() => _PagePullToRefreshState();
}

class _PagePullToRefreshState extends State<PagePullToRefresh> {
  String _direction = 'down';
  ScrollPhysics scrollPhysics = new RefreshAlwaysScrollPhysics();
  int _itemCount = 5;
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PullToRefresh'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('direction：$_direction'),
              onPressed: () {
                setState(() {
                  _itemCount = 5;
                  _direction = _direction == 'down' ? 'up' : 'down';
                });
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              flex: 1,
              child: PullToRefresh(
                // distanceToRefresh: 80.0,
                // damping: 50,
                direction: _direction,
                listView: ListView.builder(
                    physics: scrollPhysics,
                    itemCount: _itemCount,
                    itemExtent: 50.0,
                    itemBuilder: (context, index) {
                      return ListTile(title: Text("pull $_direction $index"));
                    }),
                onRefresh: () {
                  return Future.delayed(Duration(milliseconds: 3000), () {
                    setState(() {
                      _itemCount += 10;
                    });
                  });
                },
                scrollPhysicsChanged: (ScrollPhysics physics) {
                  setState(() {
                    scrollPhysics = physics;
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
