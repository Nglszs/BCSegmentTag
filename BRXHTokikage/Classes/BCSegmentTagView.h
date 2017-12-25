//
//  BCSegmentTagView.h
//  BRXHTokikage
//
//  Created by mac on 2017/12/25.
//

#import <UIKit/UIKit.h>
@protocol ClickSegmentTagDelegate <NSObject>

@required


/**
 点击当前的标签切换对应的Page

 @param item 标签
 */
- (void)clickCurrentTag:(NSInteger)item;


/**
 标题数据源

 @return 标签栏
 */
- (NSArray *)dataSourceForTag;

@end


@interface BCSegmentTagView : UIView<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *segmentCollectionView;
@property (nonatomic, weak) id<ClickSegmentTagDelegate>delegate;


/**
 滚动内容时刷新标签栏

 @param index 位置下标
 */
- (void)reloadSegmentTag:(NSInteger)index;
@end
