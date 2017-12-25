//
//  BRXHLocation.m
//  BRXHBrowser
//
//  Created by mac on 2017/10/31.
//  Copyright © 2017年 lileil. All rights reserved.
//

#import "BRXHLocation.h"

#import <CoreLocation/CoreLocation.h>

@interface BRXHLocation ()<CLLocationManagerDelegate>

@property (nonatomic,strong) CLLocationManager *locationManager;

@property (nonatomic,strong) NSDictionary *locationDict;

@end


@implementation BRXHLocation

- (instancetype)init{
    if(self = [super init]){
        [self setUp];
    }
    return self;
}

- (void)setUp{
    self.locationManager = [[CLLocationManager alloc]init];
 
    
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务当前可能尚未打开，请设置打开！");
      
    }


        //设置代理
        self.locationManager.delegate=self;
        //设置定位精度
        self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        //定位频率,每隔多少米定位一次
        CLLocationDistance distance=10.0;//十米定位一次
        self.locationManager.distanceFilter=distance;

        //启动跟踪定位
        [self.locationManager startUpdatingLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    CLLocation *loc = [locations firstObject];
    
    CLLocationCoordinate2D coordinate = loc.coordinate;
    
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        for (CLPlacemark *place in placemarks) {
            NSDictionary *location =[place addressDictionary];
            NSLog(@"国家：%@",[location objectForKey:@"Country"]);
            NSLog(@"城市：%@",[location objectForKey:@"State"]);
            NSLog(@"区：%@",[location objectForKey:@"SubLocality"]);
            
            NSLog(@"位置：%@", place.name);
            NSLog(@"国家：%@", place.country);
            NSLog(@"城市：%@", place.locality);
            NSLog(@"区：%@", place.subLocality);
            NSLog(@"街道：%@", place.thoroughfare);
            NSLog(@"子街道：%@", place.subThoroughfare);
            if (place.locality) {
                [[NSUserDefaults standardUserDefaults] setObject:place.locality forKey:@"locality"];
                 [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }
    }];

    if(!self.locationDict){
        self.locationDict = @{ @"latitude": coordinate.latitude ? [NSString stringWithFormat:@"%f",coordinate.latitude] : @"0.00",
                              @"longitude": coordinate.longitude ? [NSString stringWithFormat:@"%f",coordinate.longitude] : @"0.00"
                               };
        if(self.locationBlock){
          self.locationBlock(self.locationDict);
        }
    }
    //NSLog(@"经度：%f ------------ 纬度：%f", coordinate.latitude,coordinate.longitude);
    [self.locationManager stopUpdatingLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"error == %@",error);
    if(!self.locationDict){
        if(self.locationBlock){
            self.locationBlock(@{ @"latitude": @"0.00",
                                  @"longitude": @"0.00"
                                  });
        }
    }
}

//定位服务状态改变时调用
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        {
            if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [self.locationManager requestAlwaysAuthorization];
            }
            NSLog(@"用户还未决定授权");
           
            break;
        }
        case kCLAuthorizationStatusRestricted:
        {
            NSLog(@"访问受限");
            if(!self.locationDict){
                if(self.locationBlock){
                    self.locationBlock(@{ @"latitude": @"0.00",
                                          @"longitude": @"0.00"
                                          });
                }
            }
            break;
        }
        case kCLAuthorizationStatusDenied:
        {
            // 类方法，判断是否开启定位服务
            if ([CLLocationManager locationServicesEnabled]) {
                NSLog(@"定位服务开启，被拒绝");
            } else {
                NSLog(@"定位服务关闭，不可用");
            }
          
            break;
        }
        case kCLAuthorizationStatusAuthorizedAlways:
        {
            NSLog(@"获得前后台授权");
            break;
        }
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            NSLog(@"获得前台授权");
            break;
        }
        default:
            break;
    }
    
}


+ (BRXHLocation *)obtainLocation:(LocationBlock)locationBlock{
    BRXHLocation *location = [[BRXHLocation alloc]init];
    if(locationBlock){
        locationBlock(@{ @"latitude": @"0.00",
                         @"longitude": @"0.00"
                         });
    }
//    location.locationBlock = ^(NSDictionary *dict) {
//        if(locationBlock){
//            locationBlock(dict);
//        }
//    };
    return location;
}


@end
