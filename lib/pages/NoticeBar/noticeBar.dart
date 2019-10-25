import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../material/noticebar/noticebar.dart';
import '../../material/modal/modal.dart';

class PageNoticeBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('NoticeBar'),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              NoticeBar(
                loop: true,
                noticeText:
                    'Notice: The arrival time of incomes and transfers of Yu &#39;E Bao will be delayed during National Day.',
              ),
              SizedBox(
                height: 20.0,
              ),
              NoticeBar(
                loop: false,
                mode: 'link',
                onClick: () {
                  Modal.show(context,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('https://flutter.dev'),
                          Text(
                            '1',
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                      maskClosable: true,
                      transparent: true,
                      footer: [
                        {'text': '确定'}
                      ]);
                },
                noticeText:
                    'Notice: The arrival time of incomes and transfers of Yu &#39;E Bao will be delayed during National Day.',
              ),
              SizedBox(
                height: 20.0,
              ),
              NoticeBar(
                loop: false,
                icon: null,
                mode: 'closable',
                noticeText: 'Remove the default icon.',
              ),
              SizedBox(
                height: 20.0,
              ),
              NoticeBar(
                loop: false,
                icon: Icons.check_circle_outline,
                mode: 'closable',
                noticeText: 'Customized icon.',
              ),
              SizedBox(
                height: 20.0,
              ),
              NoticeBar(
                loop: false,
                action: Text(
                  '不再提示',
                  style: TextStyle(color: Colors.grey),
                ),
                mode: 'closable',
                noticeText: 'Link demo for `actionText`.',
              ),
              SizedBox(
                height: 20.0,
              ),
              NoticeBar(
                loop: false,
                action: Text(
                  '去看看',
                  style: TextStyle(color: Color(0xfff76a24)),
                ),
                mode: 'link',
                noticeText: 'Closable demo for `actionText`.',
              )
            ],
          ),
        ));
  }
}
