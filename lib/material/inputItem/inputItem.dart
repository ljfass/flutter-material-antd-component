import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

class InputItem extends StatefulWidget {
  InputItem({
    Key key,
    this.label,
    this.type = 'text',
    this.defaultValue = '',
    this.placeholder,
    this.editable = true,
    this.disabled = false,
    this.clear = false,
    this.maxLength,
    this.moneyKeyboardAlign = 'right',
    this.labelNumber = 5,
    this.updatePlaceholder = false,
    this.error = false,
    this.paddingLeft = 15.0,
    this.onChange,
    this.onFocus,
    this.onBlur,
    this.onErrorClick,
    this.onVirtualKeyboardConfirm,
  })  : assert(type == 'text' ||
            type == 'bankCard' ||
            type == 'phone' ||
            type == 'password' ||
            type == 'money' ||
            type == 'number' ||
            type == 'url' ||
            type == 'search' ||
            type == 'email'),
        assert(moneyKeyboardAlign == null ||
            moneyKeyboardAlign == 'left' ||
            moneyKeyboardAlign == 'right'),
        assert(label == null || label is String || label is Widget),
        assert(labelNumber >= 2 && labelNumber <= 7),
        super(key: key);
  final dynamic label;
  final String type;
  final String defaultValue;
  final String placeholder;
  final bool editable;
  final bool disabled;
  final bool clear;
  final int maxLength;
  final String moneyKeyboardAlign;
  final int labelNumber;
  final bool updatePlaceholder;
  final bool error;
  final double paddingLeft;
  final ValueChanged<String> onChange;
  final ValueChanged<String> onFocus;
  final ValueChanged<String> onBlur;
  final VoidCallback onErrorClick;
  final ValueChanged<String> onVirtualKeyboardConfirm;

  @override
  _InputItemState createState() => _InputItemState();
}

class _InputItemState extends State<InputItem> {
  bool showClear = false;
  FocusNode _focusNode;
  TextEditingController _textEditingController;
  String _placeholder;
  String _defaultValue;
  TextInputPhoneFormatter _phoneFormatter;
  TextInputBankCardFormatter _bankCardFormatter;
  int bankCardLoop = 1;
  List<TextInputFormatter> _textInputFormatterList = [];

  @override
  void initState() {
    super.initState();
    _defaultValue = widget.defaultValue;
    if (widget.type == 'bankCard') {
      _bankCardFormatter = TextInputBankCardFormatter(loop: bankCardLoop);
      _textInputFormatterList
          .add(WhitelistingTextInputFormatter(RegExp("[0-9]")));
      _textInputFormatterList.add(_bankCardFormatter);
    } else if (widget.type == 'phone') {
      _phoneFormatter = TextInputPhoneFormatter();
      _textInputFormatterList
          .add(WhitelistingTextInputFormatter(RegExp("[0-9]")));
      _textInputFormatterList.add(_phoneFormatter);
    } else if (widget.type == 'number') {
      _textInputFormatterList.add(WhitelistingTextInputFormatter.digitsOnly);
    } else if (widget.type == 'money') {
      _textInputFormatterList
          .add(WhitelistingTextInputFormatter(RegExp("[0-9.]")));
    }

    _placeholder = widget.placeholder ?? null;
    _focusNode = FocusNode();
    _textEditingController = TextEditingController(text: _defaultValue);
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

  Widget _buildInputItemChildLabel() {
    dynamic _label;
    _label = widget.label is String
        ? widget.label.length >= widget.labelNumber
            ? Text(widget.label.substring(0, widget.labelNumber))
            : Text(widget.label)
        : widget.label;
    return Container(
      constraints: BoxConstraints(minWidth: 78.0),
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(right: 5.0),
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
      child: DefaultTextStyle(
        maxLines: 1,
        overflow: TextOverflow.clip,
        textAlign: TextAlign.end,
        style: TextStyle(
            color: widget.disabled == true ? Color(0xffbbbbbb) : Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.w500),
        child: _label,
      ),
    );
  }

  TextField _buildTextFieldWidget(
      {List<TextInputFormatter> formatters,
      TextInputType type = TextInputType.text,
      bool isObscure = false,
      TextAlign textAlign = TextAlign.left,
      TextInputAction textInputAction = TextInputAction.done}) {
    return TextField(
        focusNode: _focusNode,
        controller: _textEditingController,
        textAlign: textAlign,
        keyboardType: type,
        enabled: !widget.disabled,
        readOnly: !widget.editable,
        cursorWidth: 1.2,
        maxLength: widget.maxLength ?? null,
        inputFormatters: formatters,
        obscureText: isObscure,
        textInputAction: textInputAction,
        style: TextStyle(
            color: widget.disabled == true
                ? Color(0xffc4c4c4)
                : widget.error == true ? Color(0xffff5500) : Colors.black),
        decoration: InputDecoration(
            counterText: '',
            hintText: _placeholder,
            hintStyle: TextStyle(color: Color(0xffc4c4c4), fontSize: 16.0),
            contentPadding: EdgeInsets.only(
                left: widget.label == null ? widget.paddingLeft : 0.0),
            border: OutlineInputBorder(borderSide: BorderSide.none)),
        onChanged: widget.onChange == null
            ? null
            : (String value) {
                if (widget.type == 'phone')
                  widget.onChange(value.replaceAll(RegExp(' '), ''));
                else
                  widget.onChange(value);
              },
        onSubmitted: widget.onVirtualKeyboardConfirm == null
            ? null
            : (String value) {
                widget.onVirtualKeyboardConfirm(value);
              });
  }

  Widget _buildInputItemTypeTextWithoutLabel() {
    Widget _contentWidget;
    switch (widget.type) {
      case 'text':
        {
          _contentWidget = _buildTextFieldWidget(
            formatters: [],
          );
        }
        break;
      case 'search':
        {
          _contentWidget = _buildTextFieldWidget(
              formatters: [], textInputAction: TextInputAction.search);
        }
        break;
      case 'phone':
        {
          _contentWidget = _buildTextFieldWidget(
              formatters: _textInputFormatterList, type: TextInputType.phone);
        }
        break;
      case 'bankCard':
        {
          _contentWidget = _buildTextFieldWidget(
              formatters: _textInputFormatterList, type: TextInputType.number);
        }
        break;
      case 'password':
        {
          _contentWidget =
              _buildTextFieldWidget(formatters: [], isObscure: true);
        }
        break;
      case 'number':
        {
          _contentWidget = _buildTextFieldWidget(
              formatters: _textInputFormatterList, type: TextInputType.number);
        }
        break;
      case 'money':
        {
          _contentWidget = _buildTextFieldWidget(
              formatters: _textInputFormatterList,
              type: TextInputType.number,
              textAlign: widget.moneyKeyboardAlign == 'right'
                  ? TextAlign.right
                  : TextAlign.left);
        }
        break;
      case 'email':
        {
          _contentWidget = _buildTextFieldWidget(
              formatters: [],
              type: TextInputType.emailAddress,
              textInputAction: TextInputAction.send);
        }
        break;
      case 'url':
        {
          _contentWidget =
              _buildTextFieldWidget(formatters: [], type: TextInputType.url);
        }
        break;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: _contentWidget,
        ),
        _buildClearWidget(
            show: (widget.clear == false ||
                    widget.editable == false ||
                    widget.disabled == true)
                ? false
                : showClear,
            callback: _handleContentClear),
        _buildErrorWidget(show: widget.error, callback: _handleErrorClick)
      ],
    );
  }

  Widget _buildInputItemTypeTextWidgetWithLabel() {
    Widget _contentWidget;
    switch (widget.type) {
      case 'text':
        {
          _contentWidget = _buildTextFieldWidget(
            formatters: [],
          );
        }
        break;
      case 'search':
        {
          _contentWidget = _buildTextFieldWidget(
              formatters: [], textInputAction: TextInputAction.search);
        }
        break;
      case 'phone':
        {
          _contentWidget = _buildTextFieldWidget(
              formatters: _textInputFormatterList, type: TextInputType.phone);
        }
        break;
      case 'bankCard':
        {
          _contentWidget = _buildTextFieldWidget(
              formatters: _textInputFormatterList, type: TextInputType.number);
        }
        break;
      case 'password':
        {
          _contentWidget =
              _buildTextFieldWidget(formatters: [], isObscure: true);
        }
        break;
      case 'number':
        {
          _contentWidget = _buildTextFieldWidget(
              formatters: _textInputFormatterList, type: TextInputType.number);
        }
        break;
      case 'money':
        {
          _contentWidget = _buildTextFieldWidget(
              formatters: _textInputFormatterList,
              type: TextInputType.number,
              textAlign: widget.moneyKeyboardAlign == 'right'
                  ? TextAlign.right
                  : TextAlign.left);
        }
        break;
      case 'email':
        {
          _contentWidget = _buildTextFieldWidget(
              formatters: [],
              type: TextInputType.emailAddress,
              textInputAction: TextInputAction.send);
        }
        break;
      case 'url':
        {
          _contentWidget =
              _buildTextFieldWidget(formatters: [], type: TextInputType.url);
        }
        break;
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _buildInputItemChildLabel(),
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: _contentWidget,
              ),
              _buildClearWidget(
                  show: (widget.clear == false ||
                          widget.editable == false ||
                          widget.disabled == true)
                      ? false
                      : this.showClear,
                  callback: _handleContentClear),
              _buildErrorWidget(show: widget.error, callback: _handleErrorClick)
            ],
          ),
        )
      ],
    );
  }

  void _handleContentClear() {
    setState(() {
      showClear = !showClear;
      if (widget.updatePlaceholder == true) {
        _placeholder = _textEditingController.text;
      }
    });
    _textEditingController.clear();
  }

  void _handleErrorClick() {
    if (widget.onErrorClick != null) {
      widget.onErrorClick();
    }
  }

  /// text、phone、password、number
  Widget _buildInputItemTextField() {
    return Container(
      height: 40.0,
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(
          widget.label != null ? widget.paddingLeft : 0.0, 0.0, 15.0, 0.0),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: widget.label != null
          ? _buildInputItemTypeTextWidgetWithLabel()
          : _buildInputItemTypeTextWithoutLabel(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildInputItemTextField();
  }
}

// 手机号码格式器
class TextInputPhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = new StringBuffer();
    if (newValue.text.length > 11) {
      newText.write(oldValue.text);
      return new TextEditingValue(
        text: newText.toString(),
        selection: new TextSelection.collapsed(offset: 13),
      );
    }

    if (newTextLength > 4) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 3) + ' ');
      if (newValue.selection.end >= 2) selectionIndex += 1;
    }

    if (newTextLength >= 8) {
      newText.write(newValue.text.substring(3, usedSubstringIndex = 7) + ' ');
      if (newValue.selection.end >= 2) selectionIndex += 1;
    }

    // Dump the rest.
    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));
    return new TextEditingValue(
      text: newText.toString(),
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

// 银行卡格式化器
class TextInputBankCardFormatter extends TextInputFormatter {
  TextInputBankCardFormatter({this.maxLength, this.loop});
  final int maxLength;
  final int loop;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = new StringBuffer();
    List<int> arr = [];
    for (int i = 1; i <= 9999; i++) {
      arr.add(i * 4 + 1);
    }
    for (int i = 0; i < arr.length; i++) {
      if (newTextLength >= arr[i]) {
        newText.write(newValue.text
                .substring(arr[i] - 5, usedSubstringIndex = arr[i] - 1) +
            ' ');
        if (newValue.selection.end >= 2) selectionIndex += 1;
      }
    }
    // Dump the rest.
    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));
    return new TextEditingValue(
      text: newText.toString(),
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
