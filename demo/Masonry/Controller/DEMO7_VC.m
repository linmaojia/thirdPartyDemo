//
//  DEMO1_VC.m
//  Masonry
//
//  Created by LXY on 16/5/11.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "DEMO7_VC.h"

#define publishgif @"http://1.gifclub.applinzi.com/index.php/Home/index/publishgif"
@interface DEMO7_VC ()<UITextFieldDelegate>
{
    NSMutableArray *buttonArray;    /**< 按钮数组 */
    BOOL flag;    /**< 是否收藏 */
}
@property (nonatomic, strong) UIView *bottomView;    /**< 底部视图 */



@end

@implementation DEMO7_VC


#pragma mark 懒加载控件
- (UIView *)bottomView{
    
    if(!_bottomView){
        
        buttonArray = [NSMutableArray new];//使用数组约束
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        NSArray *array = [NSArray arrayWithObjects:@"收藏或删除",@"上传" ,nil];
        for(int i=0;i<2;i++){
            
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
    
    [self CustomStatusBar];//自定义状态栏设置
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutSubviews];//控件布局
}


-(void)CustomStatusBar{
    
     //状态栏风格
     [JDStatusBarNotification setDefaultStyle:^JDStatusBarStyle *(JDStatusBarStyle *style) {
        // main properties
        style.barColor =RGBA(60, 112, 180, 1);
        style.textColor = [UIColor whiteColor];
        style.font = [UIFont systemFontOfSize:12];
        
        return style;
    }];
     
    

}

#pragma mark - 监听button方法
-(void)buttonAction:(UIButton *)sender{
    switch (sender.tag) {
        case 100:{
            if(flag){
                [JDStatusBarNotification showWithStatus:@"收藏成功" dismissAfter:2];
            }else{
                [JDStatusBarNotification showWithStatus:@"取消收藏" dismissAfter:2];
            }
            flag = !flag;
        }
            break;
        case 101:{
            [self CustomStatusBars];
            [self uploadGif];//上传gif
        }
            
        default:
            break;
    }
    
}
-(void)uploadGif{
    NSString *str=publishgif;
    str = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *URL = [NSURL URLWithString:str];
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    sessionManager.responseSerializer=[AFJSONResponseSerializer serializer];

    NSString *userId = @"f6f03063698a7eac4a12118dfd9aabf3";
    
    // 参数
    NSDictionary *parameter = @{@"ownerid":userId,@"text":@"xxx",@"provincename":@"广东",@"cityname":@"广州",@"areaname":@"广州",@"streetname":@"广州"};
    NSString*theupfilePath=[[NSBundle mainBundle]pathForResource:@"xx"ofType:@"gif"];
    NSData *imageData=[NSData dataWithContentsOfFile:theupfilePath];
    [sessionManager POST:URL.absoluteString parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:imageData name:@"gifname" fileName:@"hehe.gif" mimeType:@"gif"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        float result = (float)uploadProgress.completedUnitCount/(float)uploadProgress.totalUnitCount;
        NSLog(@"---%f", result);
        
        //回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [JDStatusBarNotification showProgress:result];
            
        });
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功---%@",responseObject);
        
       [JDStatusBarNotification showWithStatus:@"分享成功" dismissAfter:2];
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"错误%@",error);
    }];
    
    
    
    
}
-(void)CustomStatusBars{
    //状态栏风格
    [JDStatusBarNotification setDefaultStyle:^JDStatusBarStyle *(JDStatusBarStyle *style) {
        // main properties
        style.barColor =RGBA(60, 112, 180, 1);
        style.textColor = [UIColor whiteColor];
        style.font = [UIFont systemFontOfSize:12];
        
        // advanced properties
        style.animationType = JDStatusBarAnimationTypeMove;
        
        // progress bar
        style.progressBarColor = RGBA(56, 131, 211, 1);
        style.progressBarHeight = 20;
        style.progressBarPosition = JDStatusBarProgressBarPositionCenter;
        
        return style;
    }];
    
    
    
    [JDStatusBarNotification showWithStatus:@"上传中"];
    [JDStatusBarNotification showActivityIndicator:YES indicatorStyle:UIActivityIndicatorViewStyleGray];
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
