//
//  UserManager.m
//  ZiQiuBeauty
//
//  Created by Rangguangyu on 16/10/9.
//  Copyright © 2016年 zgntech. All rights reserved.
//

#import "UserManager.h"
#define UserTokenKey       @"User.UserTokenKey"
#define UserUserIdKey       @"User.UserUserIdKey"
#define PhoneString      @"User.phoneString"
#define UserDictKey    @"User.UserDictKey"

@implementation UserManager

@synthesize token=_token;
@synthesize userId=_userId;
@synthesize userDict=_userDict;
@synthesize phoneString=_phoneString;

+(UserManager *)shareManager
{
    static  dispatch_once_t  onceToken;
    static  UserManager  *shareInstance;
    dispatch_once(&onceToken, ^{
        shareInstance=[[UserManager  alloc] init];
    });
    return shareInstance;
}

-(id)init
{
    self=[super init];
    if (self) {
        userDefault=[NSUserDefaults  standardUserDefaults];
    }
    return self;
}

-(NSInteger)userId{
    _userId=[userDefault  integerForKey:UserUserIdKey];
    return _userId;
}

-(void)setUserId:(NSInteger)userId
{
    _userId=userId;
    [userDefault  setInteger:_userId forKey:UserUserIdKey];
    [userDefault  synchronize];
}

-(NSString *)token
{
    _token=[userDefault  stringForKey:UserTokenKey];
    return _token;
}

-(void)setToken:(NSString *)token
{
    _token=token;
    [userDefault  setObject:_token forKey:UserTokenKey];
    [userDefault  synchronize];
    
}
-(void)setPhoneString:(NSString *)phoneString{
    _phoneString=phoneString;
    [userDefault setObject:_phoneString forKey:PhoneString];
    [userDefault synchronize];
}
-(NSString *)phoneString{
    _phoneString=[userDefault objectForKey:PhoneString];
    return _phoneString;
}

-(NSMutableDictionary *)userDict
{
    _userDict=[userDefault  objectForKey:UserDictKey];
    return _userDict;
}

-(void)setUserDict:(NSMutableDictionary *)userDict
{
    _userDict=userDict;
    [userDefault  setObject:_userDict forKey:UserDictKey];
    [userDefault  synchronize];
}

-(void)clearUserConfig
{
    [[userDefault  dictionaryRepresentation] enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key  hasPrefix:@"User."]) {
            [userDefault  removeObjectForKey:key];
        }
    }];
    [userDefault  synchronize];
    [NSUserDefaults resetStandardUserDefaults];
    userDefault=[NSUserDefaults standardUserDefaults];
}

@end
