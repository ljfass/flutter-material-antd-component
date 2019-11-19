import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InputItem extends StatefulWidget {
  InputItem(
      {Key key,
      this.child,
      this.type = 'text',
      this.defaultValue = '',
      this.placeholder,
      this.editable = true,
      this.disabled = false,
      this.clear = false,
      this.maxLength,
      this.moneyKeyboardAlign = 'right'})
      : super(key: key);
  final Widget child;
  final String type;
  final String defaultValue;
  final String placeholder;
  final bool editable;
  final bool disabled;
  final bool clear;
  final int maxLength;
  final String moneyKeyboardAlign;

  @override
  _InputItemState createState() => _InputItemState();
}

class _InputItemState extends State<InputItem> {
  bool showClear = false;
  FocusNode _focusNode;
  TextEditingController _textEditingController;
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _textEditingController = TextEditingController(text: widget.defaultValue);
    _textEditingController.addListener(() {
      if (_textEditingController.text != '') {
        setState(() {
          showClear = true;
        });
      } else {
        setState(() {
          showClear = false;
        });
      }
    });
    _focusNode.addListener(() {
      if (_focusNode.hasFocus == true) {
        if (_textEditingController.text == '') {
          setState(() {
            showClear = false;
          });
        }
        if (_textEditingController.text != '') {
          setState(() {
            showClear = true;
          });
        }
      }

      if (_focusNode.hasFocus == false) {
        setState(() {
          showClear = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Widget _buildClearWidget({bool show = false}) {
    return Visibility(
      visible: show,
      child: Container(
        width: 14.0,
        height: 14.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: Color(0xff000000).withOpacity(0.3)),
        child: Align(
          alignment: Alignment.center,
          child: Icon(
            Icons.close,
            size: 11.0,
            color: Color(0xffffffff),
          ),
        ),
      ),
    );
  }

  Widget _buildInputItemChildLabel() {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(right: 5.0),
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
      child: DefaultTextStyle(
        maxLines: 1,
        overflow: TextOverflow.clip,
        textAlign: TextAlign.end,
        style: TextStyle(
            color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w500),
        child: widget.child,
      ),
    );
  }

  Widget _buildInputItemTypeTextWidgetChild() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _buildInputItemChildLabel(),
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  focusNode: _focusNode,
                  controller: _textEditingController,
                  textAlign: TextAlign.start,
                  enabled: !widget.disabled,
                  maxLength: widget.maxLength ?? null,
                  decoration: InputDecoration(
                      hintText: widget.placeholder ?? null,
                      hintStyle: TextStyle(color: Color(0xffc4c4c4)),
                      contentPadding: EdgeInsets.only(left: 15.0),
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                  onChanged: (String value) {
                    print(value);
                  },
                ),
              ),
              _buildClearWidget(show: widget.clear == false ? false : showClear)
            ],
          ),
        )
      ],
    );
  }

  Widget _buildInputItemTypeTextWithoutChild() {
    return TextField(
      controller: _textEditingController,
      textAlign: TextAlign.start,
      enabled: !widget.disabled,
      maxLength: widget.maxLength ?? null,
      decoration: InputDecoration(
          hintText: widget.placeholder ?? null,
          hintStyle: TextStyle(color: Color(0xffc4c4c4)),
          contentPadding: EdgeInsets.only(left: 15.0),
          border: OutlineInputBorder(borderSide: BorderSide.none)),
    );
  }

  /// text
  Widget _buildInputItemTypeText() {
    return Container(
      height: 40.0,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: widget.child != null
          ? _buildInputItemTypeTextWidgetChild()
          : _buildInputItemTypeTextWithoutChild(),
    );
  }

  Widget _buildInputItemWidget() {
    switch (widget.type) {
      case 'text':
        {
          return _buildInputItemTypeText();
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildInputItemWidget();
  }
}
