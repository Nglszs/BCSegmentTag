 //
//  UIView+frameAdjust.h
//  fenbi
//
//  Created by Tang Qiao on 12-5-31.
//  Copyright (c) 2012年 Fenbi.com . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Hex)

- (CGPoint)origin;
- (void)setOrigin:(CGPoint) point;

- (CGSize)size;
- (void)setSize:(CGSize) size;

- (CGFloat)x;
- (void)setX:(CGFloat)x;

- (CGFloat)y;
- (void)setY:(CGFloat)y;

- (CGFloat)height;
- (void)setHeight:(CGFloat)height;

- (CGFloat)width;
- (void)setWidth:(CGFloat)width;

- (CGFloat)tail;
- (void)setTail:(CGFloat)tail;

- (CGFloat)bottom;
- (void)setBottom:(CGFloat)bottom;

- (CGFloat)right;
- (void)setRight:(CGFloat)right;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

///View的边框设置(边框的颜色 圆角)
-(void)borderWidth:(CGFloat)borderWidth withBorderColor:(UIColor *)withBorderColor withCornerradius:(CGFloat)withCornerradius withMasksToBounds:(BOOL)withMasksToBounds;

@property (assign,nonatomic) CGFloat tyHeight;
@property (assign,nonatomic) CGFloat tyY;


///自定义view的阴影
-(void)setShadowColor:(UIColor *)shadowColor  withShadowOffset:(CGSize)sizeMake withShadowOpacity:(CGFloat)shadowOpacity  withShadowRadius:(CGFloat)shadowRadius;

///底部view通用磨默认的阴影
-(void)viewBottomDefault;

///获取当前ViewController
- (UIViewController*)currentController;
    
@end
