import 'package:flutter/material.dart';
import '../carousel/carousel.dart';

class Grid extends StatefulWidget {
  Grid(
      {Key key,
      this.data,
      this.isCarousel = false,
      this.columnNum = 4,
      this.hasLine = true,
      this.carouselMaxRow = 2,
      this.renderItem,
      this.selectedIndex = 0,
      this.dots = false,
      this.autoplay = false,
      this.autoplayInterval = 3000,
      this.infinite = false,
      this.afterChange,
      this.beforeChange,
      this.cellSpacing,
      this.slideWidth,
      this.easing = Curves.easeOutCirc,
      this.onClick})
      : assert(data != null && data.length > 0),
        super(key: key);
  final bool isCarousel;
  final List<Map<String, String>> data;
  final int columnNum;
  final bool hasLine;
  final int selectedIndex;
  final bool dots;
  final bool autoplay;
  final int autoplayInterval;
  final bool infinite;
  final double cellSpacing;
  final double slideWidth;
  final Curve easing;
  final int carouselMaxRow;
  final Widget renderItem;
  final ValueChanged<Map<String, dynamic>> onClick;
  final ValueChanged<Map<String, int>> beforeChange;
  final ValueChanged<int> afterChange;

  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {});
  }

  List<Widget> buildCarouselGridItem(int start, int end) {
    var total = widget.columnNum * widget.carouselMaxRow;
    List<Widget> itemlists = [];

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
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xff000000), fontSize: 12.0),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              decoration: BoxDecoration(
                border: widget.hasLine == true
                    ? Border(
                        bottom:
                            BorderSide(color: Color(0xffdddddd), width: 0.5),
                        right: BorderSide(color: Color(0xffdddddd), width: 0.5),
                        left: index == 0
                            ? BorderSide(color: Color(0xffdddddd), width: 0.5)
                            : BorderSide.none)
                    : Border.fromBorderSide(BorderSide.none),
              ),
              child: widget.renderItem != null
                  ? widget.renderItem
                  : Column(
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
    if (itemlists.length < total) {
      for (int i = 0, l = total - itemlists.length; i < l; i++) {
        itemlists.add(InkWell(
          onTap: null,
          splashColor: Colors.transparent,
          highlightColor: Color(0xffdddddd),
          child: DefaultTextStyle(
            textAlign: TextAlign.center,
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
              child: Container(),
            ),
          ),
        ));
      }
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
          textAlign: TextAlign.center,
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
            child: widget.renderItem != null
                ? widget.renderItem
                : Column(
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
    var loop = (widget.data.length / total).ceil();
    List<Widget> carouselList = [];
    for (int i = 1; i <= loop; i++) {
      //一次循环为一个区间，每次取total个
      var start = (i - 1) * total;
      var end = i * total - 1;
      carouselList.add(GridView(
        physics: NeverScrollableScrollPhysics(),
        controller: scrollController,
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.columnNum,
            mainAxisSpacing: 0.0,
            crossAxisSpacing: 0.0,
            childAspectRatio: 1.0),
        children: buildCarouselGridItem(start, end),
      ));
    }
    return Carousel(
      selectedIndex: widget.selectedIndex,
      dots: widget.dots,
      isGrid: true,
      autoplay: widget.autoplay,
      infinite: widget.infinite,
      cellSpacing: widget.cellSpacing,
      slideWidth: widget.slideWidth,
      afterChange: widget.afterChange,
      beforeChange: widget.beforeChange,
      items: carouselList,
    );
  }

  Widget buildGridView() {
    return GridView(
      physics: NeverScrollableScrollPhysics(),
      controller: scrollController,
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.columnNum,
          mainAxisSpacing: 0.0,
          crossAxisSpacing: 0.0,
          childAspectRatio: 1.0),
      children: buildGridItem(),
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
          : buildGridView(),
    );
  }
}
