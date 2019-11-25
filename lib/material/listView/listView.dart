// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef RenderRow = Widget Function(int index);
typedef SectionHeader = Widget Function(int index);

class Listview extends StatefulWidget {
  Listview({
    Key key,
    @required this.itemCount,
    @required this.renderRow,
    this.separator,
    this.listviewHeader,
    this.listviewFooter,
    this.sectionHeader,
    this.onEndReachedThreshold = 1000,
    this.onEndReached,
    this.onScroll,
  })  : assert(itemCount > 0),
        super(key: key);
  final int itemCount;
  final Widget separator;
  final Widget listviewHeader;
  final Widget listviewFooter;
  final SectionHeader sectionHeader;
  final RenderRow renderRow;
  final double onEndReachedThreshold;
  final VoidCallback onScroll;
  final VoidCallback onEndReached;

  @override
  _ListviewState createState() => _ListviewState();
}

class _ListviewState extends State<Listview> {
  ScrollController _scrollController;
  ScrollPhysics _scrollPhysics;
  bool _loading = false;
  @override
  void initState() {
    super.initState();
    _scrollPhysics = AlwaysScrollableScrollPhysics();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (widget.onScroll != null) widget.onScroll();

      if (_scrollController.position.extentAfter <
          widget.onEndReachedThreshold) {
        if (widget.onEndReached != null) {
          // setState(() {
          //   _scrollPhysics = NeverScrollableScrollPhysics();
          // });
          this._loading = true;
          widget.onEndReached();
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildListviewHeader() {
    return DefaultTextStyle(
      style: TextStyle(fontSize: 14.0, color: Color(0xff888888)),
      child: Container(
        padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 9.0),
        child: widget.listviewHeader,
      ),
    );
  }

  Widget _buildListviewFooter() {
    return DefaultTextStyle(
      style: TextStyle(fontSize: 14.0, color: Color(0xff888888)),
      child: Container(
        padding: EdgeInsets.fromLTRB(9.0, 9.0, 9.0, 15.0),
        child: widget.listviewFooter,
      ),
    );
  }

  int _getListCount() {
    return getHeaderCount() + widget.itemCount + getFooterCount();
  }

  int getHeaderCount() {
    int headerCount = widget.listviewHeader != null ? 1 : 0;
    return headerCount;
  }

  int getFooterCount() {
    int footerCount = widget.listviewFooter != null ? 1 : 0;
    return footerCount;
  }

  Widget _buildListViewItem({Widget body, int index}) {
    return widget.sectionHeader == null
        ? Container(
            child: body,
          )
        : Container(
            padding: EdgeInsets.only(left: 15.0),
            decoration: BoxDecoration(
                border: Border(
                    bottom: index ==
                            (widget.listviewHeader == null
                                ? widget.itemCount - 1
                                : widget.itemCount)
                        ? BorderSide(color: Color(0xffececed), width: 0.5)
                        : BorderSide.none,
                    top: index == (widget.listviewHeader == null ? 0 : 1)
                        ? BorderSide(color: Color(0xffececed), width: 0.5)
                        : BorderSide.none)),
            child: Column(
              children: <Widget>[_buildSectionHeader(index), body],
            ),
          );
  }

  Widget _buildSectionHeader(int index) {
    return FractionallySizedBox(
      widthFactor: 1.0,
      child: Container(
        constraints: BoxConstraints(minHeight: 40.0),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 15.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(color: Color(0xffdddddd), width: 0.5))),
        child: DefaultTextStyle(
          style: TextStyle(color: Colors.black, fontSize: 14.0),
          child: widget.sectionHeader(index),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   _scrollPhysics = AlwaysScrollableScrollPhysics();
    // });

    return Material(
      color: Colors.white,
      child: ListView.separated(
        physics:
            _loading == true ? NeverScrollableScrollPhysics() : _scrollPhysics,
        controller: _scrollController,
        itemCount: _getListCount(),
        itemBuilder: (_, int index) {
          if (index < getHeaderCount()) {
            return _buildListviewHeader();
          } else if (index + 1 == _getListCount() &&
              widget.listviewFooter != null) {
            return _buildListviewFooter();
          } else {
            return _buildListViewItem(
                body: widget.renderRow(index), index: index);
          }
        },
        separatorBuilder: (_, int index) {
          if (index < getHeaderCount()) {
            return Center();
          } else {
            return widget.separator;
          }
        },
      ),
    );
  }
}
