//
//  WTDynamicDetailViewController.m
//  BRXHTokikage
//
//  Created by mac on 2017/12/24.
//

#import "WTDynamicDetailViewController.h"
#import "SDCycleScrollView.h"
#import "LearnCommentTableViewCell.h"
#import "XHInputView.h"
#import "UIControl+BlocksKit.h"

@interface WTDynamicDetailViewController ()<SDCycleScrollViewDelegate,XHInputViewDelagete,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) SDCycleScrollView *topBannerView;//轮播图
@property (nonatomic, strong) UILabel *nameLabel,*timeLabel,*contentLabel;
@property (nonatomic, strong) UIImageView *headImageView;



@property (nonatomic, strong) UITableView *currentTableView;
@property (nonatomic, strong) NSMutableArray *commentArray;
@end

@implementation WTDynamicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = BRXHLocalString(@"WTReleaseDetail");
    
    _commentArray = [NSMutableArray array];
    
    
  
   
    
    //初始化发布者
    [self initView];
   
    
    //初始化底部按钮
    [self initBottomButton];
}


- (void)initView {
  
    
    
    
    
    //初始化发布者
    UIView *authorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KAPPW, 250)];
    [authorView addSubview:self.topBannerView];
    
    
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 190, 40, 40)];
    _headImageView.layer.cornerRadius = 20;
    _headImageView.clipsToBounds = YES;
    _headImageView.backgroundColor = [UIColor grayColor];
    [authorView addSubview:_headImageView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_headImageView.right + 10, 190, KAPPW - 60, 20)];
  
    _nameLabel.font = [UIFont systemFontOfSize:14];
    _nameLabel.textColor = [UIColor  colorWithWzxString:@"656565"];
    _nameLabel.text = @"Jack";
    [authorView addSubview:_nameLabel];
    
    
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.left, 210, KAPPW - 60, 20)];
 
    _timeLabel.font = [UIFont systemFontOfSize:14];
    _timeLabel.textColor = [UIColor  colorWithWzxString:@"656565"];
    _timeLabel.text = @"2017-12-25";
    [authorView addSubview:_timeLabel];
    
    
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _headImageView.bottom + 10, KAPPW - 20, 20)];
    _contentLabel.font = [UIFont systemFontOfSize:17];
    _contentLabel.textColor = [UIColor blackColor];
    _contentLabel.numberOfLines = 0;
    _contentLabel.text = @"今天天气不错安徽大文化大爱我的hiad哈维就得 等哈我ID哈无电话王东海多好玩都好污的哈维一等哈无ID哈 ！";
    
    [authorView addSubview:_contentLabel];
   
    _contentLabel.height = [self getStringHeightNotFormatWith:_contentLabel.text width:KAPPW - 20 font:_contentLabel.font];
    
    
    authorView.height = _contentLabel.bottom + 10;
    

    [self.currentTableView setTableHeaderView:authorView];
    [self.view addSubview:self.currentTableView];
  
    
    
}


- (void)initBottomButton {
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height -64 - 44 ,KAPPW, 44)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    bottomView.layer.shadowColor = [UIColor blackColor].CGColor;//阴影颜色
    bottomView.layer.shadowOffset = CGSizeMake(0, -3);//偏移距离
    bottomView.layer.shadowOpacity = 0.35;//不透明度
    bottomView.layer.shadowRadius = 3;//半径
    
    NSArray *titleArr = @[@"举报",@"评论",@"点赞"];
   
    
    for (int i = 0; i < 3; i ++) {
        
        UIButton  *balanceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [ balanceBtn setFrame:CGRectMake(bottomView.width/3 * i,0,KAPPW/3, 44)];
        [ balanceBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [ balanceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        balanceBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [bottomView addSubview: balanceBtn];
        balanceBtn.tag = 100 + i;
        
        
        if (i == 0) {
            [balanceBtn setTitleColor:[[UIColor redColor] colorWithAlphaComponent:0.8] forState:UIControlStateNormal];
        }
        
     
        [balanceBtn bk_addEventHandler:^(id sender) {
            
            UIButton *button = (UIButton *)sender;
            
            if (button.tag == 100) {//举报
                
                
            } else if (button.tag == 101) {//评论
                
                [XHInputView showWithStyle:InputViewStyleDefault configurationBlock:^(XHInputView *inputView) {
                    /** 请在此block中设置inputView属性 */
                    
                    /** 代理 */
                    inputView.delegate = self;
                    
                    /** 占位符文字 */
                    inputView.placeholder = @"请输入评论文字...";
                    /** 设置最大输入字数 */
                    inputView.maxCount = 50;
                    /** 输入框颜色 */
                    inputView.textViewBackgroundColor = [UIColor groupTableViewBackgroundColor];
                    
                    /** 更多属性设置,详见XHInputView.h文件 */
                    
                } sendBlock:^BOOL(NSString *text) {
                    if(text.length){
                        NSLog(@"输入的信息为:%@",text);
                        
                        return YES;//return YES,收起键盘
                    }else{
                        NSLog(@"显示提示框-请输入要评论的的内容");
                        return NO;//return NO,不收键盘
                    }
                }];
                
            } else {//点赞
                
                
            }
            
            
        } forControlEvents:UIControlEventTouchUpInside];
        
       
        
       
        if ( i < 2) { //分割线
            
            CALayer *lineLayer = [CALayer layer];
            lineLayer.frame = CGRectMake(balanceBtn.width * (i + 1), 0, .5, 44);
            lineLayer.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5].CGColor;
            [bottomView.layer addSublayer:lineLayer];
          
        }
        
        
    }
    
    
}

#pragma mark UItableview 代理

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    
    return @"评论列表";
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"kpo";
    LearnCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    if (cell == nil) {
        cell = [[LearnCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    
    //[cell setModelForCell:[_commentArray objectAtIndex:indexPath.row]];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 120;
}


#pragma mark  轮播图 & contentview & tableview


- (SDCycleScrollView *) topBannerView {
    
    if (_topBannerView == nil) {
        _topBannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KAPPW, 180) delegate:self placeholderImage:nil];
        
        _topBannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _topBannerView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _topBannerView.autoScroll = YES;
        _topBannerView.imageURLStringsGroup = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1493210044049&di=ac402c2ce8259c98e5e4ea1b7aac4cac&imgtype=0&src=http%3A%2F%2Fimg2.3lian.com%2F2014%2Ff4%2F209%2Fd%2F97.jpg"];
        
    }
    return _topBannerView;
    
    
}


- (UITableView *)currentTableView {
    
    if (!_currentTableView) {
        _currentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KAPPW, KAPPH -  64 - 44) style:UITableViewStylePlain];
        _currentTableView.delegate = self;
        _currentTableView.dataSource = self;
        _currentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _currentTableView.backgroundColor = [UIColor clearColor];
       
    }
    
    return _currentTableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGFloat)getStringHeightNotFormatWith:(NSString *)tempStr width:(CGFloat)tempWidth font:(UIFont *)tempFont {
    
    CGRect rect = [tempStr boundingRectWithSize:CGSizeMake(tempWidth, 0)
                                        options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesDeviceMetrics|NSStringDrawingUsesFontLeading
                                     attributes:@{NSFontAttributeName:tempFont}
                                        context:nil];
    
    
    return rect.size.height;
}



#pragma mark - XHInputViewDelagete
/** XHInputView 将要显示 */
-(void)xhInputViewWillShow:(XHInputView *)inputView{
    
    /** 如果你工程中有配置IQKeyboardManager,并对XHInputView造成影响,请在XHInputView将要显示时将其关闭 */
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].enable = NO;
    
}

/** XHInputView 将要影藏 */
-(void)xhInputViewWillHide:(XHInputView *)inputView{
    
    /** 如果你工程中有配置IQKeyboardManager,并对XHInputView造成影响,请在XHInputView将要影藏时将其打开 */
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    [IQKeyboardManager sharedManager].enable = YES;
}


@end
