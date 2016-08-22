# ZFVoteViewDemo（觉得好麻烦给个星star）

github地址：https://github.com/ZFbaby/ZFVoteViewDemo

##tabelView实现格瓦拉飞天投票效果

感谢GraphKit作者，demo中的绘图功能大部分实现采用他的方法和思路做的并进行了一些小改！<br />

格瓦拉目前来说动画效果确实做的还比较好，虽然不是说很炫但做到精致，这次就模仿了它投票的模块<br />

其实想到要实现它的方法很多，这次我就采用了苹果自带功能强大的控件UITableView<br />

####ZFVoteViewDemo功能介绍

1. 点击投票后当前控件实现飞天效果并转移到最顶部
2. 当控件放大时cell上文字实现自适应宽高
3. 按钮实现弹性放大效果，进度条动画比例等效果


**效果图如下** <br />

![image](https://github.com/ZFbaby/ZFVoteViewDemo/blob/master/格瓦拉投票效果1.gif)
![image](https://github.com/ZFbaby/ZFVoteViewDemo/blob/master/格瓦拉投票效果2.gif)
![image](https://github.com/ZFbaby/ZFVoteViewDemo/blob/master/格瓦拉投票效果3.gif)

######实现步骤：
* 数据回来的时候就要根据数据算出每一行的高度并且算出总高
* 设置cell的内边距离及x值
* 创建投票主控件并添加到cell上 
* 每次点击选择一个cell的时候创建个投票主控件实现动画效果
* 再用tableview的交换cell位置的方法实现cell的转换
