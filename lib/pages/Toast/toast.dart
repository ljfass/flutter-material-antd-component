import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../material/toast/toast.dart';
import '../../material/button/button.dart';

class PageToast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Toast'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            children: <Widget>[
              Button(
                buttonText: 'text only',
                onClick: () {
                  Toast.showToast(context,
                      content: 'This is a toast tips!!',
                      type: 'info',
                      duration: 10000,
                      mask: false, onClose: () {
                    // Toast.hide();
                  });
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              Button(
                buttonText: 'without mask',
                onClick: () {
                  Toast.showToast(context,
                      content: 'Toast without mask!!',
                      type: 'info',
                      mask: false, onClose: () {
                    print('done toast');
                  });
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              Button(
                buttonText: 'custom icon',
                onClick: () {
                  Toast.showToast(context,
                      content: Icon(
                        Icons.refresh,
                        color: Colors.white,
                      ),
                      mask: false,
                      type: 'info');
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              Button(
                buttonText: 'success',
                onClick: () {
                  Toast.showToast(context,
                      content: 'Load success!!', mask: false, type: 'success');
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              Button(
                buttonText: 'fail',
                onClick: () {
                  Toast.showToast(context,
                      content: 'Load failed!!', mask: false, type: 'fail');
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              Button(
                buttonText: 'network failure',
                onClick: () {
                  Toast.showToast(context,
                      content: 'Network conntection failed!!',
                      mask: false,
                      type: 'offline');
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              Button(
                buttonText: 'loading',
                onClick: () {
                  Toast.showToast(context,
                      content: 'Loading...', mask: false, type: 'loading');
                },
              )
            ],
          ),
        ));
  }
}
