import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../material/imagePicker/imagePicker.dart';

class PageImagePicker extends StatefulWidget {
  @override
  _PageImagePickerState createState() => _PageImagePickerState();
}

class _PageImagePickerState extends State<PageImagePicker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ImagePicker'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Text('default'),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: AntImagePicker(
                  files: [
                    {'url': ''},
                    {
                      'url':
                          'https://zos.alipayobjects.com/rmsportal/PZUUCKTRIHWiZSY.jpeg'
                    },
                    {
                      'url':
                          'https://zos.alipayobjects.com/rmsportal/hqQWgTXdrlmVVYi.jpeg'
                    },
                    {
                      'url':
                          'https://zos.alipayobjects.com/rmsportal/PZUUCKTRIHWiZSY.jpeg'
                    },
                    {
                      'url':
                          'https://zos.alipayobjects.com/rmsportal/hqQWgTXdrlmVVYi.jpeg'
                    },
                  ],
                  onChange: (value) {
                    print(value);
                  },
                  onImageClick: (Map<String, dynamic> value) {
                    print(value);
                  },
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text('custom the length'),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: AntImagePicker(
                  files: [
                    {'url': ''},
                    {
                      'url':
                          'https://zos.alipayobjects.com/rmsportal/PZUUCKTRIHWiZSY.jpeg'
                    },
                    {
                      'url':
                          'https://zos.alipayobjects.com/rmsportal/hqQWgTXdrlmVVYi.jpeg'
                    },
                    {
                      'url':
                          'https://zos.alipayobjects.com/rmsportal/PZUUCKTRIHWiZSY.jpeg'
                    },
                    {
                      'url':
                          'https://zos.alipayobjects.com/rmsportal/hqQWgTXdrlmVVYi.jpeg'
                    },
                  ],
                  length: 6,
                  // disableDelete: true,
                  onChange: (value) {
                    print(value);
                  },
                  onImageClick: (Map<String, dynamic> value) {
                    print(value);
                  },
                ),
              )
            ],
          ),
        ));
  }
}
