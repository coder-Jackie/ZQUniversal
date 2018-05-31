//
//  ZQBaseViewController.m
//  ZQUniversal
//
//  Created by CoderZQ on 2018/5/21.
//  Copyright © 2018年 CoderZQ. All rights reserved.
//

#import "ZQBaseViewController.h"

@interface ZQBaseViewController ()

@end

@implementation ZQBaseViewController

-(BOOL)shouldAutorotate{
    return YES;
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 解决tabbleView 自动上移问题.
    self.edgesForExtendedLayout = UIRectEdgeNone;// 推荐使用
}



@end
