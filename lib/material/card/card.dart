import 'package:flutter/material.dart';

class Card<T> extends StatelessWidget {
  Card(
      {Key key,
      this.full = false,
      this.headerTitle,
      this.headerThumb,
      this.headerExtra,
      this.body,
      this.footerContent,
      this.footerExtra,
      this.height})
      : assert((body == null) || (body != null && body is Widget)),
        super(key: key);
  final bool full;
  final double height;
  final T headerTitle;
  final T headerThumb;
  final T headerExtra;
  final Widget body;
  final T footerContent;
  final T footerExtra;

  Widget buildHeaderThumb<T>(thumb) {
    return thumb is Widget
        ? thumb
        : Container(
            width: 32.0,
            height: 32.0,
            margin: EdgeInsets.only(right: 10.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(0.0)),
                child: Image.network(
                  thumb,
                )),
          );
  }

  Widget buildHeaderTitle<T>(title) {
    return title is Widget
        ? title
        : Text(
            title,
            style: TextStyle(color: Color(0XFF000000)),
          );
  }

  Widget buildHeaderExtra<T>(extra) {
    return extra is Widget
        ? extra
        : Text(
            extra,
            style: TextStyle(color: Color(0XFF888888)),
          );
  }

  Widget buildFooterContent<T>(content) {
    return Text(
      content,
    );
  }

  Widget buildFooterExtra<T>(extra) {
    return Text(
      extra,
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 9.0, horizontal: 15.0),
      child: DefaultTextStyle(
          style: TextStyle(fontSize: 16.0),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Row(
                  children: <Widget>[
                    this.headerThumb == null
                        ? Text('')
                        : buildHeaderThumb(this.headerThumb),
                    this.headerTitle == null
                        ? Text('')
                        : buildHeaderTitle(this.headerTitle)
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      this.headerExtra == null
                          ? Text('')
                          : buildHeaderExtra(this.headerExtra)
                    ]),
              )
            ],
          )),
    );
  }

  Widget buildContent() {
    return this.body == null
        ? Container()
        : ConstrainedBox(
            constraints: BoxConstraints(minHeight: 60.0),
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 6.0),
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Color(0XFFDDDDDD), width: 0.5))),
              child: DefaultTextStyle(
                style: TextStyle(fontSize: 15.0, color: Color(0XFF333333)),
                child: this.body,
              ),
            ),
          );
  }

  Widget buildFooter() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: DefaultTextStyle(
          style: TextStyle(fontSize: 14.0, color: Color(0XFF888888)),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Row(
                  children: <Widget>[
                    this.footerContent == null
                        ? Text('')
                        : this.footerContent is Widget
                            ? this.footerContent
                            : buildFooterContent(this.footerContent),
                    this.footerExtra == null
                        ? Text('')
                        : this.footerExtra is Widget
                            ? this.footerExtra
                            : buildFooterExtra(this.footerExtra)
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      this.headerExtra == null
                          ? Text('')
                          : this.headerExtra is Widget
                              ? this.headerExtra
                              : buildHeaderExtra(this.headerExtra)
                    ]),
              )
            ],
          )),
    );
  }

  Flex buildWrapper() {
    return Column(
      children: <Widget>[buildHeader(), buildContent(), buildFooter()],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height == null ? 134.0 : this.height,
      padding: EdgeInsets.only(bottom: 6.0),
      decoration: this.full == true
          ? BoxDecoration(
              border: Border(
                  top: BorderSide(color: Color(0XFFDDDDDD), width: 0.5),
                  bottom: BorderSide(color: Color(0XFFDDDDDD), width: 0.5)))
          : BoxDecoration(
              border: Border.all(color: Color(0XFFDDDDDD), width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: buildWrapper(),
    );
  }
}
