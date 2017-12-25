//
//  BCSegmentTagView.m
//  BRXHTokikage
//
//  Created by mac on 2017/12/25.
//

#import "BCSegmentTagView.h"
#import "CellOfSmall.h"

@implementation BCSegmentTagView
{
    
    NSInteger currentIndex;
}
- (instancetype)initWithFrame:(CGRect)frame {
    
    
    
    if (self = [super initWithFrame:frame] ) {
        currentIndex = 0;
        [self initView];
    }
    
    return self;
    
}

- (void)initView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(KAPPW / 5, 40);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    layout.minimumLineSpacing = 0;
    self.segmentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width , 40) collectionViewLayout:layout];
    [self addSubview:self.segmentCollectionView];
    self.segmentCollectionView.backgroundColor = [UIColor whiteColor];
    self.segmentCollectionView.delegate = self;
    self.segmentCollectionView.dataSource = self;
    [self.segmentCollectionView registerClass:[CellOfSmall class] forCellWithReuseIdentifier:@"smallPool"];
    self.segmentCollectionView.showsHorizontalScrollIndicator = NO;
   
    

    
}


#pragma mark 代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   
    NSArray *arr = [self.delegate dataSourceForTag];
    return arr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   
        CellOfSmall *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"smallPool" forIndexPath:indexPath];
        
    
        cell.label.textAlignment = NSTextAlignmentCenter;
    
        if (indexPath.row == currentIndex) {
            cell.label.textColor = globalColor;
            cell.label.font = [UIFont systemFontOfSize:18];
            cell.redView.hidden = NO;
        }else {
            cell.label.font = [UIFont systemFontOfSize:15];
            cell.label.textColor = [UIColor blackColor];
            cell.redView.hidden = YES;
        }
    

    NSArray *arr = [self.delegate dataSourceForTag];
    cell.label.text = [arr objectAtIndex:indexPath.row];
        return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    currentIndex = indexPath.row;
    [self.delegate clickCurrentTag:indexPath.row];
    [collectionView reloadData];
    
}

- (void)reloadSegmentTag:(NSInteger)index {
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:index inSection:0];
    [self.segmentCollectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    currentIndex = index;
    [self.segmentCollectionView reloadData];
}
@end
