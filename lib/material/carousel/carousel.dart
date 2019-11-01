import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

class Carousel extends StatefulWidget {
  Carousel(
      {Key key,
      @required this.items,
      this.selectedIndex = 0,
      this.dots = false,
      this.vertical = false,
      this.autoplay = false,
      this.autoplayInterval = 3000,
      this.infinite = false,
      this.frameOverflow = false,
      this.afterChange,
      this.cellSpacing,
      this.slideWidth,
      this.easing = Curves.easeOutCirc,
      this.isGrid = false,
      this.beforeChange})
      : assert(items != null && items.length > 0),
        assert(selectedIndex <= items.length - 1),
        super(key: key);

  final List<Widget> items;
  final int selectedIndex;
  final bool dots;
  final bool vertical;
  final bool autoplay;
  final int autoplayInterval;
  final bool infinite;
  final bool frameOverflow;
  final ValueChanged<int> afterChange;
  final double cellSpacing;
  final double slideWidth;
  final Curve easing;
  final bool isGrid;
  final ValueChanged<Map<String, int>> beforeChange;
  // 模拟可无限滚动

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel>
    with SingleTickerProviderStateMixin {
  Timer timer;
  PageController pageController;
  num realPage = 10000;
  Duration playAnimation = Duration(milliseconds: 800);
  double aspectRatio;
  int currentIndex;

  @override
  void initState() {
    super.initState();
    timer = getTimer();
    aspectRatio = widget.isGrid == false ? 16 / 9 : 1.0;
    currentIndex = widget.selectedIndex;
    pageController = PageController(
        viewportFraction: widget.frameOverflow == true ? 0.8 : 1.0,
        initialPage: widget.infinite
            ? realPage + widget.selectedIndex
            : widget.selectedIndex);
    realPage = widget.infinite
        ? realPage + widget.selectedIndex
        : widget.selectedIndex;
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  Timer getTimer() {
    return Timer.periodic(
        Duration(milliseconds: widget.autoplayInterval.toInt()), (_) {
      if (widget.autoplay) {
        pageController.nextPage(duration: playAnimation, curve: widget.easing);
      }
    });
  }

  // 指示圆点
  List<Widget> getDots() {
    List<Widget> dots = [];
    widget.items.asMap().forEach((int index, item) {
      dots.add(Container(
        width: 7.5,
        height: 7.5,
        margin: EdgeInsets.fromLTRB(3.0, 0.0, 3.0, 4.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentIndex == index
                ? Theme.of(context).primaryColor
                : Color(0xffcccccc)),
      ));
    });
    return dots;
  }

  Widget getWrapper(Widget child) {
    return Container(
      width: widget.slideWidth ?? null,
      child: Stack(
        children: <Widget>[
          widget.isGrid == true
              ? Container(
                  child: child,
                )
              : AspectRatio(
                  aspectRatio: aspectRatio,
                  child: child,
                ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Wrap(
              runSpacing: 5.0,
              alignment: WrapAlignment.center,
              children: widget.dots == true ? getDots() : [],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return getWrapper(ScrollConfiguration(
      behavior: ScrollViewBehavior(false, false, Colors.blue),
      child: PageView.builder(
        physics: PageScrollPhysics(),
        scrollDirection:
            widget.vertical == false ? Axis.horizontal : Axis.vertical,
        controller: pageController,
        itemCount: widget.infinite ? null : widget.items.length,
        onPageChanged: (int index) {
          if (widget.infinite == false && widget.autoplay == true) {
            if (index == widget.items.length - 1) {
              setState(() {
                currentIndex = index;
              });
              Future.delayed(
                  Duration(milliseconds: widget.autoplayInterval.toInt()), () {
                timer.cancel();
                pageController.animateToPage(0,
                    duration: playAnimation, curve: widget.easing);
                setState(() {
                  currentIndex = 0;
                });
                timer = getTimer();
              });
            } else {
              int currentPage = _getRealIndex(
                  index + widget.selectedIndex, realPage, widget.items.length);

              if (widget.beforeChange != null) {
                widget.beforeChange({'from': currentIndex, 'to': currentPage});
              }
              setState(() {
                currentIndex = currentPage;
              });

              if (widget.afterChange != null) {
                widget.afterChange(currentPage);
              }
            }
          } else {
            int currentPage = _getRealIndex(
                index + widget.selectedIndex, realPage, widget.items.length);

            if (widget.beforeChange != null) {
              widget.beforeChange({'from': currentIndex, 'to': currentPage});
            }
            setState(() {
              currentIndex = currentPage;
            });

            if (widget.afterChange != null) {
              widget.afterChange(currentPage);
            }
          }
        },
        itemBuilder: (BuildContext context, int i) {
          final int index = _getRealIndex(
              i + widget.selectedIndex, realPage, widget.items.length);
          return Container(
            margin: EdgeInsets.symmetric(
                vertical: widget.vertical == true
                    ? widget.cellSpacing != null ? widget.cellSpacing : 0.0
                    : 0.0,
                horizontal: widget.vertical == true
                    ? 0.0
                    : widget.cellSpacing != null ? widget.cellSpacing : 0.0),
            child: AnimatedBuilder(
              animation: pageController,
              child: widget.items[index],
              builder: (BuildContext context, child) {
                // on the first render, the pageController.page is null,
                // this is a dirty hack
                if (pageController.position.minScrollExtent == null ||
                    pageController.position.maxScrollExtent == null) {
                  Future.delayed(Duration(microseconds: 1), () {
                    setState(() {});
                  });
                  return Container();
                }
                double value = pageController.page - i;
                value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                final double distortionValue = widget.frameOverflow
                    ? Curves.easeOut.transform(value)
                    : 1.0;

                final double height = (widget.slideWidth == null
                        ? MediaQuery.of(context).size.width
                        : widget.slideWidth) *
                    (1 / aspectRatio);
                final double width = distortionValue *
                    (widget.slideWidth == null
                        ? MediaQuery.of(context).size.width
                        : widget.slideWidth);

                return widget.vertical == false
                    ? Center(
                        child: SizedBox(
                          height: widget.isGrid == true
                              ? null
                              : distortionValue * height,
                          child: child,
                        ),
                      )
                    : Center(
                        child: SizedBox(
                          height: height,
                          width: width,
                          child: child,
                        ),
                      );
              },
            ),
          );
        },
      ),
    ));
  }
}

int _getRealIndex(int position, int base, int length) {
  final int offset = position - base;
  return _remainder(offset, length);
}

int _remainder(int input, int source) {
  final int result = input % source;
  return result < 0 ? source + result : result;
}

///可去掉过度滑动时ListView顶部的蓝色光晕效果
class ScrollViewBehavior extends ScrollBehavior {
  final bool isShowLeadingGlow;
  final bool isShowTrailingGlow;
  final Color _kDefaultGlowColor;

  ScrollViewBehavior(
      this.isShowLeadingGlow, this.isShowTrailingGlow, this._kDefaultGlowColor);

  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    //如果头部或底部有一个 不需要 显示光晕时 返回GlowingOverscrollIndicator
    if (!isShowLeadingGlow || !isShowTrailingGlow) {
      return new GlowingOverscrollIndicator(
        showLeading: isShowLeadingGlow,
        showTrailing: isShowTrailingGlow,
        child: child,
        axisDirection: axisDirection,
        color: _kDefaultGlowColor,
      );
    } else {
      //都需要光晕时  返回系统默认
      return super.buildViewportChrome(context, child, axisDirection);
    }
  }
}
