import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../material/carousel/carousel.dart';

class PageCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Carousel'),
        ),
        body: Container(
          width: 400,
          decoration: BoxDecoration(border: Border.all(color: Colors.green)),
          child: Carousel(
            infinite: true,
            autoplay: false,
            frameOverflow: false,
            vertical: false,
            cellSpacing: 0.0,
            selectedIndex: 2,
            beforeChange: (Map<String, int> value) {
              print(value);
            },
            dots: true,
            items: <Widget>[
              Container(
                width: 300,
                height: 200.0,
                decoration: BoxDecoration(color: Colors.red),
                child: Text(
                  '1',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                  width: 300,
                  height: 200.0,
                  decoration: BoxDecoration(color: Colors.purple),
                  child: Text(
                    '2',
                    style: TextStyle(color: Colors.white),
                  )),
              Container(
                  width: 300,
                  height: 200.0,
                  decoration: BoxDecoration(color: Colors.green),
                  child: Text(
                    '3',
                    style: TextStyle(color: Colors.white),
                  )),
              Container(
                  width: 300,
                  height: 200.0,
                  decoration: BoxDecoration(color: Colors.red),
                  child: Text(
                    '4',
                    style: TextStyle(color: Colors.white),
                  )),
              Container(
                  width: 300,
                  height: 200.0,
                  decoration: BoxDecoration(color: Colors.purple),
                  child: Text(
                    '5',
                    style: TextStyle(color: Colors.white),
                  )),
              Container(
                  width: 300,
                  height: 200.0,
                  decoration: BoxDecoration(color: Colors.yellow),
                  child: Text(
                    '6',
                    style: TextStyle(color: Colors.white),
                  )),
              Container(
                  width: 300,
                  height: 200.0,
                  decoration: BoxDecoration(color: Colors.black),
                  child: Text(
                    '7',
                    style: TextStyle(color: Colors.white),
                  )),
              Container(
                  width: 300,
                  height: 200.0,
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Text(
                    '8',
                    style: TextStyle(color: Colors.white),
                  )),
              Container(
                  width: 300,
                  height: 200.0,
                  decoration: BoxDecoration(color: Colors.orange),
                  child: Text(
                    '9',
                    style: TextStyle(color: Colors.white),
                  )),
              Container(
                  width: 300,
                  height: 200.0,
                  decoration: BoxDecoration(color: Colors.pink),
                  child: Text(
                    '10',
                    style: TextStyle(color: Colors.white),
                  )),
              Container(
                  width: 300,
                  height: 200.0,
                  decoration: BoxDecoration(color: Colors.amber),
                  child: Text(
                    '11',
                    style: TextStyle(color: Colors.white),
                  )),
              Container(
                  width: 300,
                  height: 200.0,
                  decoration: BoxDecoration(color: Colors.cyan),
                  child: Text(
                    '1',
                    style: TextStyle(color: Colors.white),
                  )),
              Container(
                  width: 300,
                  height: 200.0,
                  decoration: BoxDecoration(color: Colors.grey),
                  child: Text(
                    '12',
                    style: TextStyle(color: Colors.white),
                  )),
              Container(
                  width: 300,
                  height: 200.0,
                  decoration: BoxDecoration(color: Colors.brown),
                  child: Text(
                    '13',
                    style: TextStyle(color: Colors.white),
                  )),
              Container(
                  width: 300,
                  height: 200.0,
                  decoration: BoxDecoration(color: Colors.green),
                  child: Text(
                    '14',
                    style: TextStyle(color: Colors.white),
                  )),
              Container(
                  width: 300,
                  height: 200.0,
                  decoration: BoxDecoration(color: Colors.red),
                  child: Text(
                    '15',
                    style: TextStyle(color: Colors.white),
                  )),
              Container(
                  width: 300,
                  height: 200.0,
                  decoration: BoxDecoration(color: Colors.purple),
                  child: Text(
                    '16',
                    style: TextStyle(color: Colors.white),
                  )),
              Container(
                  width: 300,
                  height: 200.0,
                  decoration: BoxDecoration(color: Colors.green),
                  child: Text(
                    '17',
                    style: TextStyle(color: Colors.white),
                  )),
              Container(
                  // width: 300,
                  height: 200.0,
                  decoration: BoxDecoration(color: Colors.red),
                  child: Text(
                    '18',
                    style: TextStyle(color: Colors.white),
                  )),
              Container(
                  width: 300,
                  height: 200.0,
                  decoration: BoxDecoration(color: Colors.purple),
                  child: Text(
                    '19',
                    style: TextStyle(color: Colors.white),
                  )),
              Container(
                  width: 300,
                  height: 200.0,
                  decoration: BoxDecoration(color: Colors.green),
                  child: Text(
                    '20',
                    style: TextStyle(color: Colors.white),
                  )),
              Container(
                  width: 300,
                  height: 200.0,
                  decoration: BoxDecoration(color: Colors.red),
                  child: Text(
                    '21',
                    style: TextStyle(color: Colors.white),
                  )),
              Container(
                  width: 300,
                  height: 200.0,
                  decoration: BoxDecoration(color: Colors.purple),
                  child: Text(
                    '22',
                    style: TextStyle(color: Colors.white),
                  )),
              Container(
                  width: 300,
                  height: 200.0,
                  decoration: BoxDecoration(color: Colors.indigo),
                  child: Text(
                    '23',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ));
  }
}
