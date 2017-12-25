//
//  WZXFindViewController.m
//  WZXArchitecture
//
//  Created by wuzhuoxuan on 2017/7/25.
//  Copyright © 2017年 wuzhuoxuan. All rights reserved.
//

#import "WZXFindViewController.h"
#import "WZXFindViewModel.h"
#import "BRXHWebViewController.h"

@interface WZXFindViewController ()

@end

@implementation WZXFindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *clickBtn = [[UIButton alloc]init];
    [clickBtn setTitle:@"点击按钮网络请求，请求完路由跳转页面" forState:UIControlStateNormal];
    [clickBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [clickBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clickBtn];
    clickBtn.sd_layout
    .leftSpaceToView(self.view, 50)
    .rightSpaceToView(self.view, 50)
    .topSpaceToView(self.view, 100)
    .heightIs(50);
    
    UIButton *urlBtn = [[UIButton alloc]init];
    [urlBtn setTitle:@"跳转URL" forState:UIControlStateNormal];
    [urlBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [urlBtn addTarget:self action:@selector(pushURL) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:urlBtn];
    urlBtn.sd_layout
    .leftSpaceToView(self.view, 50)
    .rightSpaceToView(self.view, 50)
    .topSpaceToView(clickBtn, 20)
    .heightIs(50);
    

    
    
    
    [self initTTF];
    
    
}


//-------------------TTF demo-------------------------------
-(void)initTTF{
    
    //参数（ttf id，大小，颜色【nil为ttf默认颜色】）
    UIImage *selectedImage2 = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e61b", 24,[UIColor redColor])];
    
    [self.view addSubview:[[UIImageView alloc] initWithImage:selectedImage2]];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 280, 40)];
    
    [self.view addSubview:label];
    
    label.font = [UIFont fontWithName:@"iconfont" size:15];//设置label的字体
    
    label.text = @"这是用label显示的iconfont  \U0000e61b";
    
}

- (void)click{
    
    // 发送请求
    RACSignal *signal = [[[WZXFindViewModel alloc]init].requestCommand execute:nil];
    [signal subscribeNext:^(id x) {
        [self navPushURL:@"WZXFindViewController?userId=88888&age=18"];
    }];
}

- (void)pushURL{
    [self.navigationController pushViewController:[[BRXHWebViewController alloc]init] animated:YES];
}

@end
