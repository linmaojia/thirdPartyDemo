//
//  DEMO1_VC.m
//  Masonry
//
//  Created by LXY on 16/5/11.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "DEMO4_VC.h"
#import "HMSegmentedControl.h"
@interface DEMO4_VC ()
{
    NSInteger sementCurrent;
}

@property (nonatomic, strong) HMSegmentedControl *segmentedControl;//第三方    /**< 分段控制器 */
@property(nonatomic, strong)UISegmentedControl *segment;   /**< 分段控制器 */

@property (nonatomic, strong) HMSegmentedControl *nextSegmentedControl;    /**< 分段控制器 */
@property (nonatomic) OrderType orderType;      /**< 订单类型 */

@end

@implementation DEMO4_VC


#pragma mark 懒加载控件
- (HMSegmentedControl *)segmentedControl {
    if (!_segmentedControl) {
        _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"商品",@"品牌"]];
        _segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        _segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
        _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segmentedControl.selectionIndicatorColor = [UIColor orangeColor];
        _segmentedControl.selectedSegmentIndex = 0;
        _segmentedControl.verticalDividerEnabled = YES;
        _segmentedControl.verticalDividerColor = RGB(238, 238, 238);
        _segmentedControl.verticalDividerWidth = 1.f;
        [_segmentedControl setTitleFormatter:^NSAttributedString *(HMSegmentedControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected) {
            NSAttributedString *attString = nil;
            if (selected) {
                attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [UIColor orangeColor],NSFontAttributeName : [UIFont systemFontOfSize:16.0f]}];
            } else {
                attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [UIColor blackColor],NSFontAttributeName : [UIFont systemFontOfSize:16.0f]}];
            }
            return attString;
        }];
        [_segmentedControl addTarget:self action:@selector(segmentedControlIndexChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentedControl;
}

- (HMSegmentedControl *)nextSegmentedControl {
    if (!_nextSegmentedControl) {
        _nextSegmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"全部", @"待付款", @"待发货", @"待收货", @"已完成", @"已取消"]];
        _nextSegmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        _nextSegmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
        _nextSegmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _nextSegmentedControl.selectionIndicatorColor = [UIColor orangeColor];
        _nextSegmentedControl.selectedSegmentIndex = self.orderType;
        _nextSegmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, 0, 0, 0);
        sementCurrent = self.orderType;
        [_nextSegmentedControl setTitleFormatter:^NSAttributedString *(HMSegmentedControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected) {
            NSAttributedString *attString = nil;
            if (selected) {
                attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [UIColor orangeColor],NSFontAttributeName : [UIFont systemFontOfSize:14.0f]}];
            } else {
                attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [UIColor blackColor],NSFontAttributeName : [UIFont systemFontOfSize:14.0f]}];
            }
            return attString;
        }];
        [_nextSegmentedControl addTarget:self action:@selector(segmentedControlIndexChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _nextSegmentedControl;
}


- (UISegmentedControl *)segment {
    if (!_segment) {
        _segment = [[UISegmentedControl alloc] initWithItems:@[@"分类检索",@"组合筛选"]];
        
        [_segment addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
        _segment.tintColor = [UIColor whiteColor];
    }
    return _segment;
}


#pragma mark - 系统方法
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutSubviews];//控件布局
}

#pragma mark - 分栏控制器选择方法
- (void)segmentedControlIndexChange:(HMSegmentedControl *)seg{
    
    
    if (seg.selectedSegmentIndex == 0) {
        NSLog(@"xxxxxx----%ld",seg.selectedSegmentIndex);
    } else {
        NSLog(@"xxxxxx----%ld",seg.selectedSegmentIndex);
    }
}
#pragma mark- 标题分段控制器切换
- (void)segmentChange:(UISegmentedControl *)seg {
    
    
    if(seg.selectedSegmentIndex == 0)
    {
         NSLog(@"xxxxxx--系统的--%ld",seg.selectedSegmentIndex);
    }
    else
    {
        NSLog(@"xxxxxx--系统的--%ld",seg.selectedSegmentIndex);

    }
}
#pragma mark - 控件布局
- (void)layoutSubviews {
    
   
    [self.view addSubview:self.segmentedControl];
    [self.view addSubview:self.nextSegmentedControl];

    [self.navigationItem setTitleView:self.segment];
    
    [_segmentedControl makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@(AUTO_MATE_HEIGHT(35)));
    }];
    
    [_nextSegmentedControl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_segmentedControl.bottom).offset(10);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(AUTO_MATE_HEIGHT(35)));
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
