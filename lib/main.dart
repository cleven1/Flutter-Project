import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '斗鱼直播',
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),
      home: MyHome(),
    );
  }
}


class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// 在Flutter中,每个空间都是一个类
    return Scaffold(
      appBar: AppBar(title: Text('首页'),
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
      ],
      ),
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
    ),), /// 添加侧边栏
    );
  }
}
