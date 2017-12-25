//
//  BasicTools.h
//  JinwowoNew
//
//  Created by jww_mac_002 on 2017/3/1.
//  Copyright © 2017年 wubangxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CKAlertViewController.h"
#import "PathHeaders.h"
//#import "BugLogModelView.h"
@interface BasicTools : NSObject


///获取win
+ (UIWindow*)getwindow;

///HUD提示要手动关闭  等待中
+ (void)showHUDTitle:(NSString *)text animated:(BOOL)animated;

///HUD提示
+ (void)showHUDTitleTime:(NSString *)text duration:(NSTimeInterval)duration animated:(BOOL)animated;

/// HUD 取消
+ (void)dismissHUD;

///ToastHUD  提示  现实时间1秒 带有动画关闭
+ (void)toastHUD:(NSString *)content;

////提示框(两个按钮)
+(void)alertShowTwoBntTitleText:(NSString *)titleText withContentText:(NSString *)contentText withLeftBntTitleText:(NSString *)leftBntTitleText withRightBntTitleText:(NSString *)rightBntTitleText leftBlock:(void(^)(CKAlertAction *action))leftBlock rightBlock:(void(^)(CKAlertAction *action))rightBlock;

////提示框(一个按钮)
+(void)alertShowOneBntTitleText:(NSString *)titleText withContentText:(NSString *)contentText withLeftBntTitleText:(NSString *)leftBntTitleText leftBlock:(void(^)(CKAlertAction *action))leftBlock;

+(UIViewController *)getCurrentVC;

///通过堆栈跳转界面
+(UIViewController *)gotoPopToController:(Class)targetClass  thisController:(UIViewController *)thisController tabarIndex:(NSInteger)index;

@end

