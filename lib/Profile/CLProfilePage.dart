import 'package:flutter/material.dart';
import '../custom/CLAppbar.dart';
import '../custom/CLText.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';
import 'package:extended_image/extended_image.dart';

class CLProfileModel {
  
  String title;
  Icon icon;

  CLProfileModel(this.title,this.icon);
}

class CLProfilePage extends StatelessWidget {
  final Widget child;
  final String title;
  CLProfilePage({Key key, this.child, @required this.title}) : super(key: key);

  final List<List<CLProfileModel>> items = <List<CLProfileModel>>[
    [
      CLProfileModel("收藏", Icon(Icons.toc)),
      CLProfileModel("待办", Icon(Icons.today)),
      CLProfileModel("红包", Icon(Icons.receipt)),
    ],
    [
      CLProfileModel("奖励", Icon(Icons.remove_circle)),
      CLProfileModel("设置", Icon(Icons.settings))
    ]
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CLAppBar(
        title: "我",
      ),
      body: getListViewContainer(),
    );
  }

  getListViewContainer(){
    return SectionTableView(
        sectionCount: items.length,
        numOfRowInSection: (section) {
          return items[section].length;
        },
        cellAtIndexPath: (section, index) {
          return GestureDetector(
            onTap: () {
              print('section == $section  index == $index');
            },
            child: getItemContainer(items[section][index]),
          );
        },
        headerInSection: (section){
          return section == 0 ? getHeaderViewContainer() : getGroupTextContainer(section);
        },
      );
  }

  getHeaderViewContainer() {
    return Container(
      height: 236,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
            Expanded(
              flex: 0,
              child: ExtendedImage.network(
                'https://rpic.douyucdn.cn/live-cover/appCovers/2019/03/14/5777969_20190314185355_small.jpg',
                fit: BoxFit.cover,
                cache: true,
              ),
            ),
          getGroupTextContainer(0),
        ],
      ),
    );
  }

  getGroupTextContainer(int index) {
    return Container(
        padding: EdgeInsets.only(left: 15),
        child: CLText(text: '第${index + 1}组',style: setTextStyle(fontSize: 17,fontWeight: true),),
      );
  }

  getItemContainer(CLProfileModel model) {
    return Column(
          children: <Widget>[
            ListTile(
              leading: model.icon ,
              title: CLText(text: '${model.title}',),
              trailing: Icon(Icons.navigate_next),
            ),
            Divider(),
          ],
        );
  }

}
