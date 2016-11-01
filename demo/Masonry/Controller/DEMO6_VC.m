//
//  DEMO1_VC.m
//  Masonry
//
//  Created by LXY on 16/5/11.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "DEMO6_VC.h"
@interface DEMO6_VC ()
{
}
@property(nonatomic, strong)UITextField *tf;   /** 文本框  */
@property(nonatomic, strong)UITextField *tf1;   /** 文本框  */


@end

@implementation DEMO6_VC


#pragma mark 懒加载控件
- (UITextField *)tf
{
    if(!_tf)
    {
        _tf = [[UITextField alloc]initWithFrame:CGRectMake(50,400, 100, 30)];
        _tf.borderStyle=UITextBorderStyleRoundedRect;
        _tf.keyboardType=UIKeyboardTypeNumberPad; //设置键盘样式
        _tf.secureTextEntry=YES; //文本框文字是否保密
          //键盘距离文本框的距离
        [[IQKeyboardManager sharedManager]setKeyboardDistanceFromTextField:20];
        //  [_tf becomeFirstResponder]; //自动弹出键盘
    }
    return _tf;
}
- (UITextField *)tf1
{
    if(!_tf1)
    {
        _tf1 = [[UITextField alloc]initWithFrame:CGRectMake(50,450, 100, 30)];
        _tf1.borderStyle=UITextBorderStyleRoundedRect;
        _tf1.keyboardType=UIKeyboardTypeNumberPad; //设置键盘样式
        _tf1.secureTextEntry=YES; //文本框文字是否保密
    }
    return _tf1;
}


#pragma mark - 系统方法
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    /*
     
     当导入这个第三方时候，就已经有键盘上方的工具栏
     
     */
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    //激活
    manager.enable = YES;
    //设置点击View其它位置收回键盘
    manager.shouldResignOnTouchOutside = YES;
    //设置工具栏颜色是否跟文本框一致
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    //激活工具栏
    manager.enableAutoToolbar = YES;
    
   

}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutSubviews];//控件布局
}


#pragma mark - 控件布局
- (void)layoutSubviews {
    
   
    
    [self.view addSubview:self.tf];
    [self.view addSubview:self.tf1];

    

   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
