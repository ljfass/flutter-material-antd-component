import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../material/list/list.dart' as AntList;
import '../../material/swipeAction/swipeAction.dart';

class PageSwipeAction extends StatefulWidget {
  @override
  _PageSwipeActionState createState() => _PageSwipeActionState();
}

class _PageSwipeActionState extends State<PageSwipeAction> {
  SwipeActionController _swipeActionController;
  @override
  void initState() {
    super.initState();
    _swipeActionController = SwipeActionController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SwipeAction'),
        ),
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              SwipeAction(
                controller: _swipeActionController,
                disdabled: false,
                child: AntList.List(
                  itemContent: Text('Have left and right buttons'),
                  extra: 'More',
                  arrow: 'horizontal',
                  onClick: () {},
                ),
                swipeoutColor: Colors.grey,
                autoClose: true,
                right: [
                  {
                    'text': Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(color: Color(0xffdddddd)),
                        alignment: Alignment.center,
                        child: Text('Cancel')),
                  },
                  {
                    'text': Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(color: Color(0xffF4333C)),
                        alignment: Alignment.center,
                        child: Text('Delete')),
                  },
                ],
                left: [
                  {
                    'text': Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(color: Color(0xff108ee9)),
                        alignment: Alignment.center,
                        child: Text('Reply')),
                  },
                  {
                    'text': Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(color: Color(0xffdddddd)),
                        alignment: Alignment.center,
                        child: Text('Cancel')),
                  },
                ],
                onOpen: () {
                  print('global open');
                },
                onClose: () {
                  print('global close');
                },
              ),
              SwipeAction(
                child: AntList.List(
                  itemContent: Text('Only left buttons'),
                  extra: 'More',
                  arrow: 'horizontal',
                  onClick: () {},
                ),
                swipeoutColor: Colors.grey,
                autoClose: true,
                left: [
                  {
                    'text': Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(color: Color(0xff108ee9)),
                        alignment: Alignment.center,
                        child: Text('Reply')),
                  },
                  {
                    'text': Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(color: Color(0xffdddddd)),
                        alignment: Alignment.center,
                        child: Text('Cancel')),
                  },
                ],
              ),
              SwipeAction(
                child: AntList.List(
                  itemContent: Text('Only right buttons'),
                  extra: 'More',
                  arrow: 'horizontal',
                  onClick: () {},
                ),
                swipeoutColor: Colors.grey,
                autoClose: true,
                right: [
                  {
                    'text': Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(color: Color(0xffdddddd)),
                        alignment: Alignment.center,
                        child: Text('Cancel')),
                  },
                  {
                    'text': Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(color: Color(0xffF4333C)),
                        alignment: Alignment.center,
                        child: Text('Delete')),
                  },
                ],
              ),
              SwipeAction(
                child: AntList.List(
                  itemContent: Text('Different button width'),
                  extra: 'More',
                  arrow: 'horizontal',
                  onClick: () {},
                ),
                swipeoutColor: Colors.grey,
                autoClose: true,
                right: [
                  {
                    'text': Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(color: Color(0xfff4333c)),
                        alignment: Alignment.center,
                        child: Text('short')),
                    'onPress': () {
                      print('button1 clicked!');
                    }
                  },
                  {
                    'text': Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(color: Color(0xffdddddd)),
                        alignment: Alignment.center,
                        child: Text('long text')),
                    'onPress': () {
                      print('button2 clicked!');
                    }
                  },
                ],
              ),
              SwipeAction(
                child: AntList.List(
                  itemContent: Text(' List.Item with onClick'),
                  extra: 'More',
                  arrow: 'horizontal',
                  onClick: () {
                    print('List.Item is clicked!');
                  },
                ),
                swipeoutColor: Colors.grey,
                autoClose: true,
                right: [
                  {
                    'text': Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(color: Color(0xfff4333c)),
                        alignment: Alignment.center,
                        child: Text('button1')),
                    'onPress': () {
                      print('button1 clicked!');
                    }
                  },
                  {
                    'text': Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(color: Color(0xffdddddd)),
                        alignment: Alignment.center,
                        child: Text('button2')),
                    'onPress': () {
                      print('button2 clicked!');
                    }
                  },
                ],
              ),
            ],
          ),
        ));
  }
}

// import 'package:flutter/material.dart';

// class SwipeListItemDemoPage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => new _SwipeListItemDemoPagePageState();
// }

// class _SwipeListItemDemoPagePageState extends State<SwipeListItemDemoPage> {
//   final items = List<String>.generate(10, (i) => "Item $i");
//   @override
//   void initState() {
//     super.initState();
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: new AppBar(
//         title: new Text('SwipeListItem Demo'),
//       ),
//       body: new ListView(
//         children: ListTile.divideTiles(
//           context: context,
//           tiles: new List.generate(10, (index) {
//             final item = items[index];
//             return Builder(
//               builder: (ctx) => _buildSlideMenuItem(ctx, index, item),
//             );
//           }),
//         ).toList(),
//       ),
//     );
//   }

//   Widget _buildSlideMenuItem(BuildContext context, index, item) {
//     return new SlideMenu(
//       child: new ListTile(
//         leading: new CircleAvatar(
//           backgroundColor: Colors.indigoAccent,
//           child: new Text('$index'),
//           foregroundColor: Colors.white,
//         ),
//         title: new Text('Tile No. $index'),
//         subtitle: new Text('http://www.appblog.cn'),
//       ),
//       menuItems: <Widget>[
//         new Container(
//           color: Colors.red,
//           child: new IconButton(
//             icon: new Icon(Icons.delete),
//             color: Colors.white,
//             onPressed: () => Scaffold.of(context)
//                 .showSnackBar(SnackBar(content: Text("$item Delete"))),
//           ),
//         ),
//         new Container(
//           color: Colors.blue,
//           child: new IconButton(
//             icon: new Icon(Icons.info),
//             color: Colors.white,
//             onPressed: () => Scaffold.of(context)
//                 .showSnackBar(SnackBar(content: Text("$item Info"))),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class SlideMenu extends StatefulWidget {
//   final Widget child;
//   final List<Widget> menuItems;
//   SlideMenu({this.child, this.menuItems});
//   @override
//   _SlideMenuState createState() => new _SlideMenuState();
// }

// class _SlideMenuState extends State<SlideMenu>
//     with SingleTickerProviderStateMixin {
//   AnimationController _controller;
//   @override
//   initState() {
//     super.initState();
//     _controller = new AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 200));
//   }

//   @override
//   dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final animation = new Tween(
//             begin: const Offset(0.0, 0.0), end: const Offset(-0.4, 0.0))
//         .animate(new CurveTween(curve: Curves.decelerate).animate(_controller));
//     return new GestureDetector(
//       onHorizontalDragUpdate: (data) {
//         // we can access context.size here
//         setState(() {
//           _controller.value -= data.primaryDelta / context.size.width;
//         });
//       },
//       onHorizontalDragEnd: (data) {
//         if (data.primaryVelocity > 2000)
//           _controller
//               .animateTo(.0); //close menu on fast swipe in the right direction
//         else if (_controller.value >= .5 ||
//             data.primaryVelocity <
//                 -2000) // fully open if dragged a lot to left or on fast swipe to left
//           _controller.animateTo(1.0);
//         else // close if none of above
//           _controller.animateTo(.0);
//       },
//       child: new Stack(
//         children: <Widget>[
//           new SlideTransition(position: animation, child: widget.child),
//           new Positioned.fill(
//             child: new LayoutBuilder(
//               builder: (context, constraint) {
//                 return new AnimatedBuilder(
//                   animation: _controller,
//                   builder: (context, child) {
//                     return new Stack(
//                       children: <Widget>[
//                         new Positioned(
//                           right: .0,
//                           top: .0,
//                           bottom: .0,
//                           width: constraint.maxWidth * animation.value.dx * -1,
//                           child: Row(
//                             children: widget.menuItems.map((child) {
//                               return Expanded(
//                                 child: Container(
//                                   height: double.infinity,
//                                   child: child,
//                                 ),
//                               );
//                             }).toList(),
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
