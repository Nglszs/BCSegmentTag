//
//  BRXHViewController.h
//  Pods
//
//  Created by mac on 2017/10/24.
//

#import <UIKit/UIKit.h>

@interface BRXHViewController : UIViewController
/**================ZLJBaseMethod 用到的变量和方法======================*/
@property (nonatomic, assign) CGFloat naviHeight;
@property (nonatomic, assign) BOOL isIphoneX;
@property (nonatomic, assign) CGFloat tabbarHeight;
- (void)ZLJBaseMethod;
/**=============================================================*/
// 根据type显示不同样式的界面
@property (nonatomic, assign) NSInteger type;
-(void)navPushURL:(NSString *)URL;
@end
