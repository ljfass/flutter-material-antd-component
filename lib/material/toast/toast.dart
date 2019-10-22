import 'package:flutter/material.dart';
import '../activityIndicator/activityIndicator.dart';

class Toast<T> {
  static ToastView preToast;

  static showToast(BuildContext context,
      {@required dynamic content,
      @required String type,
      num duration = 3,
      VoidCallback onClose,
      bool mask = true}) {
    assert(type == 'info' ||
        type == 'success' ||
        type == 'fail' ||
        type == 'info' ||
        type == 'loading' ||
        type == 'offline');
    assert(content is Widget || content is String);

    var overlayState = Overlay.of(context);
    OverlayEntry _entry;
    _entry = OverlayEntry(builder: (context) {
      return mask == false
          ? Center(
              child: LayoutBuilder(builder: (context, constraints) {
                return IgnorePointer(
                  ignoring: true,
                  child: Center(
                      child: Material(
                    color: Colors.white.withOpacity(0),
                    child: Container(
                      child: Theme(
                        data: Theme.of(context).copyWith(
                            iconTheme: Theme.of(context)
                                .iconTheme
                                .copyWith(size: 40.0)),
                        child: buildWidget(type, content, context),
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xff3a3a3a).withOpacity(0.9),
                        borderRadius: BorderRadius.all(
                          Radius.circular(3),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: (type == 'success' ||
                                  type == 'fail' ||
                                  type == 'offline')
                              ? 15.0
                              : 9.0,
                          horizontal: 15),
                    ),
                  )),
                );
              }),
            )
          : AbsorbPointer(
              child: SafeArea(
                child: Material(
                  color: Color(0xffffffff).withOpacity(0.1),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: LayoutBuilder(builder: (context, constraints) {
                      return IgnorePointer(
                        ignoring: true,
                        child: Center(
                            child: Container(
                          child: Theme(
                            data: Theme.of(context).copyWith(
                                iconTheme: Theme.of(context)
                                    .iconTheme
                                    .copyWith(size: 40.0)),
                            child: buildWidget(type, content, context),
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xff3a3a3a).withOpacity(0.9),
                            borderRadius: BorderRadius.all(
                              Radius.circular(3),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: (type == 'success' ||
                                      type == 'fail' ||
                                      type == 'offline')
                                  ? 15.0
                                  : 9.0,
                              horizontal: 15.0),
                        )),
                      );
                    }),
                  ),
                ),
              ),
            );
    });
    preToast?.dismiss();
    preToast = null;

    var toastView = ToastView();
    preToast = toastView;
    toastView.overlayState = overlayState;
    toastView.overlayEntry = _entry;
    toastView.duration = duration;
    toastView.onClose = onClose;
    toastView._show();
  }

  static hide() {
    preToast?.dismiss();
  }

  static Text buildToastText(String content) {
    return Text(
      '$content',
      style: TextStyle(color: Colors.white, height: 1.5),
    );
  }

  static Widget buildWidget(
      String type, dynamic content, BuildContext context) {
    switch (type) {
      case 'info':
        {
          return content is Widget ? content : buildToastText(content);
        }
        break;
      case 'success':
        {
          return content is Widget
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                    ),
                    SizedBox(height: 5.0),
                    content,
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                    ),
                    SizedBox(height: 5.0),
                    buildToastText(content)
                  ],
                );
        }
        break;
      case 'fail':
        {
          return content is Widget
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.cancel,
                      color: Colors.white,
                    ),
                    SizedBox(height: 5.0),
                    content
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.cancel,
                      color: Colors.white,
                    ),
                    SizedBox(height: 5.0),
                    buildToastText(content)
                  ],
                );
        }
        break;
      case 'offline':
        {
          return content is Widget
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.sentiment_dissatisfied,
                      color: Colors.white,
                    ),
                    SizedBox(height: 5.0),
                    content
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.sentiment_dissatisfied,
                      color: Colors.white,
                    ),
                    SizedBox(height: 5.0),
                    buildToastText(content)
                  ],
                );
        }
        break;
      case 'loading':
        {
          return content is Widget
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    SizedBox(
                      child: ActivityIndicator(
                        size: 'large',
                      ),
                    ),
                    SizedBox(height: 8.0),
                    content,
                    SizedBox(height: 5.0),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    SizedBox(
                      child: ActivityIndicator(
                        size: 'large',
                      ),
                    ),
                    SizedBox(height: 8.0),
                    buildToastText(content),
                    SizedBox(height: 5.0),
                  ],
                );
        }
        break;
      default:
        {
          {
            return content is Widget ? content : buildToastText(content);
          }
        }
    }
  }
}

class ToastView {
  OverlayEntry overlayEntry;
  OverlayState overlayState;
  num duration;
  bool dismissed = false;
  VoidCallback onClose;

  _show() async {
    overlayState.insert(overlayEntry);
    await Future.delayed(Duration(seconds: duration));
    await this.dismiss();
    if (this.onClose != null) this.onClose();
  }

  dismiss() async {
    if (dismissed) {
      return;
    }
    this.dismissed = true;
    overlayEntry?.remove();
  }
}
