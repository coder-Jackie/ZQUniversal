//
//  UIViewController+InterVC.h
//  YiMiApp
//
//  Created by xieyan on 15/10/26.
//  Copyright © 2015年 xieyan. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString* VCTitleKey = @"vctitle";

@interface UIViewController (UIViewController_InterVC)
//压栈
@property(nonatomic,strong)id parma;
@property(nonatomic,strong)void(^callback)(id message);
-(void)pushClass:(Class)cls parma:(NSDictionary*)parma callBack:(void(^)(id message))callBack;



//推出栈
-(void)pop;
-(void)popDouble;
-(void)pop:(int)num;


//返回按钮
-(void)createReturn;



//导航栏左右item
-(UIBarButtonItem*)createBarButtonItemTitle:(NSString*)title selector:(SEL)selector left:(BOOL)isLeft;
- (UIBarButtonItem *)createBarButtonItemWithCustomImage:(UIImage*)image selector:(SEL)selector left:(BOOL)isLeft;
-(UIBarButtonItem*)createBarButtonItemImage:(UIImage*)image selector:(SEL)selector left:(BOOL)isLeft;


@end
