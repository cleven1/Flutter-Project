import 'package:flutter/material.dart';

class CLHomeModel {
  /// 房间id
  String room_id;
  /// 横屏封面
  String room_src;
  /// 竖屏封面
  String vertical_src;
  /// 是否竖屏
  bool isVertical;
  int cate_id;
  /// 放假名
  String room_name;
  /// 是否在直播
  String show_status;
  /// 主播名
  String nickname;
  /// 在线人数
  int online;
  /// 直播类型
  String game_name;
  /// 头像
  String avatar_mid;
  /// 城市
  String anchor_city;
  /// 直播时间
  int show_time;
  /// 主播id
  int owner_uid;
}