//
//  DEMO1_VC.m
//  Masonry
//
//  Created by LXY on 16/5/11.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "DEMO5_VC.h"
#import <HYBLoopScrollView.h>
#import "SVHTTPClient+KnowETao.h"
@interface DEMO5_VC ()
{
}
@property(nonatomic, strong)NSArray *imagesArray;   /**< 图片数组 */

@property (nonatomic, weak) HYBLoopScrollView *loop;   /**< 广告轮播图 */

@end

@implementation DEMO5_VC


#pragma mark 懒加载控件
- (NSArray *)imagesArray
{
    if(!_imagesArray)
    {
        _imagesArray = [NSArray new];
    }
    return _imagesArray;
}

- (HYBLoopScrollView *)loop
{
    
    if(!_loop)
    {
        _loop = [HYBLoopScrollView loopScrollViewWithFrame:CGRectZero imageUrls:self.imagesArray timeInterval:5 didSelect:^(NSInteger atIndex) {
            
            NSLog(@"---%ld",atIndex);
        } didScroll:^(NSInteger toIndex) {
             NSLog(@"--xxxx-%ld",toIndex);//切换页面时调用
        }];
        
        _loop.placeholder = [UIImage imageNamed:@"StartDefult"];
        
        _loop.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"diamond_upholstery"]];
        
        _loop.alignment = kPageControlAlignCenter;
        
        _loop.pageControl.currentPageIndicatorTintColor = mainColor;
        _loop.imageContentMode = UIViewContentModeScaleAspectFill;
        
    }
    return _loop;
}
#pragma mark - 系统方法
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self requestData];// 请求初始数据
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutSubviews];//控件布局
}

#pragma mark - 请求初始数据
- (void)requestData{
    ESWeakSelf;
    [SVHTTPClient requestNewFeatureImagesArrayWithCallback:^(NSArray *imagesArray) {
        

        __weakSelf.loop.imageUrls = imagesArray;
        
    }];

}


#pragma mark - 控件布局
- (void)layoutSubviews {
    [self.view addSubview:self.loop];
    
    [_loop makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
        
    }];
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
