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
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Slidable Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Slidable Demo'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   SlidableController slidableController;
//   final List<_HomeItem> items = List.generate(
//     20,
//     (i) => _HomeItem(
//       i,
//       'Tile n°$i',
//       _getSubtitle(i),
//       _getAvatarColor(i),
//     ),
//   );

//   @protected
//   void initState() {
//     slidableController = SlidableController(
//       onSlideAnimationChanged: handleSlideAnimationChanged,
//       onSlideIsOpenChanged: handleSlideIsOpenChanged,
//     );
//     super.initState();
//   }

//   Animation<double> _rotationAnimation;
//   Color _fabColor = Colors.blue;

//   void handleSlideAnimationChanged(Animation<double> slideAnimation) {
//     setState(() {
//       _rotationAnimation = slideAnimation;
//     });
//   }

//   void handleSlideIsOpenChanged(bool isOpen) {
//     setState(() {
//       _fabColor = isOpen ? Colors.green : Colors.blue;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: OrientationBuilder(
//           builder: (context, orientation) => _buildList(
//               context,
//               orientation == Orientation.portrait
//                   ? Axis.vertical
//                   : Axis.horizontal),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: _fabColor,
//         onPressed: null,
//         child: _rotationAnimation == null
//             ? Icon(Icons.add)
//             : RotationTransition(
//                 turns: _rotationAnimation,
//                 child: Icon(Icons.add),
//               ),
//       ),
//     );
//   }

//   Widget _buildList(BuildContext context, Axis direction) {
//     return ListView.builder(
//       scrollDirection: direction,
//       itemBuilder: (context, index) {
//         final Axis slidableDirection =
//             direction == Axis.horizontal ? Axis.vertical : Axis.horizontal;
//         var item = items[index];
//         if (item.index < 8) {
//           return _getSlidableWithLists(context, index, slidableDirection);
//         } else {
//           return _getSlidableWithDelegates(context, index, slidableDirection);
//         }
//       },
//       itemCount: items.length,
//     );
//   }

//   Widget _getSlidableWithLists(
//       BuildContext context, int index, Axis direction) {
//     final _HomeItem item = items[index];
//     //final int t = index;
//     return Slidable(
//       key: Key(item.title),
//       controller: slidableController,
//       direction: direction,
//       dismissal: SlidableDismissal(
//         child: SlidableDrawerDismissal(),
//         onDismissed: (actionType) {
//           _showSnackBar(
//               context,
//               actionType == SlideActionType.primary
//                   ? 'Dismiss Archive'
//                   : 'Dimiss Delete');
//           setState(() {
//             items.removeAt(index);
//           });
//         },
//       ),
//       actionPane: _getActionPane(item.index),
//       actionExtentRatio: 0.25,
//       child: direction == Axis.horizontal
//           ? VerticalListItem(items[index])
//           : HorizontalListItem(items[index]),
//       actions: <Widget>[
//         IconSlideAction(
//           caption: 'Archive',
//           color: Colors.blue,
//           icon: Icons.archive,
//           onTap: () => _showSnackBar(context, 'Archive'),
//         ),
//         IconSlideAction(
//           caption: 'Share',
//           color: Colors.indigo,
//           icon: Icons.share,
//           onTap: () => _showSnackBar(context, 'Share'),
//         ),
//       ],
//       secondaryActions: <Widget>[
//         Container(
//           height: 800,
//           color: Colors.green,
//           child: Text('a'),
//         ),
//         IconSlideAction(
//           caption: 'More',
//           color: Colors.grey.shade200,
//           icon: Icons.more_horiz,
//           onTap: () => _showSnackBar(context, 'More'),
//           closeOnTap: false,
//         ),
//         IconSlideAction(
//           caption: 'Delete',
//           color: Colors.red,
//           icon: Icons.delete,
//           onTap: () => _showSnackBar(context, 'Delete'),
//         ),
//       ],
//     );
//   }

//   Widget _getSlidableWithDelegates(
//       BuildContext context, int index, Axis direction) {
//     final _HomeItem item = items[index];

//     return Slidable.builder(
//       key: Key(item.title),
//       controller: slidableController,
//       direction: direction,
//       dismissal: SlidableDismissal(
//         child: SlidableDrawerDismissal(),
//         closeOnCanceled: true,
//         onWillDismiss: (item.index != 10)
//             ? null
//             : (actionType) {
//                 return showDialog<bool>(
//                   context: context,
//                   builder: (context) {
//                     return AlertDialog(
//                       title: Text('Delete'),
//                       content: Text('Item will be deleted'),
//                       actions: <Widget>[
//                         FlatButton(
//                           child: Text('Cancel'),
//                           onPressed: () => Navigator.of(context).pop(false),
//                         ),
//                         FlatButton(
//                           child: Text('Ok'),
//                           onPressed: () => Navigator.of(context).pop(true),
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               },
//         onDismissed: (actionType) {
//           _showSnackBar(
//               context,
//               actionType == SlideActionType.primary
//                   ? 'Dismiss Archive'
//                   : 'Dimiss Delete');
//           setState(() {
//             items.removeAt(index);
//           });
//         },
//       ),
//       actionPane: _getActionPane(item.index),
//       actionExtentRatio: 0.25,
//       child: direction == Axis.horizontal
//           ? VerticalListItem(items[index])
//           : HorizontalListItem(items[index]),
//       actionDelegate: SlideActionBuilderDelegate(
//           actionCount: 2,
//           builder: (context, index, animation, renderingMode) {
//             if (index == 0) {
//               return IconSlideAction(
//                 caption: 'Archive',
//                 color: renderingMode == SlidableRenderingMode.slide
//                     ? Colors.blue.withOpacity(animation.value)
//                     : (renderingMode == SlidableRenderingMode.dismiss
//                         ? Colors.blue
//                         : Colors.green),
//                 icon: Icons.archive,
//                 onTap: () async {
//                   var state = Slidable.of(context);
//                   var dismiss = await showDialog<bool>(
//                     context: context,
//                     builder: (context) {
//                       return AlertDialog(
//                         title: Text('Delete'),
//                         content: Text('Item will be deleted'),
//                         actions: <Widget>[
//                           FlatButton(
//                             child: Text('Cancel'),
//                             onPressed: () => Navigator.of(context).pop(false),
//                           ),
//                           FlatButton(
//                             child: Text('Ok'),
//                             onPressed: () => Navigator.of(context).pop(true),
//                           ),
//                         ],
//                       );
//                     },
//                   );

//                   if (dismiss) {
//                     state.dismiss();
//                   }
//                 },
//               );
//             } else {
//               return IconSlideAction(
//                 caption: 'Share',
//                 color: renderingMode == SlidableRenderingMode.slide
//                     ? Colors.indigo.withOpacity(animation.value)
//                     : Colors.indigo,
//                 icon: Icons.share,
//                 onTap: () => _showSnackBar(context, 'Share'),
//               );
//             }
//           }),
//       secondaryActionDelegate: SlideActionBuilderDelegate(
//           actionCount: 2,
//           builder: (context, index, animation, renderingMode) {
//             if (index == 0) {
//               return IconSlideAction(
//                 caption: 'More',
//                 color: renderingMode == SlidableRenderingMode.slide
//                     ? Colors.grey.shade200.withOpacity(animation.value)
//                     : Colors.grey.shade200,
//                 icon: Icons.more_horiz,
//                 onTap: () => _showSnackBar(context, 'More'),
//                 closeOnTap: false,
//               );
//             } else {
//               return IconSlideAction(
//                 caption: 'Delete',
//                 color: renderingMode == SlidableRenderingMode.slide
//                     ? Colors.red.withOpacity(animation.value)
//                     : Colors.red,
//                 icon: Icons.delete,
//                 onTap: () => _showSnackBar(context, 'Delete'),
//               );
//             }
//           }),
//     );
//   }

//   static Widget _getActionPane(int index) {
//     switch (index % 4) {
//       case 0:
//         return SlidableBehindActionPane();
//       case 1:
//         return SlidableStrechActionPane();
//       case 2:
//         return SlidableScrollActionPane();
//       case 3:
//         return SlidableDrawerActionPane();
//       default:
//         return null;
//     }
//   }

//   static Color _getAvatarColor(int index) {
//     switch (index % 4) {
//       case 0:
//         return Colors.red;
//       case 1:
//         return Colors.green;
//       case 2:
//         return Colors.blue;
//       case 3:
//         return Colors.indigoAccent;
//       default:
//         return null;
//     }
//   }

//   static String _getSubtitle(int index) {
//     switch (index % 4) {
//       case 0:
//         return 'SlidableBehindActionPane';
//       case 1:
//         return 'SlidableStrechActionPane';
//       case 2:
//         return 'SlidableScrollActionPane';
//       case 3:
//         return 'SlidableDrawerActionPane';
//       default:
//         return null;
//     }
//   }

//   void _showSnackBar(BuildContext context, String text) {
//     Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
//   }
// }

// class HorizontalListItem extends StatelessWidget {
//   HorizontalListItem(this.item);
//   final _HomeItem item;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       width: 160.0,
//       child: Column(
//         mainAxisSize: MainAxisSize.max,
//         children: <Widget>[
//           Expanded(
//             child: CircleAvatar(
//               backgroundColor: item.color,
//               child: Text('${item.index}'),
//               foregroundColor: Colors.white,
//             ),
//           ),
//           Expanded(
//             child: Center(
//               child: Text(
//                 item.subtitle,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class VerticalListItem extends StatelessWidget {
//   VerticalListItem(this.item);
//   final _HomeItem item;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () =>
//           Slidable.of(context)?.renderingMode == SlidableRenderingMode.none
//               ? Slidable.of(context)?.open()
//               : Slidable.of(context)?.close(),
//       child: Container(
//         color: Colors.white,
//         child: ListTile(
//           leading: CircleAvatar(
//             backgroundColor: item.color,
//             child: Text('${item.index}'),
//             foregroundColor: Colors.white,
//           ),
//           title: Text(item.title),
//           subtitle: Text(item.subtitle),
//         ),
//       ),
//     );
//   }
// }

// class _HomeItem {
//   const _HomeItem(
//     this.index,
//     this.title,
//     this.subtitle,
//     this.color,
//   );

//   final int index;
//   final String title;
//   final String subtitle;
//   final Color color;
// }
