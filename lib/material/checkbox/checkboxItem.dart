import 'package:flutter/material.dart';
import './checkbox.dart' as AntCheckbox;

class CheckboxItem extends StatefulWidget {
  CheckboxItem(
      {Key key,
      @required this.title,
      this.defaultChecked,
      this.checked = false,
      this.disabled = false,
      this.onChange,
      this.subTitle})
      : assert(title != null),
        assert(onChange != null),
        super(key: key);
  final String title;
  final String subTitle;
  final bool defaultChecked;
  final bool checked;
  final bool disabled;
  final ValueChanged<bool> onChange;

  @override
  _CheckboxItemState createState() => _CheckboxItemState();
}

class _CheckboxItemState extends State<CheckboxItem> {
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

  @override
  Widget build(BuildContext context) {
    var titleColor = widget.disabled == true ? Color(0xffBBBBBB) : Colors.black;
    return InkWell(
      splashColor: Colors.transparent,
      onTap: widget.disabled == true
          ? null
          : () {
              setState(() {
                _checked = !this._checked;
              });
            },
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 44.0),
        child: Container(
          padding: EdgeInsets.only(left: 15.0),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 15.0),
                child: AntCheckbox.Checkbox(
                  defaultChecked: _checked,
                  checked: _checked,
                  disabled: widget.disabled,
                  onChange: (value) {},
                ),
              ),
              Expanded(
                  child: widget.subTitle != null
                      ? Stack(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 12.5, 15.0, 12.5),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        height: 1.5,
                                        color: titleColor,
                                        fontSize: 16.0),
                                  ),
                                  SizedBox(
                                    height: 2.0,
                                  ),
                                  Text(
                                    widget.subTitle,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        height: 1.5,
                                        color: Color(0xff888888),
                                        fontSize: 15.0),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: Divider(
                                height: 1.0,
                                color: Color(0xffDDDDDD),
                              ),
                            )
                          ],
                        )
                      : Stack(
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.symmetric(vertical: 11.0),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 0.0),
                                  child: Text(
                                    widget.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        height: 1.5,
                                        color: titleColor,
                                        fontSize: 16.0),
                                  ),
                                )),
                            Positioned(
                              left: 0.0,
                              right: 0.0,
                              bottom: 0.0,
                              child: Divider(
                                height: 1.0,
                                color: Color(0xffDDDDDD),
                              ),
                            )
                          ],
                        )),
            ],
          ),
        ),
      ),
    );
  }
}
