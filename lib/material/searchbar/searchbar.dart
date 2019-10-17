import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  SearchBar({
    Key key,
    this.defaultValue = '',
    this.placeholder = '',
    this.cancelText = '取消',
    this.showCancelButton = false,
    this.disabled = false,
    this.maxLength,
    this.onCancel,
    this.onChange,
    this.onFocus,
    this.onBlur,
    this.onSubmit,
  })  : assert(defaultValue == null ||
            maxLength == null ||
            defaultValue != null &&
                maxLength != null &&
                defaultValue.length <= maxLength),
        super(key: key);
  final String defaultValue;
  final String placeholder;
  final String cancelText;
  final bool showCancelButton;
  final bool disabled;
  final int maxLength;
  final ValueChanged<String> onCancel;
  final ValueChanged<String> onChange;
  final ValueChanged<String> onSubmit;
  final VoidCallback onFocus;
  final VoidCallback onBlur;

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Alignment> _animation;
  Animation<double> _containerAnimation;
  Animation<double> _cancelButtonAnimation;
  FocusNode _focusNode;
  TextEditingController _textEditingController;
  bool _placeholderVisibile = true;
  bool _clearIconVisibile = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _textEditingController = TextEditingController(text: widget.defaultValue);

    _animationController =
        AnimationController(duration: Duration(milliseconds: 320), vsync: this);

    _animation = Tween<Alignment>(
            begin: widget.defaultValue != ''
                ? Alignment.centerLeft
                : Alignment.center,
            end: Alignment.centerLeft)
        .animate(
            CurvedAnimation(parent: _animationController, curve: Curves.ease));
    _containerAnimation = Tween<double>(
            begin: widget.defaultValue != ''
                ? 0.9
                : widget.showCancelButton == false ? 1.0 : 0.9,
            end: 0.9)
        .animate(
            CurvedAnimation(parent: _animationController, curve: Curves.ease));
    _cancelButtonAnimation = Tween<double>(
            begin: widget.defaultValue != ''
                ? 8.0
                : widget.showCancelButton == false ? -35.0 : 8.0,
            end: 8.0)
        .animate(
            CurvedAnimation(parent: _animationController, curve: Curves.ease));
    if (widget.defaultValue != '') {
      _animationController.forward();
      setState(() {
        _animation =
            Tween<Alignment>(begin: Alignment.center, end: Alignment.centerLeft)
                .animate(CurvedAnimation(
                    parent: _animationController, curve: Curves.ease));

        if (widget.showCancelButton == true) return;
        _containerAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
            CurvedAnimation(parent: _animationController, curve: Curves.ease));
        _cancelButtonAnimation = Tween<double>(begin: -35.0, end: 8.0).animate(
            CurvedAnimation(parent: _animationController, curve: Curves.ease));
      });
    }

    _focusNode.addListener(() {
      if (_focusNode.hasFocus == true) {
        if (_textEditingController.text == '') {
          _animationController.forward();
          setState(() {
            _clearIconVisibile = false;
          });
        }
        if (_textEditingController.text != '') {
          setState(() {
            _clearIconVisibile = true;
          });
        }

        if (widget.onFocus != null) widget.onFocus();
      }

      if (_focusNode.hasFocus == false) {
        setState(() {
          _clearIconVisibile = false;
        });
        if (widget.onBlur != null) widget.onBlur();
        if ((widget.onCancel == null) ||
            (widget.onCancel != null &&
                _textEditingController.text ==
                    '')) if (_textEditingController.text == '')
          _animationController.reverse();
      }
    });
    if (widget.defaultValue != '')
      setState(() {
        _placeholderVisibile = false;
      });
    _textEditingController.addListener(() {
      if (_textEditingController.text != '') {
        setState(() {
          _placeholderVisibile = false;
          if (_focusNode.hasFocus == true) _clearIconVisibile = true;
        });
      } else {
        setState(() {
          _placeholderVisibile = true;
          _clearIconVisibile = false;
        });
      }
    });
  }

  void _valueClear() {
    _textEditingController.clear();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
              height: 44.0,
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                  color: Color(0xffefeff4),
                  border: Border(bottom: BorderSide(color: Color(0xffdddddd)))),
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Flexible(
                    flex: 8,
                    child: SearchInput(
                        animation: _animation,
                        inputContainerAnimation: _containerAnimation,
                        animationController: _animationController,
                        focusNode: _focusNode,
                        textEditingController: _textEditingController,
                        maxLength: widget.maxLength,
                        placeholder: widget.placeholder,
                        onChange: widget.onChange,
                        onCancel: widget.onCancel,
                        onFocus: widget.onFocus,
                        onBlur: widget.onBlur,
                        onSubmit: widget.onSubmit,
                        placeholderVisibile: _placeholderVisibile,
                        clearIconVisibile: _clearIconVisibile,
                        valueClear: _valueClear,
                        disabled: widget.disabled),
                  ),
                ],
              )),
          CancelButtonAnimated(
            disabled: widget.disabled,
            animation: _cancelButtonAnimation,
            animationController: _animationController,
            focusNode: _focusNode,
            cancelText: widget.cancelText,
            onCancel: widget.onCancel,
            textEditingController: _textEditingController,
          )
        ],
      ),
    );
  }
}

class CancelButtonAnimated extends AnimatedWidget {
  CancelButtonAnimated(
      {Key key,
      Animation<double> animation,
      this.disabled,
      this.animationController,
      this.widget,
      this.focusNode,
      this.textEditingController,
      this.cancelText,
      this.onCancel})
      : super(key: key, listenable: animation);
  final widget;
  final AnimationController animationController;
  final bool disabled;
  final FocusNode focusNode;
  final String cancelText;
  final ValueChanged<String> onCancel;
  final TextEditingController textEditingController;

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;

    return Positioned(
      right: animation.value,
      child: GestureDetector(
        onTap: disabled == true
            ? null
            : () {
                focusNode.canRequestFocus = false;
                if (onCancel != null) {
                  onCancel(textEditingController.text);
                } else {
                  animationController.reverse();
                  textEditingController.clear();
                }
              },
        child: Text(
          cancelText,
          style:
              TextStyle(color: Theme.of(context).primaryColor, fontSize: 15.0),
        ),
      ),
    );
  }
}

class SearchInput extends StatefulWidget {
  SearchInput({
    Key key,
    this.animation,
    this.inputContainerAnimation,
    this.animationController,
    this.focusNode,
    this.textEditingController,
    this.maxLength,
    this.placeholder,
    this.onChange,
    this.onCancel,
    this.onFocus,
    this.onBlur,
    this.onSubmit,
    this.placeholderVisibile,
    this.clearIconVisibile,
    this.valueClear,
    this.disabled,
  }) : super(key: key);
  final Animation<Alignment> animation;
  final Animation<double> inputContainerAnimation;
  final AnimationController animationController;
  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final int maxLength;
  final String placeholder;
  final ValueChanged<String> onChange;
  final ValueChanged<String> onCancel;
  final ValueChanged<String> onSubmit;
  final VoidCallback onFocus;
  final VoidCallback onBlur;
  final VoidCallback valueClear;
  final bool placeholderVisibile;
  final bool clearIconVisibile;
  final bool disabled;

  @override
  _SearchInputState createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SearchInputContainer(
      animation: widget.inputContainerAnimation,
      widget: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            height: 28.0,
            decoration: BoxDecoration(
                color: Color(0xffffffff),
                borderRadius: BorderRadius.circular(3.0)),
            child: Stack(
              children: <Widget>[
                FractionallySizedBox(
                  widthFactor: 1.0,
                  heightFactor: 1.0,
                ),
                SearchSynthetic(
                  animation: widget.animation,
                  animationController: widget.animationController,
                  visibility: widget.placeholderVisibile,
                  placeholder: widget.placeholder,
                ),
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.transparent),
                    child: SearchInputTextField(
                        animationController: widget.animationController,
                        focusNode: widget.focusNode,
                        textEditingController: widget.textEditingController,
                        maxLength: widget.maxLength,
                        onChange: widget.onChange,
                        onCancel: widget.onCancel,
                        onFocus: widget.onFocus,
                        onBlur: widget.onBlur,
                        onSubmit: widget.onSubmit,
                        disabled: widget.disabled),
                  ),
                )
              ],
            ),
          ),
          Visibility(
            visible: widget.clearIconVisibile,
            child: Positioned(
              right: 6.0,
              top: 0.0,
              bottom: 0.0,
              child: GestureDetector(
                onTap: widget.valueClear,
                child: ClearIcon(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SearchInputContainer extends AnimatedWidget {
  SearchInputContainer({Key key, Animation<double> animation, this.widget})
      : super(key: key, listenable: animation);
  final widget;
  Widget build(_) {
    final Animation<double> animation = listenable;
    return FractionallySizedBox(
      widthFactor: animation.value,
      child: widget,
    );
  }
}

class SearchSynthetic extends AnimatedWidget {
  SearchSynthetic({
    Key key,
    Animation<Alignment> animation,
    this.widget,
    this.animationController,
    this.placeholder,
    this.visibility = true,
  }) : super(key: key, listenable: animation);
  final widget;
  final AnimationController animationController;
  final String placeholder;
  final bool visibility;

  Widget build(BuildContext context) {
    final Animation<Alignment> animation = listenable;
    return FractionallySizedBox(
        widthFactor: 1.0,
        heightFactor: 1.0,
        child: Container(
          padding: EdgeInsets.only(left: 15.0),
          child: Align(
            alignment: animation.value,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.search,
                  color: Color(0xffbbbbbb),
                  size: 20.0,
                ),
                Opacity(
                  opacity: visibility == true ? 1.0 : 0.0,
                  child: SizedBox(
                    child: Text(
                      this.placeholder != '' ? '$placeholder' : 'search',
                      style:
                          TextStyle(color: Color(0xffbbbbbb), fontSize: 15.0),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class SearchInputTextField extends StatefulWidget {
  SearchInputTextField(
      {Key key,
      this.animationController,
      this.focusNode,
      this.textEditingController,
      this.maxLength,
      this.disabled,
      this.onChange,
      this.onCancel,
      this.onFocus,
      this.onBlur,
      this.onSubmit})
      : super(key: key);
  final AnimationController animationController;

  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final int maxLength;
  final bool disabled;
  final ValueChanged<String> onChange;
  final ValueChanged<String> onCancel;
  final ValueChanged<String> onSubmit;
  final VoidCallback onFocus;
  final VoidCallback onBlur;

  @override
  _SearchInputTextFieldState createState() => _SearchInputTextFieldState();
}

class _SearchInputTextFieldState extends State<SearchInputTextField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: !widget.disabled,
      textAlign: TextAlign.left,
      controller: widget.textEditingController,
      focusNode: widget.focusNode,
      maxLengthEnforced: widget.maxLength != null ? true : false,
      maxLength:
          widget.maxLength == null ? TextField.noMaxLength : widget.maxLength,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(
          35.0,
          0.0,
          20.0,
          14.0,
        ),
        fillColor: Colors.transparent,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffdddddd), width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffdddddd), width: 0.5),
        ),
        border: OutlineInputBorder(),
      ),
      style: TextStyle(height: 1.0),
      onChanged: widget.onChange == null
          ? null
          : (String change) {
              widget.onChange(change);
            },
      onSubmitted: (String value) {
        widget.onSubmit(value);
      },
    );
  }
}

class ClearIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
