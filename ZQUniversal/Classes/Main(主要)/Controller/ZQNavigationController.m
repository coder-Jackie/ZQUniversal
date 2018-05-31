//
//  ZQNavigationController.m
//  ZQUniversal
//
//  Created by CoderZQ on 2018/5/18.
//  Copyright © 2018年 CoderZQ. All rights reserved.
//

#import "ZQNavigationController.h"

@interface ZQNavigationController ()

@end

@implementation ZQNavigationController

-(BOOL)shouldAutorotate {
    return [[self.viewControllers lastObject] shouldAutorotate];
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 清空弹出手势的代理，就可以恢复弹出手势
    self.interactivePopGestureRecognizer.delegate = nil;
}


/**
 *  类方法，当第一次使用这个类的时候只用1次。
 */
+ (void)initialize
{
    
    // 设置UINavigationBar主题
    [self setNavigationBarTheme];
    
    // 设置UIBarButtonItem主题
    [self setUIBarButtonItemTheme];
    
    
}

// 设置UINavigationBar主题
+ (void)setNavigationBarTheme
{
    UINavigationBar *appearance = [UINavigationBar appearance];
    NSDictionary *textAtti = @{NSFontAttributeName : [UIFont systemFontOfSize:17],NSForegroundColorAttributeName : [UIColor blackColor]};
    [appearance setTitleTextAttributes:textAtti];
    
    
}

// 设置UIBarButtonItem主题
+ (void)setUIBarButtonItemTheme
{
    // 设置普通状态下的文字属性。
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    NSDictionary *textAttr = @{NSForegroundColorAttributeName : [UIColor orangeColor],NSFontAttributeName : [UIFont systemFontOfSize:15]};
    [appearance setTitleTextAttributes:textAttr forState:UIControlStateNormal];
    
    // 设置高亮状态下的文字属性。
    
    NSDictionary *highlightAttr = @{NSForegroundColorAttributeName : [UIColor blueColor],NSFontAttributeName : [UIFont systemFontOfSize:15]};
    [appearance setTitleTextAttributes:highlightAttr forState:UIControlStateHighlighted];
    
    // 设置不可用状态下的文字属性。
    
    NSDictionary *disableAttr = @{NSForegroundColorAttributeName : [UIColor lightGrayColor],NSFontAttributeName : [UIFont systemFontOfSize:15]};
    [appearance setTitleTextAttributes:disableAttr forState:UIControlStateDisabled];
    
}
/**
 *  能拦截所有push进来的子控制器。
 *
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //NSLog(@"------self.count%ld",self.viewControllers.count);
    if (self.childViewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"btn_back_new"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"btn_back_new"] forState:UIControlStateHighlighted];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        //button.bounds = CGRectMake(0, 0, 70, 30);
        button.bounds = CGRectMake(0, 0, 44, 30);
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        if (@available(iOS 11.0, *)) {
            button.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        };
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    
    
    [super pushViewController:viewController animated:animated];
}
- (void)back
{
    [self popViewControllerAnimated:YES];
    // 告知返回按钮点击了
    if (self.backBtnAciton) {
        self.backBtnAciton();
    }
}

- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}
@end
