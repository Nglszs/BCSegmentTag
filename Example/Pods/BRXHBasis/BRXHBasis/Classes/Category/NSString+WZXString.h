//
//  NSString+WZXString.h
//  WZXArchitecture
//
//  Created by wuzhuoxuan on 2017/7/20.
//  Copyright © 2017年 wuzhuoxuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WZXString)


/*小写加密*/
+ (NSString *)md5HexDigest:(NSString*)input;

/*大写加密*/
+ (NSString *)MD5HexDigest:(NSString*)input;

/*16位MD5加密方式   大写*/
+ (NSString *)md5sss:(NSString *)str;

/*32位MD5加密方式   大写*/
+ (NSString *)md5sssLiu:(NSString *)str;

/*验证身份证*/
+ (BOOL)checkIdentityCardNo:(NSString*)cardNo;

/*验证手机*/
+ (BOOL)validateMobile:(NSString *)mobile;

/*验证邮箱*/
+ (BOOL)validateEmail:(NSString *)email;

/*验证密码长度*/
+ (BOOL)validatePassword:(NSString *)passwordStr;

/**  计算只显示一行时的width  */
- (CGFloat)widthWithFont:(UIFont *)font;

/**  计算显示多行时的height  */
- (CGFloat)heightWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth;

///验证是否为空
+ (BOOL)isEmpty:(NSString *)string;

// 时间戳转标标准时间  默认形式YYYY-MM-dd hh:mm:ss
+(NSString *)timestampSwitchTime:(NSInteger)timestamp;
// 时间戳转标标准时间  可自定义形式: YYYY-MM-dd hh:mm:ss
+(NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format;
@end
