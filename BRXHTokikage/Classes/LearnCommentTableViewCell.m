//
//  LearnCommentTableViewCell.m
//  BRXHLearn
//
//  Created by mac on 2017/11/29.
//

#import "LearnCommentTableViewCell.h"
#import "BRXHBasis.h"
@implementation LearnCommentTableViewCell


- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        [self initView];
        
    }
    
    
    return self;
}

- (void) initView {
    
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 30, 30)];
    headImageView.backgroundColor = [UIColor lightGrayColor];
    headImageView.layer.cornerRadius = 15;
    [self.contentView addSubview:headImageView];
    
    
   _nameLabel  = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:14];
    _nameLabel.textColor = [UIColor blackColor] ;
    _nameLabel.text = @"月影";
    _nameLabel.textColor = [UIColor  colorWithWzxString:@"656565"];
    [self.contentView addSubview:_nameLabel];
    
    
    
    _commentLabel = [[UILabel alloc] init];
    _commentLabel.font = [UIFont systemFontOfSize:14];
    _commentLabel.textColor = [UIColor blackColor] ;
    _commentLabel.text = @"这个视频之前就看过了";
    _commentLabel.numberOfLines = 0;
    [self.contentView addSubview:_commentLabel];
    
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont systemFontOfSize:14];
    _timeLabel.text = @"2017.11.26";
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel.textColor = [UIColor  colorWithWzxString:@"656565"];
    [self.contentView addSubview:_timeLabel];
    

    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(headImageView.mas_top).offset(5);
        make.left.equalTo(headImageView.mas_right).offset(10);
        make.height.equalTo(@20);
        make.width.equalTo(@50);
        
    }];
    
    
    [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(headImageView.mas_bottom).offset(5);
        make.left.equalTo(_nameLabel.mas_left);
        make.height.equalTo(@65);
        NSInteger  value = KAPPW - 90;
        make.width.equalTo([NSNumber numberWithInteger:value]);
    }];
    
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_nameLabel.mas_top);
        make.width.equalTo(self.contentView.mas_width).offset(-10);
        make.height.equalTo(_nameLabel.mas_height);
    
    }];
    
    //分割线
    CALayer *lineLayer = [CALayer layer];
    lineLayer.frame = CGRectMake(45, 119, KAPPW - 45, .5);
    lineLayer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5].CGColor;
    [self.contentView.layer addSublayer:lineLayer];
    
    
}

- (void)setModelForCell:(id)model {
    
    _nameLabel.text = [model objectForKey:@"username"];
    _commentLabel.text = [model objectForKey:@"content"];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
