//
//  WTDynamicCollectionViewCell.m
//  BRXHTokikage
//
//  Created by mac on 2017/12/24.
//

#import "WTDynamicCollectionViewCell.h"

#define ImageWidth (KAPPW - 30)/3

@implementation WTDynamicCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    
    
    if (self = [super initWithFrame:frame]) {
      
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self initView];
        
        
    }
    
    
    return self;
}

- (void)initView {
    
    _contentImageView = [[UIImageView alloc] init];
    _contentImageView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_contentImageView];
    
    _addressLabel = [[UILabel alloc] init];
    _addressLabel.textAlignment = NSTextAlignmentCenter;
    _addressLabel.font = [UIFont systemFontOfSize:14];
    _addressLabel.textColor = [UIColor  colorWithWzxString:@"656565"];
    _addressLabel.backgroundColor = [UIColor redColor];
    _addressLabel.text = @"南京市浦口区";
    [_addressLabel adjustsFontSizeToFitWidth];
    [self.contentView addSubview:_addressLabel];
    
    
    
    [self.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.equalTo(@160);
        make.width.equalTo(@(ImageWidth));
        
    }];
    
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(@120);
        make.height.equalTo(@40);
        make.width.equalTo(self.contentImageView.mas_width);
        
    }];
    
}


@end
