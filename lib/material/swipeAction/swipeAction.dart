import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../button/button.dart';

class SwipeAction extends StatefulWidget {
  SwipeAction(
      {Key key,
      this.left,
      this.right,
      this.autoClose = false,
      this.disdabled = false,
      this.onClose,
      this.onOpen})
      : super(key: key);
  final bool autoClose;
  final List<Map<String, dynamic>> left;
  final List<Map<String, dynamic>> right;
  final bool disdabled;
  final VoidCallback onOpen;
  final VoidCallback onClose;

  @override
  _SwipeActionState createState() => _SwipeActionState();
}

class _SwipeActionState extends State<SwipeAction>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Offset> _animation;

  Curve _kResizeTimeCurve = Curves.decelerate;
  Duration _duration = Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: _duration, vsync: this);

    _animation = Tween<Offset>(begin: Offset.zero, end: Offset(-0.4, 0.0))
        .animate(CurvedAnimation(
            parent: _animationController, curve: _kResizeTimeCurve));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<Widget> _buildLeftActions() {
    List<Widget> _actions = [];
    if (widget.left == null || widget.left.length == 0) return [];
    widget.left.asMap().forEach((int index, Map<String, dynamic> button) {
      _actions.add(GestureDetector(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(color: Colors.red),
          alignment: Alignment.center,
          child: Text(
            button['text'],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ));
    });
    return _actions;
  }

  List<Widget> _buildRightActions() {
    List<Widget> _actions = [];
    if (widget.right == null || widget.right.length == 0) return [];
    widget.right.asMap().forEach((int index, Map<String, dynamic> button) {
      _actions.add(Flexible(
        flex: 1,
        child: GestureDetector(
          child: Container(
            alignment: Alignment.center,
            child: Text(
              button['text'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ));
    });
    return _actions;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (widget.left == null && widget.right == null)
          ? null
          : (DragUpdateDetails detials) {
              if (_animationController.value > 0.65) return;
              setState(() {
                _animationController.value -=
                    detials.primaryDelta / context.size.width;
              });
            },
      onHorizontalDragEnd: (widget.left == null && widget.right == null)
          ? null
          : (DragEndDetails details) {
              if (details.primaryVelocity > 2000) {
                _animationController.animateTo(.0);
                if (widget.onClose != null) widget.onClose();
              } else if (_animationController.value >= .26 ||
                  details.primaryVelocity < -2000) // 完成打开
              {
                if (widget.onOpen != null) widget.onOpen();
                _animationController.animateTo(0.65);
              } else // close if none of above
                _animationController.animateTo(.0);
              if (widget.onClose != null) widget.onClose();
            },
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            right: 0.0,
            top: 0.0,
            child: LayoutBuilder(
              builder: (_, constraint) {
                return Stack(
                  children: <Widget>[
                    Positioned(
                      right: .0,
                      top: .0,
                      bottom: .0,
                      child: Row(
                        children: _buildLeftActions(),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          SlideTransition(
            position: _animation,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 40.0,
              decoration: BoxDecoration(color: Colors.white),
              child: Text('slidable widget'),
            ),
          ),
        ],
      ),
    );
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
//         print(_controller);
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
