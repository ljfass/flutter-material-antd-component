import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  Animation<double> __animation;
  Animation<double> _containerAnimation;
  Animation<double> _cancelButtonAnimation;
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _animationController =
        AnimationController(duration: Duration(milliseconds: 320), vsync: this);
    _animation = Tween<double>(begin: 1, end: 0.22).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.ease));
    __animation = Tween<double>(begin: -5, end: -5.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.ease));
    _containerAnimation = Tween<double>(begin: 1, end: 0.9).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.ease));
    _cancelButtonAnimation = Tween<double>(begin: -35, end: 10).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.ease));
  }

  @override
  void dispose() {
    _animationController.dispose();

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
                      showCancelButton: (bool s) {},
                    ),
                  ),
                ],
              )),
          CancelButtonAnimated(
            animation: _cancelButtonAnimation,
            animationController: _animationController,
            focusNode: _focusNode,
          )
        ],
      ),
    );
  }
}

class CancelButtonAnimated extends AnimatedWidget {
  CancelButtonAnimated({
    Key key,
    Animation<double> animation,
    this.animationController,
    this.widget,
    this.focusNode,
  }) : super(key: key, listenable: animation);
  final widget;
  final AnimationController animationController;
  final FocusNode focusNode;

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;

    return Positioned(
      right: animation.value,
      child: GestureDetector(
        onTap: () {
          animationController.reverse();
          focusNode.canRequestFocus = false;
        },
        child: Text('取消'),
      ),
    );
  }
}

class SearchInput extends StatefulWidget {
  SearchInput(
      {Key key,
      this.animation,
      this.inputContainerAnimation,
      this.animationController,
      this.showCancelButton,
      this.focusNode})
      : super(key: key);
  final Animation<double> animation;
  final Animation<double> inputContainerAnimation;
  final AnimationController animationController;
  final ValueChanged<bool> showCancelButton;
  final FocusNode focusNode;

  @override
  _SearchInputState createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  bool visibility = true;

  @override
  Widget build(BuildContext context) {
    return SearchInputContainer(
      animation: widget.inputContainerAnimation,
      widget: Container(
        alignment: Alignment.centerLeft,
        height: 28.0,
        decoration: BoxDecoration(
            color: Color(0xffffffff), borderRadius: BorderRadius.circular(3.0)),
        child: Stack(
          children: <Widget>[
            FractionallySizedBox(
              widthFactor: 1.0,
              heightFactor: 1.0,
            ),
            SearchSynthetic(
              animation: widget.animation,
              animationController: widget.animationController,
              visibility: visibility,
            ),
            Positioned(
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(color: Colors.transparent),
                child: SearchInputTextField(
                  animationController: widget.animationController,
                  focusNode: widget.focusNode,
                  cb: (bool res) {
                    setState(() {
                      visibility = res;
                    });
                  },
                ),
              ),
            )
          ],
        ),
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
  SearchSynthetic(
      {Key key,
      Animation<double> animation,
      this.widget,
      this.animationController,
      this.visibility = true})
      : super(key: key, listenable: animation);
  final widget;
  final AnimationController animationController;
  final bool visibility;

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return FractionallySizedBox(
        widthFactor: animation.value,
        heightFactor: 1.0,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.search,
                color: Color(0xffbbbbbb),
                size: 20.0,
              ),
              Opacity(
                opacity: visibility == true ? 1.0 : 0.0,
                child: Text(
                  'search',
                  style: TextStyle(color: Color(0xffbbbbbb), fontSize: 15.0),
                ),
              )
            ],
          ),
        ));
  }
}

class SearchInputTextField extends StatefulWidget {
  SearchInputTextField(
      {Key key, this.animationController, this.cb, this.focusNode})
      : super(key: key);
  final AnimationController animationController;
  final ValueChanged<bool> cb;
  final FocusNode focusNode;

  @override
  _SearchInputTextFieldState createState() => _SearchInputTextFieldState();
}

class _SearchInputTextFieldState extends State<SearchInputTextField> {
  TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: '');

    widget.focusNode.addListener(() {
      if (widget.focusNode.hasFocus == true) {
        widget.animationController.forward();
      }

      if (widget.focusNode.hasFocus == false) {
        widget.animationController.reverse();
      }
    });
    _textEditingController.addListener(() {
      if (_textEditingController.text != '') {
        widget.cb(false);
      } else {
        widget.cb(true);
      }
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.left,
      controller: _textEditingController,
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(
          24.0,
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
        //
      ),
      style: TextStyle(height: 1.0),
    );
  }
}
