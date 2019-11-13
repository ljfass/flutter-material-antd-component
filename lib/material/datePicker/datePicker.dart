import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

DateTime DEFAULT_MIN_DATETIME = DateTime(1990, 3, 1, 0, 0, 0);

DateTime DEFAULT_MAX_DATETIME = DateTime(2100, 11, 30, 23, 59, 59);

List<int> _solarMonthsOf31Days = const <int>[1, 3, 5, 7, 8, 10, 12];

class DatePicker {
  static showDatePicker(BuildContext context,
      {Key key,
      String mode,
      DateTime value,
      DateTime minDate,
      DateTime maxDate,
      bool use12Hours}) {
    return showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return DatePickerComponent(
            key: key,
            value: value,
            minDate: minDate,
            maxDate: maxDate,
          );
        });
  }
}

class DatePickerComponent extends StatefulWidget {
  DatePickerComponent(
      {Key key,
      this.mode = 'date',
      this.value,
      this.maxDate,
      this.minDate,
      this.use12Hours})
      : super(key: key);
  final String mode;
  final DateTime value;
  final DateTime minDate;
  final DateTime maxDate;
  final bool use12Hours;

  @override
  _DatePickerComponentState createState() => _DatePickerComponentState();
}

class _DatePickerComponentState extends State<DatePickerComponent> {
  List<int> _yearRange, _monthRange, _dayRange;
  DateTime _initDateTime;
  DateTime _minDateTime;
  DateTime _maxDateTime;
  int _initDateTimeStamp;
  int _minDateTimeStamp;
  int _maxDateTimeStamp;

  int _currentYear;
  int _currentMonth;
  int _currentDay;

  FixedExtentScrollController _yearScrollCtrl, _monthScrollCtrl, _dayScrollCtrl;
  Map<String, List<int>> _valueRangeMap;

  @override
  void initState() {
    super.initState();
    _initDateTime = widget.value ?? DateTime.now();
    _minDateTime = widget.minDate ?? DEFAULT_MIN_DATETIME;
    _maxDateTime = widget.maxDate ?? DEFAULT_MAX_DATETIME;

    this._yearRange = [_minDateTime.year, _maxDateTime.year];
    // this._monthRange = [_minDateTime.month, 12];
    // this._dayRange = [_minDateTime.day, 31];

    /// 时间戳
    _initDateTimeStamp = _initDateTime.millisecondsSinceEpoch;
    _minDateTimeStamp = _minDateTime.millisecondsSinceEpoch;
    _maxDateTimeStamp = _maxDateTime.millisecondsSinceEpoch;

    if (_initDateTimeStamp == _minDateTimeStamp) {
      _yearScrollCtrl = FixedExtentScrollController(initialItem: _yearRange[1]);
      _monthScrollCtrl = FixedExtentScrollController(
          initialItem: _findScrollCtrl(1, 12, _initDateTime.month));
    } else if (_initDateTimeStamp == _maxDateTimeStamp) {
      _yearScrollCtrl = FixedExtentScrollController(
          initialItem: _maxDateTime.year - _minDateTime.year);
      _monthScrollCtrl =
          FixedExtentScrollController(initialItem: 12 - _minDateTime.month);
    } else if (_initDateTimeStamp > _minDateTimeStamp &&
        _initDateTimeStamp < _maxDateTimeStamp) {
      this._monthRange = [1, 12];
      this._dayRange = [1, _getDays(_initDateTime.year, _initDateTime.month)];

      _yearScrollCtrl = FixedExtentScrollController(
          initialItem: _findScrollCtrl(
              _minDateTime.year, _maxDateTime.year, _initDateTime.year));
      _monthScrollCtrl = FixedExtentScrollController(
          initialItem: _findScrollCtrl(
              _monthRange.first, _monthRange.last, _initDateTime.month));
      _dayScrollCtrl = FixedExtentScrollController(
          initialItem: _findScrollCtrl(
              _dayRange.first, _dayRange.last, _initDateTime.day));

      // this._dayRange = [1, 31];
    }
    _currentYear = _initDateTime.year;
    _currentMonth = _initDateTime.month;
    _currentDay = _initDateTime.day;
    _valueRangeMap = {'y': _yearRange, 'm': _monthRange, 'd': _dayRange};
  }

  /// 计算该年份是否是闰年
  bool isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || year % 400 == 0;
  }

  int _getDays(int year, int month) {
    int res;
    if (isLeapYear(year)) {
      if (month == 2) {
        res = 29;
      } else {
        if (_solarMonthsOf31Days.contains(month)) {
          res = 31;
        } else {
          res = 30;
        }
      }
    } else {
      if (month == 2) {
        res = 28;
      } else {
        if (_solarMonthsOf31Days.contains(month)) {
          res = 31;
        } else {
          res = 30;
        }
      }
    }
    return res;
  }

  int _findScrollCtrl(int start, int end, int current) {
    int res;
    for (int i = 0, l = end - start + 1; i < l; i++) {
      var value = start + i;
      if (current == value) {
        res = i;
        break;
      }
    }
    return res;
  }

  double ITEM_WIDGET_HEIGHT = 36.0;

  List<int> _findPickerItemRange(String _key) {
    List<int> valueRange;
    _valueRangeMap.forEach((key, value) {
      if (_key == key) {
        valueRange = value;
      }
    });
    return valueRange;
  }

  _handleMonthChange(int index) {
    print(_currentMonth);
    // var _selectedMonth = _valueRangeMap['m'].first + index;
    // _currentMonth = _selectedMonth;
    // setState(() {
    //   _valueRangeMap['d'] = [_currentYear, _selectedMonth];
    // });

    // _currentMonth = _getCurrentValue(
    //     _valueRangeMap['y'].first, _valueRangeMap['y'].last, index);
  }

  _handleYearChange(int index) {
    // 起始年份
    if (this._yearRange.first + index == this._yearRange[0]) {
      setState(() {
        _valueRangeMap['m'] = [_minDateTime.month, 12];

        _valueRangeMap['d'] = [
          _minDateTime.day,
          _getDays(
              this._yearRange[0],
              _currentMonth < _minDateTime.month
                  ? _minDateTime.month
                  : _currentMonth)
        ];
        _monthScrollCtrl
            .jumpToItem(_findScrollCtrl(_minDateTime.month, 12, _currentMonth));
        _dayScrollCtrl.jumpToItem(_findScrollCtrl(_minDateTime.day,
            _getDays(this._yearRange[0], _currentMonth), _currentDay));
      });
      return;
    }
    // 结束年份
    if (this._yearRange.first + index == this._yearRange[1]) {
      setState(() {
        _valueRangeMap['m'] = [1, _maxDateTime.month];
        _valueRangeMap['d'] = [
          1,
          _getDays(
              this._yearRange[1],
              _currentMonth > _maxDateTime.month
                  ? _maxDateTime.month
                  : _currentMonth)
        ];
      });
      return;
    }
    // 其他年份
    setState(() {
      _valueRangeMap['m'] = [1, 12];
      _valueRangeMap['d'] = [1, _getDays(this._yearRange.first, _currentMonth)];
    });
    _currentYear = _getCurrentValue(
        _valueRangeMap['y'].first, _valueRangeMap['y'].last, index);
  }

  int _getCurrentValue(int start, int end, int index) {
    int res;
    for (int i = 0, l = end - start + 1; i < l; i++) {
      var value = start + i;
      if (index == i) {
        res = value;
        break;
      }
    }
    return res;
  }

  Widget _buildDatePickerColumn({
    @required FixedExtentScrollController scrollCtrl,
    @required List<int> valueRange,
    @required ValueChanged<int> valueChanged,
  }) {
    return Flexible(
      flex: 1,
      child: CupertinoPicker.builder(
        scrollController: scrollCtrl,
        backgroundColor: Colors.white,
        itemExtent: 25.0,
        onSelectedItemChanged: valueChanged,
        childCount: valueRange.last - valueRange.first + 1,
        itemBuilder: (BuildContext context, int index) {
          return _buildPickerItemWidget('${valueRange.first + index}');
        },
      ),
    );
  }

  Widget _buildDatePickerWidget() {
    return Row(
      children: <Widget>[
        _buildDatePickerColumn(
            scrollCtrl: _yearScrollCtrl,
            valueRange: _valueRangeMap['y'],
            valueChanged: _handleYearChange),
        _buildDatePickerColumn(
            scrollCtrl: _monthScrollCtrl,
            valueRange: _valueRangeMap['m'],
            valueChanged: _handleMonthChange),
        _buildDatePickerColumn(
            scrollCtrl: _dayScrollCtrl,
            valueRange: _valueRangeMap['d'],
            valueChanged: null),
      ],
    );
  }

  Widget _buildPickerItemWidget(String value) {
    return Container(
      height: ITEM_WIDGET_HEIGHT,
      child: Text(value),
    );
  }

  Widget _buildPickerView() {
    switch (widget.mode) {
      case 'date':
        {
          return _buildDatePickerWidget();
        }
        break;
      default:
        {
          return _buildDatePickerWidget();
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    var _containerHeight = MediaQuery.of(context).size.height * 0.35;
    return Container(
      height: _containerHeight,
      decoration: BoxDecoration(color: Colors.white),
      child: _buildPickerView(),
    );
  }
}
