import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../button/button.dart';

class Result<T> extends StatelessWidget {
  Result(
      {Key key,
      this.imgUrl,
      this.img,
      this.title,
      this.message,
      this.buttonText,
      this.buttonType,
      this.onButtonClick})
      : assert(title == null || title is String || title is Widget),
        assert(message == null || message is String || message is Widget),
        super(key: key);
  final String imgUrl;
  final Widget img;
  final T title;
  final T message;
  final String buttonText;
  final String buttonType;
  final VoidCallback onButtonClick;

  Widget buildImg() {
    return Visibility(
      visible: img == null && imgUrl == null ? false : true,
      child: img == null && imgUrl == null
          ? Container()
          : img != null
              ? Container(
                  width: 60.0,
                  height: 60.0,
                  child: img,
                )
              : Container(
                  width: 60.0,
                  height: 60.0,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      imgUrl,
                    ),
                  ),
                ),
    );
  }

  buildTitle<T>(_title) {
    return Visibility(
      visible: _title == null ? false : true,
      child: _title == null
          ? Container()
          : Container(
              margin: EdgeInsets.only(top: 8.0),
              padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
              child: DefaultTextStyle(
                style: TextStyle(fontSize: 21.0, color: Color(0xff000000)),
                child: title is String
                    ? Text(
                        _title,
                      )
                    : title,
              ),
            ),
    );
  }

  Widget buildButton() {
    return Visibility(
      visible: buttonText == null ? false : true,
      child: buttonText == null
          ? Container()
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              margin: EdgeInsets.only(top: 15.0),
              child: Button(
                type: buttonType == null ? 'default' : buttonType,
                buttonText: buttonText,
                onClick: onButtonClick == null
                    ? null
                    : () {
                        onButtonClick();
                      },
              ),
            ),
    );
  }

  buildMessage<T>(_message) {
    if (_message == null) return Text('');
    return Visibility(
      visible: _message == null ? false : true,
      child: _message == null
          ? Container()
          : Container(
              margin: EdgeInsets.only(top: 2.0),
              padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
              child: DefaultTextStyle(
                style: TextStyle(
                    fontSize: 16.0, height: 1.5, color: Color(0xff888888)),
                child: _message is String
                    ? Text(
                        _message,
                      )
                    : title,
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 21.0),
      decoration: BoxDecoration(
          color: Color(0xffffffff),
          border:
              Border(bottom: BorderSide(color: Color(0xffdddddd), width: 0.5))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          buildImg(),
          buildTitle(this.title),
          buildMessage(message),
          buildButton()
        ],
      ),
    );
  }
}
