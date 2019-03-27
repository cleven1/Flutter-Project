import 'package:flutter/material.dart';
import '../Utils/CLDioUtil.dart';
import '../Home/Model/CLHomeModel.dart';
import '../custom/CLText.dart';
import 'package:extended_image/extended_image.dart';
import '../Home/CLHomeDetailPage.dart';
import '../custom/CLListViewRefresh.dart';

class CLMeiZiPage extends StatefulWidget {
  final Widget child;
  final String title;

  CLMeiZiPage({Key key, this.child,@required this.title}) : super(key: key);

  _CLMeiZiState createState() => _CLMeiZiState();

}

class _CLMeiZiState extends State<CLMeiZiPage> with AutomaticKeepAliveClientMixin  {

  @override
  bool get wantKeepAlive => true; 


  /// 默认请求第一页的数据
  int page = 1;
  int pageSize = 20;
  /// 数组
  List<CLHomeModel> mList = [];


  void initState() { 
    super.initState();
    getDouYuMeiZiData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  AppBar(
          title: Text('${widget.title}'),
          /// 标题居中
          centerTitle: true,
          /// 设置导航栏阴影效果
          elevation: 0.0,
          /// 设置状态栏颜色
          brightness: Brightness.light,
        ),
        body: Container(
          child: CLListViewRefresh(
            listData: mList,
            onRefresh: (){

            },
            loadMore: (){

            },
            child: getListViewContainer(),
          ),
        ),
     );
  }

  getListViewContainer(){
    return ListView.builder(
            itemCount: mList.length,
            itemBuilder: (BuildContext context, int index) {
              var model = mList[index];
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => CLHomeDetailPage(roomId: model.roomId,roomName: model.roomName,),
                ));
              },
              child: getListViewItemContainer(model),
            );
           },
          );
  }

  getListViewItemContainer(CLHomeModel model){
     return Container(
              // height: 200,
              padding: EdgeInsets.only(left: 15,right: 15,top: 15),
              
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("房间ID: ${model.roomId}"),
                  Text("房间名称: ${model.roomName}"),
                  SizedBox(height: 10,),
                  Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration( /// 添加阴影
                          boxShadow: [BoxShadow(color: Colors.black26,blurRadius: 10.0,offset: Offset(10.0, 10.0),spreadRadius: 0.0),],
                          ),
                        child: ClipRRect( /// 网络图片添加圆角
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            child: ExtendedImage.network(model.verticalSrc,
                            fit: BoxFit.fill,
                            cache: true,
                            ),
                          ),
                        ),
                      Positioned(
                        left: 15,
                        bottom: 15,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CLText(text: '主播名称: ${model.nickname}',textColor: Colors.purple,),
                            SizedBox(height: 5,),
                            CLText(text: "类型: ${model.gameName}",textColor: Colors.yellow,)
                          ],
                        ),
                      ),
                      Positioned(
                        left: 15,
                        top: 15,
                        child: Text("主播ID: ${model.ownerUid}",style: TextStyle(color: Colors.pink[300]),),
                      ),
                      Positioned(
                        right: 15,
                        bottom: 15,
                        child: Text("在线人数: ${model.online.toString()}",style: TextStyle(color: Colors.red),),
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Divider() /// 添加底部线
                ],
              )
            );
  }

  getDouYuMeiZiData() async {

    int offset = (page - 1) * pageSize;
    CLResultModel response = await CLDioUtil.instance.requestGet('http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=20&offset=$offset');
    List jsons = response.data['data'];
    List<CLHomeModel> tempModel = [];
    jsons.forEach((model){
        tempModel.add(CLHomeModel.fromJson(model));
        print(model);
      });
    /// 把数据更新放到setState中会刷新页面
    setState(() {
      mList = tempModel;
    });

  }

}