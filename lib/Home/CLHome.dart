import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../Utils/CLDioUtil.dart';

class CLHome extends StatefulWidget {
  final Widget child;
  final String title;

  CLHome({Key key, this.child,@required this.title}) : super(key: key);

  _CLHomeState createState() => _CLHomeState();
}

/// 有状态控件,必须结合一个状态管理类来进行实现
class _CLHomeState extends State<CLHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(                /// 获取传进来的title(使用widget获取)
      appBar: AppBar(title: Text('${widget.title}'),
        centerTitle: true, /// 标题居中
        /// 设置状态栏颜色
        brightness: Brightness.light, 
        /// 设置导航栏阴影效果
        elevation: 0.0,
        /// 右侧按钮
        actions: <Widget>[ 
          IconButton(icon: Icon(Icons.search),
          onPressed: (){

          },)
      ],),
      /// 侧边栏
      drawer: Drawer(child: ListView(
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
      ), 
      body: CLHomeData()
    );
  }
}

/// 实例化网络请求工具
Dio dio = new Dio();

class CLHomeData extends StatefulWidget {
  final Widget child;

  CLHomeData({Key key, this.child}) : super(key: key);

  _CLHomeData createState() => _CLHomeData();
}

class _CLHomeData extends State<CLHomeData> {
  /// 默认请求第一页的数据
  int page = 1;
  int pageSize = 20;
  /// 数组
  var mList = [];

  /// 控件被创建的时候,会执行initState方法
  void initState() { 
    super.initState();
    /// 请求数据
    getDouYuLiveListData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.mList.length,
      itemBuilder: (BuildContext context, int index) {
      return Text(index.toString());
     },
    );
  }

  getDouYuLiveListData() async {
    int offset = (page - 1) * pageSize;
    CLResultModel response = await CLDioUtil.instance.requestGet('http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=20&offset=$offset');
    /// 把数据更新放到setState中会刷新页面
    setState(() {
      mList = response.data['data'];
    });
    // print(response.data);
  }
}