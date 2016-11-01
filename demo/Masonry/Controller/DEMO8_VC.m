//
//  DEMO1_VC.m
//  Masonry
//
//  Created by LXY on 16/5/11.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "DEMO8_VC.h"
#import "ETRootNavigationController.h"
#import <MWPhotoBrowser.h>
@interface DEMO8_VC ()<MWPhotoBrowserDelegate>
{
    NSMutableArray *buttonArray;    /**< 按钮数组 */
}
@property (nonatomic, strong) UIView *bottomView;    /**< 底部视图 */
@property (nonatomic, strong) NSArray *photoArray;    /**< 图片数组 */

@end

@implementation DEMO8_VC

#pragma mark 懒加载控件
- (NSArray *)photoArray{
    if(!_photoArray){
        
        _photoArray = @[@"http://oss.av-gd.com/ROOT/busiImage/dest/product/MDGH/big/DSC_3609-8ZT_20150615184545875.png",@"http://oss.av-gd.com/ROOT/busiImage/dest/product/MDGH/big/2_20160409151833842.png",@"http://oss.av-gd.com/ROOT/busiImage/dest/product/MDGH/big/20150505150015522_20150615184607718.png",@"http://oss.av-gd.com/ROOT/busiImage/dest/product/MDGH/big/DSC_3609-8ZT_20150615184545875.png"];
    }
    return _photoArray;
}

- (UIView *)bottomView{
    
    if(!_bottomView){
        
        buttonArray = [NSMutableArray new];//使用数组约束
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        for(int i=0;i<4;i++){
            
            UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
            
            button.backgroundColor = RGB(238, 91, 40);
            [button setTitleColor:[UIColor whiteColor] forState:0];
            [button setTitle:[NSString stringWithFormat:@"--%d",i] forState:UIControlStateNormal];
            button.titleLabel.font= boldSystemFont(10);
            button.tag=100+i;
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.bottomView addSubview:button];
            [buttonArray addObject:button];
            
        }
        
        
    }
    return _bottomView;
}

#pragma mark - 系统方法
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutSubviews];//控件布局
}


#pragma mark - 监听button方法
-(void)buttonAction:(UIButton *)sender{
    
    [self imageViewTapWithImageUrls:self.photoArray index:sender.tag-100];
}

- (void)imageViewTapWithImageUrls:(NSArray *)imageUrls index:(NSInteger)index{
    
    
    NSMutableArray *photoItems = [NSMutableArray array];
    
    for (NSString *imageUrl in imageUrls) {
        MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:[imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        [photoItems addObject:photo];
    }
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithPhotos:photoItems];
    browser.displayActionButton = NO;
    browser.displayNavArrows = NO;
    browser.displaySelectionButtons = NO;
    browser.alwaysShowControls = NO;
    browser.zoomPhotosToFill = YES;
    browser.enableGrid = NO;
    browser.startOnGrid = NO;
    browser.enableSwipeToDismiss = NO;
    browser.autoPlayOnAppear = YES;
    browser.delegate = self;
    [browser setCurrentPhotoIndex:index];
    ETRootNavigationController *nc = [[ETRootNavigationController alloc] initWithRootViewController:browser];
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:nc animated:YES completion:nil];
}
#pragma mark - PhotoBrowserDelegate  自定义的代理方法
- (void)savePhotoToPhotoAlubmWithPhotoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    
    
    [SVProgressHUD show];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self.photoArray[index] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self saveImageToPhotos:[UIImage imageWithData:imageData]];
        });
    });
}
#pragma mark - 保存图片
- (void)saveImageToPhotos:(UIImage*)savedImage
{
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

// 指定回调方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if(error != NULL){
        [SVProgressHUD showImage:nil status:@"图片保存失败"];
    }else{
        [SVProgressHUD showImage:nil status:@"图片保存成功"];
    }
}

#pragma mark - 控件布局
- (void)layoutSubviews {
    [self.view addSubview:self.bottomView];
    
    [_bottomView makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@40);
        make.top.left.right.equalTo(self.view);
    }];
    
    //平均分配 水平
    
    [buttonArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:5 leadSpacing:5 tailSpacing:5];
    [buttonArray makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@40);
        make.bottom.equalTo(self.bottomView);
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
