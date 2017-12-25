//
//  WZXTabBarController.h
//  WZXArchitecture
//
//  Created by wuzhuoxuan on 2017/7/10.
//  Copyright © 2017年 wuzhuoxuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZXTabBarController : UITabBarController


/**
 获取单例对象
 
 @return TabBarController
 */
+ (instancetype)shareInstance;


/**
 添加子控制器的block
 
 @param addVCBlock 添加代码块
 
 @return TabBarController
 */
+ (instancetype)tabBarControllerWithAddChildVCsBlock: (void(^)(WZXTabBarController *tabBarC))addVCBlock;


/**
 添加子控制器
 
 @param vc                子控制器
 @param normalImageName   普通状态下图片
 @param selectedImageName 选中图片
 @param isRequired        是否需要包装导航控制器
 */
- (void)addChildVC: (UIViewController *)vc title: (NSString *)title normalImageName: (NSString *)normalImageName selectedImageName:(NSString *)selectedImageName isRequiredNavController: (BOOL)isRequired;


/**
 *  根据参数, 创建并添加对应的子控制器
 *
 *  @param vc                需要添加的控制器(会自动包装导航控制器)
 *  @param isRequired             标题
 *  @param normalImage   一般图片
 *  @param selectedImage 选中图片
 *  @param titleColor    选中title color
 */
- (void)addChildVC: (UIViewController *)vc title: (NSString *)title normalImage: (UIImage *)normalImage selectedImage:(UIImage *)selectedImage isRequiredNavController: (BOOL)isRequired andTitleColor :(UIColor *)titleColor;
/**
 *  根据参数, 创建并添加对应的子控制器
 *
 *  @param vc                需要添加的控制器(会自动包装导航控制器)
 *  @param isRequired             标题
 *  @param type   样式
 *  @param normalImage   一般图片
 *  @param selectedImage 选中图片
 *  @param titleColor    选中title color
 */
- (void)addChildVC: (UIViewController *)vc title: (NSString *)title type: (NSInteger)type normalImage: (UIImage *)normalImage selectedImage:(UIImage *)selectedImage isRequiredNavController: (BOOL)isRequired andTitleColor :(UIColor *)titleColor;
@end
