//
//  DEMO1_VC.m
//  Masonry
//
//  Created by LXY on 16/5/11.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "DEMO2_VC.h"

@interface DEMO2_VC ()
{
    NSMutableArray *buttonArray;    /**< 按钮数组 */
}
@property (nonatomic, strong) UIView *LeftView;    /**< 底部视图 */
@end

@implementation DEMO2_VC


#pragma mark 懒加载控件
- (UIView *)LeftView{
    
    if(!_LeftView){
        
        buttonArray = [NSMutableArray new];//使用数组约束
        _LeftView = [[UIView alloc]init];
        _LeftView.backgroundColor = [UIColor whiteColor];
        NSArray *array = [NSArray arrayWithObjects:@"菊花",@"文字",@"!",nil];
        for(int i=0;i<3;i++){
            
            UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
            
            button.backgroundColor = RGB(238, 91, 40);
            [button setTitleColor:[UIColor whiteColor] forState:0];
            [button setTitle:array[i] forState:UIControlStateNormal];
            button.titleLabel.font= boldSystemFont(10);
            button.tag=100+i;
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.LeftView addSubview:button];
            [buttonArray addObject:button];
            
        }
        
        
    }
    return _LeftView;
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
           
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"便宜不等人,请三思而行~"];
            [alertView addButtonWithTitle:@"我再想想" type:SIAlertViewButtonTypeCancel handler:^(SIAlertView *alertView) {
                
            }];
            [alertView addButtonWithTitle:@"去意已决" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [alertView show];
            
        }
            
            break;
            
        default:
            break;
    }
    
    
    
}


#pragma mark - 控件布局
- (void)layoutSubviews {
    [self.view addSubview:self.LeftView];
    
    [_LeftView makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@40);
        make.top.left.bottom.equalTo(self.view);
    }];
    
    //平均分配 垂直
    
    [buttonArray mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:10 leadSpacing:10 tailSpacing:10];
    [buttonArray makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@40);
        make.left.equalTo(self.LeftView);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
