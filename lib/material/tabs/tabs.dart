import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class Tabs extends StatefulWidget {
  Tabs(
      {Key key,
      @required this.tabs,
      this.tabBarView,
      this.initialPage = 0,
      this.tabBarPosition = 'top',
      this.tabBarBackgroundColor,
      this.onChange,
      this.tabBarActiveTextColor,
      this.tabBarInactiveTextColor,
      this.swipeable = true,
      this.tabBarTextStyle})
      : assert(tabs.length > 0),
        assert(initialPage <= tabs.length - 1),
        assert(tabBarView == null || tabBarView.length == tabs.length),
        assert(tabBarPosition == 'bottom' || tabBarPosition == 'top'),
        super(key: key);
  final List<Map<String, dynamic>> tabs;
  final List<Widget> tabBarView;
  final int initialPage;
  final String tabBarPosition;
  final ValueChanged<int> onChange;
  final Color tabBarBackgroundColor;
  final Color tabBarActiveTextColor;
  final Color tabBarInactiveTextColor;
  final bool swipeable;
  final TextStyle tabBarTextStyle;

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> with TickerProviderStateMixin {
  TabController _tabController;
  int _currentTabIndex;
  List<TabItem> _tabItems = [];

  @override
  void initState() {
    super.initState();
    _currentTabIndex = widget.initialPage;
    _tabController = TabController(
        length: widget.tabs.length,
        vsync: this,
        initialIndex: widget.initialPage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _builTabItems();
  }

  void _onTap(int tabIndex) {
    if (widget.onChange != null) widget.onChange(tabIndex);
    setState(() {
      widget.tabs.asMap().forEach((int index, tab) {
        _tabItems[index] = TabItem(
          selected: index == tabIndex,
          activeColor: widget.tabBarActiveTextColor == null
              ? Theme.of(context).primaryColor
              : widget.tabBarActiveTextColor,
          inActiveColor: widget.tabBarInactiveTextColor == null
              ? Color(0xff000000)
              : widget.tabBarInactiveTextColor,
          label: tab['title'],
          textStyle: widget.tabBarTextStyle,
        );
      });
    });
  }

  void _builTabItems() {
    _tabItems.clear();
    widget.tabs.asMap().forEach((int index, tab) {
      _tabItems.add(TabItem(
        selected: index == _currentTabIndex,
        activeColor: widget.tabBarActiveTextColor == null
            ? Theme.of(context).primaryColor
            : widget.tabBarActiveTextColor,
        inActiveColor: widget.tabBarInactiveTextColor == null
            ? Color(0xff000000)
            : widget.tabBarInactiveTextColor,
        label: tab['title'],
        textStyle: widget.tabBarTextStyle,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        verticalDirection: widget.tabBarPosition == 'top'
            ? VerticalDirection.down
            : VerticalDirection.up,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0xffdddddd), width: 0.5))),
            child: Theme(
              data: ThemeData(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent),
              child: Material(
                color: widget.tabBarBackgroundColor == null
                    ? Colors.white
                    : widget.tabBarBackgroundColor,
                child: TabBar(
                  isScrollable: widget.tabs.length >= 4 ? true : false,
                  indicatorColor: Theme.of(context).primaryColor,
                  indicatorWeight: 1.0,
                  controller: _tabController,
                  labelPadding:
                      widget.tabs.length >= 4 ? null : EdgeInsets.all(10.0),
                  onTap: _onTap,
                  tabs: _tabItems,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: TabBarView(
                physics: widget.swipeable == true
                    ? AlwaysScrollableScrollPhysics()
                    : NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: widget.tabBarView,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TabItem<T> extends StatelessWidget {
  TabItem(
      {Key key,
      @required this.label,
      this.selected = false,
      this.activeColor,
      this.inActiveColor,
      this.textStyle})
      : super(key: key);
  final T label;
  final bool selected;
  final Color activeColor;
  final Color inActiveColor;
  final TextStyle textStyle;

  Widget _buildLabel<T>(label) {
    if (label is String) {
      return Text(
        label,
        style: textStyle != null
            ? textStyle
            : TextStyle(
                color: selected == true ? activeColor : inActiveColor,
                fontWeight: FontWeight.w400),
      );
    } else {
      return DefaultTextStyle(
        style: textStyle != null
            ? textStyle
            : TextStyle(
                color: selected == true ? activeColor : inActiveColor,
                fontWeight: FontWeight.w400),
        child: label,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.5,
      alignment: Alignment.center,
      child: _buildLabel(label),
    );
  }
}
