//
//  ViewController.m
//  ZQUniversal
//
//  Created by CoderZQ on 2018/5/17.
//  Copyright © 2018年 CoderZQ. All rights reserved.
//

#import "ViewController.h"

//#import <YYLabel.h>


#import <YYLabel.h>
#import <NSAttributedString+YYText.h>


@interface ViewController ()
/** <#describe#> */
@property(nonatomic, strong) YYLabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    
//    [SVProgressHUD show];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [SVProgressHUD dismiss];
//    });
    
    
    //    NSArray *arr = @[@"拍摄",@"从手机相册选择"];
    //    WEAKSELF;
    //    SRActionSheet *actionSheet = [SRActionSheet sr_actionSheetViewWithTitle:@"请选择"
    //                                                                cancelTitle:@"取消"
    //                                                           destructiveTitle:nil
    //                                                                otherTitles:arr
    //                                                                otherImages:nil
    //                                                           selectSheetBlock:^(SRActionSheet *actionSheetView, NSInteger index) {
    //                                                               if (index != -1) {
    ////                                                                   [weakself takePicture:index];
    //                                                                   //                                               [[GPL_GLOBAL userData] setSex:index];
    //                                                                   //                                               [ws insertData];
    //                                                               }
    //                                                           }];
    //    [actionSheet show];
    
  
//    UILabel *label = [[UILabel alloc] init];
//    label.text = @"我是打酱油的";
//    [self.view addSubview:label];
//
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(@0);
//    }];
//
//
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    param[@"studentId"] = @(110);  // 11111先写死了 后期用下面的
//    param[@"pageIndex"] = @(1);
//    param[@"pageSize"] = @(10);
//
//
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    [ZQHTTPTool POST:URL_main params:param success:^(id json) {
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        
////        [SVProgressHUD showSuccessWithStatus:json[@"message"]];
////        [OMGToast showWithText:json[@"message"] duration:3.0];
//        
//    } failure:^(NSError *error) {
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//    }];
    
    
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    param[@"studentId"] = @(110);  // 11111先写死了 后期用下面的
//    param[@"pageIndex"] = @(1);
//    param[@"pageSize"] = @(10);
//    
//    
//    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    //    [ZQHTTPTool POST:URL_main params:param success:^(id json) {
//    //
//    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    //            [MBProgressHUD hideHUDForView:self.view animated:YES];
//    //        });
//    //
//    //        //        [SVProgressHUD showSuccessWithStatus:json[@"message"]];
//    //        //        [OMGToast showWithText:json[@"message"] duration:3.0];
//    //
//    //    } failure:^(NSError *error) {
//    //
//    //        [MBProgressHUD hideHUDForView:self.view animated:YES];
//    //    }];
//    
//    [ZQHTTPTool POST:URL_main params:param success:^(id json) {
//        
//    } failure:^(NSError *error) {
//        
//    } hudInView:self.view];
    
//    NSMutableAttributedString *text = [NSMutableAttributedString new];
//    UIFont *font = [UIFont systemFontOfSize:16];
//    
//    // 添加文本
//    NSString *title = @"dwwdqwddqdqdqdqwdqdqwdqwdqdqdqdqwdqwdqdqdqwdqdqwdqdqdqdqdqdqwdq当前的群无多群无多群无多群无多群无多群多群无多群无多群无多群无多群多群多群多群当前的群无多群多群无多群多群多群多群多群多群多群多群的权威的权威的期望多无群多群无多群多群多群多群无多群无多群无多群无多群无多群无多群多群无多群无多群多群无多群多群无多无多无群多多群无多群多群多群多群无多群多无！";
//    
//    [text appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:nil]];
////    text.yy_font = font ;
//    text.font = font;
//    _label = [YYLabel new];
//    _label.userInteractionEnabled = YES;
//    _label.numberOfLines = 0;
//    _label.textVerticalAlignment = YYTextVerticalAlignmentTop;
//    _label.frame = CGRectMake(40,60, self.view.frame.size.width-80,150);
//    _label.attributedText = text;
//    [self.view addSubview:_label];
//    
//    _label.layer.borderWidth = 0.5;
//    _label.layer.borderColor = [UIColor colorWithRed:0.000 green:0.463 blue:1.000 alpha:1.000].CGColor;
//    
//    // 添加全文
//    [self addSeeMoreButton];
}

#pragma mark - 添加全文
- (void)addSeeMoreButton {
    
    __weak __typeof(self) weakSelf = self;
//
//    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"...全文"];
//
//    YYTextHighlight *hi = [YYTextHighlight new];
//    [hi setColor:[UIColor colorWithRed:0.578 green:0.790 blue:1.000 alpha:1.000]];
//
//    hi.tapAction = ^(UIView *containerView,NSAttributedString *text,NSRange range, CGRect rect) {
//
//        // 点击全文回调
//        YYLabel *label = weakSelf.label;
//        [label sizeToFit];
//    };
//
//    [text setColor:[UIColor colorWithRed:0.000 green:0.449 blue:1.000 alpha:1.000] range:[text.string rangeOfString:@"全文"]];
////    [[text setTextHighlight:hi range::[text.string rangeOfString:@"全文"]];
////    [text yy_setColor:[UIColor colorWithRed:0.000 green:0.449 blue:1.000 alpha:1.000] range:[text.string rangeOfString:@"全文"]];
////    [text yy_setTextHighlight:hi range:[text.string rangeOfString:@"全文"]];
////    text.yy_font = _label.font;
//
//    text.font = _label.font;
//
//    YYLabel *seeMore = [YYLabel new];
//    seeMore.attributedText = text;
//    [seeMore sizeToFit];
//
//    NSAttributedString *truncationToken = [NSAttributedString yy_attachmentStringWithContent:seeMore contentMode:UIViewContentModeCenter attachmentSize:seeMore.frame.size alignToFont:text.yy_font alignment:YYTextVerticalAlignmentCenter];
//
//    _label.truncationToken = truncationToken;
}

@end
