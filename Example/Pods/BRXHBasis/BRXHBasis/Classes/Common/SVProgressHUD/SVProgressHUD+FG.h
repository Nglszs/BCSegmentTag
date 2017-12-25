//
//  SVProgressHUD+FG.h
//  YiMaMa
//
//  Created by LWF on 16/1/5.
//  Copyright © 2016年 YiMaMa. All rights reserved.
//

#import "SVProgressHUD.h"
typedef void (^DissmissAnimationCompletion)();

@interface SVProgressHUD (FG)

+ (void)dismissWithSuccess:(NSString*)successString completion:(DissmissAnimationCompletion)completion;

+ (void)dismissWithSuccess:(NSString*)successString afterDelay:(NSTimeInterval)seconds completion:(DissmissAnimationCompletion)completion;

+ (void)dismissWithError:(NSString*)errorString completion:(DissmissAnimationCompletion)completion;

+ (void)dismissWithError:(NSString*)errorString afterDelay:(NSTimeInterval)seconds completion:(DissmissAnimationCompletion)completion;

@end
