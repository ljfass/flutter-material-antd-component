import 'package:flutter/material.dart';

class RadioItem extends StatefulWidget {
  RadioItem(
      {Key key,
      @required this.title,
      @required this.data,
      this.defaultChecked,
      this.checked = false,
      this.disabled = false,
      this.onChange,
      this.subTitle})
      : assert((data is List || data != null)),
        assert(title != null),
        assert(onChange != null),
        super(key: key);
  final List<Map<String, String>> data;
  final String title;
  final String subTitle;
  final bool defaultChecked;
  final bool checked;
  final bool disabled;
  final ValueChanged<bool> onChange;

  @override
  _RadioItemState createState() => _RadioItemState();
}

class _RadioItemState extends State<RadioItem> {
  bool _checked = false;

  @override
  void initState() {
    super.initState();
    if (widget.checked == null && widget.defaultChecked == null) {
      setState(() {
        _checked = false;
      });
    } else if (widget.defaultChecked != null) {
      setState(() {
        _checked = widget.defaultChecked;
      });
    } else {
      setState(() {
        _checked = widget.checked;
      });
    }
  }

  List<Widget> buildContent() {
    List<Widget> _widgetList = [];
    widget.data.asMap().forEach((int index, Map<String, String> radio) {
      _widgetList.add(InkWell(
        splashColor: Colors.transparent,
        onTap: widget.disabled == true
            ? null
            : () {
                setState(() {
                  _checked = !this._checked;
                });
              },
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 44.0),
          child: Container(
            padding: EdgeInsets.only(left: 15.0),
            child: Container(
              padding: EdgeInsets.only(right: 15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 11.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  widget.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: widget.disabled == true
                                          ? Color(0XFFBBBBBB)
                                          : Colors.black),
                                ),
                              ),
                              CheckItem(
                                disabled: widget.disabled,
                                checked: _checked,
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          left: 0.0,
                          right: 0.0,
                          bottom: 0.0,
                          child: Divider(
                            height: 1.0,
                            color: Color(0XFFDDDDDD),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ));
    });
    return _widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: buildContent(),
      ),
    );
  }
}

class CheckItem extends StatelessWidget {
  CheckItem({Key key, this.checked = false, this.disabled = false})
      : super(key: key);
  final bool checked;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    BoxDecoration boxDecoration = this.disabled == true
        ? BoxDecoration(
            border: Border(
                top: BorderSide(width: 0.0, color: Colors.transparent),
                right: BorderSide(width: 1.5, color: Color(0XFFBBBBBB)),
                bottom: BorderSide(width: 1.5, color: Color(0XFFBBBBBB)),
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
