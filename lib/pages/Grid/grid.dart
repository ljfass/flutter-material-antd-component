import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../material/grid/grid.dart';

class PageGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Grid'),
        ),
        body: Container(
          padding: EdgeInsets.all(10.0),
          width: MediaQuery.of(context).size.width,
          child: Grid(
            hasLine: true,
            columnNum: 2,
            isCarousel: true,
            onClick: (value) {
              print(value);
            },
            data: [
              {
                'icon':
                    'https://gw.alipayobjects.com/zos/rmsportal/WXoqXTHrSnRcUwEaQgXJ.png',
                'text': 'title1'
              },
              {
                'icon':
                    'https://gw.alipayobjects.com/zos/rmsportal/WXoqXTHrSnRcUwEaQgXJ.png',
                'text': 'title2'
              },
              {
                'icon':
                    'https://gw.alipayobjects.com/zos/rmsportal/WXoqXTHrSnRcUwEaQgXJ.png',
                'text': 'title3'
              },
              {
                'icon':
                    'https://gw.alipayobjects.com/zos/rmsportal/WXoqXTHrSnRcUwEaQgXJ.png',
                'text': 'title4'
              },
              {
                'icon':
                    'https://gw.alipayobjects.com/zos/rmsportal/WXoqXTHrSnRcUwEaQgXJ.png',
                'text': 'title5'
              },
              {
                'icon':
                    'https://gw.alipayobjects.com/zos/rmsportal/WXoqXTHrSnRcUwEaQgXJ.png',
                'text': 'title6'
              },
              {
                'icon':
                    'https://gw.alipayobjects.com/zos/rmsportal/WXoqXTHrSnRcUwEaQgXJ.png',
                'text': 'title7'
              },
              {
                'icon':
                    'https://gw.alipayobjects.com/zos/rmsportal/WXoqXTHrSnRcUwEaQgXJ.png',
                'text': 'title8'
              },
              {
                'icon':
                    'https://gw.alipayobjects.com/zos/rmsportal/WXoqXTHrSnRcUwEaQgXJ.png',
                'text': 'title9'
              }
            ],
          ),
        ));
  }
}
