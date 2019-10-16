import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    _animation = Tween<double>(begin: 1, end: 0.5).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.ease));
    // _animationController.forward();
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
      child: Container(
          height: 44.0,
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
              color: Color(0xffefeff4),
              border: Border(bottom: BorderSide(color: Color(0xffdddddd)))),
          child: Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Flexible(
                flex: 7,
                child: SearchInput(
                  animation: _animation,
                  animationController: _animationController,
                ),
              ),
              // Flexible(
              //   flex: 0,
              //   child: SearchCancelButton(
              //     animation: _animation,
              //   ),
              // )
            ],
          )),
    );
  }
}

class SearchInput extends StatelessWidget {
  SearchInput({Key key, this.animation, this.animationController})
      : super(key: key);
  final Animation<double> animation;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 28.0,
      decoration: BoxDecoration(
          color: Color(0xffffffff), borderRadius: BorderRadius.circular(3.0)),
      child: SearchSynthetic(
        animation: animation,
        animationController: animationController,
      ),
    );
  }
}

class SearchSynthetic extends AnimatedWidget {
  SearchSynthetic(
      {Key key,
      Animation<double> animation,
      this.widget,
      this.animationController})
      : super(key: key, listenable: animation);
  final widget;
  final AnimationController animationController;

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return FractionallySizedBox(
      widthFactor: animation.value,
      child: Container(
        alignment: Alignment.center,
        child: SearchInputTextField(
          animationController: animationController,
        ),
      ),
    );
  }
}

class SearchCancelButton extends AnimatedWidget {
  SearchCancelButton({Key key, Animation<double> animation, this.widget})
      : super(key: key, listenable: animation);
  final widget;

  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: 10.0),
      child: Text('取消'),
    );
  }
}

class SearchInputTextField extends StatefulWidget {
  SearchInputTextField({Key key, this.animationController}) : super(key: key);
  final AnimationController animationController;
  @override
  _SearchInputTextFieldState createState() => _SearchInputTextFieldState();
}

class _SearchInputTextFieldState extends State<SearchInputTextField> {
  FocusNode _focusNode;
  TextEditingController _textEditingController;
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: 'noinion');
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      // print(_focusNode.hasFocus);
      if (_focusNode.hasFocus == true) widget.animationController.forward();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      // controller: _textEditingController,
      // focusNode: _focusNode,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffdddddd), width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffdddddd), width: 0.5),
        ),
        border: OutlineInputBorder(),
        // hintText: 'search',
      ),
    );
  }
}
