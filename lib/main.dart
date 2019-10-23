import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import './pages/Menu/menu.dart';
import './pages/SegmentedControl/segmentedControl.dart';
import './pages/TabBar/tabBar.dart';
import './pages/Tabs/tabs.dart';
import './pages/Button/button.dart';
import './pages/Checkbox/checkbox.dart';
import './pages/Radio/radio.dart';
import './pages/SearchBox/searchBox.dart';
import './pages/Badge/badge.dart';
import './pages/Card/card.dart';
import './pages/List/list.dart';
import './pages/NoticeBar/noticeBar.dart';
import './pages/Tag/tag.dart';
import './pages/ActionSheet/actionSheet.dart';
import './pages/ActivityIndicator/activityIndicator.dart';
import './pages/Modal/modal.dart';
import './pages/Progress/progress.dart';
import './pages/Toast/toast.dart';
import './pages/Result/result.dart';
import './pages/Steps/steps.dart';
import 'dart:io';
import 'dart:async';
// import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('demo'),
        ),
        body: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SlidableController slidableController;
  int content;
  bool navigation = false;
  bool dataEntry = false;
  bool dataDisplay = false;
  bool feedback = false;
  bool combination = false;

  Duration timer = const Duration();
  DateTime date = DateTime(2017, 9, 7, 17, 30);
  int _selectedColorIndex = 0;
  List<String> coolColorNames = <String>[
    'Sarcoline',
    'Coquelicot',
    'Smaragdine',
    'Mikado',
    'Glaucous',
    'Wenge',
    'Fulvous',
    'Xanadu',
    'Falu',
    'Eburnean',
    'Amaranth',
    'Australien',
    'Banan',
    'Falu',
    'Gingerline',
    'Incarnadine',
    'Labrador',
    'Nattier',
    'Pervenche',
    'Sinoper',
    'Verditer',
    'Watchet',
    'Zaffre',
  ];

  @override
  void initState() {
    super.initState();
  }

  Widget _buildBottomPicker(Widget picker) {
    return Container(
      height: 316.0,
      decoration: BoxDecoration(color: Colors.white),
      padding: const EdgeInsets.only(top: 6.0),
      // color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: CupertinoColors.systemYellow,
          fontSize: 22.0,
        ),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () {},
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }

  Widget _buildMenu(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoTheme.of(context).scaffoldBackgroundColor,
        border: const Border(
          top: BorderSide(color: Color(0xFFBCBBC1), width: 0.0),
          bottom: BorderSide(color: Color(0xFFBCBBC1), width: 0.0),
        ),
      ),
      height: 44.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SafeArea(
          top: false,
          bottom: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: children,
          ),
        ),
      ),
    );
  }

  Widget _buildColorPicker(BuildContext context) {
    final FixedExtentScrollController scrollController =
        FixedExtentScrollController(initialItem: _selectedColorIndex);
    final FixedExtentScrollController _scrollController =
        FixedExtentScrollController(initialItem: _selectedColorIndex);

    return GestureDetector(
      onTap: () async {
        await showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: _buildBottomPicker(
                      CupertinoPicker(
                        // diameterRatio: 10.0,
                        scrollController: scrollController,
                        // offAxisFraction: 2.2,
                        // magnification: 20.0,
                        itemExtent: 40.0,
                        backgroundColor: CupertinoColors.white,
                        onSelectedItemChanged: (int index) {
                          setState(() => _selectedColorIndex = index);
                        },
                        children: List<Widget>.generate(coolColorNames.length,
                            (int index) {
                          return Center(
                            child: Text(
                              coolColorNames[index],
                              style: TextStyle(fontSize: 14.0),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  Expanded(
                    child: _buildBottomPicker(
                      CupertinoPicker(
                        // diameterRatio: 10.0,
                        scrollController: _scrollController,
                        // offAxisFraction: 2.2,
                        // magnification: 20.0,
                        itemExtent: 40.0,
                        backgroundColor: CupertinoColors.white,
                        onSelectedItemChanged: (int index) {
                          setState(() => _selectedColorIndex = index);
                        },
                        children: List<Widget>.generate(coolColorNames.length,
                            (int index) {
                          return Center(
                            child: Text(
                              coolColorNames[index],
                              style: TextStyle(fontSize: 14.0),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: _buildMenu(
        <Widget>[
          const Text('Favorite Color'),
          Text(
            coolColorNames[_selectedColorIndex],
            style: const TextStyle(color: CupertinoColors.inactiveGray),
          ),
        ],
      ),
    );
  }

  Widget _buildCountdownTimerPicker(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) {
            return _buildBottomPicker(
              CupertinoTimerPicker(
                initialTimerDuration: timer,
                onTimerDurationChanged: (Duration newTimer) {
                  setState(() => timer = newTimer);
                },
              ),
            );
          },
        );
      },
      child: _buildMenu(
        <Widget>[
          const Text('Countdown Timer'),
          Text(
            '${timer.inHours}:'
            '${(timer.inMinutes % 60).toString().padLeft(2, '0')}:'
            '${(timer.inSeconds % 60).toString().padLeft(2, '0')}',
            style: const TextStyle(color: CupertinoColors.inactiveGray),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) {
            return _buildBottomPicker(
              CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                use24hFormat: true,
                initialDateTime: date,
                onDateTimeChanged: (DateTime newDateTime) {
                  setState(() => date = newDateTime);
                },
              ),
            );
          },
        );
      },
      child: _buildMenu(<Widget>[
        const Text('Date'),
        Text(
          DateFormat.yMMMMd().format(date),
          style: const TextStyle(color: CupertinoColors.inactiveGray),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        const Padding(padding: EdgeInsets.only(top: 32.0)),
        _buildColorPicker(context),
        _buildCountdownTimerPicker(context),
        _buildDatePicker(context),
      ],
    );
  }
}
