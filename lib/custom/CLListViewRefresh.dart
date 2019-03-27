import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';


/// 定义回调类型
typedef Future<void> OnRefresh();
typedef Future<void> LoadMore();

class CLListViewRefresh extends StatelessWidget {

  final List listData;
  final Widget child;
  final OnRefresh onRefresh;
  final LoadMore loadMore;

  CLListViewRefresh({Key key ,@required this.child, @required this.listData, this.onRefresh, this.loadMore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getListViewContainer();
  }

  GlobalKey<EasyRefreshState> _easyRefreshKey = new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();

  getListViewContainer() {

    if (listData.isEmpty){ /// 没有数据时显示loading状态
      return Center(child: CupertinoActivityIndicator(),);
    }
    var now = DateTime.now();
    var formatter = '${now.hour.toString()}:${now.minute.toString()}:${now.second.toString()}';
    return EasyRefresh(
      key: _easyRefreshKey,
      refreshHeader: ClassicsHeader(
          key: _headerKey,
          refreshText: '下拉刷新',
          refreshReadyText: '松手刷新',
          refreshingText: '正在刷新',
          refreshedText: '刷新结束',
          moreInfo: '更新时间: ${formatter}',
          bgColor: Colors.transparent,
          textColor: Colors.black87,
          moreInfoColor: Colors.black54,
          showMore: true,
      ),
      refreshFooter: ClassicsFooter(
        key: _footerKey,
        loadText: '上拉刷新',
        loadReadyText: '松手刷新',
        loadingText: '正在加载...',
        loadedText: '加载完成',
        noMoreText: '加载完成',
        moreInfo: '更新时间: ${formatter}',
        bgColor: Colors.transparent,
        textColor: Colors.black87,
        moreInfoColor: Colors.black54,
        showMore: true,
      ),
        /// 下拉刷新
      onRefresh: onRefresh, 
      loadMore: loadMore,/// 上拉加载
      // behavior: ScrollOverBehavior(),
      autoLoad: true,
      child: child,
    );
  }

}