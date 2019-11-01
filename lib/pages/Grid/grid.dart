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
          height: 159.0,
          // decoration: BoxDecoration(color: Colors.yellow),
          width: MediaQuery.of(context).size.width,
          child: Grid(
            hasLine: true,
            infinite: true,
            dots: true,
            columnNum: 5,
            autoplay: true,
            isCarousel: true,
            renderItem: Container(
              width: 30.0,
              height: 60.0,
              child: Image.network(
                  'https://gw.alipayobjects.com/zos/rmsportal/nywPmnTAvTmLusPxHPSu.png'),
            ),
            afterChange: (int value) {
              print(value);
            },
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
              },
              {
                'icon':
                    'https://gw.alipayobjects.com/zos/rmsportal/WXoqXTHrSnRcUwEaQgXJ.png',
                'text': 'title10'
              },
              {
                'icon':
                    'https://gw.alipayobjects.com/zos/rmsportal/WXoqXTHrSnRcUwEaQgXJ.png',
                'text': 'title11'
              },
              {
                'icon':
                    'https://gw.alipayobjects.com/zos/rmsportal/WXoqXTHrSnRcUwEaQgXJ.png',
                'text': 'title12'
              },
              {
                'icon':
                    'https://gw.alipayobjects.com/zos/rmsportal/WXoqXTHrSnRcUwEaQgXJ.png',
                'text': 'title13'
              }
            ],
          ),
        ));
  }
}
