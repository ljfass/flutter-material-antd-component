import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../button/button.dart';

class Modal<T> {
  static ModalMaskView preMask;
  static Widget buildModalContent() {
    return Container(
      padding: EdgeInsets.only(top: 15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7.0),
      ),
    );
  }

  static show<T>(
    BuildContext context, {
    VoidCallback afterClose,
    bool visible,
    bool closable,
    maskClosable,
    VoidCallback onClose,
    bool transparent,
    bool popup,
    String animationType,
    T title,
    List<Button> footer,
  }) {
    assert(animationType == null ||
        animationType == 'slide-down' ||
        animationType == 'slide-up' ||
        animationType == 'fade' ||
        animationType == 'slide');

    var overlayState = Overlay.of(context);
    var toastView = ModalMaskView();
    OverlayEntry _entry;
    _entry = OverlayEntry(builder: (context) {
      return transparent == false
          ? GestureDetector(
              onTap: maskClosable == true
                  ? () {
                      toastView.dismiss();
                    }
                  : null,
              child: Material(
                color: Color(0xffffffff),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: LayoutBuilder(builder: (context, constraints) {
                    return GestureDetector(
                      onTap: () {
                        print('2');
                      },
                      child: Center(child: buildModalContent()),
                    );
                  }),
                ),
              ),
            )
          : GestureDetector(
              onTap: maskClosable == true
                  ? () {
                      toastView.dismiss();
                    }
                  : null,
              child: Material(
                color: Color(0xff000000).withOpacity(0.4),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: LayoutBuilder(builder: (context, constraints) {
                    return GestureDetector(
                      onTap: () {
                        print('2');
                      },
                      child: Center(child: buildModalContent()),
                    );
                  }),
                ),
              ),
            );
    });

    preMask?.dismiss();
    preMask = null;

    preMask = toastView;
    toastView.overlayState = overlayState;
    toastView.overlayEntry = _entry;
    toastView.duration = 3;
    toastView.onClose = onClose;
    toastView._show();
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
