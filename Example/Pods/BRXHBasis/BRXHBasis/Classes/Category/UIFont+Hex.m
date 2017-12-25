//
//  UIFont+Hex.m
//  EpetConcept
//
//  Created by epetbar on 16/7/19.
//  Copyright © 2016年 wubangxin. All rights reserved.
//

#import "UIFont+Hex.h"

//不同设备的屏幕比例(当然倍数可以自己控制)
#define SizeScale ((KAPPH > 568) ? KAPPH/568 : 1)


@implementation UIFont (Hex)

/// fontWithName 要读取 单例对象的字体名称

+ (UIFont *)customFontWithSize:(CGFloat)fontSize
{
    
//    Helvetica Neue Light 30.0  Helvetica Neue Medium 30.0

 
//    CGFloat  sizes=fontSize*SizeScale;
    
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    
    if (font == nil) {//Avenir-Light Helvetica Neue-Light  HelveticaNeue-Light
        
        font = [UIFont systemFontOfSize:fontSize];
    }
   
    return font;
}


//加粗
+ (UIFont *)customBoldFontWithSize:(CGFloat)fontSize
{
     CGFloat  sizes=fontSize*SizeScale;
    
    UIFont *font = [UIFont boldSystemFontOfSize:sizes];
    
    if (font == nil) {//Avenir-Medium Helvetica Neue-Medium
        
        font = [UIFont boldSystemFontOfSize:fontSize];
    }
  
    return font;
}

@end
