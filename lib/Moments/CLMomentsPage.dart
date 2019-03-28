import 'package:flutter/material.dart';
import '../custom/CLAppbar.dart';
import '../custom/CLText.dart';
import 'package:extended_image/extended_image.dart';
import '../custom/CLFlow.dart';
import '../custom/CLListViewRefresh.dart';
import '../Utils/CLDioUtil.dart';
import './Model/CLMomentsModel.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class CLMomentsPage extends StatefulWidget {
  final Widget child;
  final String title;

  CLMomentsPage({Key key, this.child, @required this.title}) : super(key: key);

  _CLMomentsPageState createState() => _CLMomentsPageState();
}

class _CLMomentsPageState extends State<CLMomentsPage> {

  // @override
  // bool get wantKeepAlive => true;   

  List <CLMomentsModel> mList = [];

  void initState() { 
    super.initState();
    getMomentsData();
  }

  getMomentsData({bool isLoadMore = false,String lastId}) async {

    CLResultModel result = await CLDioUtil().requestGet("http://api.cleven1.com/api/moments/momentsList?isPullUp=$isLoadMore&offset_id=$lastId");
    List jsons = result.data['data'];
    List<CLMomentsModel> tempModel = [];
    jsons.forEach((model){
        tempModel.add(CLMomentsModel.fromJson(model));
      });
    if (isLoadMore) {
      /// 把数据更新放到setState中会刷新页面
      setState(() {
        mList.addAll(tempModel);
      });
    }else{
      setState(() {
        mList = tempModel;
      });
    }
      
  }

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
        itemCount: mList.length,
        itemBuilder: (BuildContext context, int index) {
          CLMomentsModel model = mList[index];
          return model.momentPics == null ? getItemTextContainer(model) :getItemImageContainer(model);
        },
      ),
      onRefresh: (){
        getMomentsData();
      },
      loadMore: (){
        getMomentsData(isLoadMore: true,lastId: mList.last.momentId);
      },
    );
  }

  /// 文本布局
  getItemTextContainer(CLMomentsModel model){
    return getItemBaseContainer(
      model,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
         CLText(
          text: model.content,
          maxLines: 6,
          style: setTextStyle(textColor: Colors.pinkAccent),
        ),
        getFullContainer(),
       ],
     )
    );
  }

  /// 图片布局
  getItemImageContainer(CLMomentsModel model){
    return getItemBaseContainer(
      model,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CLText(
            text: model.content,
            maxLines: 6,
            style: setTextStyle(textColor: Colors.pinkAccent),
          ),
          getFullContainer(),
          SizedBox(height: 10,),
          CLFlow(
            count: model.momentPics.length,
            children: getImageContaniner(model),
          )
        ],
      )
    );
  }

  getImageContaniner(CLMomentsModel model) {
    List<ExtendedImage> images = [];
    for (var i = 0; i < model.momentPics.length; i++) {
      String imageUrl = model.momentPics[i];
      images.add(ExtendedImage.network(imageUrl,cache: true,fit: BoxFit.cover,),);
    }
    return images;
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

  getItemBaseContainer(CLMomentsModel model, Widget subChild){
    return Container(
        padding: EdgeInsets.only(left: 15,right: 15,top: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ExtendedImage.network(
              "${model.userInfo.avatarUrl}",
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
                    text: "${model.userInfo.name}",
                    textAlign: TextAlign.start,
                    style: setTextStyle(textColor: Colors.black87),
                  ),
                  CLText(
                    text: "${model.timeStamp}",
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

