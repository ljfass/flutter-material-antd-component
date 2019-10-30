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

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';

// final List<String> imgList = [
//   'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
//   'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
//   'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
//   'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
//   'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
//   'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
// ];

// void main() => runApp(CarouselDemo());

// final Widget placeholder = Container(color: Colors.grey);

// final List child = map<Widget>(
//   imgList,
//   (index, i) {
//     return Container(
//       margin: EdgeInsets.all(5.0),
//       child: ClipRRect(
//         borderRadius: BorderRadius.all(Radius.circular(5.0)),
//         child: Stack(children: <Widget>[
//           Image.network(i, fit: BoxFit.cover, width: 1000.0),
//           Positioned(
//             bottom: 0.0,
//             left: 0.0,
//             right: 0.0,
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Color.fromARGB(200, 0, 0, 0),
//                     Color.fromARGB(0, 0, 0, 0)
//                   ],
//                   begin: Alignment.bottomCenter,
//                   end: Alignment.topCenter,
//                 ),
//               ),
//               padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//               child: Text(
//                 'No. $index image',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 20.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ]),
//       ),
//     );
//   },
// ).toList();

// List<T> map<T>(List list, Function handler) {
//   List<T> result = [];
//   for (var i = 0; i < list.length; i++) {
//     result.add(handler(i, list[i]));
//   }

//   return result;
// }

// class CarouselWithIndicator extends StatefulWidget {
//   @override
//   _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
// }

// class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
//   int _current = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       CarouselSlider(
//         items: child,
//         autoPlay: true,
//         enlargeCenterPage: true,
//         aspectRatio: 2.0,
//         onPageChanged: (index) {
//           setState(() {
//             _current = index;
//           });
//         },
//       ),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: map<Widget>(
//           imgList,
//           (index, url) {
//             return Container(
//               width: 8.0,
//               height: 8.0,
//               margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
//               decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: _current == index
//                       ? Color.fromRGBO(0, 0, 0, 0.9)
//                       : Color.fromRGBO(0, 0, 0, 0.4)),
//             );
//           },
//         ),
//       ),
//     ]);
//   }
// }

// class CarouselDemo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     //Manually operated Carousel
//     final CarouselSlider manualCarouselDemo = CarouselSlider(
//       items: child,
//       autoPlay: false,
//       enlargeCenterPage: false,
//       viewportFraction: 0.9,
//       enableInfiniteScroll: true,
//       aspectRatio: 2.0,
//       initialPage: 2,
//     );

//     //Auto playing carousel
//     final CarouselSlider autoPlayDemo = CarouselSlider(
//       viewportFraction: 0.9,
//       aspectRatio: 2.0,
//       autoPlay: true,
//       enlargeCenterPage: true,
//       items: imgList.map(
//         (url) {
//           return Container(
//             margin: EdgeInsets.all(5.0),
//             child: ClipRRect(
//               borderRadius: BorderRadius.all(Radius.circular(5.0)),
//               child: Image.network(
//                 url,
//                 fit: BoxFit.cover,
//                 width: 1000.0,
//               ),
//             ),
//           );
//         },
//       ).toList(),
//     );

//     //Button controlled carousel
//     Widget buttonDemo() {
//       final basicSlider = CarouselSlider(
//         items: child,
//         autoPlay: false,
//         enlargeCenterPage: true,
//         viewportFraction: 0.9,
//         aspectRatio: 2.0,
//       );
//       return Column(children: [
//         basicSlider,
//         Row(children: [
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 15.0),
//               child: RaisedButton(
//                 onPressed: () => basicSlider.previousPage(
//                     duration: Duration(milliseconds: 300),
//                     curve: Curves.linear),
//                 child: Text('prev slider'),
//               ),
//             ),
//           ),
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 15.0),
//               child: RaisedButton(
//                 onPressed: () => basicSlider.nextPage(
//                     duration: Duration(milliseconds: 300),
//                     curve: Curves.linear),
//                 child: Text('next slider'),
//               ),
//             ),
//           ),
//         ]),
//       ]);
//     }

//     //Pages covers entire carousel
//     final CarouselSlider coverScreenExample = CarouselSlider(
//       viewportFraction: 1.0,
//       aspectRatio: 2.0,
//       autoPlay: false,
//       enlargeCenterPage: false,
//       items: map<Widget>(
//         imgList,
//         (index, i) {
//           return Container(
//             decoration: BoxDecoration(
//               image: DecorationImage(image: NetworkImage(i), fit: BoxFit.cover),
//             ),
//           );
//         },
//       ),
//     );

//     //User input pauses carousels automatic playback
//     final CarouselSlider touchDetectionDemo = CarouselSlider(
//       viewportFraction: 0.9,
//       aspectRatio: 2.0,
//       autoPlay: true,
//       enlargeCenterPage: true,
//       pauseAutoPlayOnTouch: Duration(seconds: 3),
//       items: imgList.map(
//         (url) {
//           return Container(
//             margin: EdgeInsets.all(5.0),
//             child: ClipRRect(
//               borderRadius: BorderRadius.all(Radius.circular(5.0)),
//               child: Image.network(
//                 url,
//                 fit: BoxFit.cover,
//                 width: 1000.0,
//               ),
//             ),
//           );
//         },
//       ).toList(),
//     );

//     //Non-looping manual Carousel
//     final CarouselSlider nonLoopingCarousel = CarouselSlider(
//       items: child,
//       scrollPhysics: BouncingScrollPhysics(),
//       enableInfiniteScroll: false,
//       autoPlay: false,
//       enlargeCenterPage: true,
//       viewportFraction: 0.9,
//       aspectRatio: 2.0,
//     );

//     //Vertical carousel
//     final CarouselSlider verticalScrollCarousel = CarouselSlider(
//       scrollDirection: Axis.vertical,
//       aspectRatio: 2.0,
//       autoPlay: true,
//       enlargeCenterPage: true,
//       viewportFraction: 0.9,
//       pauseAutoPlayOnTouch: Duration(seconds: 3),
//       items: imgList.map(
//         (url) {
//           return Container(
//             margin: EdgeInsets.all(5.0),
//             child: ClipRRect(
//               borderRadius: BorderRadius.all(Radius.circular(5.0)),
//               child: Image.network(
//                 url,
//                 fit: BoxFit.cover,
//                 width: 1000.0,
//               ),
//             ),
//           );
//         },
//       ).toList(),
//     );

//     //create full screen Carousel with context
//     CarouselSlider getFullScreenCarousel(BuildContext mediaContext) {
//       return CarouselSlider(
//         autoPlay: true,
//         viewportFraction: 1.0,
//         aspectRatio: MediaQuery.of(mediaContext).size.aspectRatio,
//         items: imgList.map(
//           (url) {
//             return Container(
//               child: ClipRRect(
//                 borderRadius: BorderRadius.all(Radius.circular(0.0)),
//                 child: Image.network(
//                   url,
//                   fit: BoxFit.cover,
//                   width: 1000.0,
//                 ),
//               ),
//             );
//           },
//         ).toList(),
//       );
//     }

//     return MaterialApp(
//       title: 'demo',
//       home: Scaffold(
//         appBar: AppBar(title: Text('Carousel slider demo')),
//         body: ListView(
//           children: <Widget>[
//             Padding(
//                 padding: EdgeInsets.symmetric(vertical: 15.0),
//                 child: Column(children: [
//                   Text('Manuell Carousel'),
//                   manualCarouselDemo,
//                 ])),
//             Padding(
//                 padding: EdgeInsets.symmetric(vertical: 15.0),
//                 child: Column(children: [
//                   Text('Auto Playing Carousel'),
//                   autoPlayDemo,
//                 ])),
//             Padding(
//                 padding: EdgeInsets.symmetric(vertical: 15.0),
//                 child: Column(children: [
//                   Text('Button Controlled Carousel'),
//                   buttonDemo(),
//                 ])),
//             Padding(
//                 padding: EdgeInsets.symmetric(vertical: 15.0),
//                 child: Column(children: [
//                   Text('Full Screen Carousel'),
//                   coverScreenExample,
//                 ])),
//             Padding(
//                 padding: EdgeInsets.symmetric(vertical: 15.0),
//                 child: Column(children: [
//                   Text('Carousel With Indecator'),
//                   CarouselWithIndicator(),
//                 ])),
//             Padding(
//                 padding: EdgeInsets.symmetric(vertical: 15.0),
//                 child: Column(children: [
//                   Text('Pause When Touched Carousel'),
//                   touchDetectionDemo,
//                 ])),
//             Padding(
//                 padding: EdgeInsets.symmetric(vertical: 15.0),
//                 child: Column(children: [
//                   Text('No infinity scroll carousel'),
//                   nonLoopingCarousel,
//                 ])),
//             Padding(
//                 padding: EdgeInsets.symmetric(vertical: 15.0),
//                 child: Column(children: [
//                   Text('Vertical scroll carousel'),
//                   verticalScrollCarousel,
//                 ])),
//             Padding(
//                 padding: EdgeInsets.only(top: 15.0),
//                 //Builder needed to provide mediaQuery context from material app
//                 child: Builder(builder: (context) {
//                   return Column(children: [
//                     Text('Full screen carousel'),
//                     getFullScreenCarousel(context),
//                   ]);
//                 })),
//           ],
//         ),
//       ),
//     );
//   }
// }
