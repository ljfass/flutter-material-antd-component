import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../material/list/list.dart' as AntList;

class PageList extends StatefulWidget {
  @override
  _PageListState createState() => _PageListState();
}

class _PageListState extends State<PageList> {
  double percent = 0;
  bool disabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('List'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              AntList.List(
                  itemContent: Text('Title'),
                  header: 'Basic Style',
                  onClick: () {},
                  extra: Text('extra content')),
              SizedBox(
                height: 10.0,
              ),
              AntList.List(
                itemContent: Text('Title'),
                arrow: 'horizontal',
                onClick: () {},
                // thumb:
                //     'https://zos.alipayobjects.com/rmsportal/dNuvNrtqUztHCwM.png',
                brief: Text('subTitle'),
              ),
              SizedBox(
                height: 10.0,
              ),
              AntList.List(
                itemContent: Text('ListItem（Android）'),
                brief: Text(
                    'There may have water ripple effect of material if you set the click event.'),
                arrow: 'horizontal',
                onClick: () {},
              ),
              SizedBox(
                height: 10.0,
              ),
              AntList.List(
                itemContent: Text('Title'),
                arrow: 'horizontal',
                onClick: () {},
              ),
              SizedBox(
                height: 10.0,
              ),
              AntList.List(
                itemContent: Text('Title'),
                arrow: 'horizontal',
                extra: 'extra content',
                onClick: () {},
              ),
              SizedBox(
                height: 10.0,
              ),
              AntList.List(
                itemContent: Text('Title'),
                extra: '10:30',
                thumb:
                    'https://zos.alipayobjects.com/rmsportal/dNuvNrtqUztHCwM.png',
                brief: 'subtitle',
                onClick: () {},
              ),
              SizedBox(
                height: 10.0,
              ),
              AntList.List(
                itemContent: Text('My wallet'),
                arrow: 'horizontal',
                thumb:
                    'https://zos.alipayobjects.com/rmsportal/dNuvNrtqUztHCwM.png',
                onClick: () {},
              ),
              SizedBox(
                height: 20.0,
              ),
              AntList.List(
                itemContent: Text('My Cost Ratio'),
                arrow: 'horizontal',
                thumb:
                    'https://zos.alipayobjects.com/rmsportal/UmbJMbWOejVOpxe.png',
                onClick: () {},
              ),
              SizedBox(
                height: 10.0,
              ),
              AntList.List(
                header: 'Text Wrapping',
                itemContent: Text(
                    'Single line，long text will be hidden with ellipsisSingle line，long text will be hidden with ellipsis；'),
              ),
              SizedBox(
                height: 10.0,
              ),
              AntList.List(
                header: 'Text Wrapping',
                itemContent: Text(
                    'Multiple line，long text will wrap；Long Text Long Text Long Text Long Text Long Text Long Text'),
              ),
              SizedBox(
                height: 20.0,
              ),
              AntList.List(
                header: 'Text Wrapping',
                extra: 'extra content',
                // arrow: 'empty',
                align: 'top',
                itemContent: Text(
                    ' Multiple line and long text will wrap. Long Text Long Text Long Text.Long Text Long Text Long Text.Long Text Long Text Long Text'),
              ),
              SizedBox(
                height: 10.0,
              ),
              AntList.List(
                header: 'Text Wrapping',
                extra: Switch(
                  value: true,
                  onChanged: (bool value) {},
                ),
                itemContent: Text('Confirm Information'),
              ),
              SizedBox(
                height: 10.0,
              ),
              AntList.List(
                itemContent: Slider(
                  value: 0.5,
                  onChanged: (double value) {},
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              AntList.List(
                itemContent: 'Click to disable',
                disabled: disabled,
                onClick: () {
                  setState(() {
                    disabled = true;
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ));
  }
}
