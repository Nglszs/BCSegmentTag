//
//  UIView+frameAdjust.m
//  fenbi
//
//  Created by Tang Qiao on 12-5-31.
//  Copyright (c) 2012年 Fenbi.com . All rights reserved.
//

#import "UIView+Hex.h"

@implementation UIView (Hex)

- (CGPoint) origin {
    return self.frame.origin;
}

- (void) setOrigin:(CGPoint) point {
    self.frame = CGRectMake(point.x, point.y, self.frame.size.width, self.frame.size.height);
}

- (CGSize) size {
    return self.frame.size;
}

- (void) setSize:(CGSize) size {
    self.frame = CGRectMake(self.x, self.y, size.width, size.height);
}

- (CGFloat) x {
    return self.frame.origin.x;
}

- (void) setX:(CGFloat)x {
    self.frame = CGRectMake(x, self.y, self.width, self.height);
}

- (CGFloat) y {
    return self.frame.origin.y;
}
- (void) setY:(CGFloat)y {
    self.frame = CGRectMake(self.x, y, self.width, self.height);
}

- (CGFloat) height {
    return self.frame.size.height;
}
- (void)setHeight:(CGFloat)height {
    self.frame = CGRectMake(self.x, self.y, self.width, height);
}

- (CGFloat)width {
    return self.frame.size.width;
}
- (void)setWidth:(CGFloat)width {
    self.frame = CGRectMake(self.x, self.y, width, self.height);
}

- (CGFloat)tail {
    return self.y + self.height;
}

- (void)setTail:(CGFloat)tail {
    self.frame = CGRectMake(self.x, tail - self.height, self.width, self.height);
}

- (CGFloat)bottom {
    return self.tail;
}

- (void)setBottom:(CGFloat)bottom {
    [self setTail:bottom];
}

- (CGFloat)right {
    return self.x + self.width;
}

- (void)setRight:(CGFloat)right {
    self.frame = CGRectMake(right - self.width, self.y, self.width, self.height);
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}



-(void)borderWidth:(CGFloat)borderWidth withBorderColor:(UIColor *)withBorderColor withCornerradius:(CGFloat)withCornerradius withMasksToBounds:(BOOL)withMasksToBounds{
    
    self.layer.borderWidth=borderWidth;
    
    if (withBorderColor==nil) {
        
        withBorderColor=[UIColor whiteColor];
    }
    self.layer.borderColor=withBorderColor.CGColor;
    
    if (withMasksToBounds==YES) {
        
        self.layer.masksToBounds=withMasksToBounds;
    }
    
    self.layer.cornerRadius=withCornerradius;
}

- (void)setTyHeight:(CGFloat)tyHeight{
    CGRect frame = self.frame;
    frame.size.height = tyHeight;
    self.frame = frame;
}
- (void)setTyY:(CGFloat)tyY{
    CGRect frame = self.frame;
    frame.origin.y = tyY;
    self.frame = frame;
}

-(void)setShadowColor:(UIColor *)shadowColor  withShadowOffset:(CGSize)sizeMake withShadowOpacity:(CGFloat)shadowOpacity  withShadowRadius:(CGFloat)shadowRadius{

    self.layer.shadowColor = shadowColor.CGColor;
    
    self.layer.shadowOffset =sizeMake;
    
    self.layer.shadowOpacity = shadowOpacity;
    
    self.layer.shadowRadius = shadowRadius;

}

-(void)viewBottomDefault{
    
    self.layer.shadowColor = [UIColor grayColor].CGColor;
    
    self.layer.shadowOffset = CGSizeMake(4,4);
    
    self.layer.shadowOpacity = 0.8;
    
    self.layer.shadowRadius = 4;
    
}

///获取当前ViewController
- (UIViewController *)currentController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
