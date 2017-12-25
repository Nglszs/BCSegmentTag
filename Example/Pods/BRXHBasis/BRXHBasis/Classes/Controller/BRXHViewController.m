//
//  BRXHViewController.m
//  Pods
//
//  Created by mac on 2017/10/24.
//

#import "BRXHViewController.h"
#import "AFNetworking.h"
@interface BRXHViewController ()

@end

@implementation BRXHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

#pragma mark =====================ZLJBaseMethod开始===============================
- (void)ZLJBaseMethod {
    self.tabbarHeight = 49;
    if (KAPPH*3 == 2436.0) {
        [KUserDefaults setObject:@"88" forKey:@"naviHeight"];
        self.isIphoneX = 1;
        self.tabbarHeight = 83;
    } else {
        [KUserDefaults setObject:@"64" forKey:@"naviHeight"];
        self.isIphoneX = 0;
    }
    self.naviHeight = [[KUserDefaults objectForKey:@"naviHeight"] floatValue];
    self.navigationController.navigationBar.barTintColor = globalColor;
    if ([self isDarkColor:globalColor]) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    } else {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
}
-(BOOL)isDarkColor:(UIColor *)newColor{
    
    const CGFloat *componentColors = CGColorGetComponents(newColor.CGColor);
    CGFloat colorBrightness = ((componentColors[0] * 299) + (componentColors[1] * 587) + (componentColors[2] * 114)) / 1000;
    if (colorBrightness < 0.5){
        NSLog(@"Color is dark");
        return YES;
    }
    else{
        NSLog(@"Color is light");
        return NO;
    }
}
#pragma mark =====================ZLJBaseMethod结束===============================
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)navPushURL:(NSString *)URL{
    
    if (@available(iOS 10.0, *)) {
        
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[KPushURL(URL) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:nil];
    } else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[KPushURL(URL) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    }
    
}

@end
