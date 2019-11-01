import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../material/carousel/carousel.dart';

final List<String> imgList = [
  'https://zos.alipayobjects.com/rmsportal/AiyWuByWklrrUDlFignR.png',
  'https://zos.alipayobjects.com/rmsportal/TekJlZRVCjLFexlOCuWn.png',
  'https://zos.alipayobjects.com/rmsportal/IJOtIlfsYdTyaDTRVrLI.png'
];

final List<Widget> child = List<Widget>.generate(imgList.length, (i) {
  return Container(
    child: Image.network(
      imgList[i],
      fit: BoxFit.cover,
      width: 1000.0,
    ),
  );
});

class PageCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Carousel'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              Text('基本'),
              Carousel(
                infinite: true,
                autoplay: true,
                frameOverflow: false,
                vertical: false,
                cellSpacing: 10.0,
                beforeChange: (Map<String, int> value) {
                  print(value);
                },
                afterChange: (int index) {
                  print('slide to $index');
                },
                dots: true,
                items: child,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text('带间距'),
              Carousel(
                infinite: true,
                autoplay: true,
                frameOverflow: true,
                vertical: false,
                cellSpacing: 10.0,
                beforeChange: (Map<String, int> value) {
                  print(value);
                },
                afterChange: (int index) {
                  print('slide to $index');
                },
                dots: true,
                items: child,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text('竖向'),
              Container(
                height: 50.0,
                child: Carousel(
                  infinite: true,
                  autoplay: true,
                  frameOverflow: false,
                  vertical: true,
                  cellSpacing: 10.0,
                  beforeChange: (Map<String, int> value) {
                    print(value);
                  },
                  afterChange: (int index) {
                    print('slide to $index');
                  },
                  dots: false,
                  items: [Text('iphone'), Text('ipad'), Text('ari pods')],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text('抽奖'),
              Container(
                height: 40.0,
                child: Carousel(
                  infinite: true,
                  autoplay: true,
                  frameOverflow: false,
                  vertical: true,
                  autoplayInterval: 500,
                  cellSpacing: 10.0,
                  beforeChange: (Map<String, int> value) {
                    print(value);
                  },
                  afterChange: (int index) {
                    print('slide to $index');
                  },
                  dots: false,
                  items: [Text('iphone'), Text('ipad'), Text('ari pods')],
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
            ],
          ),
        ));
  }
}
