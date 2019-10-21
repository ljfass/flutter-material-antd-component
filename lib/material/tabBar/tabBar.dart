import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabBar extends StatefulWidget {
  TabBar(
      {Key key,
      this.barTintColor = const Color(0xffffffff),
      this.tintColor,
      this.unselectedTintColor = const Color(0xff888888),
      this.hidden = false,
      this.noRenderContent = false,
      this.tabBarPosition = 'bottom',
      @required this.tabBarItem})
      : assert(tabBarItem.length > 0),
        assert(tabBarPosition == 'bottom' || tabBarPosition == 'top'),
        super(key: key);
  final Color barTintColor;
  final Color tintColor;
  final Color unselectedTintColor;
  final bool hidden;
  final bool noRenderContent;
  final String tabBarPosition;
  final List<Map<String, dynamic>> tabBarItem;

  @override
  _TabBarState createState() => _TabBarState();
}

class _TabBarState extends State<TabBar> {
  int stackIndex = 0;

  void _onTabChange(int index) {
    setState(() {
      stackIndex = index;
    });
  }

  List<TabBarItem> _buildTabBarWrap() {
    List<TabBarItem> _itemList = [];
    widget.tabBarItem.asMap().forEach((int index, dynamic item) {
      if (item['selected'] == true)
        setState(() {
          stackIndex = index;
        });
      _itemList.add(
        TabBarItem(
          index: index,
          badge: item['badge'],
          dot: item['dot'] != null ? item['dot'] : false,
          selected: item['selected'],
          icon: item['icon'] ?? null,
          selectedIcon: item['selectedIcon'] ?? null,
          title: item['title'] ?? null,
          onPress: item['onPress'] ?? null,
          child: item['child'] ?? null,
          selectedTextColor: widget.tintColor ?? Theme.of(context).primaryColor,
          unSelectedTextColor: widget.unselectedTintColor,
          onChange: _onTabChange,
        ),
      );
    });
    return _itemList;
  }

  List<Widget> _buildTabContent() {
    List<Widget> _contentList = [];
    widget.tabBarItem.asMap().forEach((int index, dynamic tabBarItem) {
      if (tabBarItem['child'] == null) {
        _contentList.add(Container());
      } else {
        _contentList.add(tabBarItem['child']);
      }
    });
    return _contentList;
  }

  @override
  Widget build(BuildContext context) {
    return widget.noRenderContent == true
        ? Container(
            alignment: Alignment.center,
            height: 45.0,
            decoration: BoxDecoration(
              border:
                  Border(top: BorderSide(color: Color(0xffdddddd), width: 0.5)),
              color: widget.barTintColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _buildTabBarWrap(),
            ),
          )
        : widget.tabBarPosition == 'top'
            ? Flex(
                direction: Axis.vertical,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Visibility(
                    visible: !widget.hidden,
                    child: Container(
                      alignment: Alignment.center,
                      height: 45.0,
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: Color(0xffdddddd), width: 0.5)),
                        color: widget.barTintColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: _buildTabBarWrap(),
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: Color(0xffffffff)),
                      child: IndexedStack(
                        index: stackIndex,
                        children: _buildTabContent(),
                      ),
                    ),
                  )
                ],
              )
            : Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Color(0xffffffff)),
                    child: IndexedStack(
                      index: stackIndex,
                      children: _buildTabContent(),
                    ),
                  ),
                  Visibility(
                    visible: !widget.hidden,
                    child: Positioned(
                      left: 0.0,
                      right: 0.0,
                      bottom: widget.tabBarPosition == 'bottom' ? 0.0 : null,
                      child: Container(
                        alignment: Alignment.center,
                        height: 45.0,
                        decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  color: Color(0xffdddddd), width: 0.5)),
                          color: widget.barTintColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: _buildTabBarWrap(),
                        ),
                      ),
                    ),
                  )
                ],
              );
  }
}

class AnimatedTabBar extends AnimatedWidget {
  AnimatedTabBar({Key key, Animation<double> animation, this.widget})
      : super(key: key, listenable: animation);
  final widget;
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: animation.value,
      child: widget,
    );
  }
}

class TabBarItem<T> extends StatelessWidget {
  TabBarItem(
      {Key key,
      this.title,
      this.icon,
      this.selectedIcon,
      this.selected = false,
      this.dot,
      this.badge,
      this.selectedTextColor,
      this.unSelectedTextColor,
      this.onPress,
      this.index,
      this.child,
      this.onChange})
      : assert(child == null || child is Widget),
        assert(icon == null || icon is Widget || icon is String),
        assert(selectedIcon == null ||
            selectedIcon is Widget ||
            selectedIcon is String),
        assert(badge == null || badge is int || badge is String),
        super(key: key);
  final int index;
  final String title;
  final T icon;
  final T selectedIcon;
  final bool selected;
  final bool dot;
  final T badge;
  final Color selectedTextColor;
  final Color unSelectedTextColor;
  final Widget child;
  final ValueChanged<int> onPress;
  final ValueChanged<int> onChange;

  _buildIcon<T>(_icon) {
    if (_icon == null) {
      return Badge(
        text: badge,
        dot: dot,
        child: Container(),
      );
    } else if (_icon is Widget) {
      return Badge(
        text: badge,
        dot: dot,
        child: _icon,
      );
    } else {
      return Badge(
        text: badge,
        dot: dot,
        child: Image.network(_icon),
      );
    }
  }

  _buildTitle() {
    if (title == null) return Text('');
    return Container(
      margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 10.0,
            height: 1.0,
            color: selected == true ? selectedTextColor : unSelectedTextColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return (title == null && icon == null)
        ? (badge == null && dot == false)
            ? Container(
                width: 22.0,
                height: 22.0,
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffdddddd), width: 0.5)),
              )
            : Badge(
                text: badge,
                dot: dot,
                child: Container(
                  width: 22.0,
                  height: 22.0,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffdddddd), width: 0.5)),
                ),
              )
        : GestureDetector(
            onTap: onPress == null
                ? () {
                    onChange(index);
                  }
                : () {
                    onChange(index);
                    onPress(index);
                  },
            child: Container(
              child: (badge == null && dot == false)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        selected == true
                            ? selectedIcon != null
                                ? _buildIcon(selectedIcon)
                                : _buildIcon(icon)
                            : _buildIcon(icon),
                        _buildTitle()
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        selected == true
                            ? selectedIcon != null
                                ? _buildIcon(selectedIcon)
                                : _buildIcon(icon)
                            : _buildIcon(icon),
                        _buildTitle()
                      ],
                    ),
            ),
          );
  }
}

class Badge<T> extends StatefulWidget {
  Badge(
      {Key key,
      this.child,
      this.size = 'small',
      this.text,
      this.corner = false,
      this.dot = false,
      this.overflowCount = 99,
      this.hot = false})
      : assert(child == null || child is Widget),
        assert(
            text == null || (text != null && (text is String || text is num))),
        super(key: key);
  final Widget child;
  final String size;
  final T text;
  final bool corner;
  final bool dot;
  final num overflowCount;
  final bool hot;

  @override
  _BadgeState createState() => _BadgeState();
}

class _BadgeState extends State<Badge> {
  GlobalKey _containerKey = GlobalKey();
  Size _containerSize = Size(0, 0);

  @override
  void initState() {
    super.initState();
    if ((widget.text is String || widget.text is num) && widget.child != null) {
      WidgetsBinding.instance.addPostFrameCallback(_onBuildCompleted);
    }
  }

  _onBuildCompleted(_) {
    _getContainerSize();
  }

  _getContainerSize() {
    final RenderBox containerRenderBox =
        _containerKey.currentContext.findRenderObject();
    final containerSize = containerRenderBox.size;
    setState(() {
      _containerSize = containerSize;
    });
  }

  Widget buildBadgeCorner(Widget _child) {
    return RotationTransition(
      turns: AlwaysStoppedAnimation(45 / 360),
      child: Container(
        alignment: Alignment.center,
        width: 80.0,
        height: 16.0,
        padding: EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
        decoration: BoxDecoration(color: Color(0XFFff5b05)),
        child: _child,
      ),
    );
  }

  Widget buildHot(content) {
    return Container(
        height: 18.0,
        padding: EdgeInsets.symmetric(horizontal: 9.0, vertical: 2.0),
        decoration: BoxDecoration(
            color: Color(0XFFF96268),
            borderRadius: BorderRadius.circular(12.0)),
        child: content is String
            ? Text('$content',
                style:
                    TextStyle(color: Colors.white, height: 1.2, fontSize: 12.0))
            : buildNumber(content));
  }

  Widget buildNumber(num number) {
    return number > widget.overflowCount
        ? Text('${widget.overflowCount}+',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, height: 1.2, fontSize: 11.0))
        : Text('$number',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, height: 1.2, fontSize: 11.0));
  }

  Widget buildDot() {
    return DecoratedBox(
      decoration:
          BoxDecoration(color: Color(0XFFFF5B05), shape: BoxShape.circle),
      child: Container(
        width: widget.size == 'small' ? 7.5 : 15.5,
        height: widget.size == 'small' ? 7.5 : 15.5,
      ),
    );
  }

  Widget buildTextWithoutChild<T>(text) {
    if (widget.corner == true) {
      return Text('');
    }
    if (widget.dot == true) {
      return buildDot();
    }
    if (text == null) {
      return Text('');
    }
    if (text is num) {
      if (text == 0) {
        return Text('');
      }
      return widget.hot == true
          ? buildHot(text)
          : ConstrainedBox(
              constraints: BoxConstraints(minWidth: 9.0),
              child: Container(
                  height: 18.0,
                  padding: EdgeInsets.symmetric(horizontal: 9.0, vertical: 2.0),
                  decoration: BoxDecoration(
                      color: Color(0XFFFF5B05),
                      borderRadius: BorderRadius.circular(12.0)),
                  child: buildNumber(text)),
            );
    } else {
      return widget.hot == true
          ? buildHot(text)
          : Container(
              height: 18.0,
              padding: EdgeInsets.symmetric(horizontal: 9.0, vertical: 2.0),
              decoration: BoxDecoration(
                  color: Color(0XFFFF5B05),
                  borderRadius: BorderRadius.circular(12.0)),
              child: Text(text,
                  style: TextStyle(
                      color: Colors.white, height: 1.2, fontSize: 12.0)));
    }
  }

  Widget buildUsualContent(content) {
    if (content is num) {
      return Container(
          height: 17.0,
          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.5),
          decoration: BoxDecoration(
              color: Color(0XFFFF5B05),
              borderRadius: BorderRadius.circular(12.0)),
          child: buildNumber(content));
    } else if (content is String) {
      return Container(
          height: 17.0,
          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.5),
          decoration: BoxDecoration(
              color: Color(0XFFFF5B05),
              borderRadius: BorderRadius.circular(12.0)),
          child: Text(content,
              style:
                  TextStyle(color: Colors.white, height: 1.2, fontSize: 11.0)));
    }
  }

  Widget buildTextWithChild<T>(text) {
    if (widget.dot == true && widget.corner == true) {
      return Text('$text');
    }
    if (widget.dot == true) {
      return Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          widget.child,
          Positioned(
            right: -3.0,
            top: -2.0,
            child: buildDot(),
          )
        ],
      );
    }
    if (text == null) {
      return widget.child;
    }
    if (text is num) {
      if (text == 0) {
        return widget.child;
      }
      return Stack(
        overflow: widget.corner == true ? Overflow.clip : Overflow.visible,
        children: <Widget>[
          Container(
            key: _containerKey,
            child: widget.child,
          ),
          widget.corner == true
              ? Positioned(
                  left: -_containerSize.width / 2,
                  top: _containerSize.height / 2,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: 9.0),
                    child: widget.corner == true
                        ? buildBadgeCorner(buildNumber(text))
                        : widget.hot == true
                            ? buildHot(text)
                            : buildUsualContent(text),
                  ),
                )
              : Positioned(
                  left: _containerSize.width - 10,
                  top: -2.0,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: 9.0),
                    child: widget.corner == true
                        ? buildBadgeCorner(buildNumber(text))
                        : widget.hot == true
                            ? buildHot(text)
                            : buildUsualContent(text),
                  ),
                )
        ],
      );
    } else {
      // text is String
      return Stack(
        overflow: widget.corner == true ? Overflow.clip : Overflow.visible,
        children: <Widget>[
          Container(
            key: _containerKey,
            child: widget.child,
          ),
          widget.corner == true
              ? Positioned(
                  left: -_containerSize.width / 2,
                  top: _containerSize.height / 2,
                  child: widget.corner == true
                      ? buildBadgeCorner(Text('$text',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              height: 1.2,
                              fontSize: 12.0)))
                      : widget.hot == true
                          ? buildHot(text)
                          : buildUsualContent(text),
                )
              : Positioned(
                  left: _containerSize.width - 10,
                  top: -2.0,
                  child: widget.corner == true
                      ? buildBadgeCorner(Text('$text',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              height: 1.2,
                              fontSize: 12.0)))
                      : widget.hot == true
                          ? buildHot(text)
                          : buildUsualContent(text),
                )
        ],
      );
    }
  }

  Widget buildContent() {
    return widget.child != null
        ? buildTextWithChild(widget.text)
        : buildTextWithoutChild(widget.text);
  }

  @override
  Widget build(BuildContext context) {
    return buildContent();
  }
}
