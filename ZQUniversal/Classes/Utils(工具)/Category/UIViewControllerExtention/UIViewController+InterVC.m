//
//  UIViewController+InterVC.m
//  YiMiApp
//
//  Created by xieyan on 15/10/26.
//  Copyright © 2015年 xieyan. All rights reserved.
//

#import "UIViewController+InterVC.h"
#import <objc/runtime.h>//objc runtime 动态增加属性



@implementation UIViewController (UIViewController_InterVC)
static char parmakey;
-(void)setParma:(id)parma{
    objc_setAssociatedObject(self, &parmakey, parma, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//相关对象强应用
}
-(id)parma{
    return objc_getAssociatedObject(self, &parmakey);
}
static char callBackKey;
-(void)setCallback:(void (^)(id))callback{
    objc_setAssociatedObject(self, &callBackKey, callback, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(void (^)(id))callback{
    return objc_getAssociatedObject(self, &callBackKey);
}

-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)popDouble{
    [self pop:2];
}
-(void)pop:(int)num{
    NSArray* array = self.navigationController.viewControllers;
    NSLog(@"%@",array);
    if (array.count==0) {
        return;
    }
    UIViewController* vc;
    if (array.count>num) {
        vc = array[array.count-num-1];
    }else{
        vc = array[0];
    }
    NSLog(@"%@",vc);
    [self.navigationController popToViewController:vc animated:YES];
}


-(UIBarButtonItem*)createBarButtonItemTitle:(NSString*)title selector:(SEL)selector left:(BOOL)isLeft{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:selector];
    if (isLeft) {
        self.navigationItem.leftBarButtonItem = item;
    }else{
        self.navigationItem.rightBarButtonItem = item;
    }
    return item;
}
- (UIBarButtonItem *)createBarButtonItemWithCustomImage:(UIImage*)image selector:(SEL)selector left:(BOOL)isLeft {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    float width = image.size.width/2.0;
    if (width <25.0) {
        width = 25.0;
    }
    float height = image.size.height/2.0;
    if (height < 25.0) {
        height = 25.0;
    }
    CGFloat screenScale = [UIScreen mainScreen].scale;
    button.bounds = CGRectMake(0, 0, width, height);
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    if (isLeft) {
        self.navigationItem.leftBarButtonItem = item;
    }else{
        self.navigationItem.rightBarButtonItem = item;
    }
    return item;

}
-(UIBarButtonItem*)createBarButtonItemImage:(UIImage*)image selector:(SEL)selector left:(BOOL)isLeft{
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:selector];
    if (isLeft) {
        self.navigationItem.leftBarButtonItem = item;
    }else{
        self.navigationItem.rightBarButtonItem = item;
    }
    return item;
}

-(void)createReturn{
    if (self.navigationController.viewControllers.firstObject == self) {
        return;
    }
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_return"] style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
   // self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fh"] style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
    // 改了染色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

-(void)pushClass:(Class)cls parma:(NSDictionary*)parma callBack:(void(^)(id message))callBack{
    UIViewController* obj = (UIViewController*)[[cls alloc] init];
    obj.callback = callBack;
    obj.parma = parma;
    if (parma && parma[VCTitleKey]) {
        obj.title = parma[VCTitleKey];
    }
    [self.navigationController pushViewController:obj animated:YES];
}
@end
