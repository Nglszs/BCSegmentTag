

1.类似于新闻首页界面，标签栏用collectionview封装。


2.左右滑动切换视图有两种常用的做法：
        一、是scrollveiw/colletionview/tableview添加对应的view
        
        
        
        
     二、是调用UIViewcontroller 自带的addChildViewController
        

上面两种方法都没用，这里我用的是UIPageViewController，感觉还不错


3、还有一个类似于微信发朋友圈选择照片文字样式的界面，可以参考一下
