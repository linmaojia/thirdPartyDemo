//
//  DEMO1_VC.m
//  Masonry
//
//  Created by LXY on 16/5/11.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "DEMO9_VC.h"
#import "JVFloatLabeledTextField.h"
@interface DEMO9_VC ()<UITextFieldDelegate>

@property (nonatomic, strong) JVFloatLabeledTextField *textField;   /**< 别名输入框或收货人 */



@end

@implementation DEMO9_VC


#pragma mark 懒加载控件
- (JVFloatLabeledTextField *)textField
{
    if(!_textField)
    {
        _textField = [[JVFloatLabeledTextField alloc] init];
        _textField.font = [UIFont systemFontOfSize:16];
        _textField.floatingLabelFont = [UIFont boldSystemFontOfSize:11];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.delegate = self;
        //实现同步获取文本
        [_textField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
        
    }
    return _textField;
}


#pragma mark - 系统方法
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
}
//+(instancetype)shareManager{
//    static DEMO9_VC *manager = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        manager = [[DEMO9_VC alloc]init];
//    });
//    return manager;
//}
//
//+(instancetype)shareManagers{
//    static DEMO9_VC *manager = nil;
//    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        manager = [[DEMO9_VC alloc]init];
//    });
//    return manager;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutSubviews];//控件布局
}


#pragma mark - 控件布局
- (void)layoutSubviews {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
