//
//  WZXTabBarController.m
//  WZXArchitecture
//
//  Created by wuzhuoxuan on 2017/7/10.
//  Copyright © 2017年 wuzhuoxuan. All rights reserved.
//

#import "WZXTabBarController.h"
#import "WZXNavigationController.h"
#import "UIImage+WZXGImage.h"


@interface WZXTabBarController ()

@end

@implementation WZXTabBarController

+ (instancetype)shareInstance {
    
    static WZXTabBarController *tabbarC;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tabbarC = [[WZXTabBarController alloc] init];
    });
    return tabbarC;
}

+ (instancetype)tabBarControllerWithAddChildVCsBlock: (void(^)(WZXTabBarController *tabBarC))addVCBlock {
    
    WZXTabBarController *tabbarVC = [[WZXTabBarController alloc] init];
    if (addVCBlock) {
        addVCBlock(tabbarVC);
    }
    
    return tabbarVC;
}


/**
 *  根据参数, 创建并添加对应的子控制器
 *
 *  @param vc                需要添加的控制器(会自动包装导航控制器)
 *  @param isRequired             标题
 *  @param normalImageName   一般图片名称
 *  @param selectedImageName 选中图片名称
 */
- (void)addChildVC: (UIViewController *)vc title: (NSString *)title normalImageName: (NSString *)normalImageName selectedImageName:(NSString *)selectedImageName isRequiredNavController: (BOOL)isRequired {
    
    if (isRequired) {
        WZXNavigationController *nav = [[WZXNavigationController alloc] initWithRootViewController:vc];
        vc.title = title;
        nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[UIImage originImageWithName:normalImageName] selectedImage:[UIImage originImageWithName:selectedImageName]];
        [self addChildViewController:nav];
    }else {
        [self addChildViewController:vc];
    }
    
}



/**
 *  根据参数, 创建并添加对应的子控制器
 *
 *  @param vc                需要添加的控制器(会自动包装导航控制器)
 *  @param isRequired             标题
 *  @param normalImage   一般图片
 *  @param selectedImage 选中图片
 *  @param titleColor    选中title color
 */
- (void)addChildVC: (UIViewController *)vc title: (NSString *)title normalImage: (UIImage *)normalImage selectedImage:(UIImage *)selectedImage isRequiredNavController: (BOOL)isRequired andTitleColor :(UIColor *)titleColor{
    
    if (isRequired) {
        WZXNavigationController *nav = [[WZXNavigationController alloc] initWithRootViewController:vc];
        vc.title = title;
        
        nav.tabBarItem.title = title;
        
        nav.tabBarItem.image = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        nav.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
        
        [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor} forState:UIControlStateSelected];
        
        [self addChildViewController:nav];
        
    }else {
        [self addChildViewController:vc];
    }
    
}


- (void)addChildVC: (BRXHViewController *)vc title: (NSString *)title type: (NSInteger)type normalImage: (UIImage *)normalImage selectedImage:(UIImage *)selectedImage isRequiredNavController: (BOOL)isRequired andTitleColor :(UIColor *)titleColor{
    if (isRequired) {
        WZXNavigationController *nav = [[WZXNavigationController alloc] initWithRootViewController:vc];
        vc.title = title;
        nav.tabBarItem.title = title;
        vc.type = type;
        nav.tabBarItem.image = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        nav.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
        
        [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor} forState:UIControlStateSelected];
        
        [self addChildViewController:nav];
        
    }else {
        [self addChildViewController:vc];
    }
    
}
@end
