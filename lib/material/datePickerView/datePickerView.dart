import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

DateTime DEFAULT_MIN_DATETIME = DateTime(1990, 3, 1, 0, 0, 0);

DateTime DEFAULT_MAX_DATETIME = DateTime(2100, 11, 30, 23, 59, 59);

List<int> _solarMonthsOf31Days = const <int>[1, 3, 5, 7, 8, 10, 12];

class DatePickerView extends StatefulWidget {
  DatePickerView(
      {Key key,
      this.mode = 'date',
      this.value,
      this.maxDate,
      this.minDate,
      this.use12Hours = false,
      this.minuteStep = 1,
      this.onChange,
      this.onValueChange})
      : assert(mode == 'date' ||
            mode == 'time' ||
            mode == 'datetime' ||
            mode == 'year' ||
            mode == 'month'),
        assert(() {
          bool res = true;
          if (minDate != null && maxDate != null) {
            if (minDate.millisecondsSinceEpoch > maxDate.millisecondsSinceEpoch)
              res = false;
          }
          return res;
        }()),
        super(key: key);

  final String mode;
  final DateTime value;
  final DateTime minDate;
  final DateTime maxDate;
  final bool use12Hours;
  final int minuteStep;
  final ValueChanged<Map<String, String>> onValueChange;
  final ValueChanged<DateTime> onChange;

  @override
  _DatePickerViewState createState() => _DatePickerViewState();
}

class _DatePickerViewState extends State<DatePickerView> {
  double _itemExtent = 28.0;
  double _squeeze = 1.0;
  double _diameterRatio = 2.0;
  Color _activeTextColor = Colors.black;
  Color _inActiveTextColor = Colors.grey;

  List<int> _yearRange, _monthRange, _dayRange, _hourRange, _minuteRange;

  DateTime _initDateTime;
  DateTime _minDateTime;
  DateTime _maxDateTime;
  int _initDateTimeStamp;
  int _minDateTimeStamp;
  int _maxDateTimeStamp;

  int _currentYear;
  int _currentMonth;
  int _currentDay;
  int _currentHour;
  int _currentMinute;
  int _currentSecond;

  bool _isYearRangeChanged = false;
  bool _isMonthRangeChanged = false;
  bool _isDayRangeChanged = false;
  bool _isHourRangeChanged = false;

  FixedExtentScrollController _yearScrollCtrl,
      _monthScrollCtrl,
      _dayScrollCtrl,
      _hourScrollCtrl,
      _minuteScrollCtrl;
  Map<String, List<int>> _valueRangeMap;

  double itemWidgetHeight = 36.0;

  @override
  void initState() {
    super.initState();
    if (widget.mode == 'time')
      _initModeIsTimeWidget();
    else
      _initModeIsElseWidget();
  }

  @override
  void dispose() {
    if (_yearScrollCtrl != null) _yearScrollCtrl.dispose();
    if (_monthScrollCtrl != null) _monthScrollCtrl.dispose();
    if (_dayScrollCtrl != null) _dayScrollCtrl.dispose();
    if (_hourScrollCtrl != null) _hourScrollCtrl.dispose();
    if (_minuteScrollCtrl != null) _minuteScrollCtrl.dispose();
    super.dispose();
  }

  void _initModeIsTimeWidget() {
    _initDateTime = widget.value != null
        ? DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, widget.value.hour, widget.value.minute)
        : DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, DateTime.now().hour, DateTime.now().minute);
    _minDateTime = widget.minDate != null
        ? DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, widget.minDate.hour, widget.minDate.minute)
        : DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            DEFAULT_MIN_DATETIME.hour,
            DEFAULT_MIN_DATETIME.minute);
    _maxDateTime = widget.maxDate != null
        ? DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, widget.maxDate.hour, widget.maxDate.minute)
        : DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            DEFAULT_MAX_DATETIME.hour,
            DEFAULT_MAX_DATETIME.minute);
    _initDateTimeStamp = _initDateTime.millisecondsSinceEpoch;
    _minDateTimeStamp = _minDateTime.millisecondsSinceEpoch;
    _maxDateTimeStamp = _maxDateTime.millisecondsSinceEpoch;
    if (_initDateTimeStamp > _minDateTimeStamp &&
        _initDateTimeStamp < _maxDateTimeStamp) {
      this._hourRange = [_minDateTime.hour, _maxDateTime.hour];
      this._minuteRange = [0, 59];
      _hourScrollCtrl = FixedExtentScrollController(
          initialItem: _findScrollCtrl(
              _hourRange.first, _hourRange.last, _initDateTime.hour));
      _minuteScrollCtrl = FixedExtentScrollController(
          initialItem: _findMinuteScrollCtrl(
              _minuteRange.first, _minuteRange.last, _initDateTime.minute));
      _currentHour = _initDateTime.hour;
      _currentMinute = _initDateTime.minute;
    } else if (_initDateTimeStamp <= _minDateTimeStamp) {
      this._hourRange = [_minDateTime.hour, 23];
      this._minuteRange = [_minDateTime.minute, 59];
      _hourScrollCtrl = FixedExtentScrollController(initialItem: 0);
      _minuteScrollCtrl = FixedExtentScrollController(initialItem: 0);
      _currentHour = _minDateTime.hour;
      _currentMinute = _minDateTime.minute;
    } else if (_initDateTimeStamp >= _maxDateTimeStamp) {
      this._hourRange = [0, _maxDateTime.hour];
      this._minuteRange = [0, _maxDateTime.minute];
      _hourScrollCtrl = FixedExtentScrollController(
          initialItem: _hourRange.last - _hourRange.first);
      _minuteScrollCtrl = FixedExtentScrollController(
          initialItem: _minuteRange.last - _minuteRange.first);
      _currentHour = _maxDateTime.hour;
      _currentMinute = _maxDateTime.minute;
    }

    _valueRangeMap = {'h': _hourRange, 'f': _minuteRange};
  }

  void _initModeIsElseWidget() {
    _initDateTime = widget.value ?? DateTime.now();
    _minDateTime = widget.minDate ?? DEFAULT_MIN_DATETIME;
    _maxDateTime = widget.maxDate ?? DEFAULT_MAX_DATETIME;

    this._yearRange = [_minDateTime.year, _maxDateTime.year];

    /// 时间戳
    _initDateTimeStamp = _initDateTime.millisecondsSinceEpoch;
    _minDateTimeStamp = _minDateTime.millisecondsSinceEpoch;
    _maxDateTimeStamp = _maxDateTime.millisecondsSinceEpoch;

    if (_initDateTimeStamp > _minDateTimeStamp &&
        _initDateTimeStamp < _maxDateTimeStamp) {
      // 初始值位于区间中间
      this._monthRange = [1, 12];
      this._dayRange = [1, _getDays(_initDateTime.year, _initDateTime.month)];
      this._hourRange = [0, 23];
      this._minuteRange = [0, 59];

      _yearScrollCtrl = FixedExtentScrollController(
          initialItem: _findScrollCtrl(
              _minDateTime.year, _maxDateTime.year, _initDateTime.year));
      _monthScrollCtrl = FixedExtentScrollController(
          initialItem: _findScrollCtrl(
              _monthRange.first, _monthRange.last, _initDateTime.month));
      _dayScrollCtrl = FixedExtentScrollController(
          initialItem: _findScrollCtrl(
              _dayRange.first, _dayRange.last, _initDateTime.day));
      _hourScrollCtrl = FixedExtentScrollController(
          initialItem: _findScrollCtrl(
              _hourRange.first, _hourRange.last, _initDateTime.hour));
      _minuteScrollCtrl = FixedExtentScrollController(
          initialItem: _findMinuteScrollCtrl(
        _minuteRange.first,
        _minuteRange.last,
        _initDateTime.minute,
      ));

      _currentYear = _initDateTime.year;
      _currentMonth = _initDateTime.month;
      _currentDay = _initDateTime.day;
      _currentHour = _initDateTime.hour;
      _currentMinute = _initDateTime.minute;
      _currentSecond = _initDateTime.second;
    } else if (_initDateTimeStamp <= _minDateTimeStamp) {
      // 初始值小于区间最小值，选中区间最小值
      this._monthRange = [_minDateTime.month, 12];
      this._dayRange = [
        _minDateTime.day,
        _getDays(_minDateTime.year, _minDateTime.month)
      ];
      this._hourRange = [_minDateTime.hour, 23];
      this._minuteRange = [_minDateTime.minute, 59];
      _yearScrollCtrl = FixedExtentScrollController(initialItem: 0);
      _monthScrollCtrl = FixedExtentScrollController(initialItem: 0);
      _dayScrollCtrl = FixedExtentScrollController(initialItem: 0);
      _hourScrollCtrl = FixedExtentScrollController(initialItem: 0);
      _minuteScrollCtrl = FixedExtentScrollController(initialItem: 0);
      _currentYear = _minDateTime.year;
      _currentMonth = _minDateTime.month;
      _currentDay = _minDateTime.day;
      _currentHour = _minDateTime.hour;
      _currentMinute = _minDateTime.minute;
      _currentSecond = _minDateTime.second;
    } else if (_initDateTimeStamp >= _maxDateTimeStamp) {
      // 初始值大于区间最大值，选中区间最大值
      this._monthRange = [1, _maxDateTime.month];
      this._dayRange = [1, _maxDateTime.day];
      this._hourRange = [0, _maxDateTime.hour];
      this._minuteRange = [0, _maxDateTime.minute];
      _yearScrollCtrl = FixedExtentScrollController(
          initialItem: _yearRange.last - _yearRange.first);
      _monthScrollCtrl = FixedExtentScrollController(
          initialItem: _monthRange.last - _monthRange.first);
      _dayScrollCtrl = FixedExtentScrollController(
          initialItem: _dayRange.last - _dayRange.first);
      _hourScrollCtrl = FixedExtentScrollController(
          initialItem: _hourRange.last - _hourRange.first);
      _minuteScrollCtrl = FixedExtentScrollController(
          initialItem: _minuteRange.last - _minuteRange.first);
      _currentYear = _maxDateTime.year;
      _currentMonth = _maxDateTime.month;
      _currentDay = _maxDateTime.day;
      _currentHour = _maxDateTime.hour;
      _currentMinute = _maxDateTime.minute;
      _currentSecond = _maxDateTime.second;
    }
    _valueRangeMap = {
      'y': _yearRange,
      'm': _monthRange,
      'd': _dayRange,
      'h': _hourRange,
      'f': _minuteRange
    };
  }

  /// 计算该年份是否是闰年
  bool isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || year % 400 == 0;
  }

  /// 计算一个月有多少天
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

  int _findScrollCtrl(int startValue, int endValue, int currValue) {
    int res;
    for (int i = 0, l = endValue - startValue + 1; i < l; i++) {
      var value = startValue + i;
      if (currValue == value) {
        res = i;
        break;
      }
    }
    return res;
  }

  int _findMinuteScrollCtrl(int startValue, int endValue, int currValue) {
    int res;
    bool flag = false;
    for (int i = 0,
            l = ((endValue - startValue + 1) / widget.minuteStep).ceil();
        i < l;
        i++) {
      var value = widget.minuteStep * i + startValue;
      if (value == currValue) {
        res = i;
        flag = true;
        break;
      }
    }
    if (currValue == startValue) {
      _currentMinute = startValue;
      res = 0;
    } else if (currValue == endValue) {
      res = ((endValue - startValue + 1) / widget.minuteStep).ceil() - 1;
      _currentMinute =
          ((((endValue - startValue + 1) / widget.minuteStep).ceil() - 1) *
                  widget.minuteStep) +
              startValue;
    } else if (flag == false) {
      for (int i = 0,
              l = ((endValue - startValue + 1) / widget.minuteStep).ceil();
          i < l;
          i++) {
        var value = widget.minuteStep * i + startValue;
        if (value > currValue) {
          _currentMinute = value;
          res = i;
          break;
        }
      }
    }
    return res;
  }

  _handleMinuteChange(int index) {
    if (_isMonthRangeChanged == true ||
        _isYearRangeChanged == true ||
        _isDayRangeChanged == true ||
        _isHourRangeChanged == true) return;
    int _selectedMin = widget.minuteStep * index + _valueRangeMap['f'].first;

    _currentMinute = _selectedMin;
    setState(() {
      _minuteScrollCtrl = FixedExtentScrollController(initialItem: index);
    });
    _handleValueChange(_currentMinute.toString(), 4);
  }

  _handleHourChange(int index) {
    if (_isMonthRangeChanged == true ||
        _isYearRangeChanged == true ||
        _isDayRangeChanged == true) return;
    _isHourRangeChanged = true;
    int _selectedHour = _valueRangeMap['h'].first + index;
    int _startMinute;
    int _endMinute;

    _currentHour = _selectedHour;

    if (_currentYear == _yearRange.first &&
        _currentMonth == _minDateTime.month &&
        _currentDay == _minDateTime.day &&
        _currentHour == _minDateTime.hour) {
      // 初始年初始月初始日初始时
      _startMinute = _minDateTime.minute;
      _endMinute = 59;
      _currentMinute =
          _currentMinute < _startMinute ? _startMinute : _currentMinute;
    } else if (_currentYear == _yearRange.last &&
        _currentMonth == _maxDateTime.month &&
        _currentDay == _maxDateTime.day &&
        _currentHour == _maxDateTime.hour) {
      // 结束年结束月结束日结束时
      _startMinute = 0;
      _endMinute = _maxDateTime.minute;
      _currentMinute =
          _currentMinute > _endMinute ? _endMinute : _currentMinute;
    } else {
      _startMinute = 0;
      _endMinute = 59;
    }

    setState(() {
      _valueRangeMap['f'] = [_startMinute, _endMinute];
      _hourScrollCtrl = FixedExtentScrollController(initialItem: index);
      _minuteScrollCtrl.jumpToItem(0);
      _minuteScrollCtrl.jumpToItem(
          _findMinuteScrollCtrl(_startMinute, _endMinute, _currentMinute));
    });
    _isHourRangeChanged = false;
    _handleValueChange(_currentHour.toString(), 3);
  }

  /// mode为time
  _handleTimeHourChange(int index) {
    int _selectedHour = _valueRangeMap['h'].first + index;
    int _startMinute;
    int _endMinute;
    _isHourRangeChanged = true;
    _currentHour = _selectedHour;
    if (_currentHour == _hourRange.first) {
      _startMinute = _minDateTime.minute;
      _endMinute = 59;
      _currentMinute =
          _currentMinute < _startMinute ? _startMinute : _currentMinute;
    } else if (_currentHour == _hourRange.last) {
      _startMinute = 0;
      _endMinute = _maxDateTime.minute;
      _currentMinute =
          _currentMinute > _endMinute ? _endMinute : _currentMinute;
    } else {
      _startMinute = 0;
      _endMinute = 59;
    }

    setState(() {
      _valueRangeMap['f'] = [_startMinute, _endMinute];
      _hourScrollCtrl = FixedExtentScrollController(initialItem: index);
      _minuteScrollCtrl.jumpToItem(0);
      _minuteScrollCtrl.jumpToItem(
          _findMinuteScrollCtrl(_startMinute, _endMinute, _currentMinute));
    });
    _isHourRangeChanged = false;
    _handleValueChange(_currentHour.toString(), 0);
  }

  /// mode为time
  _handleTimeMinuteChange(int index) {
    if (_isHourRangeChanged == true) return;
    int _selectedMin = widget.minuteStep * index + _valueRangeMap['f'].first;
    _currentMinute = _selectedMin;
    setState(() {
      _minuteScrollCtrl = FixedExtentScrollController(initialItem: index);
    });
    _handleValueChange(_currentMinute.toString(), 1);
  }

  _handleDayChange(int index) {
    if (_isMonthRangeChanged == true || _isYearRangeChanged == true) return;
    _isDayRangeChanged = true;
    int _selectedDay = _valueRangeMap['d'].first + index;
    int _startHour;
    int _endHour;
    int _startMinute;
    int _endMinute;

    _currentDay = _selectedDay;
    if (_currentYear == _yearRange.first &&
        _currentMonth == _minDateTime.month &&
        _currentDay == _minDateTime.day) {
      // 始年���始月初始日初始时
      _startHour = _minDateTime.hour;
      _endHour = 23;
      _currentHour = _currentHour < _startHour ? _startHour : _currentHour;

      if (_currentHour == _minDateTime.hour) {
        _startMinute = _minDateTime.minute;
        _endMinute = 59;
        _currentMinute =
            _currentMinute < _startMinute ? _startMinute : _currentMinute;
      } else {
        _startMinute = 0;
      }
    } else if (_currentYear == _yearRange.last &&
        _currentMonth == _maxDateTime.month &&
        _currentDay == _maxDateTime.day) {
      // 结束年结束月结束日
      _startHour = 0;
      _endHour = _maxDateTime.hour;
      _currentHour = _currentHour > _endHour ? _endHour : _currentHour;

      if (_currentHour == _minDateTime.hour) {
        _startMinute = 0;
        _endMinute = _maxDateTime.minute;
        _currentMinute =
            _currentMinute > _endMinute ? _endMinute : _currentMinute;
      } else {
        _endMinute = 59;
      }
    } else {
      _startHour = 0;
      _endHour = 23;
      _startMinute = 0;
      _endMinute = 59;
    }

    setState(() {
      _valueRangeMap['h'] = [_startHour, _endHour];
      _valueRangeMap['f'] = [_startMinute, _endMinute];
      _dayScrollCtrl = FixedExtentScrollController(initialItem: index);
      _hourScrollCtrl.jumpToItem(0);
      _hourScrollCtrl
          .jumpToItem(_findScrollCtrl(_startHour, _endHour, _currentHour));
      _minuteScrollCtrl.jumpToItem(0);
      _minuteScrollCtrl.jumpToItem(
          _findMinuteScrollCtrl(_startMinute, _endMinute, _currentMinute));
    });
    _isDayRangeChanged = false;
    _handleValueChange(_currentDay.toString(), 2);
  }

  _handleMonthChange(int index) {
    if (_isYearRangeChanged == true) return;
    _isMonthRangeChanged = true;
    int _selectedMonth = _valueRangeMap['m'].first + index;
    int _startDay;
    int _startHour;
    int _startMinute;
    int _endHour;
    int _endDay;
    int _endMinute;
    _currentMonth = _selectedMonth;

    if (_currentYear == _yearRange.first) {
      _endDay = _getDays(_currentYear, _currentMonth);
      _endHour = 23;
      _endMinute = 59;

      /// 当前年是初始年
      setState(() {
        if (_currentMonth == _minDateTime.month) {
          /// 初始年，最小月
          _startDay = _minDateTime.day;
          _currentDay = _startDay;

          if (_currentDay == _minDateTime.day) {
            /// 初始年，最小月，最小天
            _startHour = _minDateTime.hour;
            _currentHour =
                _currentHour < _startHour ? _startHour : _currentHour;
            if (_currentHour == _minDateTime.hour) {
              /// 初始年，最小月，最小天，最小时
              _startMinute = _minDateTime.minute;
              _currentMinute =
                  _currentMinute < _startMinute ? _startMinute : _currentMinute;
            } else {
              _startMinute = 0;
            }
          } else {
            _startHour = 0;
          }
        } else {
          _startDay = 1;
          _startHour = 0;
          _startMinute = 0;
        }

        _valueRangeMap['d'] = [_startDay, _endDay];
        _valueRangeMap['h'] = [_startHour, _endHour];
        _valueRangeMap['f'] = [_startMinute, _endMinute];
        _monthScrollCtrl = FixedExtentScrollController(initialItem: index);
        _dayScrollCtrl.jumpToItem(1);
        _dayScrollCtrl.jumpToItem(_findScrollCtrl(_startDay, _endDay,
            _currentDay > _startDay ? _currentDay : _startDay));
        _hourScrollCtrl.jumpToItem(1);
        _hourScrollCtrl
            .jumpToItem(_findScrollCtrl(_startHour, _endHour, _currentHour));
        _minuteScrollCtrl.jumpToItem(1);
        _minuteScrollCtrl.jumpToItem(
            _findMinuteScrollCtrl(_startMinute, _endMinute, _currentMinute));
      });
      _isMonthRangeChanged = false;
      _handleValueChange(_currentMonth.toString(), 1);
    } else if (_currentYear == _yearRange.last) {
      /// 当前年是结束年
      _startDay = 1;
      _startHour = 0;
      _startMinute = 0;

      if (_currentMonth == _maxDateTime.month) {
        /// 结束年，结束月
        _endDay = _maxDateTime.day;
        _currentDay = _endDay;

        if (_currentDay == _maxDateTime.day) {
          /// 结束年，结束月，最大天
          _endHour = _maxDateTime.hour;
          _currentHour = _currentHour > _endHour ? _endHour : _currentHour;
          if (_currentHour == _maxDateTime.hour) {
            /// 结束年，结束月，最大天，最大时
            _endMinute = _maxDateTime.minute;
            _currentMinute =
                _currentMinute > _endMinute ? _endMinute : _currentMinute;
          } else {
            _endMinute = 59;
          }
        } else {
          _endHour = 23;
        }
      } else {
        _endDay = _getDays(_currentYear, _currentMonth);
        _endHour = 23;
        _endMinute = 59;
      }

      setState(() {
        _valueRangeMap['d'] = [_startDay, _endDay];
        _valueRangeMap['h'] = [_startHour, _endHour];
        _valueRangeMap['f'] = [_startMinute, _endMinute];
        _monthScrollCtrl = FixedExtentScrollController(initialItem: index);
        _dayScrollCtrl.jumpToItem(1);
        _dayScrollCtrl.jumpToItem(_findScrollCtrl(
            _startDay, _endDay, _currentDay > _endDay ? _endDay : _currentDay));
        _hourScrollCtrl.jumpToItem(1);
        _hourScrollCtrl.jumpToItem(_findScrollCtrl(_startHour, _endHour,
            _currentHour > _endHour ? _endHour : _currentHour));
        _minuteScrollCtrl.jumpToItem(1);
        _minuteScrollCtrl.jumpToItem(
            _findMinuteScrollCtrl(_startMinute, _endMinute, _currentMinute));
      });
      _isMonthRangeChanged = false;
      _handleValueChange(_currentMonth.toString(), 1);
    } else {
      /// 其他年份
      _startDay = 1;
      _startMinute = 0;
      _startHour = 0;
      _endDay = _getDays(_currentYear, _currentMonth);
      _endHour = 23;
      _endMinute = 59;

      setState(() {
        _valueRangeMap['d'] = [_startDay, _endDay];
        _valueRangeMap['h'] = [_startHour, _endHour];
        _valueRangeMap['f'] = [_startMinute, _endMinute];
        _monthScrollCtrl = FixedExtentScrollController(initialItem: index);
        _dayScrollCtrl.jumpToItem(1);
        _dayScrollCtrl.jumpToItem(_findScrollCtrl(
            _startDay, _endDay, _currentDay > _endDay ? _endDay : _currentDay));
        _hourScrollCtrl.jumpToItem(1);
        _hourScrollCtrl
            .jumpToItem(_findScrollCtrl(_startHour, _endHour, _currentHour));
        _minuteScrollCtrl.jumpToItem(1);
        _minuteScrollCtrl.jumpToItem(
            _findMinuteScrollCtrl(_startMinute, _endMinute, _currentMinute));
      });
      _isMonthRangeChanged = false;
      _handleValueChange(_currentMonth.toString(), 1);
    }
  }

  _handleYearChange(int index) {
    _isYearRangeChanged = true;
    // 起始年份
    if (this._yearRange.first + index == this._yearRange[0]) {
      int _startDay;
      int _currDay;
      int _startHour;
      int _startMinute;
      int _currHour;
      int _currMinute;

      int _currMonth = _currentMonth < _minDateTime.month
          ? _minDateTime.month
          : _currentMonth;
      if (_currMonth == _minDateTime.month) {
        // 起始月
        _startDay = _minDateTime.day;
        _currDay =
            _currentDay > _minDateTime.day ? _currentDay : _minDateTime.day;
        if (_currDay == _minDateTime.day) {
          // 起始天
          _startHour = _minDateTime.hour;
          _currHour = _minDateTime.hour > _currentHour
              ? _minDateTime.hour
              : _currentHour;
          // 起始时
          if (_currHour == _minDateTime.hour) {
            _startMinute = _minDateTime.minute;
            _currMinute = _minDateTime.minute > _currentMinute
                ? _minDateTime.minute
                : _currentMinute;
          } else {
            _startMinute = 0;
            _currMinute = _currentMinute;
          }
        } else {
          _startHour = 0;
          _startMinute = 0;
          _currHour = _currentHour;
          _currMinute = _currentMinute;
        }
      } else {
        _startDay = 1;
        _startMinute = 0;
        _startHour = 0;
        _currDay = _currentDay;
        _currHour = _currentHour;
        _currMinute = _currentMinute;
      }

      _currentYear = _getCurrentValue(
          _valueRangeMap['y'].first, _valueRangeMap['y'].last, index);
      _currentMonth = _currMonth;
      _currentDay = _currDay;
      _currentHour = _currHour;
      _currentMinute = _currMinute;

      setState(() {
        _valueRangeMap['m'] = [_minDateTime.month, 12];
        _valueRangeMap['d'] = [
          _startDay,
          _getDays(this._yearRange[0], _currMonth)
        ];
        _valueRangeMap['h'] = [_startHour, 23];
        _valueRangeMap['f'] = [_startMinute, 59];
        _yearScrollCtrl = FixedExtentScrollController(initialItem: index);
        _monthScrollCtrl
            .jumpToItem(_findScrollCtrl(_minDateTime.month, 12, _currMonth));
        _dayScrollCtrl.jumpToItem(1);
        _dayScrollCtrl.jumpToItem(_findScrollCtrl(
            _startDay, _getDays(_minDateTime.year, _currMonth), _currDay));
        _hourScrollCtrl.jumpToItem(1);
        _hourScrollCtrl.jumpToItem(_findScrollCtrl(_startHour, 23, _currHour));
        _minuteScrollCtrl.jumpToItem(1);
        _minuteScrollCtrl
            .jumpToItem(_findMinuteScrollCtrl(_startMinute, 59, _currMinute));
      });
      _isYearRangeChanged = false;
      _handleValueChange(_currentYear.toString(), 0);
      return;
    }
    // 结束年份
    if (this._yearRange.first + index == this._yearRange[1]) {
      int _endDay;
      int _endHour;
      int _endMinute;
      int _currDay;
      int _currHour;
      int _currMinute;

      int _currMonth = _currentMonth < _maxDateTime.month
          ? _currentMonth
          : _maxDateTime.month;

      if (_currMonth == _maxDateTime.month) {
        // 结束月
        _endDay = _maxDateTime.day;
        _currDay =
            _currentDay < _maxDateTime.day ? _currentDay : _maxDateTime.day;
        if (_currDay == _maxDateTime.day) {
          // 结束天
          _endHour = _maxDateTime.hour;
          _currHour = _currentHour > _maxDateTime.hour
              ? _maxDateTime.hour
              : _currentHour;
          if (_currHour == _maxDateTime.hour) {
            // 结束时
            _endMinute = _maxDateTime.minute;
            _currMinute = _currentMinute > _maxDateTime.minute
                ? _maxDateTime.minute
                : _currentMinute;
          } else {
            _currMinute = _currentMinute;
            _endMinute = 59;
          }
        } else {
          _currHour = _currentHour;
          _currMinute = _currentMinute;
          _endHour = 23;
          _endMinute = 59;
        }
      } else {
        _endDay = _getDays(this._yearRange[1], _currentMonth);
        _endHour = 23;
        _endMinute = 59;
        _currDay = _currentDay;
        _currHour = _currentHour;
        _currMinute = _currentMinute;
      }

      setState(() {
        _valueRangeMap['m'] = [1, _maxDateTime.month];
        _valueRangeMap['d'] = [1, _endDay];
        _valueRangeMap['h'] = [0, _endHour];
        _valueRangeMap['f'] = [0, _endMinute];
        _yearScrollCtrl = FixedExtentScrollController(initialItem: index);
        _monthScrollCtrl
            .jumpToItem(_findScrollCtrl(1, _maxDateTime.month, _currMonth));
        _dayScrollCtrl.jumpToItem(1);
        _dayScrollCtrl.jumpToItem(_findScrollCtrl(
            1, _getDays(_maxDateTime.year, _currMonth), _currDay));
        _hourScrollCtrl.jumpToItem(1);
        _hourScrollCtrl.jumpToItem(_findScrollCtrl(0, _endHour, _currHour));
        _minuteScrollCtrl.jumpToItem(1);
        _minuteScrollCtrl
            .jumpToItem(_findMinuteScrollCtrl(0, _endMinute, _currMinute));
      });
      _currentMonth = _currMonth;
      _currentDay = _currDay;
      _currentHour = _currHour;
      _currentMinute = _currMinute;
      _currentYear = _getCurrentValue(
          _valueRangeMap['y'].first, _valueRangeMap['y'].last, index);
      _isYearRangeChanged = false;
      _handleValueChange(_currentYear.toString(), 0);
      return;
    }
    _currentYear = _getCurrentValue(
        _valueRangeMap['y'].first, _valueRangeMap['y'].last, index);

    // 其他年份

    setState(() {
      _valueRangeMap['m'] = [1, 12];
      _valueRangeMap['d'] = [1, _getDays(_currentYear, _currentMonth)];
      _valueRangeMap['h'] = [0, 23];
      _valueRangeMap['f'] = [0, 59];
      _yearScrollCtrl = FixedExtentScrollController(initialItem: index);
      _monthScrollCtrl.jumpToItem(1);
      _monthScrollCtrl.jumpToItem(_findScrollCtrl(1, 12, _currentMonth));
      _dayScrollCtrl.jumpToItem(1);
      _dayScrollCtrl.jumpToItem(_findScrollCtrl(
          1, _getDays(_currentYear, _currentMonth), _currentDay));
      _hourScrollCtrl.jumpToItem(1);
      _hourScrollCtrl.jumpToItem(_findScrollCtrl(0, 23, _currentHour));
      _minuteScrollCtrl.jumpToItem(1);
      _minuteScrollCtrl
          .jumpToItem(_findMinuteScrollCtrl(0, 59, _currentMinute));
    });
    _isYearRangeChanged = false;
    _handleValueChange(_currentYear.toString(), 0);
  }

  void _handleValueChange(String value, int index) {
    if (widget.onValueChange != null) {
      widget.onValueChange({'vals': value, 'index': index.toString()});
    }
    if (widget.onChange != null) {
      widget.onChange(DateTime(_currentYear, _currentMonth, _currentDay,
          _currentHour, _currentMinute, _currentSecond));
    }
  }

  /// 根据index获取值
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

  Widget _buildPickerItemWidget(String value, {bool active = true}) {
    return Container(
        height: itemWidgetHeight,
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: active == true ? _activeTextColor : _inActiveTextColor),
          child: Text(value),
        ));
  }

  Widget _buildDatePickerColumn(
      {@required FixedExtentScrollController scrollCtrl,
      @required List<int> valueRange,
      @required ValueChanged<int> valueChanged,
      String type,
      int minuteStep = 1}) {
    return Flexible(
      flex: 1,
      child: CupertinoPicker.builder(
        scrollController: scrollCtrl,
        backgroundColor: Colors.white,
        itemExtent: _itemExtent,
        squeeze: _squeeze,
        diameterRatio: _diameterRatio,
        onSelectedItemChanged: valueChanged,
        childCount: valueRange.last - valueRange.first + 1,
        itemBuilder: (BuildContext context, int index) {
          return _buildPickerItemWidget('${valueRange.first + index}$type');
        },
      ),
    );
  }

  Widget _buildDateMinutePickerColumn(
      {@required FixedExtentScrollController scrollCtrl,
      @required List<int> valueRange,
      @required ValueChanged<int> valueChanged,
      String type,
      int minuteStep = 1}) {
    return Flexible(
      flex: 1,
      child: CupertinoPicker.builder(
        scrollController: scrollCtrl,
        backgroundColor: Colors.white,
        itemExtent: _itemExtent,
        squeeze: _squeeze,
        diameterRatio: _diameterRatio,
        onSelectedItemChanged: valueChanged,
        childCount:
            ((valueRange.last - valueRange.first + 1) / minuteStep).ceil(),
        itemBuilder: (BuildContext context, int index) {
          return _buildPickerItemWidget(
              '${(index * widget.minuteStep + valueRange.first)}$type');
        },
      ),
    );
  }

  /// 渲染模式为time
  Widget _buildTimePickerWidget() {
    return Row(
      children: <Widget>[
        _buildDatePickerColumn(
            scrollCtrl: _hourScrollCtrl,
            valueRange: _valueRangeMap['h'],
            valueChanged: _handleTimeHourChange,
            type: '时'),
        _buildDateMinutePickerColumn(
            scrollCtrl: _minuteScrollCtrl,
            valueRange: _valueRangeMap['f'],
            valueChanged: _handleTimeMinuteChange,
            minuteStep: widget.minuteStep,
            type: '分')
      ],
    );
  }

  /// 渲染模式为date
  Widget _buildDatePickerWidget() {
    return Row(
      children: <Widget>[
        _buildDatePickerColumn(
            scrollCtrl: _yearScrollCtrl,
            valueRange: _valueRangeMap['y'],
            type: '年',
            valueChanged: _handleYearChange),
        _buildDatePickerColumn(
            scrollCtrl: _monthScrollCtrl,
            valueRange: _valueRangeMap['m'],
            type: '月',
            valueChanged: _handleMonthChange),
        _buildDatePickerColumn(
          scrollCtrl: _dayScrollCtrl,
          valueRange: _valueRangeMap['d'],
          type: '日',
          valueChanged: _handleDayChange,
        ),
      ],
    );
  }

  // Widget _buildYearPickerColumn(
  //     {@required FixedExtentScrollController scrollCtrl,
  //     @required List<int> valueRange,
  //     @required ValueChanged<int> valueChanged}) {
  //   return Flexible(
  //     flex: 1,
  //     child: CupertinoPicker.builder(
  //       scrollController: scrollCtrl,
  //       backgroundColor: Colors.white,
  //       itemExtent: _itemExtent,
  //       squeeze: _squeeze,
  //       diameterRatio: _diameterRatio,
  //       onSelectedItemChanged: valueChanged,
  //       childCount: valueRange.last - valueRange.first + 1,
  //       itemBuilder: (BuildContext context, int index) {
  //         return _buildPickerItemWidget('${valueRange.first + index}年');
  //       },
  //     ),
  //   );
  // }

  /// 渲染模式为year
  Widget _buildYearPickerWidget() {
    return Row(
      children: <Widget>[
        _buildDatePickerColumn(
            scrollCtrl: _yearScrollCtrl,
            valueRange: _valueRangeMap['y'],
            type: '年',
            valueChanged: (int index) {
              _currentYear = _getCurrentValue(
                  _valueRangeMap['y'].first, _valueRangeMap['y'].last, index);
              _handleValueChange(_currentYear.toString(), 0);
            })
      ],
    );
  }

  /// 渲染模式为month
  Widget _buildMonthPickerWidget() {
    return Row(
      children: <Widget>[
        _buildDatePickerColumn(
            scrollCtrl: _yearScrollCtrl,
            valueRange: _valueRangeMap['y'],
            valueChanged: _handleYearChange,
            type: '年'),
        _buildDatePickerColumn(
            scrollCtrl: _monthScrollCtrl,
            valueRange: _valueRangeMap['m'],
            valueChanged: _handleMonthChange,
            type: '月')
      ],
    );
  }

  /// 渲染模式为datetime
  Widget _buildDatetimePickerWidget() {
    return Row(
      children: <Widget>[
        _buildDatePickerColumn(
            scrollCtrl: _yearScrollCtrl,
            valueRange: _valueRangeMap['y'],
            type: '年',
            valueChanged: _handleYearChange),
        _buildDatePickerColumn(
            scrollCtrl: _monthScrollCtrl,
            valueRange: _valueRangeMap['m'],
            type: '月',
            valueChanged: _handleMonthChange),
        _buildDatePickerColumn(
            scrollCtrl: _dayScrollCtrl,
            valueRange: _valueRangeMap['d'],
            type: '日',
            valueChanged: _handleDayChange),
        _buildDatePickerColumn(
            scrollCtrl: _hourScrollCtrl,
            valueRange: _valueRangeMap['h'],
            type: '时',
            valueChanged: _handleHourChange),
        _buildDateMinutePickerColumn(
            scrollCtrl: _minuteScrollCtrl,
            valueRange: _valueRangeMap['f'],
            type: '分',
            valueChanged: _handleMinuteChange,
            minuteStep: widget.minuteStep),
      ],
    );
  }

  Widget _buildPickerView() {
    switch (widget.mode) {
      case 'date':
        {
          return _buildDatePickerWidget();
        }
        break;
      case 'year':
        {
          return _buildYearPickerWidget();
        }
        break;
      case 'month':
        {
          return _buildMonthPickerWidget();
        }
        break;
      case 'time':
        {
          return _buildTimePickerWidget();
        }
        break;
      case 'datetime':
        {
          return _buildDatetimePickerWidget();
        }
        break;
      // default:
      //   {
      //     return _buildDatePickerWidget();
      //   }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.white),
        child: _buildPickerView());
  }
}
