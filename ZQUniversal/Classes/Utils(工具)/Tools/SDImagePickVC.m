//
//  SDImagePickVC.m
//  YiMiApp
//
//  Created by Yangsenkai on 2017/3/6.
//  Copyright © 2017年 YiMi. All rights reserved.
//

#import "SDImagePickVC.h"
@interface SDImagePickVC ()

@end

@implementation SDImagePickVC

- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.navigationBar.tintColor = [UIColor hexStringColor:@"333333"];
    }
    return self;
}
-(void)aaaaaaaaa{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    
    
    return UIStatusBarStyleDefault;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        self.navigationBar.tintColor = [UIColor colorWithHexString:@"333333"];
        [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"111111"]}];
    }
    
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"333333"]} forState:UIControlStateNormal];
    }
    
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    }
}

-(BOOL)shouldAutorotate{return NO;}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    if (_direction == YIMIImagePickerDirectionPortrait) {
        return UIInterfaceOrientationMaskPortrait;
    }
    else if (_direction == YIMIImagePickerDirectionLandscapeRight) {
        return UIInterfaceOrientationMaskLandscapeRight;
    }
    return UIInterfaceOrientationMaskPortrait;}
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    if (_direction == YIMIImagePickerDirectionPortrait) {
        return UIInterfaceOrientationPortrait;
    }
    else if (_direction == YIMIImagePickerDirectionLandscapeRight) {
        return UIInterfaceOrientationLandscapeRight;
    }
    return UIInterfaceOrientationPortrait;}

@end
