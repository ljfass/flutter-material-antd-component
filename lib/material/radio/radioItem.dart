import 'package:flutter/material.dart';

class RadioItem extends StatefulWidget {
  RadioItem({
    Key key,
    @required this.data,
  })  : assert((data is List || data != null)),
        super(key: key);
  final List<Map<String, dynamic>> data;

  @override
  _RadioItemState createState() => _RadioItemState();
}

class _RadioItemState extends State<RadioItem> {
  List<Map<String, dynamic>> _data = [];

  @override
  void initState() {
    super.initState();
  }

  List<Widget> buildContent() {
    List<Widget> _widgetList = [];
    this._data.asMap().forEach((int index, Map<String, dynamic> radio) {
      _widgetList.add(InkWell(
        splashColor: Colors.transparent,
        onTap: radio['disabled'] == true
            ? null
            : () {
                radio['onChange']();
              },
        child: radio['subTitle'] != null
            ? Container(
                padding: EdgeInsets.only(left: 15.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color(0XFFDDDDDD), width: 0.5))),
                  padding: EdgeInsets.symmetric(vertical: 7.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(radio['title'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: radio['disabled'] == true
                                          ? Color(0XFFBBBBBB)
                                          : Colors.black)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 15.0),
                            child: CheckItem(
                              disabled: radio['disabled'],
                              checked: radio['checked'],
                            ),
                          )
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top: 6.0),
                        child: Text(radio['subTitle'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                height: 1.5,
                                color: Color(0xff888888),
                                fontSize: 15.0)),
                      )
                    ],
                  ),
                ))
            : Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 44.0,
                        decoration: BoxDecoration(
                            border: index == this._data.length - 1
                                ? null
                                : Border(
                                    bottom: BorderSide(
                                        color: Color(0XFFDDDDDD), width: 0.5))),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                radio['title'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: radio['disabled'] == true
                                        ? Color(0XFFBBBBBB)
                                        : Colors.black),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 15.0),
                              child: CheckItem(
                                disabled: radio['disabled'],
                                checked: radio['checked'],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )),
      ));
    });
    return _widgetList;
  }

  @override
  Widget build(BuildContext context) {
    _data.clear();
    widget.data.asMap().forEach((int index, Map<String, dynamic> value) {
      if (value['checked'] == null && value['defaultChecked'] == null) {
        _data.add({
          'defaultChecked': null,
          'checked': false,
          'title': value['title'],
          'subTitle': value['subTitle'] != null ? value['subTitle'] : null,
          'disabled': value['disabled'] != null ? value['disabled'] : false,
          'onChange': value['onChange'] != null ? value['onChange'] : null
        });
      } else if (value['defaultChecked'] != null) {
        _data.add({
          'defaultChecked': value['defaultChecked'],
          'checked': value['checked'] != null ? value['checked'] : false,
          'title': value['title'],
          'subTitle': value['subTitle'] != null ? value['subTitle'] : null,
          'disabled': value['disabled'] != null ? value['disabled'] : false,
          'onChange': value['onChange'] != null ? value['onChange'] : null
        });
      } else {
        _data.add({
          'defaultChecked':
              value['defaultChecked'] != null ? value['defaultChecked'] : null,
          'checked': value['checked'],
          'title': value['title'],
          'subTitle': value['subTitle'] != null ? value['subTitle'] : null,
          'disabled': value['disabled'] != null ? value['disabled'] : false,
          'onChange': value['onChange'] != null ? value['onChange'] : null
        });
      }
    });
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(color: Color(0XFFDDDDDD), width: 0.5),
              bottom: BorderSide(color: Color(0XFFDDDDDD), width: 0.5))),
      child: SingleChildScrollView(
        child: Column(
          children: buildContent(),
        ),
      ),
    );
  }
}

class CheckItem extends StatelessWidget {
  CheckItem(
      {Key key,
      this.checked = false,
      this.defaultChecked,
      this.disabled = false})
      : super(key: key);
  final bool checked;
  final bool defaultChecked;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    print(checked);
    BoxDecoration boxDecoration = this.disabled == true
        ? this.checked == true
            ? BoxDecoration(
                border: Border(
                    top: BorderSide(width: 0.0, color: Colors.transparent),
                    right: BorderSide(width: 1.5, color: Color(0XFFBBBBBB)),
                    bottom: BorderSide(width: 1.5, color: Color(0XFFBBBBBB)),
                    left: BorderSide(width: 0.0, color: Colors.transparent)))
            : BoxDecoration(
                border: Border(
                    top: BorderSide(width: 0.0, color: Colors.transparent),
                    right: BorderSide(width: 1.5, color: Colors.transparent),
                    bottom: BorderSide(width: 1.5, color: Colors.transparent),
                    left: BorderSide(width: 0.0, color: Colors.transparent)))
        : this.checked
            ? BoxDecoration(
                border: Border(
                    top: BorderSide(width: 0.0, color: Colors.transparent),
                    right: BorderSide(
                        width: 1.5, color: Theme.of(context).primaryColor),
                    bottom: BorderSide(
                        width: 1.5, color: Theme.of(context).primaryColor),
                    left: BorderSide(width: 0.0, color: Colors.transparent)))
            : BoxDecoration(
                border: Border(
                    top: BorderSide(width: 0.0, color: Colors.transparent),
                    right: BorderSide(width: 1.5, color: Colors.transparent),
                    bottom: BorderSide(width: 1.5, color: Colors.transparent),
                    left: BorderSide(width: 0.0, color: Colors.transparent)));
    return Stack(
      children: <Widget>[
        Container(
          width: 15.0,
          height: 15.0,
        ),
        Positioned(
          top: 3.0,
          right: 7.0,
          child: RotationTransition(
            turns: AlwaysStoppedAnimation(45 / 360),
            child: Container(
              width: 5.0,
              height: 11.0,
              decoration: boxDecoration,
              child: Container(),
            ),
          ),
        )
      ],
    );
  }
}
