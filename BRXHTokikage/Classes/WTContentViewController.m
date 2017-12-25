//
//  WTContentViewController.m
//  BRXHTokikage
//
//  Created by mac on 2017/12/25.
//

#import "WTContentViewController.h"
#import "WTDynamicCollectionViewCell.h"
#import "WTDynamicDetailViewController.h"


#define ImageWidth (KAPPW - 30)/3

@interface WTContentViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation WTContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
    layout.minimumInteritemSpacing = 0;
    
    _dynamicCollectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KAPPW, KAPPH - 109 - 230) collectionViewLayout:layout];
    [_dynamicCollectView registerClass:[WTDynamicCollectionViewCell class] forCellWithReuseIdentifier:@"jack"];
    _dynamicCollectView.delegate = self;
    _dynamicCollectView.dataSource = self;
    
    _dynamicCollectView.backgroundColor = [UIColor whiteColor];
      [self.view addSubview:_dynamicCollectView];
    
    
    
}
#pragma mark collectionView代理
- (CGSize)collectionView:(UICollectionView *)collectionView  layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    return CGSizeMake(ImageWidth, 160);
    
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    
    return 5;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 15;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WTDynamicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"jack" forIndexPath:indexPath];
    
    
    
    
    cell.addressLabel.text = _content;
    
    
    
    return cell;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WTDynamicDetailViewController *dynamciDetailVC = [[WTDynamicDetailViewController alloc] init];
    
    [self.navigationController pushViewController:dynamciDetailVC animated:YES];
    
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
