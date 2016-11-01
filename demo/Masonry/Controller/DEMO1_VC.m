//
//  DEMO1_VC.m
//  Masonry
//
//  Created by LXY on 16/5/11.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "DEMO1_VC.h"

@interface DEMO1_VC ()
{
    NSMutableArray *buttonArray;    /**< 按钮数组 */
}
@property (nonatomic, strong) UIView *bottomView;    /**< 底部视图 */
@end

@implementation DEMO1_VC

#pragma mark 懒加载控件
- (UIView *)bottomView{
    
    if(!_bottomView){
        
        buttonArray = [NSMutableArray new];//使用数组约束
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        NSArray *array = [NSArray arrayWithObjects:@"菊花",@"文字",@"!",@"成功",@"失败" ,nil];
        for(int i=0;i<5;i++){
            
            UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
            
            button.backgroundColor = RGB(238, 91, 40);
            [button setTitleColor:[UIColor whiteColor] forState:0];
            [button setTitle:array[i] forState:UIControlStateNormal];
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
    switch (sender.tag) {
        case 100:{
        //加个fang 的定时器
            [SVProgressHUD show];
            [self performSelector:@selector(delayAction) withObject:nil afterDelay:2.0];//延时执行
        }
            
            break;
        case 101:{
            [SVProgressHUD showWithStatus:@"正在刷新购物车,请稍等"];//文字
            [self performSelector:@selector(delayAction) withObject:nil afterDelay:2.0];//延时执行

        }
            
            break;
        case 102:{
            [SVProgressHUD showInfoWithStatus:@"xxxxx."];//感叹号
        }
            
            break;
        case 103:{
            [SVProgressHUD showSuccessWithStatus:@"Success!"];
        }
            break;
        case 104:{
            [SVProgressHUD showErrorWithStatus:@"Error"];
        }
            break;
      
        default:
            break;
    }
    
 
    
}

//延时执行
- (void)delayAction {
    [SVProgressHUD dismiss];
    
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
