# Flutter的旅行之旅

## 前言
flutter是谷歌2018年推出的跨平台解决方案,貌似后续可以支持五端运行(iOS,Android,macOS,Windows,Linux),个人感觉这可能是后续发展的趋势,所以心里一直惦记着flutter这门技术,这周公司项目不是很忙,抓紧时间入门了flutter,花了两天的时间算是基本掌握了flutter的各种语法和常用Widget,算是flutter的基本套路玩法已经掌握了,后续多写多看多了解让自己处于持续进步的状态

## 旅行第一站

 - 首先是看[官方文档](https://flutterchina.club/setup-macos),
 - 根据文档自己去撸感受flutter的美妙
 - 看技术博客
  1. 根据博客内容学习大牛是怎么开发的
  2. 可以避免重复采坑
  3. 站在巨人的肩膀上前进
 
#### 推荐几篇我在学习过程中觉得还不错的文章,感谢这些大牛的贡献

适合新手看 [Flutter学习之布局、交互、动画](https://juejin.im/post/5c617e34f265da2d90581613)

可以学习本地缓存,内存缓存,清除本地缓存,清除内存缓存,保存图片到相册
[Flutter 什么功能都有的Image](https://juejin.im/post/5c867112f265da2dd427a340)

记录了Flutter开发中遇到的问题[Flutter 问题解决总结](https://juejin.im/post/5c91a8da5188252db75696c0)

Matrix4矩阵变换可以学习一下[https://juejin.im/post/5be2fd9e6fb9a04a0e2cace0](flutter布局-5-Matrix4矩阵变换)

## 旅行第二站

俗话说,看千遍万遍都不如动手写一遍,只有动手了才会加深记忆力,在自己使用flutter开发的过程中,作为一个iOS开发者心里默默的对比了一下,使用flutter速度更快,更灵活,最重要的是[性能更高](https://www.colabug.com/4531573.html)fps可以达到120


##### 先上图,自己练习做的小demo,[项目地址](https://github.com/cleven1/Flutter-Project)

![](./sources/sources.gif)

1. 此项目中首页和美女模块的数据来源于斗鱼直播,抓包找到了他们的颜值类型的接口,可以看到各种妹子,还是妹子的吸引力大啊😊😊😊

2. 朋友圈的数据来源于本人自己的后台,使用Python开发,存了几条数据,写demo完全够用了,后续准备写爬虫抓一些带文字,带图片的数据

### 开发过程中遇到的问题

- 做朋友圈的时候想做个点击全文展开收起的功能,现在的解决办法是按照文字的长度展示全文按钮,然后Text的maxLines设置的6行,在各种测试下虽然暂时满足了需求,但是感觉还是有bug的,希望有大牛指导一下我应该怎么完成这个功能,在此先谢过,期待您的指导~

### 在开发的过程中把常用的组件进行了封装,一次封装长久使用

- APPBar的封装
- 刷新控件的封装
- [九宫格图片布局封装](https://github.com/cleven1/Flutter-CLFlow) 
- Text封装
- 网络库Dio封装
- 一些常用方法封装工具栏(屏幕size,时间戳,状态栏高度,文件大小)





