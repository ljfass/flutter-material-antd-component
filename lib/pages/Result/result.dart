import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../material/result/result.dart';

class PageResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Result'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Result(
                imgUrl:
                    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1571138078130&di=71ed99ebc2a07e373a3789f998f5d9bb&imgtype=0&src=http%3A%2F%2Fwww.xdowns.com%2Fattachment%2Fsyapp%2Flogo%2F201807191532012573.jpg',
                title: '验证成功',
                message: '所提交内容已完成验证',
                buttonType: 'primary',
                buttonText: '按钮',
                onButtonClick: () {
                  print('hahha');
                },
              )
            ],
          ),
        ));
  }
}
