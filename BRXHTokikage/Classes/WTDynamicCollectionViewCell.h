//
//  WTDynamicCollectionViewCell.h
//  BRXHTokikage
//
//  Created by mac on 2017/12/24.
//

#import <UIKit/UIKit.h>

@interface WTDynamicCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *contentImageView;
@property (nonatomic, strong) UILabel *addressLabel;

- (void)modelForCell:(id)model;
@end
