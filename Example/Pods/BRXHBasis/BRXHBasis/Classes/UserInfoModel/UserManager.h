//
//  UserManager.h
//  ZiQiuBeauty
//
//  Created by Rangguangyu on 16/10/9.
//  Copyright © 2016年 zgntech. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserManager : NSObject
{
    NSUserDefaults  *userDefault;
}
+(UserManager *)shareManager;
@property(nonatomic,strong)NSString       *token;
@property(nonatomic,assign)NSInteger    userId;
@property(nonatomic,strong)NSString     *phoneString;
/*
 {
 email      邮箱
 id         用户id
 nickname  昵称
 token
 url      头像
 username  用户名
 }
 */
@property(nonatomic,strong)NSMutableDictionary *userDict;//登录完成后获取用户资料信息

-(void)clearUserConfig;


@end
