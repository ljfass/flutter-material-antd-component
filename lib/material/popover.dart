import 'package:flutter/material.dart';

class Popover extends StatefulWidget {
  @override
  _PopoverState createState() => _PopoverState();
}

class _PopoverState extends State<Popover> {
  bool show = false;
  double dx;
  double dy;
  GlobalKey _key = GlobalKey();

  showLoaderOverlay(BuildContext context) {
    final entry = OverlayEntry(builder: (context) {
      return AbsorbPointer(
        child: SafeArea(
          child: Center(
            child: Container(
              decoration:
                  BoxDecoration(color: Color(0xff000000).withOpacity(0.4)),
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Center(),
            ),
          ),
        ),
      );
    });

    Overlay.of(context).insert(entry);
  }

  @override
  Widget build(BuildContext context) {
    // showLoaderOverlay(context);
    return Center(
      child: this.show == true
          ? InkWell(
              child: Text('hi'),
              onTap: () {
                print('xiexie');
              },
            )
          : IconButton(
              key: _key,
              onPressed: () {
                setState(() {
                  this.show = true;
                });
                showLoaderOverlay(context);
                final newEntry = OverlayEntry(builder: (context) {
                  return AbsorbPointer(
                    child: SafeArea(
                      child: Material(
                        child: Center(
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                left: dx,
                                top: dy,
                                child: Container(
                                  decoration:
                                      BoxDecoration(color: Colors.white),
                                  width: 160,
                                  height: 60,
                                  child: IconButton(
                                    icon: Icon(Icons.satellite),
                                    onPressed: () {
                                      print('button');
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
                Overlay.of(context).insert(newEntry);
                final RenderBox renderBoxRed =
                    _key.currentContext.findRenderObject();
                final positionRed = renderBoxRed.localToGlobal(Offset.zero);
                setState(() {
                  this.dx = positionRed.dx + 20;
                  this.dy = positionRed.dy;
                });
              },
              icon: Icon(Icons.ac_unit),
            ),
    );
  }
}
