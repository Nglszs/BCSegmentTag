//
//  WTDynamicViewController.m
//  AFNetworking
//
//  Created by mac on 2017/12/24.
//

#import "WTDynamicViewController.h"
#import "SDCycleScrollView.h"
#import "WTDynamicCollectionViewCell.h"
#import "WTReleaseViewController.h"
#import "BCSegmentTagView.h"
#import "WTDynamicDetailViewController.h"
#import "WTContentViewController.h"


#define ImageWidth (KAPPW - 30)/3

@interface WTDynamicViewController ()<SDCycleScrollViewDelegate,ClickSegmentTagDelegate,UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@property (nonatomic, strong) SDCycleScrollView *topBannerView;//轮播图
@property (nonatomic, strong) UIScrollView  *contentView;
@property (nonatomic, strong) UIPageViewController *pageViewController;//切换视图
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) BCSegmentTagView *segementView;//标签栏

@property (nonatomic, strong) NSArray *vcArr;//重用池
@property (nonatomic, strong) NSArray *arr;//暂时的数据
@end

@implementation WTDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = BRXHLocalString(@"WTDynamicTitle");
    
    
    //重用时调用
    _vcArr = @[[WTContentViewController new],[WTContentViewController new],[WTContentViewController new]];
   
     _arr = @[@"第一",@"第二",@"第三",@"第四",@"第五",@"第六",@"第七",@"第八",@"第九",@"第十"];
    
    //初始化内容view
    [self.view addSubview:self.contentView];
    
    //头部标签栏
    _segementView = [[BCSegmentTagView alloc] initWithFrame:CGRectMake(0, 190, KAPPW, 40)];
    _segementView.delegate = self;
    [self.contentView addSubview:_segementView];
    
    
    //轮播图
    [self.contentView addSubview:self.topBannerView];
    
    //初始化主视图
    [self initView];
    
}

- (void)initView {
    
    //初始化pagecontrol
    
    NSDictionary *option = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:0] forKey:UIPageViewControllerOptionInterPageSpacingKey];
    _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:option];
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;
    _pageViewController.view.frame = CGRectMake(0, 230, KAPPW, KAPPH - 49 - 230);
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
  
    
    
  
    
    
    //初始化发布按钮
    UIButton *releaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    releaseButton.frame = CGRectMake(KAPPW - 80, KAPPH - 49 - 80 - 64, 50, 50);
    releaseButton.backgroundColor = [UIColor whiteColor];
    releaseButton.layer.cornerRadius = 25;
    releaseButton.clipsToBounds = YES;
    [releaseButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e64c", 24,nil)] forState:UIControlStateNormal];
    [self.view addSubview:releaseButton];
    [releaseButton addTarget:self action:@selector(clickReleaseButton) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    
    
    
}

#pragma mark UIPageViewController 代理


// 返回上一个ViewController对象

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [self indexOfViewController:(WTContentViewController *)viewController];
    if (index == 0 || (index == NSNotFound)) {
        return nil;
    }
    index--;
    
    return [self viewControllerForIndex:index];
    
}

#pragma mark 返回下一个ViewController对象

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
   NSUInteger index = [self indexOfViewController:(WTContentViewController *)viewController];
    if (index == self.arr.count - 1 || (index == NSNotFound)) {
        return nil;
    }
    index++;
    
   
    return [self viewControllerForIndex:index];
    
}

#pragma mark 开启重用并返回对应的controller并添加数据
- (UIViewController *)viewControllerForIndex:(NSInteger)index {
    
    //这里开启重用
    WTContentViewController *contentVC = [_vcArr objectAtIndex:index%3];
    contentVC.content = [self.arr objectAtIndex:index];
    [contentVC.dynamicCollectView reloadData];
    return contentVC;
}


#pragma mark 返回对应的下标
- (NSUInteger)indexOfViewController:(WTContentViewController *)viewController {
    return [self.arr indexOfObject:viewController.content];
}
#pragma mark 将要滑动切换的时候
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    WTContentViewController *nextVC = (WTContentViewController *)[pendingViewControllers firstObject];
    NSInteger index = [self indexOfViewController:nextVC];
    _pageIndex = index;
}
#pragma mark 滑动结束后
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        
        //刷新滚动内容时标签栏选中行
        [self.segementView reloadSegmentTag:_pageIndex];
      
    }
}

//第一次进来
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

    UIViewController *vc = [self viewControllerForIndex:_pageIndex];
    [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
    
   
}





#pragma mark 发布按钮点击事件
- (void)clickReleaseButton {
    
    [self.navigationController pushViewController:[WTReleaseViewController new] animated:YES];
    
}
#pragma mark  轮播图 & contentview
- (UIScrollView *)contentView {
    
    
    
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _contentView.alwaysBounceVertical = YES;
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.showsVerticalScrollIndicator = NO;
        _contentView.scrollEnabled = NO;

    }
    
    return _contentView;
}


- (SDCycleScrollView *) topBannerView {
    
    if (_topBannerView == nil) {
        _topBannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 10, KAPPW, 180) delegate:self placeholderImage:nil];
       
        _topBannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _topBannerView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
       
        _topBannerView.titleLabelHeight = 60;
        
        _topBannerView.autoScroll = YES;
        _topBannerView.imageURLStringsGroup = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1493210044049&di=ac402c2ce8259c98e5e4ea1b7aac4cac&imgtype=0&src=http%3A%2F%2Fimg2.3lian.com%2F2014%2Ff4%2F209%2Fd%2F97.jpg",@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1493199772&di=66346cd79eed9c8cb4ec03c3734d0b31&src=http://img15.3lian.com/2015/f2/128/d/123.jpg",@"http://wmtp.net/wp-content/uploads/2017/04/0420_sweet945_1.jpeg",@"http://wmtp.net/wp-content/uploads/2017/04/0407_shouhui_1.jpeg"];
        _topBannerView.titlesGroup = @[@"教程 2017时尚流行发型\n 高贵的典雅 岁月...多想把",@"超级简单又好看的流行编发教程 2017时尚流行发型 \n高贵的典雅  岁月...多想把",@"超级简单又好看的流行编发教程 2017时尚流行发型 \n高贵的典雅  岁月...多想把",@"超级简单又好看的流行编发教程 2017时尚流行发型 \n高贵的典雅  岁月...多想把"];
    }
    return _topBannerView;
    
    
}


#pragma mark 头部标签栏代理

- (void)clickCurrentTag:(NSInteger)item {
    
    if (item == _pageIndex) {
        return;
    }
    
    
    //切换page
    UIViewController *vc = [self viewControllerForIndex:item];
    if (item > _pageIndex) {
        [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
        }];
    } else {
        [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL finished) {
        }];
    }
    
    _pageIndex = item;
    
    //移动标签栏
   
        NSIndexPath *path = [NSIndexPath indexPathForRow:_pageIndex inSection:0];
        [self.segementView.segmentCollectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
  

    
    
}

- (NSArray *)dataSourceForTag {
    
  
    
    return _arr;
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
