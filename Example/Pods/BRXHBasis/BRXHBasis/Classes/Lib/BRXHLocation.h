//
//  BRXHLocation.h
//  BRXHBrowser
//
//  Created by mac on 2017/10/31.
//  Copyright © 2017年 lileil. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LocationBlock)(NSDictionary *dict);

@interface BRXHLocation : NSObject

@property (nonatomic, copy)LocationBlock locationBlock;

+ (BRXHLocation *)obtainLocation:(LocationBlock)locationBlock;

@end
