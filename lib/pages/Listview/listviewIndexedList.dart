import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../material/listView/listView.dart';

typedef void IndexBarTouchCallback(String tag);

class ListviewIndexedList extends StatefulWidget {
  @override
  _ListviewIndexedListState createState() => _ListviewIndexedListState();
}

class _ListviewIndexedListState extends State<ListviewIndexedList> {
  int i = 16;
  List<Widget> items;
  String footerContent = '';
  @override
  void initState() {
    super.initState();
    i = 16;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Listview'),
        ),
        body: Center(
          child: Container(
            child: Stack(children: <Widget>[
              Listview(
                itemCount: i,
                renderRow: (int index) {
                  List<Widget> _contents = [];
                  for (int j = 0; j < 5; j++) {
                    _contents.add(Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 5.0),
                                child: Text(
                                  'Eat the week',
                                  style: TextStyle(
                                      color: Color(0xff888888), fontSize: 18.0),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 15.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 60.0,
                                      height: 60.0,
                                      child: Image.network(
                                          'https://zos.alipayobjects.com/rmsportal/hfVtzEhPzTUewPm.png'),
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text('不是所有的兼职'),
                                        Text('35')
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        j == 4
                            ? Center()
                            : Container(
                                height: 8.0,
                                decoration: BoxDecoration(
                                    color: Color(0xfff5f5f9),
                                    border: Border(
                                        top: BorderSide(
                                            color: Color(0xffececed)),
                                        bottom: BorderSide(
                                            color: Color(0xffececed)))),
                              )
                      ],
                    ));
                  }

                  return Column(
                    children: _contents,
                  );
                },
                stickyHeader: true,
                sectionHeader: (int index) {
                  return Text('Task $index');
                },
                listviewHeader: Text('header'),
                listviewFooter: Text(footerContent),
                onEndReachedThreshold: 500,
                onEndReached: () {
                  if (this.mounted) {
                    setState(() {
                      this.footerContent = 'loading...';
                    });
                    return Future.delayed(Duration(milliseconds: 1000), () {
                      setState(() {
                        this.footerContent = 'loaded successfully!';
                        i = i + 10;
                      });
                    });
                  }
                },
              ),
              Positioned(
                right: 10.0,
                top: 60.0,
                child: _IndexBar(
                  onTouch: (String tag) {
                    print(tag);
                  },
                ),
              )
            ]),
          ),
        ));
  }
}

class _IndexBar extends StatefulWidget {
  _IndexBar({Key key, @required this.onTouch})
      : assert(onTouch != null),
        super(key: key);
  final IndexBarTouchCallback onTouch;

  @override
  _IndexBarState createState() => _IndexBarState();
}

class _IndexBarState extends State<_IndexBar> {
  int _widgetTop = -1;
  List<String> _data = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K'];

  List<int> _indexSectionList = new List();
  int _lastIndex = 0;
  String _tag = '';
  @override
  void initState() {
    super.initState();
    init();
  }

  int _getIndex(int offset) {
    for (int i = 0, length = _indexSectionList.length; i < length - 1; i++) {
      int a = _indexSectionList[i];
      int b = _indexSectionList[i + 1];
      if (offset >= a && offset < b) {
        return i;
      }
    }
    return -1;
  }

  void init() {
    _indexSectionList.clear();
    _indexSectionList.add(0);
    int tempHeight = 0;

    _data?.forEach((value) {
      tempHeight = tempHeight + 16;
      _indexSectionList.add(tempHeight);
    });
  }

  _triggerTouchEvent() {
    if (widget.onTouch != null) {
      widget.onTouch(_tag);
    }
  }

  @override
  Widget build(BuildContext context) {
    init();
    List<Widget> _children = new List();
    _data.forEach((v) {
      _children.add(new Container(
        decoration: BoxDecoration(
            color: _tag == v ? Colors.black.withOpacity(0.4) : Colors.white),
        width: 30,
        height: 16,
        child: new Text(
          v,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
      ));
    });

    return GestureDetector(
      onVerticalDragDown: (DragDownDetails details) {
        RenderBox box = context.findRenderObject();
        Offset topLeftPosition = box.localToGlobal(Offset.zero);
        _widgetTop = topLeftPosition.dy.toInt();
        int offset = details.globalPosition.dy.toInt() - _widgetTop;
        int index = _getIndex(offset);
        if (index != -1) {
          _lastIndex = index;
          setState(() {
            _tag = _data[index];
          });
          _triggerTouchEvent();
        }
      },
      onVerticalDragUpdate: (DragUpdateDetails details) {
        int offset = details.globalPosition.dy.toInt() - _widgetTop;
        int index = _getIndex(offset);
        if (index != -1 && _lastIndex != index) {
          _lastIndex = index;
          setState(() {
            _tag = _data[index];
          });
          _triggerTouchEvent();
        }
      },
      onVerticalDragEnd: (DragEndDetails details) {
        setState(() {
          _tag = '';
        });
        _triggerTouchEvent();
      },
      onTapUp: (TapUpDetails details) {
        setState(() {
          _tag = '';
        });
        _triggerTouchEvent();
      },
      child: Container(
        width: 35.0,
        height: 300.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _children,
        ),
      ),
    );
  }
}
