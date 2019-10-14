import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:material_antd/material/toast/toast.dart';
import '../button/button.dart';

typedef void VoidCallback();

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
                fontSize: 14.0,
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
            ? () {
                mask.dismiss();
              }
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

  static Widget buildModalFooter(BuildContext context,
      List<Map<String, dynamic>> footer, ModalMaskView maskView) {
    if (footer == null || footer.length == 0) return Row();
    List<Expanded> _buttonGroup = [];
    List<Button> __buttonGroup = [];
    footer.asMap().forEach((int index, Map<String, dynamic> button) {
      _buttonGroup.add(Expanded(
        child: Button(
          radius: 0.0,
          buttonText: button['text'],
          buttonTextColor: (footer.length == 2 && index == 0)
              ? Colors.black
              : Theme.of(context).primaryColor,
          onClick: button['onPress'] == null
              ? () {
                  maskView.dismiss();
                }
              : () {
                  var cb = button['onPress']();
                  if (cb is Future) {
                    cb.then((data) {
                      maskView.dismiss();
                    });
                  } else {
                    maskView.dismiss();
                  }
                },
        ),
      ));
      __buttonGroup.add(Button(
        radius: 0.0,
        buttonText: button['text'],
        buttonTextColor: Theme.of(context).primaryColor,
        onClick: button['onPress'] == null
            ? () {
                maskView.dismiss();
              }
            : () {
                var cb = button['onPress']();
                if (cb is Future) {
                  cb.then((data) {
                    maskView.dismiss();
                  });
                } else {
                  maskView.dismiss();
                }
              },
      ));
    });
    return footer.length > 2
        ? Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: __buttonGroup,
            ),
          )
        : footer.length == 1
            ? Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: _buttonGroup,
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

  static Widget buildModalOperationFooter(BuildContext context,
      List<Map<String, dynamic>> actions, ModalMaskView maskView) {
    if (actions == null || actions.length == 0) {
      return Row(
        children: <Widget>[
          Expanded(
              child: Button(
            radius: 0.0,
            textAlign: 'left',
            buttonText: '确定',
            onClick: () {
              maskView.dismiss();
            },
          ))
        ],
      );
    }

    List<Button> _buttonGroup = [];
    actions.forEach((Map<String, dynamic> button) {
      _buttonGroup.add(Button(
        radius: 0.0,
        textAlign: 'left',
        buttonText: button['text'],
        onClick: button['onPress'] == null
            ? () {
                maskView.dismiss();
              }
            : () {
                var cb = button['onPress'];
                if (cb is Future) {
                  maskView.dismiss();
                } else {
                  maskView.dismiss();
                }
              },
      ));
    });

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: _buttonGroup,
      ),
    );
  }

  static Widget buildModalBody(Widget body, bool popup) {
    return DefaultTextStyle(
      style: TextStyle(color: Color(0xff888888), height: 1.5, fontSize: 15.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.transparent),
        padding: popup == true
            ? EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0)
            : EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
        child: body,
      ),
    );
  }

  static Widget buildModalContent(BuildContext context,
      {Widget child,
      bool closable,
      bool popup,
      title,
      List<Map<String, dynamic>> footer,
      bool transparent,
      ModalMaskView maskView,
      VoidCallback afterClose}) {
    return transparent == true
        ? Stack(
            children: <Widget>[
              ClipRRect(
                child: Container(
                  padding: EdgeInsets.only(top: popup == true ? 0.0 : 15.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Container(
                    width: popup == true ? null : 270.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        buildModalTitle(title),
                        buildModalBody(child, popup),
                        buildModalFooter(context, footer, maskView),
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
                  color: Colors.white,
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
                        buildModalBody(child, popup),
                        buildModalFooter(context, footer, maskView)
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
      {ModalMaskView maskView,
      title,
      message,
      String defaultValue,
      callbackOrActions,
      String type,
      List<String> placeholders}) {
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
              ModalPromptContentContainer(
                  type: type,
                  defaultValue: defaultValue,
                  placeholders: placeholders,
                  callbackOrActions: callbackOrActions,
                  maskView: maskView)
            ],
          ),
        ),
      ),
      borderRadius: BorderRadius.circular(7.0),
    );
  }

  static Widget buildModalAlertContent(BuildContext context,
      {ModalMaskView maskView,
      title,
      message,
      List<Map<String, dynamic>> actions}) {
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
              buildModalFooter(context, actions, maskView)
            ],
          ),
        ),
      ),
      borderRadius: BorderRadius.circular(7.0),
    );
  }

  static Widget buildModalOperationContent(BuildContext context,
      {List<Map<String, dynamic>> actions, ModalMaskView maskView}) {
    return ClipRRect(
      child: Container(
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
              buildModalOperationFooter(context, actions, maskView),
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
    bool closable = false,
    bool maskClosable,
    VoidCallback onClose,
    bool transparent = false,
    bool popup = false,
    String animationType,
    T title,
    List<Map<String, dynamic>> footer,
  }) {
    assert(animationType == null ||
        animationType == 'slide-down' ||
        animationType == 'slide-up');
    if (footer != null && footer.length > 0) {
      footer.forEach((button) {
        assert(button['text'] != null);
        if (button['onPress'] != null) assert(button['onPress'] is Function());
      });
    }

    var overlayState = Overlay.of(context);
    var focusScopeNode = FocusScopeNode();
    var maskView = ModalMaskView();
    OverlayEntry _entry;
    _entry = OverlayEntry(builder: (context) {
      FocusScope.of(context).setFirstFocus(focusScopeNode);
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
                                closable: closable,
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
                                  closable: closable,
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
                  child: FocusScope(
                    node: focusScopeNode,
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
                                  closable: closable,
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
      @required T callbackOrActions}) {
    assert(
        type == 'default' || type == 'secure-text' || type == 'login-password');
    assert(callbackOrActions is Function(String) ||
        callbackOrActions is Function(String, String) ||
        callbackOrActions is List);
    if (callbackOrActions is List) {
      if (callbackOrActions.length > 0) {
        callbackOrActions.forEach((value) {
          assert(value['text'] != null && value['text'] is String);
          if (value['onPress'] != null) {
            assert(value['onPress'] is Function(String) ||
                value['onPress'] is Function(String, String));
          }
        });
      }
    }

    var overlayState = Overlay.of(context);
    var maskView = ModalMaskView();
    var focusScopeNode = FocusScopeNode();
    OverlayEntry _entry;

    _entry = OverlayEntry(builder: (BuildContext context) {
      FocusScope.of(context).setFirstFocus(focusScopeNode);
      return FocusScope(
        node: focusScopeNode,
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
                        child: buildModalPromptContent(context,
                            maskView: maskView,
                            title: title,
                            message: message,
                            callbackOrActions: callbackOrActions,
                            type: type,
                            defaultValue: defaultValue,
                            placeholders: placeholders))),
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
    maskView._show();
  }

  static alert<T>(BuildContext context,
      {T title, T message, List<Map<String, dynamic>> actions}) {
    if (actions != null && actions.length > 0) {
      actions.forEach((value) {
        assert(value['text'] != null && value['text'] is String);
        if (value['onPress'] != null) {
          assert(value['onPress'] is Function());
        }
      });
    }

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
                      child: buildModalAlertContent(context,
                          maskView: maskView,
                          title: title,
                          message: message,
                          actions: actions))),
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

  static operation(BuildContext context, {List<Map<String, dynamic>> actions}) {
    if (actions != null && actions.length > 1) {
      actions.forEach((value) {
        assert(value['text'] != null);
      });
    }
    var overlayState = Overlay.of(context);
    var maskView = ModalMaskView();
    OverlayEntry _entry;
    _entry = OverlayEntry(builder: (BuildContext context) {
      return GestureDetector(
        onTap: () {
          maskView.dismiss();
        },
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
                        child: buildModalOperationContent(context,
                            actions: actions, maskView: maskView))),
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

class ModalPromptContentContainer<T> extends StatefulWidget {
  ModalPromptContentContainer(
      {Key key,
      this.type,
      this.defaultValue,
      this.placeholders,
      this.callbackOrActions,
      this.maskView})
      : super(key: key);
  final String type;
  final String defaultValue;
  final List<String> placeholders;
  final T callbackOrActions;
  final ModalMaskView maskView;

  @override
  _ModalPromptContentContainerState createState() =>
      _ModalPromptContentContainerState();
}

class _ModalPromptContentContainerState
    extends State<ModalPromptContentContainer> {
  TextEditingController _textEditingController;
  TextEditingController _passwordEditingController;
  String defaultTextValue;

  Widget buildPromptModalFooter(
      context, type, callbackOrActions, textEditingController,
      {passwordEditingController}) {
    if ((callbackOrActions is Function(String) ||
        callbackOrActions is Function(String, String))) {
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
                onClick: () {
                  widget.maskView.dismiss();
                },
              ),
            ),
            Expanded(
              child: Button(
                radius: 0.0,
                buttonText: '确定',
                buttonTextColor: Theme.of(context).primaryColor,
                onClick: () {
                  if (type == 'default' || type == 'secure-text') {
                    var cb = callbackOrActions is Function(String)
                        ? callbackOrActions(textEditingController.text)
                        : callbackOrActions(textEditingController.text, null);

                    if (cb is Future) {
                      cb.then((data) {
                        widget.maskView.dismiss();
                      });
                    } else {
                      widget.maskView.dismiss();
                    }
                  } else {
                    var cb = callbackOrActions is Function(String)
                        ? callbackOrActions(textEditingController.text)
                        : callbackOrActions(textEditingController.text,
                            passwordEditingController.text);
                    if (cb is Future) {
                      cb.then((data) {
                        widget.maskView.dismiss();
                      });
                    } else {
                      widget.maskView.dismiss();
                    }
                  }
                },
              ),
            ),
          ],
        ),
      );
    } else {
      if (callbackOrActions.length == 0) return Row();
      List<Expanded> _buttonGroup = [];
      List<Button> __buttonGroup = [];
      callbackOrActions
          .asMap()
          .forEach((int index, Map<String, dynamic> button) {
        _buttonGroup.add(Expanded(
            child: Button(
          radius: 0.0,
          buttonText: button['text'],
          buttonTextColor: (callbackOrActions.length == 2 && index == 0)
              ? Colors.black
              : Theme.of(context).primaryColor,
          onClick: button['onPress'] == null
              ? () {
                  widget.maskView.dismiss();
                }
              : () {
                  if (type == 'default') {
                    var cb = button['onPress'] is Function(String)
                        ? button['onPress'](textEditingController.text)
                        : button['onPress'](textEditingController.text, null);
                    if (cb is Future) {
                      cb.then((data) {
                        widget.maskView.dismiss();
                      });
                    } else {
                      widget.maskView.dismiss();
                    }
                  } else {
                    var cb = button['onPress'] is Function(String)
                        ? button['onPress'](textEditingController.text)
                        : button['onPress'](textEditingController.text,
                            passwordEditingController.text);
                    if (cb is Future) {
                      cb.then((data) {
                        widget.maskView.dismiss();
                      });
                    } else {
                      widget.maskView.dismiss();
                    }
                  }
                },
        )));
        __buttonGroup.add(Button(
          radius: 0.0,
          buttonText: button['text'],
          buttonTextColor: Theme.of(context).primaryColor,
          onClick: button['onPress'] == null
              ? () {
                  widget.maskView.dismiss();
                }
              : () {
                  if (type == 'default') {
                    var cb = button['onPress'] is Function(String)
                        ? button['onPress'](textEditingController.text)
                        : button['onPress'](textEditingController.text, null);
                    if (cb is Future) {
                      cb.then((data) {
                        widget.maskView.dismiss();
                      });
                    } else {
                      widget.maskView.dismiss();
                    }
                  } else {
                    var cb = button['onPress'] is Function(String)
                        ? button['onPress'](textEditingController.text)
                        : button['onPress'](textEditingController.text,
                            passwordEditingController.text);
                    if (cb is Future) {
                      cb.then((data) {
                        widget.maskView.dismiss();
                      });
                    } else {
                      widget.maskView.dismiss();
                    }
                  }
                },
        ));
      });
      return callbackOrActions.length > 2
          ? Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: __buttonGroup,
              ),
            )
          : callbackOrActions.length == 1
              ? Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: _buttonGroup,
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
  }

  @override
  void initState() {
    super.initState();
    defaultTextValue = widget.defaultValue != null ? widget.defaultValue : '';
    _textEditingController =
        TextEditingController(text: widget.type == 'default' ? '100' : '');
    if (widget.type == 'login-password')
      _passwordEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    double _cursorWidth = 3.0;
    EdgeInsets _contentPadding =
        EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0);
    OutlineInputBorder _focusedBorder = OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xffdddddd), width: 0.5),
        borderRadius: BorderRadius.circular(3.0));
    OutlineInputBorder _enabledBorder = OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xffdddddd), width: 0.0),
        borderRadius: BorderRadius.circular(3.0));

    TextStyle _hintStyle = TextStyle(fontSize: 14.0, color: Color(0xffCDCDCD));
    Color _cursorColor = Theme.of(context).primaryColor;
    switch (widget.type) {
      case 'default':
        {
          return Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
                child: Theme(
                  data: ThemeData(primaryColor: Color(0xffdddddd)),
                  child: TextField(
                    cursorColor: _cursorColor,
                    autofocus: true,
                    cursorWidth: _cursorWidth,
                    controller: _textEditingController,
                    obscureText: false,
                    decoration: InputDecoration(
                        contentPadding: _contentPadding,
                        focusedBorder: _focusedBorder,
                        enabledBorder: _enabledBorder,
                        border: const OutlineInputBorder(),
                        hintStyle: _hintStyle,
                        hintText: (widget.placeholders != null &&
                                widget.placeholders.length > 0)
                            ? widget.placeholders[0]
                            : ''),
                  ),
                ),
              ),
              buildPromptModalFooter(context, widget.type,
                  widget.callbackOrActions, _textEditingController)
            ],
          );
        }
        break;
      case 'secure-text':
        {
          return Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
                child: Theme(
                  data: ThemeData(primaryColor: Color(0xffdddddd)),
                  child: TextField(
                    cursorColor: _cursorColor,
                    autofocus: true,
                    cursorWidth: _cursorWidth,
                    controller: _textEditingController,
                    obscureText: true,
                    decoration: InputDecoration(
                        contentPadding: _contentPadding,
                        focusedBorder: _focusedBorder,
                        enabledBorder: _enabledBorder,
                        border: const OutlineInputBorder(),
                        hintStyle: _hintStyle,
                        hintText: (widget.placeholders != null &&
                                widget.placeholders.length > 0)
                            ? widget.placeholders[0]
                            : ''),
                  ),
                ),
              ),
              buildPromptModalFooter(context, widget.type,
                  widget.callbackOrActions, _textEditingController)
            ],
          );
        }
        break;
      case 'login-password':
        {
          return Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
                child: Theme(
                  data: ThemeData(primaryColor: Color(0xffdddddd)),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        cursorColor: _cursorColor,
                        autofocus: true,
                        cursorWidth: _cursorWidth,
                        controller: _textEditingController,
                        decoration: InputDecoration(
                            contentPadding: _contentPadding,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffdddddd), width: 0.0),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(3.0),
                                    topRight: Radius.circular(3.0),
                                    bottomLeft: Radius.zero,
                                    bottomRight: Radius.zero)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffdddddd), width: 0.0),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(3.0),
                                    topRight: Radius.circular(3.0),
                                    bottomLeft: Radius.zero,
                                    bottomRight: Radius.zero)),
                            border: const OutlineInputBorder(),
                            hintStyle: _hintStyle,
                            hintText: (widget.placeholders != null &&
                                    widget.placeholders.length > 0)
                                ? widget.placeholders[0]
                                : ''),
                      ),
                      TextField(
                        cursorColor: _cursorColor,
                        cursorWidth: _cursorWidth,
                        controller: _passwordEditingController,
                        obscureText: true,
                        decoration: InputDecoration(
                            contentPadding: _contentPadding,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffdddddd), width: 0.0),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(3.0),
                                    bottomRight: Radius.circular(3.0),
                                    topLeft: Radius.zero,
                                    topRight: Radius.zero)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffdddddd), width: 0.0),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(3.0),
                                    bottomRight: Radius.circular(3.0),
                                    topLeft: Radius.zero,
                                    topRight: Radius.zero)),
                            border: const OutlineInputBorder(),
                            hintStyle: _hintStyle,
                            hintText: (widget.placeholders != null &&
                                    widget.placeholders.length > 1)
                                ? widget.placeholders[1]
                                : ''),
                      )
                    ],
                  ),
                ),
              ),
              buildPromptModalFooter(context, widget.type,
                  widget.callbackOrActions, _textEditingController,
                  passwordEditingController: _passwordEditingController)
            ],
          );
        }
        break;
    }
  }
}
