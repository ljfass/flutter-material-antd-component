import 'package:flutter/material.dart';

class List<T> extends StatelessWidget {
  List({
    Key key,
    @required this.itemContent,
    this.header,
    this.footer,
    this.thumb,
    this.extra,
    this.arrow,
    this.align = 'middle',
    this.onClick,
    this.error = false,
    this.multipleLine = false,
    this.wrap = false,
    this.brief,
    this.disabled = false,
  })  : assert(itemContent is String || itemContent is Widget),
        assert(header == null || header is String || header is Widget),
        assert(footer == null || footer is String || footer is Widget),
        assert(extra == null || extra is String || extra is Widget),
        assert(brief == null || brief is String || brief is Widget),
        assert(thumb == null || thumb is String || thumb is Widget),
        assert(arrow == null ||
            arrow == 'horizontal' ||
            arrow == 'up' ||
            arrow == 'down' ||
            arrow == 'empty'),
        assert(align == 'top' || align == 'middle' || align == 'bottom'),
        super(key: key);

  final T itemContent;
  final T header;
  final T footer;
  final T thumb;
  final T extra;
  final T brief;
  final String arrow;
  final String align;
  final VoidCallback onClick;
  final bool error;
  final bool multipleLine;
  final bool wrap;
  final bool disabled;

  Widget buildItemContent<T>(itemContent) {
    if (itemContent is String) {
      return wrap == true
          ? Text(
              itemContent,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: this.disabled == true
                      ? Color(0xffbbbbbb)
                      : Color(0xff000000),
                  fontSize: 14.0),
            )
          : Text(
              itemContent,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: this.disabled == true
                      ? Color(0xffbbbbbb)
                      : Color(0xff000000),
                  fontSize: 14.0),
            );
    } else {
      return wrap == true
          ? DefaultTextStyle(
              style: TextStyle(
                  color: this.disabled == true
                      ? Color(0xffbbbbbb)
                      : Color(0xff000000),
                  fontSize: 14.0),
              child: itemContent)
          : DefaultTextStyle(
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: this.disabled == true
                      ? Color(0xffbbbbbb)
                      : Color(0xff000000),
                  fontSize: 14.0),
              child: itemContent);
    }
  }

  Widget buildExtraContent<T>(extraContent) {
    if (extraContent is String) {
      return wrap == true
          ? Text(
              extraContent,
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: this.disabled == true
                      ? Color(0xffbbbbbb)
                      : this.error == true
                          ? Color(0xffff5500)
                          : Color(0xff888888),
                  fontSize: 14.0),
            )
          : Text(
              extraContent,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: this.disabled == true
                      ? Color(0xffbbbbbb)
                      : this.error == true
                          ? Color(0xffff5500)
                          : Color(0xff888888),
                  fontSize: 14.0),
            );
    } else if (extraContent is Widget) {
      return wrap == true
          ? DefaultTextStyle(
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: this.disabled == true
                      ? Color(0xffbbbbbb)
                      : this.error == true
                          ? Color(0xffff5500)
                          : Color(0xff888888),
                  fontSize: 14.0),
              child: extraContent,
            )
          : DefaultTextStyle(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: this.disabled == true
                      ? Color(0xffbbbbbb)
                      : this.error == true
                          ? Color(0xffff5500)
                          : Color(0xff888888),
                  fontSize: 14.0),
              child: extraContent,
            );
    } else {
      return Container();
    }
  }

  Widget buildArrow() {
    if (this.arrow == 'empty') {
      return Container(
        width: 15.0,
        height: 15.0,
      );
    } else if (this.arrow == 'horizontal') {
      return Container(
          width: 15.0,
          padding: EdgeInsets.only(top: 2.0),
          margin: EdgeInsets.only(left: 8.0),
          child: Icon(
            Icons.keyboard_arrow_right,
            color: Color(0xffd1d1d5),
          ));
    } else if (this.arrow == 'up') {
      return Container(
        width: 15.0,
        padding: EdgeInsets.only(top: 2.0),
        margin: EdgeInsets.only(left: 8.0),
        child: Icon(
          Icons.keyboard_arrow_up,
          color: Color(0xffd1d1d5),
        ),
      );
    } else if (this.arrow == 'down') {
      return Container(
        width: 15.0,
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 2.0),
        margin: EdgeInsets.only(left: 8.0),
        child: Icon(
          Icons.keyboard_arrow_down,
          color: Color(0xffd1d1d5),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget buildHeader<T>(header) {
    if (header is String) {
      return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 9.0),
        child: Text(
          header,
          style: TextStyle(color: Color(0xff888888), fontSize: 14.0),
        ),
      );
    } else {
      return DefaultTextStyle(
        style: TextStyle(color: Color(0xff888888), fontSize: 14.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 9.0),
            child: header,
          ),
        ),
      );
    }
  }

  Widget buildThumb<T>(thumb) {
    if (thumb is String) {
      return Container(
        width: 20.0,
        height: 20.0,
        margin: EdgeInsets.only(right: 15.0),
        child: Image.network(thumb),
      );
    } else {
      return thumb;
    }
  }

  Widget buildFooter<T>(footer) {
    if (footer is String) {
      return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 9.0),
        child: Text(
          footer,
          style: TextStyle(color: Color(0xff888888), fontSize: 14.0),
        ),
      );
    } else {
      return DefaultTextStyle(
        style: TextStyle(color: Color(0xff888888), fontSize: 14.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 9.0),
            child: footer,
          ),
        ),
      );
    }
  }

  Widget buildBrief<T>(brief) {
    if (brief is String) {
      return Container(
        margin: EdgeInsets.only(top: 6.0),
        child: Text(
          brief,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style:
              TextStyle(color: Color(0xff888888), fontSize: 15.0, height: 1.5),
        ),
      );
    } else {
      return DefaultTextStyle(
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Color(0xff888888), fontSize: 15.0, height: 1.5),
        child: Container(
          margin: EdgeInsets.only(top: 6.0),
          child: brief,
        ),
      );
    }
  }

  Widget buildContent() {
    return this.onClick == null
        ? ConstrainedBox(
            constraints: BoxConstraints(minHeight: 44.0),
            child: Container(
                padding: this.multipleLine == true
                    ? EdgeInsets.fromLTRB(15.0, 12.5, 15, 12.5)
                    : EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.0),
                decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    border: Border(
                        top: BorderSide(color: Color(0xffdddddd), width: 0.5),
                        bottom:
                            BorderSide(color: Color(0xffdddddd), width: 0.5))),
                child: this.thumb != null
                    ? Flex(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: this.align == 'top'
                            ? CrossAxisAlignment.start
                            : this.align == 'bottom'
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.center,
                        direction: Axis.horizontal,
                        children: <Widget>[
                          Flexible(
                            flex: this.extra != null ? 7 : 10,
                            child: Row(
                              children: <Widget>[
                                buildThumb(thumb),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    buildItemContent(this.itemContent),
                                    this.brief != null
                                        ? buildBrief(this.brief)
                                        : Container()
                                  ],
                                ))
                              ],
                            ),
                          ),
                          Flexible(
                            flex: this.extra != null ? 3 : 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                this.extra != null
                                    ? Expanded(
                                        child: buildExtraContent(this.extra),
                                      )
                                    : Container(),
                                buildArrow()
                              ],
                            ),
                          )
                        ],
                      )
                    : Flex(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: this.align == 'top'
                            ? CrossAxisAlignment.start
                            : this.align == 'bottom'
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.center,
                        direction: Axis.horizontal,
                        children: <Widget>[
                          Flexible(
                            flex: this.extra != null ? 7 : 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                buildItemContent(this.itemContent),
                                this.brief != null
                                    ? buildBrief(this.brief)
                                    : Container()
                              ],
                            ),
                          ),
                          Flexible(
                            flex: this.extra != null ? 3 : 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                this.extra != null
                                    ? Expanded(
                                        child: buildExtraContent(this.extra),
                                      )
                                    : Container(),
                                buildArrow()
                              ],
                            ),
                          )
                        ],
                      )),
          )
        : ConstrainedBox(
            constraints: BoxConstraints(minHeight: 44.0),
            child: Material(
              color: Color(0xffffffff),
              child: InkWell(
                onTap: this.disabled == true ? null : this.onClick,
                child: Container(
                  padding: this.multipleLine == true
                      ? EdgeInsets.fromLTRB(15.0, 12.5, 15, 12.5)
                      : EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.0),
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Color(0xffdddddd), width: 0.5),
                          bottom: BorderSide(
                              color: Color(0xffdddddd), width: 0.5))),
                  child: this.thumb != null
                      ? Flex(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: this.align == 'top'
                              ? CrossAxisAlignment.start
                              : this.align == 'bottom'
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.center,
                          direction: Axis.horizontal,
                          children: <Widget>[
                            Flexible(
                              flex: this.extra != null ? 7 : 10,
                              child: Row(
                                children: <Widget>[
                                  buildThumb(thumb),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      buildItemContent(this.itemContent),
                                      this.brief != null
                                          ? buildBrief(this.brief)
                                          : Container()
                                    ],
                                  ))
                                ],
                              ),
                            ),
                            Flexible(
                              flex: this.extra != null ? 3 : 0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  this.extra != null
                                      ? Expanded(
                                          child: buildExtraContent(this.extra),
                                        )
                                      : Container(),
                                  buildArrow()
                                ],
                              ),
                            )
                          ],
                        )
                      : Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: this.align == 'top'
                              ? CrossAxisAlignment.start
                              : this.align == 'bottom'
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              flex: 7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  buildItemContent(this.itemContent),
                                  this.brief != null
                                      ? buildBrief(this.brief)
                                      : Container()
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  this.extra != null
                                      ? Expanded(
                                          child: buildExtraContent(this.extra),
                                        )
                                      : Container(),
                                  buildArrow()
                                ],
                              ),
                            )
                          ],
                        ),
                ),
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    if (this.header != null && this.footer != null) {
      return Column(
        children: <Widget>[
          buildHeader(header),
          buildContent(),
          buildFooter(footer),
        ],
      );
    } else if (this.header != null && this.footer == null) {
      return Column(
        children: <Widget>[buildHeader(header), buildContent()],
      );
    } else if (this.header == null && this.footer != null) {
      return Column(
        children: <Widget>[
          buildContent(),
          buildFooter(footer),
        ],
      );
    } else {
      return buildContent();
    }
  }
}
