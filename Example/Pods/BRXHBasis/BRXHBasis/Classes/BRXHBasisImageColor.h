//
//  BRXHBasisImageColor.h
//  Pods
//
//  Created by mac on 2017/11/13.
//

#ifndef BRXHBasisImageColor_h
#define BRXHBasisImageColor_h


//  跳转
#define KPushURL(url) [NSString stringWithFormat:@"%@://NaviPush/%@",appPushURL,url]

//  tabbar默认颜色
#define tabBarColor [UIColor blackColor]

//  tabbar选中颜色
#define tabBarSelectColor [UIColor colorWithWzxString:@"#eec433"]

//  主题颜色
#define globalColor [UIColor colorWithWzxString:@"#eec433"]

//  app类别 0资讯  1彩票  2商城
#define AppType  0

//AF请求访问类
#define AFAPPType @"football"  //1.足球  football  2.娱乐  entertainment  3.热点  news

#define Klang  @"EN"  // 'zh-CHS',中文  'ja', 日文  'EN', 英文 'ko', 韩文 'fr', 法文 'ru', 俄文 'pt', 葡萄牙文 'es', 西班牙文

//  AppKey
#define AppKey @"D9B7DF2A95C324F91C9B803029C4BF09"

//  JPushAppKey
#define JPAppKey @"a02b01a3d1354b98c3b939f6"

//  跳转key
#define appPushURL  @"bairuixinghong"


#endif /* BRXHBasisImageColor_h */
