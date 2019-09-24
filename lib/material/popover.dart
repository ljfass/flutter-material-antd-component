import 'package:flutter/material.dart';

class Popover extends StatefulWidget {
  @override
  _PopoverState createState() => _PopoverState();
}

class _PopoverState extends State<Popover> {
  bool show = false;
  double dx;
  double dy;
  OverlayEntry _entry;
  OverlayEntry entry;
  GlobalKey _key = GlobalKey();

  @override
  void dispose() {
    super.dispose();
    _entry.remove();
    entry.remove();
  }

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

  final _layerLink = LayerLink();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        key: _key,
        onPressed: () {
          setState(() {
            this.show = true;
          });
          showLoaderOverlay(context);
          _entry = OverlayEntry(builder: (_) {
            final RenderBox renderBoxRed = context.findRenderObject();
            final position = renderBoxRed.localToGlobal(Offset.zero);
            final size = renderBoxRed.size;

            return Positioned(
              left: dx,
              top: dy + 40,
              child: CompositedTransformFollower(
                link: _layerLink,
                offset: Offset(0, (position.dy + size.height)),
                child: Material(
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    width: 160,
                    height: 200,
                    child: Column(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.access_alarms),
                          onPressed: () {
                            print(1);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.access_alarms),
                          onPressed: () {
                            print(2);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.access_alarms),
                          onPressed: () {
                            print(3);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.access_alarms),
                          onPressed: () {
                            print(4);
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
          Overlay.of(context).insert(_entry);
          final RenderBox renderBoxRed = _key.currentContext.findRenderObject();
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
