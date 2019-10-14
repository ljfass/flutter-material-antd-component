import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../badge/badge.dart';
import '../button/button.dart';

class ActionSheet {
  static showActionSheetWithOptions(BuildContext context,
      {@required List<String> options,
      List<dynamic> badges,
      int cancelButtonIndex,
      int destructiveButtonIndex,
      String title,
      String message,
      bool maskClosable = true,
      Future Function(int) callback}) {
    showModalBottomSheet<Null>(
        context: context,
        builder: (_) {
          return ActionSheetWithOptions(
            options: options,
            badges: badges ?? null,
            title: title ?? null,
            message: message ?? null,
            cancelButtonIndex: cancelButtonIndex ?? null,
            destructiveButtonIndex: destructiveButtonIndex ?? null,
            callback: callback ?? null,
          );
        });
  }

  static showShareActionSheetWithOptions<T>(BuildContext context,
      {@required List<dynamic> options,
      String cancelButtonText,
      String title,
      T message,
      Future Function() callback}) {
    showModalBottomSheet<Null>(
        context: context,
        builder: (_) {
          return ActionShareSheetWithOptions(
            options: options,
            cancelButtonText: cancelButtonText ?? '取消',
            message: message ?? null,
            title: title ?? null,
            callback: callback ?? null,
          );
        });
  }

  static close(BuildContext context) {
    Navigator.of(context).pop();
  }
}

class ActionShareSheetWithOptions<T> extends StatefulWidget {
  ActionShareSheetWithOptions(
      {Key key,
      @required this.options,
      this.cancelButtonText,
      this.title,
      this.message,
      this.callback})
      : super(key: key);

  final List<dynamic> options;
  final String cancelButtonText;
  final String title;
  final T message;
  final Future Function() callback;

  @override
  _ActionShareSheetWithOptionsState createState() =>
      _ActionShareSheetWithOptionsState();
}

class _ActionShareSheetWithOptionsState
    extends State<ActionShareSheetWithOptions> with TickerProviderStateMixin {
  AnimationController _animationController;
  bool _messageVisible;
  bool _titleVisible;

  @override
  void initState() {
    super.initState();
    _titleVisible = widget.title == null ? false : true;
    _messageVisible = widget.message == null ? false : true;
    _animationController = AnimationController(vsync: this);
  }

  Widget buildIcon(icon, title) {
    return Container(
      margin: EdgeInsets.only(right: 12.0),
      child: Column(
        children: <Widget>[
          Container(
            width: 60.0,
            height: 60.0,
            margin: EdgeInsets.only(bottom: 9.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(3.0)),
            child: icon == null
                ? null
                : Container(width: 36.0, height: 36.0, child: icon),
          ),
          title == null
              ? Text('', style: TextStyle(fontSize: 10.0))
              : Text(
                  title,
                  style: TextStyle(color: Color(0xff888888), fontSize: 10.0),
                )
        ],
      ),
    );
  }

  Widget buildMessage<T>(message) {
    if (message is String) {
      return Text(
        widget.message,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14.0, color: Color(0xff888888)),
      );
    } else {
      return DefaultTextStyle(
        style: TextStyle(fontSize: 14.0, color: Color(0xff888888)),
        child: message,
      );
    }
  }

  Widget buildCancelButton() {
    return Container(
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(top: BorderSide(color: Color(0xffdddddd), width: 0.5))),
      child: DefaultTextStyle(
          style: TextStyle(color: Color(0xff000000), fontSize: 18.0),
          child: Button(
            buttonText: widget.cancelButtonText,
            showBorder: false,
            onClick: widget.callback == null
                ? null
                : () {
                    var cb = widget.callback();
                    if (cb is Future) {
                      cb.then((data) {
                        Navigator.of(context).pop();
                      });
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
          )),
    );
  }

  List<dynamic> buildOptions() {
    List<dynamic> _optionsList = [];
    List<Widget> _rowItem = [];

    if (widget.options[0] is List) {
      widget.options.asMap().forEach((int index, dynamic option) {
        assert(widget.options[0] is List && option is List);
      });
    }
    if (widget.options[0] is List) {
      widget.options.forEach((item) {
        item.forEach((child) {
          assert(child['icon'] != null);
          assert(child['title'] != null && child['title'] is String);
        });
      });
    } else {
      widget.options.forEach((item) {
        if (item is Map) {
          assert(item['icon'] != null);
          assert(item['title'] != null && item['title'] is String);
        } else if (item is List) {
          item.forEach((child) {
            assert(child['icon'] != null);
            assert(child['title'] != null && child['title'] is String);
          });
        }
      });
    }

    if (widget.options[0] is List) {
      widget.options.asMap().forEach((int index, dynamic option) {
        if (option is List) {
          List<Widget> __rowItem = [];
          option.forEach((item) {
            __rowItem.add(buildIcon(item['icon'], item['title']));
          });

          _optionsList.add(Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(15.0, 21.0, 0, 21.0),
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: Color(0xffdddddd), width: 0.5))),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Flex(
                direction: Axis.horizontal,
                children: __rowItem,
              ),
            ),
          ));
        }
      });
    } else {
      widget.options.asMap().forEach((int index, dynamic option) {
        if (option is List) {
          _rowItem.add(buildIcon(null, null));
        } else {
          _rowItem.add(buildIcon(option['icon'], option['title']));
        }
      });
    }

    if (_rowItem.length > 0) {
      _optionsList.add(Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(15.0, 21.0, 0, 21.0),
        decoration: BoxDecoration(
            border:
                Border(top: BorderSide(color: Color(0xffdddddd), width: 0.5))),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Flex(
            direction: Axis.horizontal,
            children: _rowItem,
          ),
        ),
      ));
    }

    return _optionsList;
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        elevation: 0.0,
        animationController: _animationController,
        onClosing: () {},
        enableDrag: true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
                decoration: BoxDecoration(color: Color(0xfff2f2f2)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Visibility(
                      visible: _titleVisible,
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(vertical: 12.0),
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: _titleVisible == false
                            ? Text('')
                            : Text(
                                widget.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 17.0, color: Color(0xff000000)),
                              ),
                      ),
                    ),
                    Visibility(
                      visible: _messageVisible,
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(vertical: 12.0),
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: _messageVisible == false
                            ? Text('')
                            : buildMessage(widget.message),
                      ),
                    ),
                    ...buildOptions(),
                    buildCancelButton()
                  ],
                )),
          );
        });
  }
}

class ActionSheetWithOptions extends StatefulWidget {
  ActionSheetWithOptions(
      {Key key,
      @required this.options,
      this.badges,
      this.title,
      this.message,
      this.cancelButtonIndex,
      this.destructiveButtonIndex,
      this.callback})
      : super(key: key);
  final List<String> options;
  final List<dynamic> badges;
  final String title;
  final String message;
  final int cancelButtonIndex;
  final int destructiveButtonIndex;
  final Future Function(int) callback;

  @override
  _ActionSheetWithOptionsState createState() => _ActionSheetWithOptionsState();
}

class _ActionSheetWithOptionsState extends State<ActionSheetWithOptions>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  bool _messageVisible;
  bool _titleVisible;

  @override
  void initState() {
    super.initState();
    _titleVisible = widget.title == null ? false : true;
    _messageVisible = widget.message == null ? false : true;
    _animationController = AnimationController(vsync: this);
  }

  List<dynamic> _buildButtonOptionsWithBadges() {
    List<dynamic> _buttonOptions = [];
    widget.options.asMap().forEach((int index, String option) {
      _buttonOptions.add(Button(
        onClick: widget.callback == null
            ? null
            : () {
                var cb = widget.callback(index);

                if (cb is Future) {
                  cb.then((data) {
                    Navigator.pop(context);
                  });
                } else {
                  Navigator.pop(context);
                }
              },
        buttonText: option,
        buttonTextColor: widget.destructiveButtonIndex != null
            ? widget.destructiveButtonIndex == index ? Colors.red : null
            : null,
      ));
    });

    widget.options.asMap().forEach((int index, String option) {
      widget.badges.forEach((dynamic bage) {
        assert(bage['index'] != null && bage['index'] is int);
        if (bage['index'] == index &&
            (widget.cancelButtonIndex == null
                ? true
                : bage['index'] != widget.cancelButtonIndex &&
                        widget.destructiveButtonIndex == null
                    ? true
                    : bage['index'] != widget.destructiveButtonIndex)) {
          _buttonOptions[index] = Button(
            onClick: widget.callback == null
                ? null
                : () {
                    var cb = widget.callback(index);
                    if (cb is Future) {
                      cb.then((data) {
                        Navigator.pop(context);
                      });
                    } else {
                      Navigator.pop(context);
                    }
                  },
            buttonText: Row(
              children: <Widget>[
                Text(option),
                SizedBox(
                  width: 6.0,
                ),
                Badge(
                  child: bage['child'] ?? null,
                  size: bage['size'] ?? 'small',
                  text: bage['text'] ?? null,
                  dot: bage['dot'] ?? false,
                  corner: bage['corner'] ?? false,
                  overflowCount: bage['overflowCount'] ?? 99,
                  hot: bage['hot'] ?? false,
                )
              ],
            ),
            buttonTextColor: widget.destructiveButtonIndex != null
                ? widget.destructiveButtonIndex == index ? Colors.red : null
                : null,
          );
        }
      });
    });

    if ((widget.cancelButtonIndex != null) &&
        (widget.cancelButtonIndex >= 0 &&
            widget.cancelButtonIndex < widget.options.length - 1)) {
      var cancelButton = _buttonOptions.removeAt(widget.cancelButtonIndex);
      _buttonOptions.add(Container(
        height: 6.0,
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: Color(0xffdddddd), width: 0.5),
                bottom: BorderSide(color: Color(0xffdddddd), width: 0.5)),
            color: Color(0xffe7e7e7)),
      ));
      _buttonOptions.add(cancelButton);
    }

    return _buttonOptions;
  }

  List<dynamic> _buildButtonOptions() {
    List<dynamic> _buttonOptions = [];
    widget.options.asMap().forEach((int index, String option) {
      _buttonOptions.add(Button(
        onClick: widget.callback == null
            ? null
            : () {
                var cb = widget.callback(index);
                if (cb is Future) {
                  cb.then((data) {
                    Navigator.pop(context);
                  });
                } else {
                  Navigator.pop(context);
                }
              },
        buttonText: option,
        buttonTextColor: widget.destructiveButtonIndex != null
            ? widget.destructiveButtonIndex == index ? Colors.red : null
            : null,
      ));
    });

    if ((widget.cancelButtonIndex != null) &&
        (widget.cancelButtonIndex >= 0 &&
            widget.cancelButtonIndex < widget.options.length - 1)) {
      _buttonOptions.removeAt(widget.cancelButtonIndex);
      _buttonOptions.add(Container(
        height: 6.0,
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: Color(0xffdddddd), width: 0.5),
                bottom: BorderSide(color: Color(0xffdddddd), width: 0.5)),
            color: Color(0xffe7e7e7)),
      ));
      _buttonOptions.add(Button(
        onClick: widget.callback == null
            ? null
            : () {
                var cb = widget.callback(_buttonOptions.length - 1);
                if (cb is Future) {
                  cb.then((data) {
                    Navigator.pop(context);
                  });
                } else {
                  Navigator.pop(context);
                }
              },
        buttonText: widget.options[widget.cancelButtonIndex],
      ));
    }

    return _buttonOptions;
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        elevation: 0.0,
        animationController: _animationController,
        onClosing: () {},
        enableDrag: true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(color: Color(0xffffffff)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: (widget.badges != null && widget.badges.length > 0)
                    ? <Widget>[
                        Visibility(
                          visible: _titleVisible,
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 12.0),
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: _titleVisible == false
                                ? Text('')
                                : Text(
                                    widget.title,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        color: Color(0xff000000)),
                                  ),
                          ),
                        ),
                        Visibility(
                          visible: _messageVisible,
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 12.0),
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: _messageVisible == false
                                ? Text('')
                                : Text(
                                    widget.message,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: Color(0xff888888)),
                                  ),
                          ),
                        ),
                        ..._buildButtonOptionsWithBadges()
                      ]
                    : <Widget>[
                        Visibility(
                          visible: _titleVisible,
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 12.0),
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: _titleVisible == false
                                ? Text('')
                                : Text(
                                    widget.title,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        color: Color(0xff000000)),
                                  ),
                          ),
                        ),
                        Visibility(
                          visible: _messageVisible,
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 12.0),
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: _messageVisible == false
                                ? Text('')
                                : Text(
                                    widget.message,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: Color(0xff888888)),
                                  ),
                          ),
                        ),
                        ..._buildButtonOptions()
                      ],
              ),
            ),
          );
        });
  }
}
