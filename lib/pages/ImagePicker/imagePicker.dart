import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../material/imagePicker/imagePicker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

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
        body: Center(
          child: Container(
            width: 400.0,
            padding: EdgeInsets.symmetric(horizontal: 15.0),
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
          ),
        ));
  }
}
