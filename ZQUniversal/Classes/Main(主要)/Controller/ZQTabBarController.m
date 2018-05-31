//
//  ZQTabBarController.m
//  ZQUniversal
//
//  Created by CoderZQ on 2018/5/18.
//  Copyright © 2018年 CoderZQ. All rights reserved.
//

#import "ZQTabBarController.h"
#import "ZQNavigationController.h"

#import "ViewController.h"

#import "WKHomeVC.h"
#import "WKMineVC.h"

@interface ZQTabBarController ()

@end

@implementation ZQTabBarController

-(BOOL)shouldAutorotate{return YES;}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{return UIInterfaceOrientationMaskPortrait;}
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{return UIInterfaceOrientationPortrait;}


+ (void)initialize
{
    UITabBarItem *appearance = [UITabBarItem appearance];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [appearance setTitleTextAttributes:attrs forState:UIControlStateSelected];
    
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 初始化所有的子控制器
    [self setupChildViewControllers];
}

/**
 * 初始化所有的子控制器
 */
- (void)setupChildViewControllers
{
//    XMGEssenceViewController *essence = [[XMGEssenceViewController alloc] init];
    ViewController *essence = [[ViewController alloc] init];
    WKHomeVC *homeVC = [[WKHomeVC alloc] init];
    [self setupOneChildViewController:homeVC title:@"主页" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
////    XMGNewViewController *new = [[XMGNewViewController alloc] init];
//    UIViewController *new = [[UIViewController alloc] init];
//    [self setupOneChildViewController:new title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
//
////    XMGFriendTrendsViewController *friends = [[XMGFriendTrendsViewController alloc] init];
//    UIViewController *friends = [[UIViewController alloc] init];
//    [self setupOneChildViewController:friends title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
//    XMGMeViewController *me = [[XMGMeViewController alloc] init];
//    UIViewController *me = [[UIViewController alloc] init];
//    ViewController *me = [[ViewController alloc] init];
    WKMineVC *me = [[WKMineVC alloc] init];
    [self setupOneChildViewController:me title:@"我的" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
}

- (void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
#warning 注销掉
//    vc.view.backgroundColor = KRandomColor;
    vc.title = title;
    
    [self addChildViewController:[[ZQNavigationController alloc] initWithRootViewController:vc]];
}
@end
