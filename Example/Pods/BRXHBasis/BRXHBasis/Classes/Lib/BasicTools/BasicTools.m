//
//  BasicTools.m
//  JinwowoNew
//
//  Created by jww_mac_002 on 2017/3/1.
//  Copyright © 2017年 wubangxin. All rights reserved.
//

#import "BasicTools.h"

#import "WKProgressHUD.h"

@implementation BasicTools



+ (void)showHUDTitle:(NSString *)text animated:(BOOL)animated{
    
    [WKProgressHUD showInView:[self getwindow] withText:text animated:animated];
}

+ (void)toastHUD:(NSString *)content{
    
    [self showHUDTitleTime:content duration:1 animated:YES];
    
}
+ (void)showHUDTitleTime:(NSString *)text duration:(NSTimeInterval)duration animated:(BOOL)animated{
    
    [WKProgressHUD popMessage:text inView:[self getwindow] duration:duration animated:animated];
}

+ (void)dismissHUD{
    
    [WKProgressHUD dismissAll:YES];
}

////提示框(两个按钮)
+(void)alertShowTwoBntTitleText:(NSString *)titleText withContentText:(NSString *)contentText withLeftBntTitleText:(NSString *)leftBntTitleText withRightBntTitleText:(NSString *)rightBntTitleText leftBlock:(void(^)(CKAlertAction *action))leftBlock rightBlock:(void(^)(CKAlertAction *action))rightBlock{

    CKAlertViewController *alertVC = [CKAlertViewController alertControllerWithTitle:titleText message:contentText];
    
    CKAlertAction *cancel = [CKAlertAction actionWithTitle:leftBntTitleText handler:^(CKAlertAction *action){
    
        leftBlock(action);
    }];
    
    CKAlertAction *update = [CKAlertAction actionWithTitle:rightBntTitleText handler:^(CKAlertAction *action){
        
       rightBlock(action);
        
    }];
    
    [alertVC addAction:cancel];
    
    [alertVC addAction:update];
    
    [[BasicTools getCurrentVC] presentViewController:alertVC animated:NO completion:nil];

}

/**** toast 提示***/
+ (UIWindow*)getwindow{
    
    return [UIApplication sharedApplication].keyWindow;
}

////提示框(一个按钮)
+(void)alertShowOneBntTitleText:(NSString *)titleText withContentText:(NSString *)contentText withLeftBntTitleText:(NSString *)leftBntTitleText leftBlock:(void(^)(CKAlertAction *action))leftBlock {
    
    CKAlertViewController *alertVC = [CKAlertViewController alertControllerWithTitle:titleText message:contentText];
    
    CKAlertAction *cancel = [CKAlertAction actionWithTitle:leftBntTitleText handler:^(CKAlertAction *action){
    
  
       
        leftBlock(action);
    

    }];
   
    [alertVC addAction:cancel];
    
    [[BasicTools getCurrentVC] presentViewController:alertVC animated:NO completion:nil];
    
}

+(UIViewController *)getCurrentVC{
    
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //        UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result=nav.childViewControllers.lastObject;
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    
    return result;
}

///通过堆栈跳转界面
+(UIViewController *)gotoPopToController:(Class)targetClass  thisController:(UIViewController *)thisController tabarIndex:(NSInteger)index{
    
    UIViewController *target = nil;
    
    UINavigationController *nav=[thisController.tabBarController.viewControllers objectAtIndex:index];
    
    NSMutableArray *navigationArray = [[NSMutableArray alloc] initWithArray:nav.viewControllers];
    
    for (UIViewController * controller in navigationArray) { //遍历
        
        for (UIViewController * kewrap in  controller.childViewControllers) {
            
            for (UIViewController *vc in kewrap.childViewControllers) {
                
                if ([vc isKindOfClass:targetClass]) { //这里判断是否为你想要跳转的页面
                    
                    target = controller;
                    
                    break;
                }
                
            }
        }
    }
    
    if (target) {
        
        //        [thisController.navigationController popToViewController:target animated:YES]; //跳转
        return target;
    }else{
        
        return nil;
    }
    
    
    
}

@end
