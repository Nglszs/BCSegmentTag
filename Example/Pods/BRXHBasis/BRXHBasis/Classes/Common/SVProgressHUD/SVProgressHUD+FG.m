
//
//  SVProgressHUD+FG.m
//  YiMaMa
//
//  Created by LWF on 16/1/5.
//  Copyright © 2016年 YiMaMa. All rights reserved.
//

#import "SVProgressHUD+FG.h"

@implementation SVProgressHUD (FG)

+ (void)dismissWithSuccess:(NSString*)successString completion:(DissmissAnimationCompletion)completion{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD dismissWithSuccess:successString afterDelay:1];
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1+0.3 * NSEC_PER_SEC));
        
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            completion();
        });
    });
}

+ (void)dismissWithSuccess:(NSString*)successString afterDelay:(NSTimeInterval)seconds completion:(DissmissAnimationCompletion)completion{
    [SVProgressHUD dismissWithSuccess:successString afterDelay:seconds];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds+0.3 * NSEC_PER_SEC));
    
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        completion();
    });
}

+ (void)dismissWithError:(NSString*)errorString completion:(DissmissAnimationCompletion)completion{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD dismissWithError:errorString afterDelay:1];
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1+0.3 * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            completion();
        });
    });
}

+ (void)dismissWithError:(NSString*)errorString afterDelay:(NSTimeInterval)seconds completion:(DissmissAnimationCompletion)completion{
    [SVProgressHUD dismissWithError:errorString afterDelay:seconds];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds+0.3 * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        completion();
    });
}

@end
