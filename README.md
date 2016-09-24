# 萌货(一款所有萌物的APP)
><h3>项目的简单介绍
<h4>由于现在对萌物的追捧，我们打算收集所有好看的萌货，以及列出相关的淘宝购买地址</h4>
---

##软件的亮点PNG图片
--- 
![Home ViewController](https://github.com/Moshimol/Meng/blob/master/Effect/Home.png)
![More ViewController](https://github.com/Moshimol/Meng/blob/master/Effect/More.png)<br><br>
![Profile ViewController](https://github.com/Moshimol/Meng/blob/master/Effect/Profile.png)
![AllPic](https://github.com/Moshimol/Meng/blob/master/Effect/AllPic.png)<br><br>
![SharSdk](https://github.com/Moshimol/Meng/blob/master/Effect/SharSDK.png)

* 可以把萌货的相关链接分享到微信(朋友圈，微信好友 这个需要安装微信。也可以分享到微博上，分享到微博需要微博登陆，不必使用微博客户端
* 萌货的页面都是实时更新的数据，可以看到最新的数据
* 更多页面切换

---


##项目进度
---
<h4>项目进度的详情</h4>
>1. 8.20 实现页面的布局,使用Chrales抓取API接口<br>
>2. 8.21 首次登陆APP实现页面的引导<br>
>3. 8.22实现首页的基本布局，滑动视图的实现,以及页面的加载<br>
>4. 8.23第二页面实现左右滑动，切换视图。<br>
>5. 8.23 - 8.27号 第一页面和第二页面的网络请求的数据加载和显示，实现部分功能<br>
>6. 8.28 - 9.5 实现第三页面的布局以及头像的切换、选择性别、年龄、缓存的清理、意见的反馈<br>
>7. 9.15 - 9.17 使用第三方SDK实现微博,微信的分享，基本完成功能<br>
>8. 9.16 - 今 逐步完善所有页面的布局，以及更改不适合的图片<br>

---

##项目中用到的相关技术
---

>1.ScrollView和PageControl配合使用完成首次登陆的导航界面并自动跳转;<br>
>2.首页顶部的图片轮播，自定义cell利用TableView完成界面的基本布局;<br>
>3.自定义TextView实现加入Placeholder;<br>
>4.商品详情界面Label的复杂布局;<br>
>5.清除缓存使用(SDImageCache 类的方法),alertView 的使用
>6.利用CollectionView，TableView实现个人中心界面布局;<br>
>7.改变头像和昵称并保存到本地，头像可以通过相册或者相机获取图片;<br>
>8.使用第三方SDK，实现分享的功能，使卖萌货能在微信，微博上进行分享;<br>
>9.使用第三方框架AFNetworking进行网络请求，以及SDWebImage进行加载图片

---
##项目更改BUG细节
---
>1.下个版本增加不同网络状态下的判断，来记性加载，使得在没有网出现没有数据的问题得到解决


###作者的联系方式
<h4>[卢仕彤微博](http://weibo.com/1865131860/profile?rightmod=1&wvr=6&mod=personinfo)  <br>[袁王东  微博](http://weibo.com/u/3816905770?refer_flag=1005050005_)
