//
//  BRXHWebViewController.h
//  BRXHFootball
//
//  Created by mac on 2017/10/26.
//  Copyright © 2017年 wzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BRXHWebViewController : UIViewController

// 是否隐藏导航栏 默认显示
@property (nonatomic,assign) BOOL isNavHidden;

// 网址链接
@property (nonatomic, copy) NSString *URLString;

// 加载url
- (void)loadWebURLString:(NSString *)URL;

// 加载HTML字符
- (void)loadWebHTMLString:(NSString *)HTMLString;

@end
