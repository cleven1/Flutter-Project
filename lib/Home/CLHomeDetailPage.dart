import 'package:flutter/material.dart';

class CLHomeDetailPage extends StatefulWidget {
  final Widget child;
  final String roomId;
  final String roomName;
  CLHomeDetailPage({Key key, this.child, this.roomId, this.roomName}) : super(key: key);

  _CLHomeDetailState createState() => _CLHomeDetailState();
}

class _CLHomeDetailState extends State<CLHomeDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  AppBar(
          title: Text('${widget.roomName}'),
          /// 标题居中
          centerTitle: true,
          /// 设置导航栏阴影效果
          elevation: 0.0,
          /// 设置状态栏颜色
          brightness: Brightness.light,
        ),
        body: Container(
          child: Center(child: Text('${widget.roomId}'),),
        ),
    );
  }
}
