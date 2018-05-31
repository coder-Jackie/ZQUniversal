//
//  WKPersonInfoVC.m
//  ZQUniversal
//
//  Created by CoderZQ on 2018/5/29.
//  Copyright © 2018年 CoderZQ. All rights reserved.
//

#import "WKPersonInfoVC.h"

typedef NS_ENUM(NSUInteger, WKUserInfoSexType) {
    WKUserInfoSexTypeMale,  // 男
    WKUserInfoSexTypeFemale // 女
};

@interface WKPersonInfoVC ()

@end

@implementation WKPersonInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor hs_colorWithHexString:@"#EBEDEF"];
    self.title = @"个人信息";
    
    [self initSetTableViewConfigureStyle:UITableViewStylePlain];
    
    
    //头像
    UIImage *icon = [UIImage imageNamed:@"ic_icon_header"];
    HSImageCellModel *header = [[HSImageCellModel alloc] initWithTitle:@"头像" placeholderImage:icon imageUrl:nil actionBlock:^(HSBaseCellModel *model) {
        
    } imageBlock:^(HSBaseCellModel *cellModel) {
        HSLog(@"点击头像--%@",cellModel)
    }];
    
    //名字
    HSTextCellModel *name = [[HSTextCellModel alloc] initWithTitle:@"名字" detailText:@"人名的名义" actionBlock:^(HSBaseCellModel *model) {
        
    }];
    
    
    
    //微信号
    HSTextCellModel *number = [[HSTextCellModel alloc] initWithTitle:@"微信号" detailText:@"HSSetTableView" actionBlock:^(HSBaseCellModel *model) {
        
    }];
    number.selectionStyle = UITableViewCellSelectionStyleNone;
    number.showArrow = NO;
    
    //我的二维码
    UIImage *image = [UIImage imageNamed:@"ic_icon_qrCode"];
    HSImageCellModel *qrCode = [[HSImageCellModel alloc] initWithTitle:@"我的二维码" placeholderImage:image imageUrl:nil actionBlock:^(HSBaseCellModel *model) {
        
    } imageBlock:nil];
    qrCode.imageSize = CGSizeMake(15, 15);
    qrCode.cellHeight = HS_KCellHeight;
    
    //我的地址
    HSTitleCellModel *address = [[HSTitleCellModel alloc] initWithTitle:@"我的地址" actionBlock:^(HSBaseCellModel *model) {
        ZQCommonWebVC *reportVC = [[ZQCommonWebVC alloc] init];
        reportVC.loadUrl = @"https://www.baidu.com";
        [self.navigationController pushViewController:reportVC animated:YES];
    }];
    
    //性别
    WEAKSELF;
    HSTextCellModel *sex = [[HSTextCellModel alloc] initWithTitle:@"性别" detailText:@"男" actionBlock:^(HSBaseCellModel *model) {
        HSTextCellModel *sexModel = (HSTextCellModel *)model;
        NSArray *arr = @[@"男",@"女"];
        SRActionSheet *actionSheet = [SRActionSheet sr_actionSheetViewWithTitle:@"请选择"
                                                                    cancelTitle:@"取消"
                                                               destructiveTitle:nil
                                                                    otherTitles:arr
                                                                    otherImages:nil
                                                               selectSheetBlock:^(SRActionSheet *actionSheetView, NSInteger index) {
                                                                   if (index != -1) { // 0男 1女
                                                                       
                                                                       sexModel.detailText = (index == 0 ? @"男" : @"女");
                                                                       [self updateCellModel:sexModel];
                                                                       
                                                                       [weakSelf requestSetSex:index];
                                                                   }
                                                               }];
        [actionSheet show];
    }];
    
    //地区
    HSTextCellModel *area = [[HSTextCellModel alloc] initWithTitle:@"地区" detailText:@"四川 成都" actionBlock:^(HSBaseCellModel *model) {
        [[MOFSPickerManager shareManger] showMOFSAddressPickerWithTitle:nil cancelTitle:@"取消" commitTitle:@"完成" commitBlock:^(NSString *address, NSString *zipcode) {
            HSTextCellModel *areaModel = (HSTextCellModel *)model;
            areaModel.detailText = address;
            [self updateCellModel:areaModel];
        } cancelBlock:^{
            
        }];
        
        [MOFSPickerManager shareManger].addressPicker.numberOfSection = 2;
    }];
    
    
    // 生日
    NSDateFormatter *df = [NSDateFormatter new];
    df.dateFormat = @"yyyy-MM-dd";
    HSTextCellModel *birthday = [[HSTextCellModel alloc] initWithTitle:@"生日" detailText:@"1970-01-01" actionBlock:^(HSBaseCellModel *model) {
//        [MOFSPickerManager shareManger].datePicker.toolBar.cancelBarTintColor = [UIColor redColor];
//        [MOFSPickerManager shareManger].datePicker.toolBar.titleBarTitle = @"选择日期";
        [MOFSPickerManager shareManger].datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        [[MOFSPickerManager shareManger] showDatePickerWithTitle:nil cancelTitle:@"取消" commitTitle:@"完成" firstDate:nil minDate:nil maxDate:nil datePickerMode:UIDatePickerModeDate tag:1 commitBlock:^(NSDate *date) {
            HSTextCellModel *birthdayModel = (HSTextCellModel *)model;
            birthdayModel.detailText = [df stringFromDate:date];
            [self updateCellModel:birthdayModel];
        } cancelBlock:^{
            
        }];

    }];
    
    //
    //
    //个性签名
    HSTextCellModel *sign = [[HSTextCellModel alloc] initWithTitle:@"签名" detailText:@"气质如虹气质如虹气质如虹气质如虹气质如虹气质如虹气质如虹气质如虹气质如虹气质如虹气质如虹气质如虹气质如虹气质如虹气质如虹气质如虹气质如虹气质如虹气质如虹气质如虹气质如虹气质如虹气质如虹" actionBlock:nil];
    //    sign.controlRightOffset = 30;
    //    sign.arrowControlRightOffset = 50;
    
    
    
    NSMutableArray *section0 = [NSMutableArray arrayWithObjects:header,name,number,qrCode,address, nil];
    NSMutableArray *section1 = [NSMutableArray arrayWithObjects:area,birthday,sex,sign,nil];
    [self.hs_dataArry addObject:section0];
    [self.hs_dataArry addObject:section1];
    [self.hs_tableView reloadData];
}


#pragma mark- actionSheet


/**
 修改性别
 
 @param index  0男 1女
 */
-(void)requestSetSex:(NSInteger)index{
    
//    [MBProgressHUD showSuccess:[NSString stringWithFormat:@"选了%@",(index == 0 ? @"男": @"女")]];
//    NSDictionary *dic = @{@"sex":[NSString stringWithFormat:@"%zd",index],
//                          @"token":[GPL_GLOBAL userData].token,
//                          //                          @"sign":@"",
//                          @"timestamp":[XYZSystemInfo getTimeStemp]};
//    [SDHttp POSTUrl:Url_Edit_SD parma:[SDHttp dicWithSign:dic] response:^(id response, int code) {
//        if (code == 1) {
//            [[GPL_GLOBAL userData]setSex:index];
//            [GPL_DRAFT setCacheFromObject:[GPL_GLOBAL userData] toKey:UserInfoNew];
//            [self insertData];
//        }
//        else{
//            [OMGToast showWithText:response[@"message"]];
//        }
//    } failed:^(id response) {
//        [OMGToast showWithText:NetField];
//    } hudInview:self.view];
}

@end
