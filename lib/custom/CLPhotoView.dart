import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:photo_manager/photo_manager.dart';
import 'package:common_utils/common_utils.dart';


/// 定义回调类型
typedef Future<void> OnDeleteItem(List<AssetEntity> list);

class AssetImageWidget extends StatelessWidget {
  final AssetEntity assetEntity;
  final double width;
  final double height;
  final BoxFit boxFit;

  const AssetImageWidget({
    Key key,
    @required this.assetEntity,
    this.width,
    this.height,
    this.boxFit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (assetEntity == null) {
      return _buildContainer();
    }
    return FutureBuilder<Size>(
      builder: (c, s) {
        if (!s.hasData) {
          return Container();
        }
        var size = s.data;
        return FutureBuilder<Uint8List>(
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              return _buildContainer(
                child: Image.memory(
                  snapshot.data,
                  width: width,
                  height: height,
                  fit: boxFit,
                ),
              );
            } else {
              return _buildContainer();
            }
          },
          future: assetEntity.thumbDataWithSize(
            size.width.toInt(),
            size.height.toInt(),
          ),
        );
      },
      future: assetEntity.size,
    );
  }

  Widget _buildContainer({Widget child}) {
    child ??= Container(width: width,height: height,);
    return Container(
      width: width,
      height: height,
      child: child,
    );
  }
}

class CLPhotoView extends StatefulWidget {
  final List<AssetEntity> list;
  final OnDeleteItem onDeleteItem;
  final bool isShowDeleteButton;

  CLPhotoView({
    Key key, 
    @required this.list,
     this.onDeleteItem,
     this.isShowDeleteButton}) : super(key: key);

  _CLPhotoViewState createState() => _CLPhotoViewState();
}

class _CLPhotoViewState extends State<CLPhotoView> {

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.start,
      children: widget.list
            .map((item) => Stack(
              children: <Widget>[
                AssetImageWidget(
                  assetEntity: item,
                  width: 80,
                  height: 80,
                  boxFit: BoxFit.cover,
                ),
                Positioned(
                  right: -8,
                  top: -3,
                  child: IconButton(
                    icon: Icon(Icons.delete_forever,color: Colors.red,size: 20,),
                    iconSize: widget.isShowDeleteButton ? 25 : 0,
                    alignment: Alignment.topRight,
                    onPressed: (){
                      setState(() {
                        widget.list.remove(item);
                        widget.onDeleteItem(widget.list);
                      });
                    },),
                )
              ],
            ))
            .toList(),
    );
  }
}