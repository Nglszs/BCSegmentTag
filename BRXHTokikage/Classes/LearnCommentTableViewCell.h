//
//  LearnCommentTableViewCell.h
//  BRXHLearn
//
//  Created by mac on 2017/11/29.
//

#import <UIKit/UIKit.h>

@interface LearnCommentTableViewCell : UITableViewCell
@property(nonatomic, strong) UILabel *nameLabel, *timeLabel,*commentLabel;
- (void)setModelForCell:(id)model;
@end
