//
//  HomeWebViewController.m
//  MyHome
//
//  Created by DHSoft on 16/8/31.
//  Copyright © 2016年 DHSoft. All rights reserved.
//

#import "HomeWebViewController.h"
#import <WebKit/WKWebView.h>

@interface HomeWebViewController ()

@end

@implementation HomeWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self HomeWebView];
}

- (void)HomeWebView
{
    WKWebView *webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, KAPPW, KAPPH-64)];
    [self.view addSubview:webView];
    
    
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];

    
    if(self.AppDelegateSele == -1)
    {
          self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e61b", 24,nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    }
    
}

- (void)back
{
    
    if(self.WebBack){
        
        self.WebBack();
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (NSString *)urlStr
{
    if(_urlStr == nil)
    {
        _urlStr = [NSString string];
    }
    return _urlStr;
}

@end
