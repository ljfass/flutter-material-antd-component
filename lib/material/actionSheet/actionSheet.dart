import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../badge/badge.dart';
import '../button/button.dart';

class ActionSheet {
  static showActionSheetWithOptions(BuildContext context,
      {List<String> options,
      List<Badge> badges,
      int cancelButtonIndex,
      int destructiveButtonIndex,
      String title,
      String message,
      bool maskClosable = true,
      ValueChanged<int> callback}) {
    showModalBottomSheet<Null>(
        context: context,
        builder: (BuildContext context) {
          return ActionSheetWithOptions(
            options: options,
            title: title ?? null,
            message: message ?? null,
            cancelButtonIndex: cancelButtonIndex ?? null,
            destructiveButtonIndex: destructiveButtonIndex ?? null,
            callback: callback ?? callback,
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
  final List<Badge> badges;
  final String title;
  final String message;
  final int cancelButtonIndex;
  final int destructiveButtonIndex;
  final ValueChanged<int> callback;

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

  List<dynamic> _buildButtonOptions() {
    List<dynamic> _buttonOptions = [];
    widget.options.asMap().forEach((int index, String option) {
      _buttonOptions.add(Button(
        onClick: widget.callback == null
            ? null
            : () {
                widget.callback(index);
                Navigator.pop(context);
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
                widget.callback(_buttonOptions.length - 1);
                Navigator.pop(context);
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
        onClosing: () {
          return false;
        },
        enableDrag: true,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(color: Color(0xffffffff)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
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
                                fontSize: 17.0, color: Color(0xff000000)),
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
                                fontSize: 14.0, color: Color(0xff888888)),
                          ),
                  ),
                ),
                ..._buildButtonOptions()
              ],
            ),
          );
        });
  }
}
