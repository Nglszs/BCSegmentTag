//
//  NSDictionary+WZX.m
//  WZXArchitecture
//
//  Created by wuzhuoxuan on 2017/7/21.
//  Copyright © 2017年 wuzhuoxuan. All rights reserved.
//

#import "NSDictionary+WZX.h"
#import <objc/runtime.h>
@implementation NSDictionary (WZX)

+(id)ZLJChangeType:(id)myObj
{
    if ([myObj isKindOfClass:[NSDictionary class]])
    {
        return [self nullDic:myObj];
    }
    else if([myObj isKindOfClass:[NSArray class]])
    {
        return [self nullArr:myObj];
    }
    else if([myObj isKindOfClass:[NSString class]])
    {
        return [self stringToString:myObj];
    }
    else if([myObj isKindOfClass:[NSNull class]])
    {
        return [self nullToString];
    }
    //    else if([myObj isKindOfClass:[NSNumber class]])
    //    {
    //        return [self numberToString:myObj];
    //    }
    else
    {
        return myObj;
    }
}
#pragma mark - 私有方法
//将NSDictionary中的Null类型的项目转化成@""
+(NSDictionary *)nullDic:(NSDictionary *)myDic
{
    NSArray *keyArr = [myDic allKeys];
    NSMutableDictionary *resDic = [[NSMutableDictionary alloc]init];
    for (int i = 0; i < keyArr.count; i ++)
    {
        id obj = [myDic objectForKey:keyArr[i]];
        
        obj = [self ZLJChangeType:obj];
        
        [resDic setObject:obj forKey:keyArr[i]];
    }
    return resDic;
}

//将NSDictionary中的Null类型的项目转化成@""
+(NSArray *)nullArr:(NSArray *)myArr
{
    NSMutableArray *resArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < myArr.count; i ++)
    {
        id obj = myArr[i];
        
        obj = [self ZLJChangeType:obj];
        
        [resArr addObject:obj];
    }
    return resArr;
}

//将NSString类型的原路返回
+(NSString *)stringToString:(NSString *)string
{
    
    if (KString_Is_Empty(string)) {
        return @"";
    } else {
        return string;
    }
}

//将Null类型的项目转化成@""
+(NSString *)nullToString
{
    return @"";
}
+(NSString *)numberToString:(NSNumber *)number
{
    return [NSString stringWithFormat:@"%@",number];
}


+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self exchangeOriginalMethod:class_getInstanceMethod(objc_getClass("__NSDictionaryI"), @selector(dictionaryWithObjects:forKeys:count:)) withNewMethod:class_getInstanceMethod(object_getClass(@"__NSDictionaryI"), @selector(wzx_dictionaryWithObjects:forKeys:count:))];
        [self exchangeOriginalMethod:class_getInstanceMethod(objc_getClass("__NSDictionaryM"), @selector(setObject:forKey:)) withNewMethod:class_getInstanceMethod(objc_getClass("__NSDictionaryM"), @selector(wzx_setObject:forKey:))];
    });
}


+ (instancetype)wzx_dictionaryWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)count{
    id validObjects[count];
    id<NSCopying> validKeys[count];
    NSUInteger cnt = 0;
    for (NSUInteger i = 0; i < count; i++)
    {
        if (objects[i] && keys[i])
        {
            validObjects[cnt] = objects[i];
            validKeys[cnt] = keys[i];
            count ++;
        }
        else
        {
            NSLog(@"[%@ %@] NIL object or key at index{%lu}.",
                    NSStringFromClass(self),
                    NSStringFromSelector(_cmd),
                    (unsigned long)i);
        }
    }
    
    return [self wzx_dictionaryWithObjects:validObjects forKeys:validKeys count:count];

}

- (void)wzx_setObject:(id)object forKey:(NSString *)key{
    if(!object){
        @try{
            [self wzx_setObject:object forKey:key];
        } @catch(NSException *exception){
            NSLog(@"---------- %s 字典添加为空 %s  ----------\n", class_getName(self.class), __func__);
            NSLog(@"%@", [exception callStackSymbols]);
            object = [NSString stringWithFormat:@""];
            [self wzx_setObject:object forKey:key];
        } @finally{
            
        }
    }else{
        [self wzx_setObject:object forKey:key];
    }
}

+ (void)exchangeOriginalMethod:(Method)originalMethod withNewMethod:(Method)newMethod
{
    method_exchangeImplementations(originalMethod, newMethod);
}
@end
