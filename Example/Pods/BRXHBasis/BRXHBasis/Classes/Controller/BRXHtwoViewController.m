//
//  BRXHtwoViewController.m
//  BRXHBasis_Example
//
//  Created by mac on 2017/11/6.
//  Copyright © 2017年 BRXH. All rights reserved.
//

#import "BRXHtwoViewController.h"

@interface BRXHtwoViewController ()

@end

@implementation BRXHtwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 400, 400)];
    UIFont *iconfont = [UIFont fontWithName:@"iconfont" size: 100];
    label.font = iconfont;
    label.text = @"\U0000e63a \U0000e6a7";
    label.textColor = [UIColor redColor];
    [self.view addSubview: label];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
