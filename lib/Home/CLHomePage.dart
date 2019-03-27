import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../Utils/CLDioUtil.dart';
import '../Home/Model/CLHomeModel.dart';
import './CLHomeDetailPage.dart';
import '../custom/CLText.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import '../custom/CLListViewRefresh.dart';
import '../custom/CLAppbar.dart';

class CLHomePage extends StatefulWidget {
  final Widget child;
  final String title;

  CLHomePage({Key key, this.child,@required this.title}) : super(key: key);

  _CLHomeState createState() => _CLHomeState();
}

/// 有状态控件,必须结合一个状态管理类来进行实现
class _CLHomeState extends State<CLHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(                /// 获取传进来的title(使用widget获取)
      appBar: CLAppBar(title: '${widget.title}',
        /// 右侧按钮
        actions: <Widget>[ 
          IconButton(icon: Icon(Icons.search),
          onPressed: (){

          },)
      ],),
      /// 侧边栏
      drawer: getDrawerContainer(), 
      body: CLHomeData()
    );
  }
}

/// 侧边栏
getDrawerContainer() {
  return Drawer(child: ListView(
        padding: EdgeInsets.all(0), /// 取消内边距,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('cleven'),
            accountEmail: Text('clevenzhao@gmail.com'),
            currentAccountPicture: CircleAvatar(backgroundImage: NetworkImage('https://avatars0.githubusercontent.com/u/18156348?s=460&v=4'),),
            /// 美化当前控件
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://rpic.douyucdn.cn/live-cover/appCovers/2019/03/06/5987179_20190306000039_small.jpg'),
                fit: BoxFit.cover)
            ),
          ),
            ListTile(title: Text('用户隐私'),trailing: Icon(Icons.feedback),),
            ListTile(title: Text('服务条款'),trailing: Icon(Icons.phone),),
            ListTile(title: Text('设置'),trailing: Icon(Icons.settings),),
            Divider(),/// 添加分割线
            ListTile(title: Text("退出"),trailing: Icon(Icons.exit_to_app))
          ],
        ),
      );
}

/// 实例化网络请求工具
Dio dio = new Dio();

class CLHomeData extends StatefulWidget {
  final Widget child;

  CLHomeData({Key key, this.child}) : super(key: key);

  _CLHomeData createState() => _CLHomeData();
}

class _CLHomeData extends State<CLHomeData> with AutomaticKeepAliveClientMixin {
  
  @override
  bool get wantKeepAlive => true;
  
  /// 默认请求第一页的数据
  int page = 1;
  int pageSize = 20;
  /// 数组
  List<CLHomeModel> mList = [];

  /// 控件被创建的时候,会执行initState方法
  void initState() { 
    super.initState();
    /// 请求数据
    /// 延时3秒
    Future.delayed(Duration(seconds: 3),(){
      getDouYuLiveListData();
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return getListViewContainer();
  }

  getListViewContainer() {

    return CLListViewRefresh(
      listData: mList,
      onRefresh: (){
        getDouYuLiveListData();
      },
      loadMore: () {
        getDouYuLiveListData(isLoadMore: true);
      },
      child: ListView.builder(
      itemCount: this.mList.length,
      itemBuilder: (BuildContext context, int index) {
        var model = mList[index];
      return GestureDetector(onTap: (){ /// 添加item点击事件
        /// 跳转界面
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return CLHomeDetailPage(roomName: model.roomName,roomId: model.roomId);
        }));
      },child: getListViewItemContainer(model),
      );
     },
    ),
    );
  }

  /// cell布局
  getListViewItemContainer(CLHomeModel model) {
    return Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12)),
        ),
        child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 15),
            
            child: ExtendedImage.network(model.roomSrc,width: 130,height: 180,fit: BoxFit.cover,cache: true,),
          ),
          Container(
            height: 180,
            width: MediaQuery.of(context).size.width - 130 - 15,
            padding: EdgeInsets.only(left: 15,bottom: 15),
            child: Column(
            /// 副轴开始位置对齐
            crossAxisAlignment: CrossAxisAlignment.start,
            /// 平分区域
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CLText(text: "房间ID: ${model.roomId}",),
              CLText(text: "房间名称: ${model.roomName}",maxLines: 1,),
              CLText(text: "主播名称: ${model.nickname}"),
              CLText(text: "主播ID: ${model.ownerUid}"),
              CLText(text: "观看人数: ${model.online.toString()}"),
              CLText(text: "直播类型: ${model.gameName}"),
            ],
          ),
          )
        ],
      ),
      );
  }

  /// 获取数据
  getDouYuLiveListData({bool isLoadMore = false}) async {
    int offset = 0;
    if (isLoadMore) {
        offset = (page - 1) * pageSize;
    }
    CLResultModel response = await CLDioUtil.instance.requestGet('http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=20&offset=$offset');
    List jsons = response.data['data'];
    List<CLHomeModel> tempModel = [];
    jsons.forEach((model){
        tempModel.add(CLHomeModel.fromJson(model));
      });
    /// 把数据更新放到setState中会刷新页面
    setState(() {
      if (isLoadMore){
        mList.addAll(tempModel);
      }else{
        mList = tempModel;
      }
    });
  }
}