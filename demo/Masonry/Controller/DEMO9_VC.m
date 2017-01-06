//
//  DEMO1_VC.m
//  Masonry
//
//  Created by LXY on 16/5/11.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "DEMO9_VC.h"
#import "UIImageView+WebCache.h"
#import "NSString+Extend.h"
@interface DEMO9_VC ()
{
    NSString *urlString;
    NSString *urlString1;
    NSString *urlString2;
}
@property (nonatomic, strong) UIImageView *titleImg;         /**<  图片 */
@property (strong, nonatomic) IBOutlet UIImageView *imageVIedw;

@property (strong, nonatomic) IBOutlet UIImageView *img1;
@property (strong, nonatomic) IBOutlet UIImageView *img2;

@end

@implementation DEMO9_VC


#pragma mark 懒加载控件

- (UIImageView *)titleImg {
    if (!_titleImg) {
        UIImageView *imgeView = [[UIImageView alloc] init];
        imgeView.image = [UIImage imageNamed:@"logo_del_pro"];
        imgeView.backgroundColor = [UIColor grayColor];
        _titleImg = imgeView;
    }
    return _titleImg;
}

#pragma mark - 系统方法
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}
#pragma mark - 正常图片链接
- (IBAction)xxx:(id)sender {
    
    //获取图片缓存
        UIImage *productImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:urlString];
    
        if(productImage)
        {
            NSLog(@"存在图片");
            self.imageVIedw.image = productImage;
        }
        else
        {
            NSLog(@"不存在图片");
        }
}
- (IBAction)but_2:(id)sender {
    
    //获取图片缓存
    UIImage *productImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[urlString1 urlTransCoding]];
    
    if(productImage)
    {
        NSLog(@"存在图片");
        self.imageVIedw.image = productImage;
    }
    else
    {
        NSLog(@"不存在图片");
    }
}
- (IBAction)but_3:(id)sender {
    //获取图片缓存
    UIImage *productImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[urlString2 urlTransCoding]];
    
    if(productImage)
    {
        NSLog(@"存在图片");
        self.imageVIedw.image = productImage;
    }
    else
    {
        NSLog(@"不存在图片");
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self LayoutSubviews];//控件布局
    
    
    urlString = @"http://a.hiphotos.baidu.com/zhidao/pic/item/f9dcd100baa1cd11aa2ca018bf12c8fcc3ce2d74.jpg";
    
    urlString1 = @"http://192.168.0.37/longma/image/text/haah 是电风扇的 sdfdsdfl 的 点点 d d d.jpg";
    
    urlString2 = @"http://192.168.0.37/longma/image/text/ni是wode 水电费sdfsdfs s sdf&^(&(*(*.jpg";
    
    //正常地址
    NSURL *imgUrl = [NSURL URLWithString:urlString];
    
    [_titleImg sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"logo_del_pro"] options:SDWebImageLowPriority | SDWebImageRetryFailed];
    
    NSURL *imgUrl1 = [NSURL URLWithString:[urlString1 urlTransCoding]];
    
    [_img1 sd_setImageWithURL:imgUrl1 placeholderImage:[UIImage imageNamed:@"logo_del_pro"] options:SDWebImageLowPriority | SDWebImageRetryFailed];
    
    NSURL *imgUrl2 = [NSURL URLWithString:[urlString2 urlTransCoding]];

    [_img2 sd_setImageWithURL:imgUrl2 placeholderImage:[UIImage imageNamed:@"logo_del_pro"] options:SDWebImageLowPriority | SDWebImageRetryFailed];
    
}

- (IBAction)downBtn:(id)sender {
    NSString *urls =@"http://img-download.pchome.net/download/1k0/xp/3h/odxxqk-9xw.jpg";
    NSURL *imgUrl2 = [NSURL URLWithString:urls];
    
//    __block CGFloat viewH = 0;
    [_imageVIedw sd_setImageWithURL:imgUrl2 placeholderImage:[UIImage imageNamed:@"logo_del_pro"] options:SDWebImageLowPriority | SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        //判断图片是否有值，避免出现除以零的情况导致崩溃
        if (image)
        {
            NSData * imageData = UIImageJPEGRepresentation(image,1);
            NSInteger length = [imageData length]/1024;
            NSLog(@"---%ld",length);
        }
        
    }];
    NSData * imageData = UIImagePNGRepresentation([UIImage imageNamed:@"odxxqk-9xw"]);
    NSInteger length = [imageData length]/1024;
    NSLog(@"---%ld",length);
//    UIImage *dxxx= [UIImage imageNamed:@"odxxqk-9xw"];
//    CGFloat big =  dxxx.size.width * dxxx.size.height *4;
//     NSLog(@"---%lf",big);
    
    
}

#pragma mark - 控件布局
- (void)LayoutSubviews {
    [self.view addSubview:self.titleImg];
    
    [_titleImg makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view).offset(30);
        make.height.width.equalTo(@100);
    }];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
