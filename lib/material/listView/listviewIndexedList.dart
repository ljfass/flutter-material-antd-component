import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../material/listView/listView.dart';
import 'package:lpinyin/lpinyin.dart';

typedef void IndexBarTouchCallback(String tag);

class ListviewIndexedList extends StatefulWidget {
  ListviewIndexedList(
      {Key key,
      @required this.data,
      this.initialListSize,
      this.listviewHeader,
      this.listviewFooter,
      this.stickyHeader = false})
      : super(key: key);
  final List<dynamic> data;
  final bool stickyHeader;
  final Widget listviewHeader;
  final Widget listviewFooter;
  final int initialListSize;

  @override
  _ListviewIndexedListState createState() => _ListviewIndexedListState();
}

class _ListviewIndexedListState extends State<ListviewIndexedList> {
  ScrollController _scrollController;
  List<Widget> items;
  int sectionHeaderHeight = 28;
  int itemHeight = 40;
  Map<String, int> _suspensionSectionMap = new Map();
  List<CityInfo> _data = new List();
  List<String> _tagList = [];
  GlobalKey _listviewHeaderKey;
  int offset = 0;
  int initOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    if (widget.listviewHeader != null) {
      _listviewHeaderKey = GlobalKey();
      WidgetsBinding.instance.addPostFrameCallback(_getRenderBox);
    }
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  _getRenderBox(_) {
    //获取`RenderBox`对象
    RenderBox renderBox = _listviewHeaderKey.currentContext.findRenderObject();
    initOffset = renderBox.size.height.toInt();
    setState(() {
      offset = renderBox.size.height.toInt();
    });
  }

  void sortListBySuspensionTag(List<CityInfo> list) {
    if (list == null || list.isEmpty) return;
    list.sort((a, b) {
      if (a.getSuspensionTag == "@" || b.getSuspensionTag == "#") {
        return -1;
      } else if (a.getSuspensionTag == "#" || b.getSuspensionTag == "@") {
        return 1;
      } else {
        return a.getSuspensionTag.compareTo(b.getSuspensionTag);
      }
    });
  }

  void init() async {
    String tag;
    List list = widget.data ?? [];
    list.forEach((value) {
      _data.add(CityInfo(name: value['name']));
    });
    _handleList(_data);
    _data.forEach((v) {
      if (tag != v.getSuspensionTag) {
        tag = v.getSuspensionTag;
        setState(() {
          _suspensionSectionMap.putIfAbsent(tag, () => offset);
        });
        offset = offset + sectionHeaderHeight + itemHeight;
      } else {
        offset = offset + itemHeight;
      }
    });
  }

  void _onIndexBarTouch(String tag) {
    if (tag == '') return;
    if (tag == '#') {
      _scrollController.jumpTo(this.initOffset.toDouble());
      return;
    }

    int offset = _suspensionSectionMap[tag];

    if (offset != null) {
      _scrollController.jumpTo((offset.toDouble() +
          (widget.stickyHeader == true ? sectionHeaderHeight : 0.0)));
    }
  }

  void _handleList(List<CityInfo> list) {
    if (list == null || list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
    sortListBySuspensionTag(list);
    setState(() {
      _tagList = ['#']..addAll(getTagIndexList(list));
    });
  }

  List<String> getTagIndexList(List<CityInfo> list) {
    List<String> indexData = new List();
    if (list != null && list.isNotEmpty) {
      String tempTag;
      for (int i = 0, length = list.length; i < length; i++) {
        String tag = list[i].getSuspensionTag;
        if (tag.length > 2) tag = tag.substring(0, 2);
        if (tempTag != tag) {
          indexData.add(tag);
          tempTag = tag;
        }
      }
    }
    return indexData;
  }

  Widget _buildListviewHeader() {
    return Container(
      key: _listviewHeaderKey,
      padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 9.0),
      child: widget.listviewHeader,
    );
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Container(
      child: Stack(children: <Widget>[
        Listview(
            scrollController: _scrollController,
            itemCount: _suspensionSectionMap.length,
            initialListSize: widget.initialListSize,
            renderRow: _tagList.length == 0
                ? (int index) {
                    return Center();
                  }
                : (int index) {
                    String tag = _tagList[index];
                    List<Widget> _contents = List();
                    for (int j = 0; j < _data.length; j++) {
                      if (_data[j].tagIndex != tag) continue;
                      _contents.add(Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Container(
                              height: itemHeight.toDouble(),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                _data[j].name,
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: j == _data.length - 1
                                          ? BorderSide.none
                                          : BorderSide(
                                              color: Color(0xffdddddd),
                                              width: 0.5))),
                            ),
                          )
                        ],
                      ));
                    }

                    return Column(
                      children: _contents,
                    );
                  },
            stickyHeader: widget.stickyHeader,
            sectionHeader: _tagList.length == 0
                ? (int index) {
                    return Center();
                  }
                : (int index) {
                    return _tagList[index] == '#'
                        ? Center()
                        : FractionallySizedBox(
                            widthFactor: 1.0,
                            child: Container(
                              constraints: BoxConstraints(
                                  minHeight: sectionHeaderHeight.toDouble()),
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 15.0),
                              decoration: BoxDecoration(
                                  color:
                                      _tagList[index].toString().codeUnitAt(0) %
                                                  2 ==
                                              0
                                          ? Color(0xff5890ff)
                                          : Color(0xffF8591A),
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Color(0xffdddddd),
                                          width: 0.5))),
                              child: DefaultTextStyle(
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14.0),
                                child: Text(_tagList[index]),
                              ),
                            ),
                          );
                  },
            listviewHeader:
                widget.listviewHeader == null ? null : _buildListviewHeader(),
            listviewFooter: widget.listviewFooter),
        Positioned(
          right: 0.0,
          top: 60.0,
          child: _IndexBar(
            tagList: _tagList,
            onTouch: (String tag) {
              _onIndexBarTouch(tag);
            },
          ),
        )
      ]),
    );
  }
}

class _IndexBar extends StatefulWidget {
  _IndexBar({Key key, @required this.tagList, @required this.onTouch})
      : assert(onTouch != null),
        super(key: key);
  final List<String> tagList;
  final IndexBarTouchCallback onTouch;

  @override
  _IndexBarState createState() => _IndexBarState();
}

class _IndexBarState extends State<_IndexBar> {
  int _widgetTop = -1;

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

    widget.tagList?.forEach((value) {
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
    widget.tagList.forEach((v) {
      _children.add(Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 5.0),
        decoration: BoxDecoration(
            color:
                _tag == v ? Colors.black.withOpacity(0.4) : Colors.transparent),
        width: 30,
        height: 16,
        child: Text(
          v,
          textAlign: TextAlign.center,
          style:
              TextStyle(color: Theme.of(context).primaryColor, fontSize: 15.0),
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
            _tag = widget.tagList[index];
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
            _tag = widget.tagList[index];
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
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _children,
        ),
      ),
    );
  }
}

class CityInfo {
  String name;
  String tagIndex;
  String namePinyin;

  CityInfo({
    this.name,
    this.tagIndex,
    this.namePinyin,
  });

  CityInfo.fromJson(Map<String, dynamic> json)
      : name = json['name'] == null ? "" : json['name'];

  Map<String, dynamic> toJson() =>
      {'name': name, 'tagIndex': tagIndex, 'namePinyin': namePinyin};

  String get getSuspensionTag {
    return tagIndex;
  }
}
