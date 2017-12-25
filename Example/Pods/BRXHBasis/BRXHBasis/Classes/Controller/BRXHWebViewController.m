//
//  BRXHWebViewController.m
//  BRXHFootball
//
//  Created by mac on 2017/10/26.
//  Copyright © 2017年 wzx. All rights reserved.
//

#import "BRXHWebViewController.h"
#import <WebKit/WebKit.h>
#import <WebKit/WKWebView.h>
#import "BRXHBasis.h"
#import <UIAlertView+BlocksKit.h>

typedef enum{
    loadWebURLString =0,
    loadWebHTMLString,
}wkWebLoadType;



static void *WkwebBrowserContext = &WkwebBrowserContext;

@interface BRXHWebViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

// 网页View
@property (nonatomic, strong) WKWebView *wkWebView;
// 网页加载进度条
@property (nonatomic, strong) UIProgressView *progressView;
// 加载类型 URL  HTML字符串
@property (nonatomic, assign) wkWebLoadType loadType;
// 保存请求链接
@property (nonatomic, strong) NSMutableArray *snapShotsArray;
// 返回按钮
@property (nonatomic, strong) UIBarButtonItem *backBarItem;
// 关闭按钮
@property (nonatomic, strong) UIBarButtonItem *closeBarItem;

// 返回按钮
@property (nonatomic,strong) UIButton *backBtn;
// 前进按钮
@property (nonatomic,strong) UIButton *forwardBtn;

//菜单选项
@property (nonatomic,strong) UIView *menuView;

@property (nonatomic,assign) BOOL isShow;


@end

@implementation BRXHWebViewController


- (UIView *)menuView{
    if (!_menuView) {
        CGFloat w = 80;
        CGFloat h = 44;
        NSArray *titleArray = @[@"分享",@"消息",@"清除缓存"];
        _menuView = [[UIView alloc] initWithFrame:CGRectMake(KAPPW - w, KAPPH, w, h*titleArray.count + 2)];
        UIColor *color = nil;
        if (AppType == 0) {//足球
            color = KColor(0, 143, 96, 1);
        }else{
            color = [UIColor redColor];
        }
        _menuView.backgroundColor = [color colorWithAlphaComponent:0.6];
        KLRViewBorderRadius(_menuView, 8, 1, [UIColor whiteColor]);
        for (NSInteger i = 0; i<titleArray.count;++i) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, i*h, w, h)];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn setTitle:titleArray[i] forState:UIControlStateNormal];
            btn.tag = 100 + i;
            [btn addTarget:self action:@selector(menuViewClicked:) forControlEvents:UIControlEventTouchUpInside];
            [_menuView addSubview:btn];
            if (i != titleArray.count - 1) {
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, btn.bottom, w, 1)];
                [_menuView addSubview:lineView];
                lineView.backgroundColor = [UIColor whiteColor];
            }
        }
        
    }
    return _menuView;
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;

   
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpUI];
    [self setUp];
  
    
}


- (void)setUpUI{
    UIView *bottom = [[UIView alloc]initWithFrame:CGRectMake(0, KAPPH-50, KAPPW, 50)];
    UIColor *color = nil;
    if (AppType == 0) {//足球
        color = KColor(0, 143, 96, 1);
    }else{
        color = [UIColor redColor];
    }
    bottom.backgroundColor = color;
    CGFloat w = KAPPW/5.0;
    
    NSArray *titles = @[@"首页",@"后退",@"快速充值",@"刷新",@"菜单"];
    NSArray *images = @[@"\U0000e673",@"\U0000e65e",@"\U0000e65f",@"\U0000e8d0",@"\U0000e646"];
   
    for (NSInteger i = 0; i<titles.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i*w, 0, w, 50)];
        [bottom addSubview:btn];
         UIImage *image = [UIImage iconWithInfo:TBCityIconInfoMake(images[i], 18,[UIColor whiteColor])];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setImage:image forState:UIControlStateNormal];
        
        btn.imageEdgeInsets = UIEdgeInsetsMake(-btn.titleLabel.intrinsicContentSize.height*0.5, btn.titleLabel.intrinsicContentSize.width*0.5, btn.titleLabel.intrinsicContentSize.height*0.5, -btn.titleLabel.intrinsicContentSize.width*0.5);
        btn.titleEdgeInsets = UIEdgeInsetsMake(btn.imageView.intrinsicContentSize.height*0.5, -btn.imageView.intrinsicContentSize.width*0.5, -btn.imageView.intrinsicContentSize.height*0.5, btn.imageView.intrinsicContentSize.width*0.5);
     
        btn.tag = 100 + i;
        if (i == 1) {
            self.backBtn = btn;
        }
        if (i == 2) {
            self.forwardBtn = btn;
        }
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self.view addSubview:bottom];
}


- (void)btnClicked:(UIButton *)btn{
    
    switch (btn.tag) {
        case 100:
            [self closeItemClick];
            break;
        case 101:
            [self backItemClick];
            break;
        case 102:
            [self goForward];
            
            break;
        case 103:
            [self roadLoadClicked];
            break;
        case 104://菜单
            [self setupMenuView];
            
            break;
            
        default:
            break;
    }
    
    
}

- (void)setupMenuView{
    
    [UIView animateWithDuration:0.6 animations:^{
        if (!self.isShow) {
            self.menuView.y = KAPPH - self.menuView.height - 50;
            self.isShow = YES;
        }else{
            self.menuView.y = KAPPH;
            self.isShow = NO;
        }
        
        
    }];
}

- (void)menuViewClicked:(UIButton *)btn{
    [self setupMenuView];
    switch (btn.tag) {
        case 100://分享
        {
            
            NSString *textToShare;
            //分享的图片
            if (AppType == 0) {
                textToShare = @"钻石信誉，皇冠品质，官方网址";
            }else{
                
                textToShare = @"大富翁-欢迎您的光临，官方网址";
            }
            //分享的url
            NSURL *urlToShare = [NSURL URLWithString:self.URLString];
            //分享的url
            //在这里呢 如果想分享图片 就把图片添加进去  文字什么的通上
            NSArray *activityItems = @[textToShare, urlToShare];
            UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
            //不出现在活动项目
            activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
            [self presentViewController:activityVC animated:YES completion:nil];
            // 分享之后的回调
            activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
                if (completed) {
                    NSLog(@"completed");
                    //分享 成功
                } else  {
                    NSLog(@"cancled");
                    //分享 取消
                }
            };
        }
            break;
        case 101://消息
        {
            [UIAlertView bk_showAlertViewWithTitle:nil message:@"暂无消息" cancelButtonTitle:@"确定" otherButtonTitles:nil handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                
                
            }];
            
        }
            break;
        case 102://清除缓存
        {
            
            
            [UIAlertView bk_showAlertViewWithTitle:nil message:@"是否清除缓存" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                if(buttonIndex == 1){
                    [[SDImageCache sharedImageCache] clearDisk];
                    
                    [[SDImageCache sharedImageCache] clearMemory];//可有可无
                    [MBProgressHUD showSuccess:@"清除成功"];
                }
                
            }];
            
        }
            
            break;
            
        default:
            break;
    }
    
}


- (void)setUp{
    self.isNavHidden = NO;
    [MBProgressHUD showMessage:@"正在加载中"];
    [WZXNetworking getWithUrl:[NSString stringWithFormat:@"%@api_appweburl?app_key=%@",KHttpUrl,AppKey] params:nil success:^(id response) {
        self.URLString = @"http://www.55756a.com/";
//        if([response[@"success"] intValue] == 1){
//            self.URLString = [response objectForKey:@"homeUrl"];
//        }else{
//            self.URLString = @"https://www.baidu.com";
//        }
        [MBProgressHUD hideHUD];
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUD];
        self.URLString = @"https://www.baidu.com";
    }];
}
#pragma mark ================ 加载方式 ================

- (void)webViewloadURLType:(NSString *)URL{
    switch (self.loadType) {
        case loadWebURLString:{
            //创建一个NSURLRequest 的对象
            NSURLRequest * Request_zsj = [NSURLRequest requestWithURL:[NSURL URLWithString:URL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
            //加载网页
            [self.wkWebView loadRequest:Request_zsj];
            break;
        }
        case loadWebHTMLString:{
            [self loadHostPathURL:URL];
            break;
        }
    }
}
// 加载url
- (void)loadWebURLString:(NSString *)URL{
    self.loadType = loadWebURLString;
    [self webViewloadURLType:URL];
}


- (void)setURLString:(NSString *)URLString{
    _URLString = URLString;
    self.loadType = loadWebURLString;
    [self webViewloadURLType:URLString];
}
// 加载HTML字符
- (void)loadWebHTMLString:(NSString *)HTMLString{
    self.loadType = loadWebHTMLString;
    [self webViewloadURLType:HTMLString];
}



- (void)loadHostPathURL:(NSString *)url{
    //获取JS所在的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:url ofType:@"html"];
    //获得html内容
    NSString *html = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //加载js
    [self.wkWebView loadHTMLString:html baseURL:[[NSBundle mainBundle] bundleURL]];
}


#pragma mark ================ WKNavigationDelegate ================

//这个是网页加载完成，导航的变化
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    /*
     主意：这个方法是当网页的内容全部显示（网页内的所有图片必须都正常显示）的时候调用（不是出现的时候就调用），，否则不显示，或则部分显示时这个方法就不调用。
     */

    // 获取加载网页的标题
    self.title = self.wkWebView.title.length > 20 ? [self.wkWebView.title substringToIndex:20] : self.wkWebView.title;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self updateNavigationItems];
}

//开始加载
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    //开始加载的时候，让加载进度条显示
    self.progressView.hidden = NO;
}

//内容返回时调用
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{}

//服务器请求跳转的时候调用
-(void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{}

//服务器开始请求的时候调用
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    //    NSString* orderInfo = [[AlipaySDK defaultService]fetchOrderInfoFromH5PayUrl:[navigationAction.request.URL absoluteString]];
    //    if (orderInfo.length > 0) {
    //        [self payWithUrlOrder:orderInfo];
    //    }
    //    //拨打电话
    //    //兼容安卓的服务器写法:<a class = "mobile" href = "tel://电话号码"></a>
    //    NSString *mobileUrl = [[navigationAction.request URL] absoluteString];
    //    mobileUrl = [mobileUrl stringByRemovingPercentEncoding];
    //    NSArray *urlComps = [mobileUrl componentsSeparatedByString:@"://"];
    //    if ([urlComps count]){
    //
    //        if ([[urlComps objectAtIndex:0] isEqualToString:@"tel"]) {
    //
    //            UIAlertController *mobileAlert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"拨号给 %@ ？",urlComps.lastObject] preferredStyle:UIAlertControllerStyleAlert];
    //            UIAlertAction *suerAction = [UIAlertAction actionWithTitle:@"拨号" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    //
    //                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mobileUrl]];
    //            }];
    //            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    //                return ;
    //            }];
    //
    //            [mobileAlert addAction:suerAction];
    //            [mobileAlert addAction:cancelAction];
    //
    //            [self presentViewController:mobileAlert animated:YES completion:nil];
    //        }
    //    }
    
    
    switch (navigationAction.navigationType) {
        case WKNavigationTypeLinkActivated: {
            [self pushCurrentSnapshotViewWithRequest:navigationAction.request];
            break;
        }
        case WKNavigationTypeFormSubmitted: {
            [self pushCurrentSnapshotViewWithRequest:navigationAction.request];
            break;
        }
        case WKNavigationTypeBackForward: {
            break;
        }
        case WKNavigationTypeReload: {
            break;
        }
        case WKNavigationTypeFormResubmitted: {
            break;
        }
        case WKNavigationTypeOther: {
            [self pushCurrentSnapshotViewWithRequest:navigationAction.request];
            break;
        }
        default: {
            break;
        }
    }
    [self updateNavigationItems];
    decisionHandler(WKNavigationActionPolicyAllow);
}

//请求链接处理
-(void)pushCurrentSnapshotViewWithRequest:(NSURLRequest*)request{
    //    NSLog(@"push with request %@",request);
    NSURLRequest* lastRequest = (NSURLRequest*)[[self.snapShotsArray lastObject] objectForKey:@"request"];
    
    //如果url是很奇怪的就不push
    if ([request.URL.absoluteString isEqualToString:@"about:blank"]) {
        //        NSLog(@"about blank!! return");
        return;
    }
    
    if ([request.URL.absoluteString hasPrefix:@"weixin:"] || [request.URL.absoluteString hasPrefix:@"mqqapi:"] || [request.URL.absoluteString hasPrefix:@"alipays:"]) {
        
        if (@available(iOS 10.0, *)) {
            
            [[UIApplication sharedApplication]openURL:request.URL options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:nil];
        } else{
            [[UIApplication sharedApplication] openURL:request.URL];
        }
        
    }
    
    
    //如果url一样就不进行push
    if ([lastRequest.URL.absoluteString isEqualToString:request.URL.absoluteString]) {
        return;
    }
    UIView* currentSnapShotView = [self.wkWebView snapshotViewAfterScreenUpdates:YES];
    [self.snapShotsArray addObject:
     @{@"request":request,@"snapShotView":currentSnapShotView}];
}

// 内容加载失败时候调用
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"页面加载超时");
}

//跳转失败的时候调用
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{}

//进度条
-(void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{}

#pragma mark ================ WKUIDelegate ================

//// 获取js 里面的提示
//-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
//
////    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
////    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
////        completionHandler();
////    }]];
////
////    [self presentViewController:alert animated:YES completion:NULL];
//}
//
//// js 信息的交流
//-(void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
////    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
////    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
////        completionHandler(YES);
////    }]];
////    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
////        completionHandler(NO);
////    }]];
////    [self presentViewController:alert animated:YES completion:NULL];
//}
//
//// 交互。可输入的文本。
//-(void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
//
////    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"textinput" message:@"JS调用输入框" preferredStyle:UIAlertControllerStyleAlert];
////    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
////        textField.textColor = [UIColor redColor];
////    }];
////    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
////        completionHandler([[alert.textFields lastObject] text]);
////    }]];
////
////    [self presentViewController:alert animated:YES completion:NULL];
//
//}

//KVO监听进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.wkWebView) {
        [self.progressView setAlpha:1.0f];
        BOOL animated = self.wkWebView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.wkWebView.estimatedProgress animated:animated];
        
        // Once complete, fade out UIProgressView
        if(self.wkWebView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark ================ WKScriptMessageHandler ================

//拦截执行网页中的JS方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    //服务器固定格式写法 window.webkit.messageHandlers.名字.postMessage(内容);
    //客户端写法 message.name isEqualToString:@"名字"]
    if ([message.name isEqualToString:@"WXPay"]) {
        NSLog(@"%@", message.body);
        
    }
}


#pragma mark ================== 导航栏事件 =======================



-(void)updateNavigationItems{
    if (self.wkWebView.canGoBack) {
        UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceButtonItem.width = - 6.5;
        
        [self.navigationItem setLeftBarButtonItems:@[spaceButtonItem,self.backBarItem,self.closeBarItem] animated:NO];
    }else{
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        [self.navigationItem setLeftBarButtonItems:@[]];
    }
    if(self.wkWebView.canGoForward){
        
    }else{
        
    }
}

- (void)setIsNavHidden:(BOOL)isNavHidden{
    
    self.navigationController.navigationBarHidden = YES;
    //创建一个高20的假状态栏
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20)];
    //设置成绿色
    statusBarView.backgroundColor=[UIColor whiteColor];
    // 添加到 navigationBar 上
    [self.view addSubview:statusBarView];
    
    
}

- (void)roadLoadClicked{
    [self.wkWebView reload];
}

- (void)backItemClick{
    if (self.wkWebView.canGoBack) {
        [self.wkWebView goBack];
        [self updateNavigationItems];
    }else{
        if(self.wkWebView.backForwardList.backList.count > 0){
            [self.wkWebView goToBackForwardListItem:self.wkWebView.backForwardList.backList[0]];
        }else{
            [self.wkWebView goBack];
        }
        [self updateNavigationItems];
    }
}

- (void)closeItemClick{
    [self.wkWebView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    self.wkWebView = nil;
    [self loadWebURLString:self.URLString];
    
}

- (void)goForward{
    NSURL *url = [NSURL URLWithString:@"http://www.756pay.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.wkWebView loadRequest:request];
    
    [self updateNavigationItems];
}
#pragma mark ==================== 懒加载 =======================

- (WKWebView *)wkWebView{
    if(!_wkWebView){
        // 设置网页的配置文件
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        // 允许在线播放
        configuration.allowsInlineMediaPlayback = YES;
        // 允许可以与网页交互，选择视图
        configuration.selectionGranularity = YES;
        // web内容处理池
        configuration.processPool = [[WKProcessPool alloc] init];
        //自定义配置,一般用于 js调用oc方法(OC拦截URL中的数据做自定义操作)
        WKUserContentController * UserContentController = [[WKUserContentController alloc]init];
        // 添加消息处理，注意：self指代的对象需要遵守WKScriptMessageHandler协议，结束时需要移除
        [UserContentController addScriptMessageHandler:self name:@"WXPay"];
        // 是否支持记忆读取
        configuration.suppressesIncrementalRendering = YES;
        // 允许用户更改网页的设置
        configuration.userContentController = UserContentController;
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 20, KAPPW, KAPPH-70) configuration:configuration];
        _wkWebView.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];
        //kvo 添加进度监控
        [_wkWebView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:WkwebBrowserContext];
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
        //开启手势触摸
        _wkWebView.allowsBackForwardNavigationGestures = YES;
        // 设置 可以前进 和 后退
        //适应你设定的尺寸
        [_wkWebView sizeToFit];
        [self.view addSubview:_wkWebView];
          [self.view addSubview:self.menuView];
        
    }
    return _wkWebView;
}



- (UIBarButtonItem *)backBarItem{
    if(!_backBarItem){
        UIImage *selectedImage = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e61b", 24,nil)];
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _backBarItem = [[UIBarButtonItem alloc] initWithImage:selectedImage  style:UIBarButtonItemStylePlain target:self action:@selector(backItemClick)];
        
    }
    return _backBarItem;
}

- (UIBarButtonItem *)closeBarItem{
    if(!_closeBarItem){
        UIImage *closeImage = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e65f", 24,nil)];
        closeImage = [closeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _closeBarItem = [[UIBarButtonItem alloc] initWithImage:closeImage  style:UIBarButtonItemStylePlain target:self action:@selector(closeItemClick)];
    }
    return _closeBarItem;
}

- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
      
        _progressView.frame = CGRectMake(0, 20, [[UIScreen mainScreen] bounds].size.width, 3);
      
        
        [_progressView setTrackTintColor:KColor(240, 240, 240, 1)];
        // 设置进度条的色彩
        UIColor *color = nil;
        if (AppType == 0) {//足球
            color = KColor(0, 143, 96, 1);
        }else{
            color = [UIColor redColor];
        }
        _progressView.progressTintColor = color;
        [self.view addSubview:_progressView];
        
        

    }
    return _progressView;
}

- (NSMutableArray *)snapShotsArray{
    if(!_snapShotsArray){
        _snapShotsArray = [NSMutableArray array];
    }
    return _snapShotsArray;
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"WXPay"];
    [self.wkWebView setNavigationDelegate:nil];
    [self.wkWebView setUIDelegate:nil];
}

//注意，观察的移除
-(void)dealloc{
    [self.wkWebView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
}

@end
