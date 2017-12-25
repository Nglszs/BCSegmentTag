//
//  CellOfSmall.m
//  Parctice 滑条问题
//
//  Created by 冀永金 on 16/7/16.
//  Copyright © 2016年 冀永金. All rights reserved.
//

#import "CellOfSmall.h"

@interface CellOfSmall ()

@end
@implementation CellOfSmall
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        self.label = [[UILabel alloc]init];
        [self.contentView addSubview:_label];
        self.redView = [[UIView alloc] init];
        _redView.backgroundColor = globalColor;
        _redView.hidden = YES;
        [self.contentView addSubview:_redView];
    }
    return self;
}
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {

    self.label.frame = self.contentView.frame;
    self.redView.frame = CGRectMake(10, self.contentView.frame.size.height-2, self.contentView.frame.size.width - 20, 2);
}
@end
