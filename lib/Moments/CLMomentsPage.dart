import 'package:flutter/material.dart';
import '../custom/CLAppbar.dart';
import '../custom/CLText.dart';
import 'package:extended_image/extended_image.dart';
import '../custom/CLFlow.dart';
import '../custom/CLListViewRefresh.dart';

class CLMomentsPage extends StatefulWidget {
  final Widget child;
  final String title;

  CLMomentsPage({Key key, this.child, @required this.title}) : super(key: key);

  _CLMomentsPageState createState() => _CLMomentsPageState();
}

class _CLMomentsPageState extends State<CLMomentsPage> {

  List <String> mList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CLAppBar(
        title: '朋友圈',
      ),
      body: getListViewContainer(),
    );
  }

  getListViewContainer() {

    return CLListViewRefresh(
      listData: mList,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return index % 2 == 0 ? getItemTextContainer() :getItemImageContainer();
        },
      ),
    );
  }

  /// 文本布局
  getItemTextContainer(){
    return getItemBaseContainer(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
         CLText(
          text: '阿里看风景奥利给记录卡爱上观看垃圾刚喀什噶了司空见惯阿三哥卡拉格拉斯挂看帅哥a',
          maxLines: 6,
          style: setTextStyle(textColor: Colors.pinkAccent),
        ),
        getFullContainer(),
       ],
     )
    );
  }

  /// 图片布局
  getItemImageContainer(){
    return getItemBaseContainer(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CLText(
            text: '阿里看风景奥利给记录卡爱上观看垃圾刚喀什噶了司空见惯阿三哥卡拉格拉斯挂看帅哥a',
            maxLines: 6,
            style: setTextStyle(textColor: Colors.pinkAccent),
          ),
          getFullContainer(),
          SizedBox(height: 10,),
          CLFlow(
            count: 9,
            children: <Widget>[
              new Container(width: 90.0, height:110.0, color: Colors.black,),
              new Container(width: 90.0, height:110.0, color: Colors.green,),
              new Container(width: 90.0, height:110.0, color: Colors.blue,),
              new Container(width: 90.0, height:110.0,  color: Colors.yellow,),
              new Container(width: 90.0, height:110.0, color: Colors.brown,),
              new Container(width: 90.0, height:110.0,  color: Colors.purple,),
              new Container(width: 90.0, height:110.0,  color: Colors.yellow,),
              new Container(width: 90.0, height:110.0, color: Colors.brown,),
              new Container(width: 90.0, height:110.0,  color: Colors.purple,),
            ],
          )
        ],
      )
    );
  }

  getFullContainer(){
    return Container(
          padding: EdgeInsets.only(top: 10),
          child: GestureDetector(
            onTap: (){
              print('点击全文');
            },
            child: CLText(text: '全文',style: setTextStyle(textColor: Colors.blue),),
          )
        );
  }

  getItemBaseContainer(Widget subChild){
    return Container(
        padding: EdgeInsets.only(left: 15,right: 15,top: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ExtendedImage.network(
              'https://apic.douyucdn.cn/upload/avatar_v3/201812/71c742ce5a77ff0d8f80a4d14e1ad79e_middle.jpg',
              width: 40,
              height: 40,
              shape: BoxShape.circle,
              borderRadius: BorderRadius.circular(20),
              cache: true,
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CLText(
                    text: '测试',
                    textAlign: TextAlign.start,
                    style: setTextStyle(textColor: Colors.black87),
                  ),
                  CLText(
                    text: '2分钟前',
                    style: setTextStyle(textColor: Colors.grey,fontSize: 12),
                  ),
                  SizedBox(height: 5,),
                  subChild,
                ],
              ),
            ),
            GestureDetector(
              onDoubleTap: (){
                  print("点击");
              },
              child: Icon(Icons.more_horiz,),
            )
          ],
        ),
      );
  }
}

