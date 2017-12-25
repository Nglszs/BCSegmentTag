//
//  WTReleaseViewController.m
//  BRXHTokikage
//
//  Created by mac on 2017/12/24.
//

#import "WTReleaseViewController.h"
#import "UITextView+Common.h"
#import "UIControl+BlocksKit.h"
#import "ZZPhotoKit.h"
#import "WTDynamicDetailViewController.h"



#define tempValue 10
#define photoWidth (KAPPW - tempValue * 5)/4

@interface WTReleaseViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) UIView *photoChooseView;//选择图片背景view
@property (nonatomic, strong) UIButton *addPhotoBtn;//选择图片

@property (nonatomic, assign) NSInteger photoCount;
@property (nonatomic, strong) NSMutableArray *uploadImageArr;
@end

@implementation WTReleaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = BRXHLocalString(@"WTReleaseTitle");

    _uploadImageArr = [NSMutableArray array];
    //取消按钮
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 24 , 44);
    [leftButton setTitle:@"取消" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor  colorWithWzxString:@"656565"] forState:UIControlStateNormal];
    
    [leftButton bk_addEventHandler:^(id sender) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    leftButton.titleLabel.font = [UIFont systemFontOfSize:17];
    UIBarButtonItem *leftBut = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBut;
    
    
    
    //发布按钮
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 24 , 44);
    [rightButton setTitle:@"发布" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    
    [rightButton bk_addEventHandler:^(id sender) {
        
    
        
    
        WTDynamicDetailViewController *dynamciDetailVC = [[WTDynamicDetailViewController alloc] init];
        
        [self.navigationController pushViewController:dynamciDetailVC animated:YES];
    
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBut = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBut;
    
    
    
    [self initView];
    
}


- (void)initView {
    
    
    _contentScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _contentScrollView.alwaysBounceVertical = YES;
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    _contentScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_contentScrollView];
    
    
   
    UITextView *contentTV = [[UITextView alloc] initWithFrame:CGRectMake(15, 0, KAPPW - 30, 120)];
    contentTV.placeholder = @"记录最美的时景，说两句呗！";
    contentTV.limitLength = @(140);
    contentTV.font = [UIFont systemFontOfSize:14];
    [_contentScrollView addSubview:contentTV];
    
    
    
    //初始化相册选择界面
    
    [self initPhotoView];
}

#pragma mark 选择图片
- (void)initPhotoView {
    
    _photoChooseView = [[UIView alloc] initWithFrame:CGRectMake(0, 120, KAPPW, 75)];
    _photoChooseView.backgroundColor = [UIColor whiteColor];
    [_contentScrollView addSubview:_photoChooseView];
    
    
    
    _addPhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addPhotoBtn.frame = CGRectMake(tempValue, 0, photoWidth, photoWidth);
    [_addPhotoBtn setBackgroundImage:EXBundleImageNamed(@"plus") forState:UIControlStateNormal];
    [_photoChooseView addSubview:_addPhotoBtn];
     [_addPhotoBtn addTarget:self action:@selector(addPhotoAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)addPhotoAction {
    
    
   
    UIAlertController *sheetController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [self presentViewController:sheetController animated:YES completion:nil];
    
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        [self cameraFromUIImagePickerController:0];
        
        
        
        
    }];
    
    UIAlertAction *pictureAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
  
            
            [self cameraFromUIImagePickerController:1];
            
        
        
        
    }];
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [sheetController addAction:pictureAction];
    [sheetController addAction:albumAction];
    [sheetController addAction:cancelAction];
    
    
}
- (void)cameraFromUIImagePickerController:(NSUInteger)type {
  
    if (type == 0) {//从相册中读取
        
        ZZPhotoController *photoController = [[ZZPhotoController alloc]init];
        photoController.selectPhotoOfMax = 8;
        [photoController showIn:self result:^(id responseObject){
          
            NSArray *resultImage = (NSArray *)responseObject;
            
            for (int i = 0; i < resultImage.count; i ++) {
                ZZPhoto *photo = [resultImage objectAtIndex:i];
                [self showChosePhoto:photo.originImage];
                
            }
          
          
            
        }];
        
    } else {//拍照
        
        ZZCameraController *cameraController = [[ZZCameraController alloc]init];
        cameraController.takePhotoOfMax = 8;
        
        cameraController.isSaveLocal = NO;
        [cameraController showIn:self result:^(id responseObject){
            
        NSArray *resultImage = (NSArray *)responseObject;
            
            for (int i = 0; i < resultImage.count; i ++) {
               
                
                ZZCamera *camera = [resultImage objectAtIndex:i];
                [self showChosePhoto:camera.image];
              
            }
            
        }];
        
    }
    
    
  
    
}


- (void)showChosePhoto:(UIImage *)newImage {
    
    _photoCount ++;
   
    
    //这里保存的图片数据用于上传
    NSData *imageData = UIImageJPEGRepresentation(newImage, 0.1);
    [_uploadImageArr addObject:newImage];
    
    
    
    if (_photoCount%4 == 0 && _photoCount != 0) {
        
        
        _photoChooseView.height = (tempValue + photoWidth) * (_photoCount/4 + 1) + tempValue ;
        _contentScrollView.contentSize = CGSizeMake(KAPPW, _photoChooseView.bottom + 130);
        
    }
    
    
    //用imageview显示出来，然后移动button的位置
    UIImageView *showImage = [[UIImageView alloc] initWithFrame:CGRectMake(tempValue + (_photoCount - 1)%4 * (photoWidth + tempValue),tempValue + (tempValue + photoWidth) * ((_photoCount - 1)/4), photoWidth, photoWidth)];
    showImage.tag = 400 + _photoCount;
    showImage.image = newImage;
    [_photoChooseView addSubview:showImage];
    
    _addPhotoBtn.frame = CGRectMake(tempValue + _photoCount%4 * (photoWidth + tempValue), tempValue + (tempValue + photoWidth) * (_photoCount/4), photoWidth, photoWidth);
    
    
    
    //删除按钮
    UIButton *deleteImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteImageBtn.tag = 500 + _photoCount;
    deleteImageBtn.frame = CGRectMake(CGRectGetMaxX(showImage.frame) - 12,CGRectGetMinY(showImage.frame) - 5, 20, 20);

    [deleteImageBtn setImage:EXBundleImageNamed(@"close") forState:UIControlStateNormal];
    [deleteImageBtn addTarget:self action:@selector(deletePhotoAction:) forControlEvents:UIControlEventTouchUpInside];

    [_photoChooseView addSubview:deleteImageBtn];
    
    
}

- (void)deletePhotoAction:(UIButton *)button {
    
    //删除数组里已经有的图片
     NSInteger currentIndex = button.tag - 500;
    [_uploadImageArr removeObjectAtIndex:currentIndex - 1];
    
    
    
    //移除相应显示的imageview和button
    UIImageView *imageView = (UIImageView *)[_photoChooseView viewWithTag:(400 + currentIndex)];
    [imageView removeFromSuperview];
    imageView = nil;
    [button removeFromSuperview];
    button = nil;
    
    
    //排序剩下的图片位置
    for (NSInteger i = currentIndex; i < _photoCount; i ++) {
        
        UIImageView *photoImageView = (UIImageView *)[_photoChooseView viewWithTag:(400 + i + 1)];
        photoImageView.frame = CGRectMake(tempValue + (i - 1)%3 * (photoWidth + tempValue),(tempValue + photoWidth) * ((i - 1)/3) + tempValue, photoWidth, photoWidth);
        photoImageView.tag--;
        
        UIButton *deButton = (UIButton *)[_photoChooseView viewWithTag:(500 + i + 1)];
        
        deButton.frame = CGRectMake(CGRectGetMaxX(photoImageView.frame) - 12,CGRectGetMinY(photoImageView.frame) - 5, 20, 20);
        
        deButton.tag--;
    }
    
    
    
    if (_photoCount%4 == 0 && _photoCount != 0) {//改变背景的frame
        
        
        
        _photoChooseView.height = (tempValue + photoWidth) * _photoCount/4 + tempValue;
        
        
        _contentScrollView.contentSize = CGSizeMake(KAPPW, _photoChooseView.bottom + 130);
        
    }
    
    _photoCount--;
    _addPhotoBtn.frame = CGRectMake(tempValue + _photoCount%4 * (photoWidth + tempValue), tempValue + (tempValue + photoWidth) * (_photoCount/4), photoWidth, photoWidth);
    
    
   
  
    
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
