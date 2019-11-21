import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class TextareaItem extends StatefulWidget {
  TextareaItem({
    Key key,
    this.title,
    this.defaultValue = '',
    this.placeholder = '',
    this.editable = true,
    this.disabled = false,
    this.clear = false,
    this.rows,
    this.count = 0,
    this.error = false,
    this.onChange,
    this.onFocus,
    this.onBlur,
    this.onErrorClick,
    this.autoHeight = false,
    this.labelNumber = 5,
    this.paddingLeft = 15.0,
  }) : super(key: key);
  final dynamic title;
  final String defaultValue;
  final String placeholder;
  final bool editable;
  final bool disabled;
  final bool clear;
  final int rows;
  final int count;
  final bool error;
  final bool autoHeight;
  final int labelNumber;
  final double paddingLeft;
  final ValueChanged<String> onChange;
  final ValueChanged<String> onFocus;
  final ValueChanged<String> onBlur;
  final VoidCallback onErrorClick;

  @override
  _TextareaItemState createState() => _TextareaItemState();
}

class _TextareaItemState extends State<TextareaItem> {
  int _rows;
  bool showClear = false;
  FocusNode _focusNode;
  TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _textEditingController = TextEditingController(text: widget.defaultValue);
    if (widget.autoHeight == false) {
      _rows = widget.rows ?? 1;
    }
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
        if (widget.onFocus != null) {
          widget.onFocus(_textEditingController.text);
        }
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
        this.showClear = false;
        setState(() {});
        if (widget.onBlur != null) widget.onBlur(_textEditingController.text);
      }
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Widget _buildClearWidget({bool show = false, VoidCallback callback}) {
    return Visibility(
      visible: show,
      child: GestureDetector(
        onTap: callback ?? null,
        child: Container(
          width: 14.0,
          height: 14.0,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff000000).withOpacity(0.3)),
          child: Align(
            alignment: Alignment.center,
            child: Icon(
              Icons.close,
              size: 11.0,
              color: Color(0xffffffff),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget({bool show = false, VoidCallback callback}) {
    return Visibility(
      visible: show,
      child: GestureDetector(
        onTap: callback ?? null,
        child: Container(
          margin: EdgeInsets.only(left: 6.0),
          width: 14.0,
          height: 14.0,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffffffff),
              border: Border.all(color: Color(0xffff5500))),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              '!',
              style: TextStyle(fontSize: 11.0, color: Color(0xffff5500)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputItemChildtitle() {
    dynamic _title;
    _title = widget.title is String
        ? widget.title.length >= widget.labelNumber
            ? Text(widget.title.substring(0, widget.labelNumber))
            : Text(widget.title)
        : widget.title;
    return Container(
      constraints: BoxConstraints(minWidth: 78.0),
      alignment: Alignment.topLeft,
      // decoration: BoxDecoration(color: Colors.yellow),
      margin: EdgeInsets.only(right: 5.0),
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
      child: DefaultTextStyle(
        maxLines: 1,
        overflow: TextOverflow.clip,
        textAlign: TextAlign.end,
        style: TextStyle(
            color: widget.disabled == true ? Color(0xffbbbbbb) : Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.w500),
        child: _title,
      ),
    );
  }

  Widget _buildTextFieldWidget() {
    return TextField(
      focusNode: _focusNode,
      controller: _textEditingController,
      cursorWidth: 1.8,
      enabled: !widget.disabled,
      readOnly: !widget.editable,
      maxLength: widget.count == 0 ? null : widget.count,
      maxLines: widget.rows != null
          ? widget.rows
          : widget.autoHeight == true ? null : _rows,
      style: TextStyle(
          color: widget.disabled == true
              ? Color(0xffc4c4c4)
              : widget.error == true ? Color(0xffff5500) : Colors.black),
      decoration: InputDecoration(
          contentPadding: widget.title == null
              ? EdgeInsets.only(top: 20.0)
              : EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          counterText: '',
          hintText: widget.placeholder,
          hintStyle: TextStyle(color: Color(0xffc4c4c4), fontSize: 16.0),
          border: OutlineInputBorder(borderSide: BorderSide.none)),
      onChanged: widget.onChange == null
          ? null
          : (String value) {
              widget.onChange(value);
            },
    );
  }

  Widget _buildInputItemTypeTextWithouttitle() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _buildTextFieldWidget(),
            ),
            Container(
              margin: EdgeInsets.only(top: 12.0),
              child: _buildClearWidget(
                  show: (widget.clear == false ||
                          widget.editable == false ||
                          widget.disabled == true)
                      ? false
                      : showClear,
                  callback: _handleContentClear),
            ),
            Container(
              margin: EdgeInsets.only(top: 12.0),
              child: _buildErrorWidget(
                  show: widget.error, callback: _handleErrorClick),
            )
          ],
        ),
        _buildCounter(
            show: widget.count > 1 && widget.rows != null && widget.rows > 1)
      ],
    );
  }

  Widget _buildInputItemTypeTextWidgetWithtitle() {
    return Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildInputItemChildtitle(),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 4.0),
                      child: _buildTextFieldWidget(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.0),
              child: _buildClearWidget(
                  show: (widget.clear == false ||
                          widget.editable == false ||
                          widget.disabled == true)
                      ? false
                      : this.showClear,
                  callback: _handleContentClear),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.0),
              child: _buildErrorWidget(
                  show: widget.error, callback: _handleErrorClick),
            )
          ],
        ),
        _buildCounter(
            show: widget.count > 1 && widget.rows != null && widget.rows > 1)
      ],
    );
  }

  Container _buildCounter({bool show = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.0),
      child: Visibility(
        visible: show,
        child: Align(
          alignment: Alignment.bottomRight,
          child: RichText(
              text: TextSpan(
                  text: _textEditingController.text.length.toString(),
                  style: TextStyle(color: Colors.black),
                  children: <TextSpan>[
                TextSpan(text: '/', style: TextStyle(color: Color(0xffc4c4c4))),
                TextSpan(
                    text: widget.count.toString(),
                    style: TextStyle(color: Color(0xffc4c4c4)))
              ])),
        ),
      ),
    );
  }

  void _handleContentClear() {
    setState(() {
      showClear = !showClear;
    });
    _textEditingController.clear();
  }

  void _handleErrorClick() {
    if (widget.onErrorClick != null) {
      widget.onErrorClick();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 40.0),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(
          widget.title != null ? widget.paddingLeft : 0.0, 0.0, 0.0, 0.0),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: widget.title != null
          ? _buildInputItemTypeTextWidgetWithtitle()
          : _buildInputItemTypeTextWithouttitle(),
    );
  }
}
