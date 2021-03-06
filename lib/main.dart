import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
import './pages/PullToRefresh/pullToRefresh.dart';
import './pages/SwipeAction/swipeAction.dart';
import './pages/Carousel/carsousel.dart';
import './pages/Grid/grid.dart';
import './pages/picker/picker.dart';
import './pages/PickerView/pickerView.dart';
import './pages/DatePicker/datePicker.dart';
import './pages/DatePickerView/datePickerView.dart';
import './pages/InputItem/inputItem.dart';
import './pages/TextareaItem/textareaItem.dart';
import './pages/ImagePicker/imagePicker.dart';
import './pages/Listview/listview.dart';
import './pages/Listview/listviewIndexedList.dart';

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
  int content;
  bool navigation = false;
  bool dataEntry = false;
  bool dataDisplay = false;
  bool feedback = false;
  bool combination = false;
  bool gesture = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              navigation = !navigation;
            });
          },
          children: [
            ExpansionPanel(
                headerBuilder: (_, __) {
                  return Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text('导航 Navigation'),
                  );
                },
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return PageMenu();
                        }));
                      },
                      child: ListTile(
                        title: Text('Menu 菜单',
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.grey)),
                        trailing: Container(
                          child: Icon(Icons.chevron_right),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return PageSegmentedControl();
                        }));
                      },
                      child: ListTile(
                        title: Text('SegmentedControl 分段器',
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.grey)),
                        trailing: Container(
                          child: Icon(Icons.chevron_right),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return PageTabBar();
                        }));
                      },
                      child: ListTile(
                        title: Text('TabBar 标签栏',
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.grey)),
                        trailing: Container(
                          child: Icon(Icons.chevron_right),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return PageTabs();
                        }));
                      },
                      child: ListTile(
                        title: Text('Tabs 标签页',
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.grey)),
                        trailing: Container(
                          child: Icon(Icons.chevron_right),
                        ),
                      ),
                    )
                  ],
                ),
                isExpanded: navigation)
          ],
        ),
        SizedBox(
          height: 15.0,
        ),
        ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              dataEntry = !dataEntry;
            });
          },
          children: [
            ExpansionPanel(
                headerBuilder: (_, __) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
                    child: Text('数据录入 Data Entry'),
                  );
                },
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return PageButton();
                        }));
                      },
                      child: ListTile(
                        title: Text(
                          'Button 按钮',
                          style: TextStyle(fontSize: 14.0, color: Colors.grey),
                        ),
                        trailing: Container(
                          child: Icon(Icons.chevron_right),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return PageDatePickerView();
                        }));
                      },
                      child: ListTile(
                        title: Text(
                          'DatePickerView 选择器',
                          style: TextStyle(fontSize: 14.0, color: Colors.grey),
                        ),
                        trailing: Container(
                          child: Icon(Icons.chevron_right),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return PageDatePicker();
                        }));
                      },
                      child: ListTile(
                        title: Text(
                          'DatePicker 日期选择',
                          style: TextStyle(fontSize: 14.0, color: Colors.grey),
                        ),
                        trailing: Container(
                          child: Icon(Icons.chevron_right),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return PageInputItem();
                        }));
                      },
                      child: ListTile(
                        title: Text(
                          'InputItem 文本输入',
                          style: TextStyle(fontSize: 14.0, color: Colors.grey),
                        ),
                        trailing: Container(
                          child: Icon(Icons.chevron_right),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return PageImagePicker();
                        }));
                      },
                      child: ListTile(
                        title: Text(
                          'ImagePicker 图片选择器',
                          style: TextStyle(fontSize: 14.0, color: Colors.grey),
                        ),
                        trailing: Container(
                          child: Icon(Icons.chevron_right),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return PageCheckbox();
                        }));
                      },
                      child: ListTile(
                        title: Text('Checkbox 复选框',
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.grey)),
                        trailing: Container(
                          child: Icon(Icons.chevron_right),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return PagePickerView();
                        }));
                      },
                      child: ListTile(
                        title: Text('PickerView 选择器',
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.grey)),
                        trailing: Container(
                          child: Icon(Icons.chevron_right),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return PagePicker();
                        }));
                      },
                      child: ListTile(
                        title: Text('Picker 选择器',
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.grey)),
                        trailing: Container(
                          child: Icon(Icons.chevron_right),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return PageRadio();
                        }));
                      },
                      child: ListTile(
                        title: Text('Radio 单选框',
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.grey)),
                        trailing: Container(
                          child: Icon(Icons.chevron_right),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return PageSearchBox();
                        }));
                      },
                      child: ListTile(
                        title: Text('SearchBar 搜索栏',
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.grey)),
                        trailing: Container(
                          child: Icon(Icons.chevron_right),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return PageTextareaItem();
                        }));
                      },
                      child: ListTile(
                        title: Text('TextareaItem 多行输入',
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.grey)),
                        trailing: Container(
                          child: Icon(Icons.chevron_right),
                        ),
                      ),
                    )
                  ],
                ),
                isExpanded: dataEntry)
          ],
        ),
        SizedBox(
          height: 15.0,
        ),
        ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              dataDisplay = !dataDisplay;
            });
          },
          children: [
            ExpansionPanel(
                headerBuilder: (_, __) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
                    child: Text('数据展示 Data Display'),
                  );
                },
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return PageBadge();
                        }));
                      },
                      child: ListTile(
                        title: Text(
                          'Badge 徽标数',
                          style: TextStyle(fontSize: 14.0, color: Colors.grey),
                        ),
                        trailing: Container(
                          child: Icon(Icons.chevron_right),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return PageCarousel();
                        }));
                      },
                      child: ListTile(
                        title: Text(
                          'Carousel 走马灯',
                          style: TextStyle(fontSize: 14.0, color: Colors.grey),
                        ),
                        trailing: Container(
                          child: Icon(Icons.chevron_right),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return PageCard();
                        }));
                      },
                      child: ListTile(
                        title: Text('Card 卡片',
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.grey)),
                        trailing: Container(
                          child: Icon(Icons.chevron_right),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return PageGrid();
                        }));
                      },
                      child: ListTile(
                        title: Text('Grid 宫格',
                            style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey.withOpacity(0.9))),
                        trailing: Container(
                          child: Icon(Icons.chevron_right),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return PageList();
                        }));
                      },
                      child: ListTile(
                        title: Text('List 列表',
                            style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey.withOpacity(0.9))),
                        trailing: Container(
                          child: Icon(Icons.chevron_right),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return PageNoticeBar();
                        }));
                      },
                      child: ListTile(
                        title: Text('NoticeBar 通告栏',
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.grey)),
                        trailing: Container(
                          child: Icon(Icons.chevron_right),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return PageSteps();
                        }));
                      },
                      child: ListTile(
                        title: Text('Steps 步骤条',
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.grey)),
                        trailing: Container(
                          child: Icon(Icons.chevron_right),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return PageTag();
                        }));
                      },
                      child: ListTile(
                        title: Text('Tag 标签',
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.grey)),
                        trailing: Container(
                          child: Icon(Icons.chevron_right),
                        ),
                      ),
                    )
                  ],
                ),
                isExpanded: dataDisplay)
          ],
        ),
        SizedBox(
          height: 15.0,
        ),
        ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              feedback = !feedback;
            });
          },
          children: [
            ExpansionPanel(
                headerBuilder: (_, __) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
                    child: Text('操作反馈 Feedback'),
                  );
                },
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return PageActionSheet();
                        }));
                      },
                      child: ListTile(
                        title: Text(
                          'ActionSheet 动作画板',
                          style: TextStyle(fontSize: 14.0, color: Colors.grey),
                        ),
                        trailing: Container(
                          child: Icon(Icons.chevron_right),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return PageActivityIndicator();
                        }));
                      },
                      child: ListTile(
                        title: Text('ActivityIndicator 活动指示器',
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.grey)),
                        trailing: Container(
                          child: Icon(Icons.chevron_right),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return PageModal();
                        }));
                      },
                      child: ListTile(
                        title: Text('Modal 对话框',
                            style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey.withOpacity(0.9))),
                        trailing: Container(
                          child: Icon(Icons.chevron_right),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return PageProgress();
                        }));
                      },
                      child: ListTile(
                        title: Text('Progress 进度条',
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.grey)),
                        trailing: Container(
                          child: Icon(Icons.chevron_right),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return PageToast();
                        }));
                      },
                      child: ListTile(
                        title: Text('Toast 轻提示',
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.grey)),
                        trailing: Container(
                          child: Icon(Icons.chevron_right),
                        ),
                      ),
                    )
                  ],
                ),
                isExpanded: feedback)
          ],
        ),
        SizedBox(
          height: 15.0,
        ),
        ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              combination = !combination;
            });
          },
          children: [
            ExpansionPanel(
                headerBuilder: (_, __) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
                    child: Text('组合组件 Combination'),
                  );
                },
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          // return PageListview();
                          return PageListview();
                        }));
                      },
                      child: ListTile(
                        title: Text(
                          'Listview 长列表',
                          style: TextStyle(fontSize: 14.0, color: Colors.grey),
                        ),
                        trailing: Container(
                          child: Icon(Icons.chevron_right),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          // return PageListview();
                          return PageListviewIndexedList();
                        }));
                      },
                      child: ListTile(
                        title: Text(
                          'ListviewIndexedList 城市列表',
                          style: TextStyle(fontSize: 14.0, color: Colors.grey),
                        ),
                        trailing: Container(
                          child: Icon(Icons.chevron_right),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return PageResult();
                        }));
                      },
                      child: ListTile(
                        title: Text(
                          'Result 结果页',
                          style: TextStyle(fontSize: 14.0, color: Colors.grey),
                        ),
                        trailing: Container(
                          child: Icon(Icons.chevron_right),
                        ),
                      ),
                    )
                  ],
                ),
                isExpanded: combination)
          ],
        ),
        SizedBox(
          height: 15.0,
        ),
        ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              gesture = !gesture;
            });
          },
          children: [
            ExpansionPanel(
                headerBuilder: (_, __) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
                    child: Text('手势 Gesture'),
                  );
                },
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return PagePullToRefresh();
                        }));
                      },
                      child: ListTile(
                        title: Text(
                          'PullToRefresh 拉动刷新',
                          style: TextStyle(fontSize: 14.0, color: Colors.grey),
                        ),
                        trailing: Container(
                          child: Icon(Icons.chevron_right),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return PageSwipeAction();
                        }));
                      },
                      child: ListTile(
                        title: Text(
                          'SwipeAction 滑动操作',
                          style: TextStyle(fontSize: 14.0, color: Colors.grey),
                        ),
                        trailing: Container(
                          child: Icon(Icons.chevron_right),
                        ),
                      ),
                    )
                  ],
                ),
                isExpanded: gesture)
          ],
        )
      ],
    ));
  }
}
