import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:material_antd/material/toast/toast.dart';
import '../button/button.dart';

class Modal<T> {
  static ModalMaskView preMask;

  static Widget buildModalTitle<T>(title) {
    return title == null
        ? Container()
        : Container(
            padding: EdgeInsets.fromLTRB(15.0, 6.0, 15.0, 12.0),
            child: DefaultTextStyle(
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
                height: 1.0,
                color: Color(0xff000000),
              ),
              child: title is Widget ? title : Text(title),
            ),
          );
  }

  static Widget buildModalMessage<T>(message) {
    return message == null
        ? Container()
        : Container(
            padding: EdgeInsets.fromLTRB(15.0, 6.0, 15.0, 15.0),
            child: DefaultTextStyle(
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.0,
                height: 1.0,
                color: Color(0xff888888),
              ),
              child: message is Widget ? message : Text(message),
            ),
          );
  }

  static Widget buildCloseButton(title, mask, afterClose, closable) {
    return Positioned(
      right: 10.0,
      top: closable == false ? 9999.0 : 12.0,
      child: GestureDetector(
        onTap: closable == false
            ? null
            : () {
                mask.dismiss();
                if (afterClose != null) afterClose();
              },
        child: Container(
          alignment: Alignment.center,
          width: 21.0,
          height: 21.0,
          decoration: BoxDecoration(color: Colors.transparent),
          child: Icon(
            Icons.close,
            size: 20.0,
            color: Color(0xffcccccc),
          ),
        ),
      ),
    );
  }

  static Widget buildModalFooter(List<Button> footer) {
    if (footer == null || footer.length == 0) return Row();
    List<Expanded> _buttonGroup = [];
    List<Button> __buttonGroup = [];
    footer.forEach((Button button) {
      _buttonGroup.add(Expanded(child: button));
      __buttonGroup.add(button);
    });
    return footer.length > 2
        ? Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: __buttonGroup,
            ),
          )
        : Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: _buttonGroup,
            ),
          );
  }

  static Widget buildPromptModalFooter<T>(
      context, callbackOrActions, textEditingController, value) {
    if (callbackOrActions is ValueChanged) {
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Button(
                radius: 0.0,
                buttonText: '取消',
                buttonTextColor: Colors.black,
              ),
            ),
            Expanded(
              child: Button(
                radius: 0.0,
                buttonText: '确定',
                buttonTextColor: Theme.of(context).primaryColor,
                onClick: () {
                  callbackOrActions(value);
                },
              ),
            ),
          ],
        ),
      );
    } else {}
  }

  static Widget buildModalBody(Widget body) {
    return DefaultTextStyle(
      style: TextStyle(color: Color(0xff888888), height: 1.5, fontSize: 15.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.transparent),
        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
        child: body,
      ),
    );
  }

  static Widget buildPromptModalBody(String type, String defaultValue,
      List<String> placeholders, TextEditingController textEditingController) {
    switch (type) {
      case 'default':
        {
          return TextField(
            controller: textEditingController,
            obscureText: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          );
        }
        break;
      case 'secure-text':
        {
          return Container();
        }
        break;
      case 'login-password':
        {
          return Container();
        }
        break;
    }
  }

  static Widget buildModalContent(BuildContext context,
      {Widget child,
      bool closable,
      bool popup,
      title,
      List<Button> footer,
      bool transparent,
      ModalMaskView maskView,
      VoidCallback afterClose}) {
    return transparent == true
        ? Stack(
            children: <Widget>[
              ClipRRect(
                child: Container(
                  padding: EdgeInsets.only(top: 15.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Container(
                    width: 270.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        buildModalTitle(title),
                        buildModalBody(child),
                        buildModalFooter(footer),
                      ],
                    ),
                  ),
                ),
                borderRadius: BorderRadius.circular(popup == false ? 7.0 : 0.0),
              ),
              buildCloseButton(title, maskView, afterClose, closable)
            ],
          )
        : Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.only(top: 15.0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        buildModalTitle(title),
                        buildModalBody(child),
                        buildModalFooter(footer)
                      ],
                    ),
                  ),
                ),
              ),
              buildCloseButton(title, maskView, afterClose, closable)
            ],
          );
  }

  static Widget buildModalPromptContent(BuildContext context,
      {title,
      message,
      String defaultValue,
      callbackOrActions,
      String type,
      List<String> placeholders}) {
    String textValue;
    TextEditingController _textEditingController = TextEditingController();
    _textEditingController.addListener(() {
      // print(_textEditingController.text);
      textValue = _textEditingController.text;
    });
    return ClipRRect(
      child: Container(
        padding: EdgeInsets.only(top: 15.0),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Container(
          width: 270.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildModalTitle(title),
              buildModalMessage(message),
              buildPromptModalBody(
                  type, defaultValue, placeholders, _textEditingController),
              buildPromptModalFooter(context, callbackOrActions,
                  _textEditingController, textValue),
            ],
          ),
        ),
      ),
      borderRadius: BorderRadius.circular(7.0),
    );
  }

  static show<T>(
    BuildContext context, {
    Widget child,
    VoidCallback afterClose,
    bool closable,
    bool maskClosable,
    VoidCallback onClose,
    bool transparent,
    bool popup = false,
    String animationType,
    T title,
    List<Button> footer,
  }) {
    assert(animationType == null ||
        animationType == 'slide-down' ||
        animationType == 'slide-up');
    if (footer != null && footer.length > 0) {
      footer.forEach((button) {
        assert(button is Button);
      });
    }

    var overlayState = Overlay.of(context);
    var maskView = ModalMaskView();
    OverlayEntry _entry;
    _entry = OverlayEntry(builder: (context) {
      return transparent == false
          ? GestureDetector(
              onTap: maskClosable == true
                  ? () {
                      maskView.dismiss();
                      if (afterClose != null) afterClose();
                    }
                  : null,
              child: Material(
                color: Color(0xffffffff),
                child: Container(
                  alignment: Alignment.topCenter,
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.only(top: 20.0),
                  child: LayoutBuilder(builder: (context, constraints) {
                    return PopupModal(
                      child: GestureDetector(
                        onTap: () {},
                        child: Center(
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: buildModalContent(context,
                                child: child,
                                transparent: transparent,
                                title: title,
                                maskView: maskView,
                                afterClose: afterClose,
                                footer: footer,
                                popup: popup),
                          ),
                        ),
                      ),
                      animationType: animationType,
                    );
                  }),
                ),
              ),
            )
          : popup == true
              ? GestureDetector(
                  onTap: maskClosable == true
                      ? () {
                          maskView.dismiss();
                          if (afterClose != null) afterClose();
                        }
                      : null,
                  child: Material(
                    color: Color(0xff000000).withOpacity(0.4),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: LayoutBuilder(builder: (context, constraints) {
                        return PopupModal(
                          child: GestureDetector(
                            onTap: () {},
                            child: Center(
                                child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: buildModalContent(context,
                                  child: child,
                                  transparent: transparent,
                                  title: title,
                                  maskView: maskView,
                                  afterClose: afterClose,
                                  footer: footer,
                                  popup: popup),
                            )),
                          ),
                          animationType: animationType,
                        );
                      }),
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: maskClosable == true
                      ? () {
                          maskView.dismiss();
                          if (afterClose != null) afterClose();
                        }
                      : null,
                  child: Material(
                    color: Color(0xff000000).withOpacity(0.4),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: LayoutBuilder(builder: (context, constraints) {
                        return GestureDetector(
                          onTap: () {},
                          child: Center(
                              child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: buildModalContent(context,
                                child: child,
                                transparent: transparent,
                                title: title,
                                maskView: maskView,
                                afterClose: afterClose,
                                footer: footer,
                                popup: popup),
                          )),
                        );
                      }),
                    ),
                  ),
                );
    });

    preMask?.dismiss();
    preMask = null;

    preMask = maskView;
    maskView.overlayState = overlayState;
    maskView.overlayEntry = _entry;
    maskView.duration = 3;
    maskView.onClose = onClose;
    maskView._show();
  }

  static prompt<T>(BuildContext context,
      {T title,
      T message,
      String type = 'default',
      String defaultValue,
      List<String> placeholders,
      T callbackOrActions}) {
    assert(
        type == 'default' || type == 'secure-text' || type == 'login-password');

    var overlayState = Overlay.of(context);
    var maskView = ModalMaskView();
    OverlayEntry _entry;

    _entry = OverlayEntry(builder: (BuildContext context) {
      return Material(
        color: Color(0xff000000).withOpacity(0.4),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: LayoutBuilder(builder: (context, constraints) {
            return GestureDetector(
              onTap: () {},
              child: Center(
                  child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: buildModalPromptContent(context,
                          title: title,
                          message: message,
                          callbackOrActions: callbackOrActions,
                          type: type,
                          defaultValue: defaultValue,
                          placeholders: placeholders))),
            );
          }),
        ),
      );
    });

    preMask?.dismiss();
    preMask = null;

    preMask = maskView;
    maskView.overlayState = overlayState;
    maskView.overlayEntry = _entry;
    maskView.duration = 3;
    maskView._show();
  }
}

class ModalMaskView {
  OverlayEntry overlayEntry;
  OverlayState overlayState;
  num duration;
  bool dismissed = false;
  VoidCallback onClose;

  _show() async {
    overlayState.insert(overlayEntry);
  }

  dismiss() async {
    if (dismissed) {
      return;
    }
    this.dismissed = true;
    overlayEntry?.remove();
  }
}

class PopupModal extends StatefulWidget {
  PopupModal({Key key, this.child, this.animationType = 'slide-down'})
      : super(key: key);
  final Widget child;
  final String animationType;

  @override
  _PopupModalState createState() => _PopupModalState();
}

class _PopupModalState extends State<PopupModal>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;
  double _positionBegin = -500.0;
  double _positionEnd = 0.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: Duration(milliseconds: 320),
        vsync: this,
        animationBehavior: AnimationBehavior.preserve);
    _animation = Tween<double>(begin: _positionBegin, end: _positionEnd)
        .animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatiedModal(
      animation: _animation,
      animationType: widget.animationType,
      widget: widget.child,
    );
  }
}

class AnimatiedModal extends AnimatedWidget {
  AnimatiedModal(
      {Key key, Animation<double> animation, this.animationType, this.widget})
      : super(key: key, listenable: animation);

  final widget;
  final String animationType;

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return animationType == 'slide-up'
        ? Stack(
            children: <Widget>[
              Positioned(
                left: 0.0,
                right: 0.0,
                bottom: animation.value,
                child: widget,
              )
            ],
          )
        : Stack(
            children: <Widget>[
              Positioned(
                left: 0.0,
                right: 0.0,
                top: animation.value,
                child: widget,
              )
            ],
          );
  }
}
