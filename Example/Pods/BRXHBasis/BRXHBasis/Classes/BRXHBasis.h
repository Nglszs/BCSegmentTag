//
//  BRXHBasis.h
//  Pods
//
//  Created by mac on 2017/10/24.
//


#import "WZXNavBar.h"
#import "WZXNavigationController.h"
#import "WZXTabBarController.h"
#import "WZXNetworking.h"
#import "BRXHWebViewController.h"
#import "UserInfo.h"
#import "MBProgressHUD+WZX.h"
#import "NSArray+WZX.h"
#import "NSDictionary+WZX.h"
#import "NSString+WZXString.h"
#import "UIColor+WZX.h"
#import "UIFont+Hex.h"
#import "UITableView+Hex.h"
#import "UIImage+WZXGImage.h"
#import "UIView+Hex.h"
#import "BRXHViewController.h"
#import "BDImagePicker.h"
#import "Notifications.h"
#import "BRXHLocation.h"
#import "UIViewController+HUD.h"
#import "HomeWebViewController.h"
#import "BRXHLandscapeViewController.h"
#import "BRXHBasisImageColor.h"
#import "UserManager.h"
#import "YKeychain.h"

#import "MJExtension.h"
#import "MJRefresh.h"
#import "SDAutoLayout.h"
#import "JLRoutes.h"
#import "Masonry.h"
#import "ReactiveObjC.h"
#import "BlocksKit.h"
#import "SDWebImageManager.h"
#import "ZFPlayer.h"
#import "UIImageView+WebCache.h"
#import "KSPhotoBrowser.h"
#import "IQKeyboardManager.h"
#import "BasicTools.h"
#import "MKButton.h"
#import "TBCityIconFont.h"
#import "UIImage+TBCityIconFont.h"
#import "SVProgressHUD+FG.h"
#import "SDCycleScrollView.h"

//获取系统对象
#define KApplication        [UIApplication sharedApplication]
#define KAppWindow          [UIApplication sharedApplication].delegate.window
#define KAppDelegate        [AppDelegate shareAppDelegate]
#define KRootViewController [UIApplication sharedApplication].delegate.window.rootViewController
#define KUserDefaults       [NSUserDefaults standardUserDefaults]
#define KNotificationCenter [NSNotificationCenter defaultCenter]

//获取当前语言
#define KCURRENT_LANGUAGE ([[NSLocale preferredLanguages] objectAtIndex:0])
//判断是否为iPhone
#define KIS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//判断是否为iPad
#define KIS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// 屏幕高度
#define KAPPH [[UIScreen mainScreen] bounds].size.height

// 屏幕宽度
#define KAPPW [[UIScreen mainScreen] bounds].size.width

// 设置view的圆角边框
#define KLRViewBorderRadius(View, Radius, Width, Color)\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]];

//获取temp
#define KPathTemp NSTemporaryDirectory()

//获取沙盒 Document
#define KPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

//获取沙盒 Cache
#define KPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

// RGB颜色
#define KColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

// Label黑色
#define LableBlack [UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0]

// Label灰色
#define LableGray [UIColor colorWithRed: 120.0/255.0 green:120.0/255.0 blue:120.0/255.0 alpha:1.0]

// 随机色
#define KRandomColor KColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

//rgb颜色(十六进制)
#define KUIColorFromHexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


//字符串是否为空
#define KString_Is_Empty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define KArray_Is_Empty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define KDict_Is_Empty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
//是否是空对象
#define KObject_Is_Empty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))



//将对象转换成弱引用类型，有block时使用
#define WeakObj(obj) __block __weak typeof(obj) weak_##obj = obj
#define StrongObj(type) __strong typeof(type) type = weak##type;


//DEBUG模式下,打印日志(包括函数名、行号)
#ifdef DEBUG
# define NSLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
# define NLog(...)
#endif
//以iphone6为基准向下适配宽高
#define AutoWidth_6(width)  (width)*(KAPPW/375)
/*距离顶部64*/
#define Top 64

//iOS 版本判断
#define IOSAVAILABLEVERSION(version) ([[UIDevice currentDevice] availableVersion:version] < 0)

//获取一段时间间隔
#define KStartTime CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define KEndTime  NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start)

//打印当前方法名
#define KITTDPRINTMETHODNAME() ITTDPRINT(@"%s", __PRETTY_FUNCTION__)
//http://api.btxgame.com/


// 谨慎修改框架控制接口地址
#define KHttpUrl @"http://i.btxgame.com/"

// 谨慎修改数据接口地址
#define KDateUrl @"http://api.zry1688.com/"

// 图片地址
#define KImageUrl @"http://brxh8.cc/files/img/"

//单例化一个类
// @interface
#define singleton_interface(className) \
+ (className *)shared##className;

// @implementation
#define singleton_implementation(className) \
static className *_instance; \
+ (id)allocWithZone:(NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
+ (className *)shared##className \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
}



#define BRXHLocalString(key) NSLocalizedString(key, nil)

#define CPNewNSStringName(key)  ({\
NSString *app_Name = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];\
app_Name = [app_Name substringToIndex:2];\
NSString *path = [[NSBundle mainBundle] pathForResource:@"language" ofType:@"plist"];\
NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:path];\
NSString *value = dictionary[key] ? dictionary[key] : key;\
NSString *value1 = [value rangeOfString:@"11选5"].location != NSNotFound ? [value substringToIndex:2]:value;\
NSString *value2 = [value1 rangeOfString:@"11选3"].location != NSNotFound ? [value1 substringToIndex:2]:value1;\
value = [value isEqualToString:value2] ? [value substringFromIndex:2] : value2;\
NSString *str = [NSString stringWithFormat:@"%@%@",app_Name,value];\
str;\
})


