import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Steps extends StatefulWidget {
  Steps(
      {Key key,
      this.current = 0,
      this.size,
      this.status = 'process',
      this.direction = 'vertical',
      @required this.steps})
      : assert(size == null || size == 'small'),
        assert(status == 'process' ||
            status == 'wait' ||
            status == 'finish' ||
            status == 'error'),
        assert(direction == 'vertical' || direction == 'horizontal'),
        super(key: key);

  final int current;
  final String size;
  final String status;
  final String direction;
  final List<StepItem> steps;
  @override
  _StepsState createState() => _StepsState();
}

class _StepsState extends State<Steps> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_onBuildCompleted);
  }

  _onBuildCompleted(_) {
    _getContainerSize();
  }

  _getContainerSize() {
    _containerKeyList.asMap().forEach((int index, _key) {
      final RenderBox containerRenderBox =
          _key.currentContext.findRenderObject();
      final containerSize = containerRenderBox.size;
      setState(() {
        _sizeList[index] = containerSize;
      });
    });
  }

  List<GlobalKey> _containerKeyList = [];
  List<Size> _sizeList = [];
  List<String> _statusList = [];

  Widget buildContentHorizontal(BuildContext context) {
    List<Widget> _children = [];

    widget.steps.asMap().forEach((int index, StepItem stepItem) {
      _containerKeyList.add(GlobalKey());
    });

    widget.steps.asMap().forEach((int index, StepItem stepItem) {
      _sizeList.add(Size(0, 0));
    });

    widget.steps.asMap().forEach((int index, StepItem stepItem) {
      String _status = stepItem.status != null
          ? stepItem.status
          : widget.status != null
              ? widget.current == index
                  ? widget.status
                  : widget.current > index ? 'finish' : 'wait'
              : widget.current == index
                  ? 'process'
                  : widget.current > index ? 'finish' : 'wait';
      _statusList.add(_status);
    });
    widget.steps.asMap().forEach((int index, StepItem stepItem) {
      double _top = widget.size == 'small' ? 7.0 : 9.5;
      String _status = stepItem.status != null
          ? stepItem.status
          : widget.status != null
              ? widget.current == index
                  ? widget.status
                  : widget.current > index ? 'finish' : 'wait'
              : widget.current == index
                  ? 'process'
                  : widget.current > index ? 'finish' : 'wait';

      if (index == 0) {
        _children.add(Expanded(
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Container(
                key: _containerKeyList[index],
                alignment: Alignment.center,
                child: StepItem(
                  index: index,
                  title: stepItem.title,
                  size: widget.size,
                  description: stepItem.description,
                  current: widget.current,
                  status: _status,
                  direction: widget.direction,
                  icon: stepItem.icon ?? null,
                  sizeList: _sizeList,
                ),
              ),
              Positioned(
                left:
                    _sizeList[index].width * 0.5 + (_sizeList[index].width / 5),
                right: 0.0,
                top: _top,
                child: buildTail(
                    context,
                    (_statusList[index + 1] == 'finish' ||
                            _statusList[index + 1] == 'process')
                        ? true
                        : false,
                    _statusList[index + 1] == 'error' ? 'error' : _status,
                    widget.direction),
              ),
            ],
          ),
        ));
      } else if (index + 1 == widget.steps.length) {
        _children.add(Expanded(
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Container(
                key: _containerKeyList[index],
                alignment: Alignment.center,
                child: StepItem(
                  index: index,
                  title: stepItem.title,
                  size: widget.size,
                  description: stepItem.description,
                  current: widget.current,
                  status: _status,
                  direction: widget.direction,
                  icon: stepItem.icon ?? null,
                  sizeList: _sizeList,
                ),
              ),
              Positioned(
                left: 0.0,
                right:
                    _sizeList[index].width * 0.5 + (_sizeList[index].width / 5),
                top: _top,
                child: buildTail(
                    context,
                    (_status == 'process' || _status == 'finish')
                        ? true
                        : false,
                    _status,
                    widget.direction),
              )
            ],
          ),
        ));
      } else {
        _children.add(Expanded(
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Container(
                key: _containerKeyList[index],
                alignment: Alignment.center,
                child: StepItem(
                  index: index,
                  title: stepItem.title,
                  size: widget.size,
                  description: stepItem.description,
                  current: widget.current,
                  status: _status,
                  direction: widget.direction,
                  icon: stepItem.icon ?? null,
                  sizeList: _sizeList,
                ),
              ),
              Positioned(
                left:
                    _sizeList[index].width * 0.5 + (_sizeList[index].width / 5),
                right: 0.0,
                top: _top,
                child: buildTail(
                    context,
                    (_statusList[index + 1] == 'finish' ||
                            _statusList[index + 1] == 'process')
                        ? true
                        : false,
                    _statusList[index] == 'error' ? 'wait' : _status,
                    widget.direction),
              ),
              Positioned(
                left: 0.0,
                right:
                    _sizeList[index].width * 0.5 + (_sizeList[index].width / 5),
                top: _top,
                child: buildTail(
                    context,
                    (_status == 'process' || _status == 'finish')
                        ? true
                        : false,
                    _status,
                    widget.direction),
              )
            ],
          ),
        ));
      }
    });

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _children,
    );
  }

  Widget buildContentVertical(BuildContext context) {
    List<Widget> _children = [];
    double _height = widget.size == 'small' ? 52.0 : 63.0;
    widget.steps.asMap().forEach((int index, StepItem stepItem) {
      String _status = stepItem.status != null
          ? stepItem.status
          : widget.status != null
              ? widget.current == index
                  ? widget.status
                  : widget.current > index ? 'finish' : 'wait'
              : widget.current == index
                  ? 'process'
                  : widget.current > index ? 'finish' : 'wait';
      if (index > 0) {
        _children.add(Container(
          height: _height,
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              StepItem(
                  title: stepItem.title,
                  description: stepItem.description,
                  current: widget.current,
                  size: widget.size,
                  status: _status,
                  direction: widget.direction,
                  icon: stepItem.icon ?? null),
              Positioned(
                top: widget.size == 'small' ? -29.0 : -33.0,
                child: buildTail(
                    context,
                    (_status == 'process' || _status == 'finish')
                        ? true
                        : false,
                    _status,
                    widget.direction),
              )
            ],
          ),
        ));
      } else {
        _children.add(Container(
          alignment: Alignment.centerLeft,
          height: _height,
          child: StepItem(
            title: stepItem.title,
            size: widget.size,
            description: stepItem.description,
            current: widget.current,
            status: _status,
            direction: widget.direction,
            icon: stepItem.icon ?? null,
          ),
        ));
      }
    });

    return Column(
      children: _children,
    );
  }

  Widget buildTail(
      BuildContext context, bool isActive, String status, String direction) {
    Color tailColor = Color(0xffdddddd);
    Color tailColorActive = Theme.of(context).primaryColor;
    EdgeInsets _margin = widget.size == 'small'
        ? EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0)
        : EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0);
    EdgeInsets _padding = widget.size == 'small'
        ? EdgeInsets.fromLTRB(0, 17.0, 0, 4.0)
        : EdgeInsets.fromLTRB(0, 22.0, 0, 4.0);

    return direction == 'vertical'
        ? Container(
            width: 1.0,
            margin: _margin,
            decoration: BoxDecoration(
                color: status == 'error'
                    ? Color(0xfff4333c)
                    : isActive == true ? tailColorActive : tailColor),
            padding: _padding,
          )
        : Container(
            height: 1.0,
            decoration: BoxDecoration(
                color: status == 'error'
                    ? Color(0xfff4333c)
                    : isActive == true ? tailColorActive : tailColor),
          );
  }

  @override
  Widget build(BuildContext context) {
    if (this.widget.steps.length <= 1) {
      return Container();
    }
    return widget.direction == 'vertical'
        ? buildContentVertical(context)
        : buildContentHorizontal(context);
  }
}

class StepItem<T> extends StatelessWidget {
  StepItem(
      {Key key,
      this.index,
      this.current = 0,
      this.status,
      @required this.title,
      this.size,
      this.description,
      this.direction,
      this.icon,
      this.sizeList})
      : assert(status == null ||
            status == 'process' ||
            status == 'wait' ||
            status == 'finish' ||
            status == 'error'),
        assert(icon == null || icon is IconData || icon is Icon),
        super(key: key);
  final int current;
  final String status;
  final String title;
  final String description;
  final T icon;
  final String size;
  final String direction;
  final int index;
  final List<Size> sizeList;

  Widget buildIcon<T>(icon, double iconSize, BuildContext context) {
    if (icon is IconData) {
      return Icon(
        icon,
        size: iconSize,
        color: Colors.white,
      );
    } else {
      return Theme(
        data: Theme.of(context).copyWith(
            iconTheme: Theme.of(context)
                .iconTheme
                .copyWith(color: Colors.white, size: iconSize)),
        child: icon,
      );
    }
  }

  Widget buildStepItem(BuildContext context) {
    Color themeColor = status == 'error'
        ? Color(0xfff4333c)
        : status == 'wait' ? Color(0xffcccccc) : Theme.of(context).primaryColor;
    TextStyle labelStyle = TextStyle(
        color: Color(0xffffffff), fontSize: size == 'small' ? 12.0 : 14.0);
    double containerSize = size == 'small' ? 16.0 : 20.0;
    double iconSize = size == 'small' ? 14.0 : 14.0;
    Widget ellipsis = Container(
      width: size == 'small' ? 3.31 : 4.05,
      height: size == 'small' ? 3.31 : 4.05,
      decoration:
          BoxDecoration(color: Color(0xffcccccc), shape: BoxShape.circle),
    );
    if (icon != null) {
      return Container(
          width: containerSize,
          height: containerSize,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(color: themeColor),
              color: themeColor,
              shape: BoxShape.circle),
          child: buildIcon(icon, iconSize, context));
    }
    switch (this.status) {
      case 'process':
        {
          return Container(
            width: containerSize,
            height: containerSize,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(color: themeColor),
                color: themeColor,
                shape: BoxShape.circle),
            child: Text('${current + 1}', style: labelStyle),
          );
        }
        break;
      case 'wait':
        {
          return Container(
            width: containerSize,
            height: containerSize,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[ellipsis, ellipsis, ellipsis],
            ),
          );
        }
        break;
      case 'finish':
        {
          return Container(
            width: containerSize,
            height: containerSize,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(color: themeColor),
                color: Color(0xffffffff),
                shape: BoxShape.circle),
            child: Icon(
              Icons.check,
              size: iconSize,
              color: themeColor,
            ),
          );
        }
        break;
      case 'error':
        {
          return Container(
            width: containerSize,
            height: containerSize,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xfff4333c)),
                color: Color(0xfff4333c),
                shape: BoxShape.circle),
            child: Icon(
              Icons.close,
              size: iconSize,
              color: Color(0xffffffff),
            ),
          );
        }
    }
  }

  Widget buildStep(BuildContext context) {
    TextStyle titleStyle = TextStyle(
        color: status == 'error' ? Color(0xfff4333c) : Color(0xff000000),
        fontSize: 14.0,
        fontWeight: FontWeight.w700);
    TextStyle smallSizeDescriptionStyle = TextStyle(
        color: status == 'error' ? Color(0xfff4333c) : Color(0xffbbbbbb),
        fontSize: 12.0);
    TextStyle defaultSizeDescriptionStyle = TextStyle(
        color: status == 'error' ? Color(0xfff4333c) : Color(0xff000000),
        fontSize: 15.0);
    double _top = size == 'small' ? 0.0 : description == null ? 4.0 : 2.0;
    return description == 'vertical'
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildStepItem(context),
              SizedBox(
                width: 8.0,
              ),
              Padding(
                padding: EdgeInsets.only(top: _top),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: titleStyle,
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    description == null
                        ? Text('')
                        : Text(description,
                            style: size == null
                                ? defaultSizeDescriptionStyle
                                : smallSizeDescriptionStyle)
                  ],
                ),
              )
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              buildStepItem(context),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: EdgeInsets.only(top: _top),
                child: Column(
                  children: <Widget>[
                    Text(
                      title,
                      style: titleStyle,
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    description == null
                        ? Text('')
                        : Container(
                            width: 96.0,
                            child: Text(description,
                                textAlign: TextAlign.center,
                                style: size == null
                                    ? defaultSizeDescriptionStyle
                                    : smallSizeDescriptionStyle),
                          )
                  ],
                ),
              )
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return buildStep(context);
  }
}
