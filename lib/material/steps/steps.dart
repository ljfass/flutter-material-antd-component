import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Steps extends StatelessWidget {
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

  Widget buildContentHorizontal(BuildContext context) {
    List<Widget> _children = [];
    double _height = size == 'small' ? 83.0 : 83.0;
    this.steps.asMap().forEach((int index, StepItem stepItem) {
      String _status = stepItem.status != null
          ? stepItem.status
          : status != null
              ? current == index ? status : current > index ? 'finish' : 'wait'
              : current == index
                  ? 'process'
                  : current > index ? 'finish' : 'wait';
      if (index > 0) {
        _children.add(Expanded(
          child: Container(
            alignment: Alignment.center,
            // decoration: BoxDecoration(color: Colors.pink),
            width: 120.0,
            // height: _height,
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                StepItem(
                    title: stepItem.title,
                    description: stepItem.description,
                    current: current,
                    size: size,
                    status: _status,
                    direction: direction,
                    icon: stepItem.icon ?? null),
                Positioned(
                  left: -66.0,
                  top: 8.0,
                  child: buildTail(
                      context,
                      (_status == 'process' || _status == 'finish')
                          ? true
                          : false,
                      _status,
                      direction),
                )
              ],
            ),
          ),
        ));
      } else {
        _children.add(Expanded(
          child: Container(
            alignment: Alignment.center,
            width: 120.0,
            // height: _height,
            child: StepItem(
              title: stepItem.title,
              size: size,
              description: stepItem.description,
              current: current,
              status: _status,
              direction: direction,
              icon: stepItem.icon ?? null,
            ),
          ),
        ));
      }
    });

    return Row(
      children: _children,
    );
  }

  Widget buildContentVertical(BuildContext context) {
    List<Widget> _children = [];
    double _height = size == 'small' ? 52.0 : 63.0;
    this.steps.asMap().forEach((int index, StepItem stepItem) {
      String _status = stepItem.status != null
          ? stepItem.status
          : status != null
              ? current == index ? status : current > index ? 'finish' : 'wait'
              : current == index
                  ? 'process'
                  : current > index ? 'finish' : 'wait';
      if (index > 0) {
        _children.add(Container(
          height: _height,
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              StepItem(
                  title: stepItem.title,
                  description: stepItem.description,
                  current: current,
                  size: size,
                  status: _status,
                  direction: direction,
                  icon: stepItem.icon ?? null),
              Positioned(
                top: size == 'small' ? -29.0 : -33.0,
                child: buildTail(
                    context,
                    (_status == 'process' || _status == 'finish')
                        ? true
                        : false,
                    _status,
                    direction),
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
            size: size,
            description: stepItem.description,
            current: current,
            status: _status,
            direction: direction,
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
    EdgeInsets _margin = size == 'small'
        ? EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0)
        : EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0);
    EdgeInsets _padding = size == 'small'
        ? EdgeInsets.fromLTRB(0, 17.0, 0, 4.0)
        : EdgeInsets.fromLTRB(0, 22.0, 0, 4.0);
    EdgeInsets _paddingHorizontal = size == 'small'
        ? EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0)
        : EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0);
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
            width: 80.0,
            decoration: BoxDecoration(
                color: status == 'error'
                    ? Color(0xfff4333c)
                    : isActive == true ? tailColorActive : tailColor),
            padding: _paddingHorizontal,
          );
  }

  @override
  Widget build(BuildContext context) {
    if (this.steps.length <= 1) {
      return Container();
    }
    return direction == 'vertical'
        ? buildContentVertical(context)
        : buildContentHorizontal(context);
  }
}

class StepItem<T> extends StatelessWidget {
  StepItem(
      {Key key,
      this.current = 0,
      this.status,
      @required this.title,
      this.size,
      this.description,
      this.direction,
      this.icon})
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
              Expanded(
                child: Padding(
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
                          : Expanded(
                              child: Container(
                                  width: 60.0,
                                  child: Text(description,
                                      textAlign: TextAlign.center,
                                      style: size == null
                                          ? defaultSizeDescriptionStyle
                                          : smallSizeDescriptionStyle)),
                            )
                    ],
                  ),
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
