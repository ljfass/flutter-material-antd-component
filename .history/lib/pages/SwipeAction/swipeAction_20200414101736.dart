import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../material/list/list.dart' as AntList;
import '../../material/swipeAction/swipeAction.dart';

class PageSwipeAction extends StatefulWidget {
  @override
  _PageSwipeActionState createState() => _PageSwipeActionState();
}

class _PageSwipeActionState extends State<PageSwipeAction> {
  @override
  void initState() {
    super.initState();
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
              // SwipeAction(
              //   disdabled: false,
              //   child: AntList.List(
              //     itemContent: Text('Have left and right buttons'),
              //     extra: 'More',
              //     arrow: 'horizontal',
              //     onClick: () {},
              //   ),
              //   swipeoutColor: Colors.grey,
              //   autoClose: true,
              //   right: [
              //     {
              //       'text': Container(
              //           padding: EdgeInsets.symmetric(horizontal: 8.0),
              //           decoration: BoxDecoration(color: Color(0xffdddddd)),
              //           alignment: Alignment.center,
              //           child: Text('Cancel')),
              //     },
              //     {
              //       'text': Container(
              //           padding: EdgeInsets.symmetric(horizontal: 8.0),
              //           decoration: BoxDecoration(color: Color(0xffF4333C)),
              //           alignment: Alignment.center,
              //           child: Text('Delete')),
              //     },
              //   ],
              //   left: [
              //     {
              //       'text': Container(
              //           padding: EdgeInsets.symmetric(horizontal: 8.0),
              //           decoration: BoxDecoration(color: Color(0xff108ee9)),
              //           alignment: Alignment.center,
              //           child: Text('Reply')),
              //     },
              //     {
              //       'text': Container(
              //           padding: EdgeInsets.symmetric(horizontal: 8.0),
              //           decoration: BoxDecoration(color: Color(0xffdddddd)),
              //           alignment: Alignment.center,
              //           child: Text('Cancel')),
              //     },
              //   ],
              //   onOpen: () {
              //     print('global open');
              //   },
              //   onClose: () {
              //     print('global close');
              //   },
              // ),
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
              // SwipeAction(
              //   child: AntList.List(
              //     itemContent: Text('Only right buttons'),
              //     extra: 'More',
              //     arrow: 'horizontal',
              //     onClick: () {},
              //   ),
              //   swipeoutColor: Colors.grey,
              //   autoClose: true,
              //   right: [
              //     {
              //       'text': Container(
              //           padding: EdgeInsets.symmetric(horizontal: 8.0),
              //           decoration: BoxDecoration(color: Color(0xffdddddd)),
              //           alignment: Alignment.center,
              //           child: Text('Cancel')),
              //     },
              //     {
              //       'text': Container(
              //           padding: EdgeInsets.symmetric(horizontal: 8.0),
              //           decoration: BoxDecoration(color: Color(0xffF4333C)),
              //           alignment: Alignment.center,
              //           child: Text('Delete')),
              //     },
              //   ],
              // ),
              SwipeAction(
                controller: SlidableController(),
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
                controller: SlidableController(),
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
