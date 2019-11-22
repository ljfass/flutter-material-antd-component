import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';

class AntImagePicker extends StatefulWidget {
  AntImagePicker(
      {Key key,
      this.files,
      this.selectable = true,
      this.multiple = false,
      this.length = 4,
      this.disableDelete = false,
      this.onChange,
      this.onImageClick,
      this.onAddImageClick,
      this.onFail,
      this.accept})
      : super(key: key);
  final List<Map<String, String>> files;
  final bool selectable;
  final bool multiple;
  final int length;
  final bool disableDelete;
  final List<String> accept;
  final ValueChanged<Map<String, dynamic>> onChange;
  final ValueChanged<Map<String, dynamic>> onImageClick;
  final VoidCallback onAddImageClick;
  final ValueChanged<String> onFail;

  @override
  _AntImagePickerState createState() => _AntImagePickerState();
}

class _AntImagePickerState extends State<AntImagePicker> {
  List<dynamic> _files = [];
  List<Map<String, dynamic>> objectlist = [];

  Future getImage({int index, ImageSource source}) async {
    var imageFile = await ImagePicker.pickImage(source: source);
    if (imageFile != null) {
      setState(() {
        _files[index] = imageFile;

        _handleOnChange(file: imageFile);
        if (index == _files.length - 1 && widget.selectable == true) {
          _files.add('');
        }
      });
      _buildSelectImage(index: index, file: imageFile);
    }
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.files.length; i++) {
      if (widget.files[i]['url'] == '' || widget.files[i]['url'] == null)
        continue;
      objectlist.add(widget.files[i]);
      _files.add(widget.files[i]['url']);
    }
    if (widget.selectable == true) _files.add('');
  }

  Widget _buildPickerWidget({int i, dynamic url}) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Color(0xffdddddd),
      onTap: () async {
        if (url == '') {
          // 添加图片
          if (widget.onAddImageClick != null) widget.onAddImageClick();
          if (Platform.isAndroid) _buildAndroidModalSelection(context, i);
          if (Platform.isIOS) _buildIosModalSelection(context, i);
        }
        if (widget.onImageClick != null && url != '') {
          widget.onImageClick({'index': i, 'object': this.objectlist});
        }
      },
      child: Stack(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.0,
            child: url == ''
                ? _buildSelectable()
                : Container(
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(3.0)),
                        child: url is String
                            ? Image.network(
                                url,
                                fit: BoxFit.fill,
                              )
                            : Image.file(
                                url,
                                fit: BoxFit.fill,
                              )),
                  ),
          ),
          Positioned(
            right: 6.0,
            top: 6.0,
            child: _buildClearWidget(
                show: widget.disableDelete == true
                    ? false
                    : url == '' ? false : true,
                callback: url == ''
                    ? null
                    : () {
                        _removeImage(i);
                      }),
          )
        ],
      ),
    );
  }

  void _buildAndroidModalSelection(BuildContext ctx, int index) {
    showDialog(
        context: ctx,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
              '上传文件',
              style: TextStyle(color: Colors.grey, fontSize: 12.0),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    Navigator.of(context).pop();
                    await getImage(index: index, source: ImageSource.camera);
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text('拍照'),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.of(context).pop();
                    await getImage(index: index, source: ImageSource.gallery);
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text('照片'),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  void _buildIosModalSelection(BuildContext ctx, int index) {
    showCupertinoModalPopup<void>(
        context: ctx,
        builder: (ctx) {
          return CupertinoActionSheet(
            actions: <Widget>[
              CupertinoActionSheetAction(
                onPressed: () async {
                  await getImage(index: index, source: ImageSource.camera);
                },
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '拍照',
                          style: TextStyle(color: Colors.black),
                        ),
                        Icon(
                          CupertinoIcons.photo_camera_solid,
                          color: CupertinoTheme.of(context).primaryColor,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              CupertinoActionSheetAction(
                onPressed: () async {
                  await getImage(index: index, source: ImageSource.gallery);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '图片图库',
                      style: TextStyle(color: Colors.black),
                    ),
                    Icon(
                      CupertinoIcons.collections,
                      color: CupertinoTheme.of(context).primaryColor,
                    )
                  ],
                ),
              )
            ],
            cancelButton: CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text("取消")),
          );
        });
  }

  void _removeImage(int index) {
    setState(() {
      this._files.removeAt(index);
      _handleOnChange(index: index);
    });
  }

  void _buildSelectImage({int index, File file}) {
    Platform.isAndroid
        ? FutureBuilder<void>(
            future: retrieveLostData(index: index),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const Text(
                    '加载中...',
                    textAlign: TextAlign.center,
                  );
                case ConnectionState.done:
                  {}
                  break;
                default:
                  {
                    if (snapshot.hasError) {
                      _handleOnFail(snapshot.error.toString());
                    }
                  }
              }
            },
          )
        : _showImage(index: index, file: file);
  }

  void _handleOnChange({int index, File file}) {
    if (widget.onChange != null) {
      if (index == null) {
        this.objectlist.add({'url': file});
        widget.onChange({'files': this.objectlist, 'operationType': 'add'});
      } else {
        this.objectlist.removeAt(index);
        widget.onChange({
          'files': this.objectlist,
          'operationType': 'delete',
          'index': index
        });
      }
    }
  }

  void _handleOnFail(String msg) {
    if (widget.onFail != null) {
      widget.onFail(msg);
    }
  }

  void _showImage({int index, File file}) {
    setState(() {
      this._files[index] = file;
    });
  }

  retrieveLostData({int index}) async {
    final LostDataResponse response = await ImagePicker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _files[index] = response.file;
        _handleOnChange(file: response.file);
      });
    } else {
      if (response.exception.message != null) {
        _handleOnFail(response.exception.message);
      }
    }
  }

  Widget _buildSelectable() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
          border: Border.all(color: Color(0xffdddddd))),
      alignment: Alignment.center,
      child: _buildSelectableCross(),
    );
  }

  Widget _buildSelectableCross() {
    return CustomPaint(
      painter: CrossPainter(),
    );
  }

  Widget _buildClearWidget({bool show = true, VoidCallback callback}) {
    return Visibility(
      visible: show,
      child: GestureDetector(
        onTap: callback ?? null,
        child: Container(
          width: 14.0,
          height: 14.0,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff000000).withOpacity(0.3)),
          child: Align(
            alignment: Alignment.center,
            child: Icon(
              Icons.close,
              size: 11.0,
              color: Color(0xffffffff),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageGridView(List<Widget> _children) {
    return GridView(
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.length,
          mainAxisSpacing: 15.0,
          crossAxisSpacing: 6.0,
          childAspectRatio: 1.0),
      children: _children,
      physics: NeverScrollableScrollPhysics(),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> roslist = [];
    for (int i = 0, l = _files.length; i < l; i++) {
      roslist.add(_buildPickerWidget(i: i, url: _files[i]));
    }
    return _buildImageGridView(roslist);
  }
}

class CrossPainter extends CustomPainter {
  CrossPainter({this.size});

  final String size;

  @override
  void paint(Canvas canvas, Size size) {
    final p1 = Offset(0, -12.0);
    final p2 = Offset(0, 12.0);
    final paint = Paint()
      ..color = Color(0xffcccccc)
      ..strokeWidth = 1.0;
    canvas.drawLine(p1, p2, paint);

    final _p1 = Offset(-12, 0);
    final _p2 = Offset(12.0, 0);
    final _paint = Paint()
      ..color = Color(0xffcccccc)
      ..strokeWidth = 1.0;
    canvas.drawLine(_p1, _p2, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
