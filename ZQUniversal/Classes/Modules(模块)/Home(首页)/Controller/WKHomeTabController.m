//
//  WKHomeTabController.m
//  ZQUniversal
//
//  Created by CoderZQ on 2018/5/22.
//  Copyright © 2018年 CoderZQ. All rights reserved.
//

#import "WKHomeTabController.h"
#import "TableViewController.h"
//#import "UINavigationController+FDFullscreenPopGesture.h"

@interface WKHomeTabController ()

@end

@implementation WKHomeTabController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.interceptRightSlideGuetureInFirstPage = YES;
    
    self.tabBar.itemTitleColor = [UIColor colorWithHexString:@"9B9B9B"];
    self.tabBar.itemTitleSelectedColor = KColorGlobal;
    self.tabBar.itemTitleFont = [UIFont systemFontOfSize:14];
    self.tabBar.itemTitleSelectedFont = [UIFont systemFontOfSize:16];
    
    self.tabBar.itemFontChangeFollowContentScroll = YES;
    
    self.tabBar.indicatorScrollFollowContent = YES;
    self.tabBar.indicatorColor = KColorGlobal;
//    [self.tabBar setIndicatorInsets:UIEdgeInsetsMake(40, 10, 0, 10) tapSwitchAnimated:NO];
//    [self.tabBar setIndicatorInsets:UIEdgeInsetsMake(40, 40, 0, 40) tapSwitchAnimated:YES];
    
    [self.tabBar setIndicatorWidthFixTextAndMarginTop:40 marginBottom:0 widthAdditional:0 tapSwitchAnimated:YES];
    
    self.yp_tabItem.badgeStyle = YPTabItemBadgeStyleDot;
    
    self.loadViewOfChildContollerWhileAppear = YES;
    
    [self setContentScrollEnabledAndTapSwitchAnimated:NO];
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"image" ofType:@"jpg"];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.userInteractionEnabled = YES;
    
    CGFloat bottom = 0;
    if (screenSize.height == 812) {
        bottom += 34;
    }
    if ([self.parentViewController isKindOfClass:[YPTabBarController class]]) {
        bottom += 50;
    }
    
    [self setHeaderView:imageView
            needStretch:NO
           headerHeight:250
           tabBarHeight:44
      contentViewHeight:screenSize.height - 250 - 44 - bottom - 60
  tabBarStopOnTopHeight:20];
    
//    [self setHeaderView:imageView
//            needStretch:YES
//           headerHeight:250
//           tabBarHeight:44
//      contentViewHeight:screenSize.height - 250 - 44 - bottom
//  tabBarStopOnTopHeight:20];
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(10, 20, 50, 40);
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    [self initViewControllers];
    
    [self addBottomView];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initViewControllers {
    TableViewController *controller1 = [[TableViewController alloc] init];
    controller1.yp_tabItemTitle = @"课程详情";
    
//    TableViewController *controller2 = [[TableViewController alloc] init];
//    controller2.yp_tabItemTitle = @"课程列表";
    
    TableViewController *controller3 = [[TableViewController alloc] init];
    controller3.yp_tabItemTitle = @"课程列表";
    controller3.numberOfRows = 5;
//
//    TableViewController *controller4 = [[TableViewController alloc] init];
//    controller4.yp_tabItemTitle = @"第四";
    
    self.viewControllers = [NSMutableArray arrayWithObjects:controller1, controller3, nil];
    
}


- (void)addBottomView
{
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = KWhiteColor;
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@60);
        make.bottom.equalTo(@(-KSafeAreaBottomHeight));
    }];
    
    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyBtn setTitle:@"$0.01/立即订阅" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    [buyBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [buyBtn setBackgroundColor:[UIColor colorWithHexString:@"6B56C7"]];
    [buyBtn xyzShowBorder:[UIColor colorWithHexString:@"6B56C7"] cornerRadius:20];
    [buyBtn addTarget:self action:@selector(buyBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:buyBtn];
    
    [buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@10);
        make.bottom.equalTo(@(-10));
        make.right.equalTo(@(-20));
                                             
    }];
}


- (void)buyBtnAction
{
    ZQLog(@"立即订阅点击了");
    
}

@end
