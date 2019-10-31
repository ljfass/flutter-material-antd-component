import 'package:flutter/material.dart';
import '../carousel/carousel.dart';
import 'dart:math';

class Grid extends StatefulWidget {
  Grid(
      {Key key,
      this.data,
      this.columnNum = 4,
      this.hasLine = true,
      this.isCarousel = false,
      this.carouselMaxRow = 2,
      this.renderItem,
      this.onClick})
      : assert(data != null && data.length > 0),
        super(key: key);
  final List<Map<String, String>> data;
  final int columnNum;
  final bool hasLine;
  final bool isCarousel;
  final int carouselMaxRow;
  final Widget renderItem;
  final ValueChanged<Map<String, dynamic>> onClick;

  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {
      print(scrollController.offset);
      print(scrollController.position);
    });
  }

  List<Widget> buildCarouselGridItem(int start, {int end}) {
    List<Widget> itemlists = [];
    // var rangeItems = widget.data.getRange(start, end);
    if (end == null) {
      for (int i = 0, l = widget.carouselMaxRow * widget.columnNum;
          i < l;
          i++) {
        itemlists.add(InkWell(
          onTap: i > 0
              ? null
              : () {
                  if (widget.onClick != null) {
                    widget.onClick({
                      'icon': widget.data[start]['icon'] ?? '',
                      'text': widget.data[start]['text'] ?? '',
                      'index': start
                    });
                  }
                },
          splashColor: Colors.transparent,
          highlightColor: Color(0xffdddddd),
          child: DefaultTextStyle(
            style: TextStyle(color: Color(0xff000000), fontSize: 12.0),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              decoration: BoxDecoration(
                border: widget.hasLine == true
                    ? Border(
                        bottom:
                            BorderSide(color: Color(0xffdddddd), width: 0.5),
                        right: BorderSide(color: Color(0xffdddddd), width: 0.5),
                        left: i == 0
                            ? BorderSide(color: Color(0xffdddddd), width: 0.5)
                            : BorderSide.none)
                    : Border.fromBorderSide(BorderSide.none),
              ),
              child: i == 0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FractionallySizedBox(
                            widthFactor: 0.28,
                            child: Image.network(
                              widget.data[start]['icon'],
                            )),
                        Container(
                          margin: EdgeInsets.only(top: 9),
                          child: Text(widget.data[start]['text']),
                        )
                      ],
                    )
                  : Container(),
            ),
          ),
        ));
      }
    } else {
      widget.data.asMap().forEach((int index, Map<String, String> item) {
        if (index >= start && index <= end) {
          itemlists.add(InkWell(
            onTap: () {
              if (widget.onClick != null) {
                widget.onClick({
                  'icon': item['icon'] ?? '',
                  'text': item['text'] ?? '',
                  'index': index
                });
              }
            },
            splashColor: Colors.transparent,
            highlightColor: Color(0xffdddddd),
            child: DefaultTextStyle(
              style: TextStyle(color: Color(0xff000000), fontSize: 12.0),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                decoration: BoxDecoration(
                  border: widget.hasLine == true
                      ? Border(
                          bottom:
                              BorderSide(color: Color(0xffdddddd), width: 0.5),
                          right:
                              BorderSide(color: Color(0xffdddddd), width: 0.5),
                          left: index == 0
                              ? BorderSide(color: Color(0xffdddddd), width: 0.5)
                              : BorderSide.none)
                      : Border.fromBorderSide(BorderSide.none),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FractionallySizedBox(
                        widthFactor: 0.28,
                        child: Image.network(
                          item['icon'],
                        )),
                    Container(
                      margin: EdgeInsets.only(top: 9),
                      child: Text(item['text']),
                    )
                  ],
                ),
              ),
            ),
          ));
        }
      });
    }
    return itemlists;
  }

  List<Widget> buildGridItem() {
    List<Widget> itemlists = [];
    widget.data.asMap().forEach((int index, Map<String, String> item) {
      itemlists.add(InkWell(
        onTap: () {
          if (widget.onClick != null) {
            widget.onClick({
              'icon': item['icon'] ?? '',
              'text': item['text'] ?? '',
              'index': index
            });
          }
        },
        splashColor: Colors.transparent,
        highlightColor: Color(0xffdddddd),
        child: DefaultTextStyle(
          style: TextStyle(color: Color(0xff000000), fontSize: 12.0),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            decoration: BoxDecoration(
              border: widget.hasLine == true
                  ? Border(
                      bottom: BorderSide(color: Color(0xffdddddd), width: 0.5),
                      right: BorderSide(color: Color(0xffdddddd), width: 0.5),
                      left: index == 0
                          ? BorderSide(color: Color(0xffdddddd), width: 0.5)
                          : BorderSide.none)
                  : Border.fromBorderSide(BorderSide.none),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FractionallySizedBox(
                    widthFactor: 0.28,
                    child: Image.network(
                      item['icon'],
                    )),
                Container(
                  margin: EdgeInsets.only(top: 9),
                  child: Text(item['text']),
                )
              ],
            ),
          ),
        ),
      ));
    });
    return itemlists;
  }

  Widget buildCarousel() {
    var total = widget.columnNum * widget.carouselMaxRow;

    return Carousel(
      dots: true,
      isGrid: true,
      items: <Widget>[
        GridView(
          physics: NeverScrollableScrollPhysics(),
          controller: scrollController,
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.columnNum,
              mainAxisSpacing: 0.0,
              crossAxisSpacing: 0.0,
              childAspectRatio: 1.0),
          children: buildCarouselGridItem(0, end: total - 1),
        ),
        GridView(
          physics: NeverScrollableScrollPhysics(),
          controller: scrollController,
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.columnNum,
              mainAxisSpacing: 0.0,
              crossAxisSpacing: 0.0,
              childAspectRatio: 1.0),
          children: buildCarouselGridItem(total),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var total = widget.columnNum * widget.carouselMaxRow;
    return Container(
      decoration: BoxDecoration(
        border: widget.hasLine == true
            ? Border(top: BorderSide(color: Color(0xffdddddd), width: 0.5))
            : Border.fromBorderSide(BorderSide.none),
      ),
      child: (widget.isCarousel == true && widget.data.length > total)
          ? buildCarousel()
          : GridView(
              physics: NeverScrollableScrollPhysics(),
              controller: scrollController,
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.columnNum,
                  mainAxisSpacing: 0.0,
                  crossAxisSpacing: 0.0,
                  childAspectRatio: 1.0),
              children: buildGridItem(),
            ),
    );
  }
}
