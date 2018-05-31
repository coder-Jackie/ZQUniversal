//
//  WKMineVC.m
//  ZQUniversal
//
//  Created by CoderZQ on 2018/5/22.
//  Copyright © 2018年 CoderZQ. All rights reserved.
//

#import "WKMineVC.h"
//#import "TableViewController.h"
#import "HSCustomCellModel.h"
#import "HSHeaderCellModel.h"
#import "ZQRefreshGifHeader.h"
#import "SDImagePickVC.h"
#import "GLShareManager.h"
#import "ZQShareView.h"

#import "WKPersonInfoVC.h"



@interface WKMineVC () <UIImagePickerControllerDelegate,UIAlertViewDelegate>

@property(nonatomic, strong) SDImagePickVC *pickerVC;

@property(nonatomic, strong) HSHeaderCellModel *header;
/** 清除缓存模型 */
@property(nonatomic, strong) HSTextCellModel *cleanCacheModel;

@end

@implementation WKMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor hs_colorWithHexString:@"#EBEDEF"];
    

    
    WEAKSELF;
    HSHeaderCellModel *header = [[HSHeaderCellModel alloc] initWithCellIdentifier:@"HSHeaderTableViewCell" actionBlock:^(HSBaseCellModel *model) {
        HSHeaderCellModel *hederModel = (HSHeaderCellModel *)model;
        hederModel.text = @"奔跑吧,兄弟";
        hederModel.headIVStr = @"MoreExpressionShops";
        [weakSelf updateCellModel:hederModel];
    }];
    header.text = @"天霸动霸tuo";
    header.cellHeight = 100;
    self.header = header;
    
    
    
    HSTitleCellModel *photo = [[HSTitleCellModel alloc] initWithTitle:@"相册" actionBlock:^(HSBaseCellModel *model) {
        HSLog(@"点击相册")
        
        
            NSArray *arr = @[@"拍摄",@"从手机相册选择"];
            SRActionSheet *actionSheet = [SRActionSheet sr_actionSheetViewWithTitle:@"请选择"
                                                                        cancelTitle:@"取消"
                                                                   destructiveTitle:nil
                                                                        otherTitles:arr
                                                                        otherImages:nil
                                                                   selectSheetBlock:^(SRActionSheet *actionSheetView, NSInteger index) {
                                                                       if (index != -1) { // - 1为取消
                                                                           [weakSelf takePicture:index];
                                                                       }
                                                                   }];
            [actionSheet show];
        
    }];
    photo.icon = [UIImage imageNamed:@"MoreMyAlbum"];
    
    
    
    
    HSTitleCellModel *favorite = [[HSTitleCellModel alloc] initWithTitle:@"个人信息" actionBlock:^(HSBaseCellModel *model) {
        HSLog(@"个人信息")
        
        WKPersonInfoVC *personInfoVC = [[WKPersonInfoVC alloc] init];
        [self.navigationController pushViewController:personInfoVC animated:YES];
    }];
    favorite.icon = [UIImage imageNamed:@"MoreMyFavorites"];
    
    
    
    HSTitleCellModel *wallet = [[HSTitleCellModel alloc] initWithTitle:@"分享" actionBlock:^(HSBaseCellModel *model) {
        HSLog(@"点击分享")
        // 测试使用 ,后期 更加参数去设置
        [self shareWithShareTitle:@"分享" shareContext:@"欢迎使用【友盟+】社会化组件U-Share" shareUrl:@"http://mobile.umeng.com/social" shareImageUrl:@"https://mobile.umeng.com/images/pic/home/social/img-1.png"];
    }];
    wallet.icon = [UIImage imageNamed:@"MoreMyAlbum"];
    
    
    
    HSTitleCellModel *expression = [[HSTitleCellModel alloc] initWithTitle:@"表情" actionBlock:^(HSBaseCellModel *model) {
        HSLog(@"点击表情")
    }];
    expression.icon = [UIImage imageNamed:@"MoreExpressionShops"];
    
    
    
    HSTitleCellModel *setting = [[HSTitleCellModel alloc] initWithTitle:@"设置" actionBlock:^(HSBaseCellModel *model) {
        HSLog(@"点击设置")
    }];
    setting.icon = [UIImage imageNamed:@"MoreExpressionShops"];
    
    
    // 清除缓存
    HSTextCellModel *cleanCacheModel = [[HSTextCellModel alloc] initWithTitle:@"清除缓存" detailText:[self getCacheSize] actionBlock:^(HSBaseCellModel *model) {
        HSLog(@"清除缓存")
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要清理缓存?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }];
    cleanCacheModel.showArrow = NO;
    cleanCacheModel.icon = [UIImage imageNamed:@"MoreMyAlbum"];
    self.cleanCacheModel = cleanCacheModel;
    
    // 版本号
    
//    ZQVersionManager
    NSString *versionStr = [NSString stringWithFormat:@"当前版本(%@)",[ZQSystemInfo getAppVersion]];
    HSTextCellModel *version = [[HSTextCellModel alloc] initWithTitle:versionStr detailText:@"当前是最新版本" actionBlock:^(HSBaseCellModel *model) {
        HSLog(@"版本号")
    }];
    version.showArrow = NO;
    version.icon = [UIImage imageNamed:@"MoreMyFavorites"];
    // 调取接口获取是否最新版本
    
    
    NSMutableArray *section = [NSMutableArray arrayWithObjects:header,nil];
    NSMutableArray *section0 = [NSMutableArray arrayWithObjects:photo,favorite,wallet, nil];
    NSMutableArray *section1 = [NSMutableArray arrayWithObjects:expression,nil];
    NSMutableArray *section2 = [NSMutableArray arrayWithObjects:setting,cleanCacheModel,version,nil];
    
    [self.hs_dataArry addObject:section];
    [self.hs_dataArry addObject:section0];
    [self.hs_dataArry addObject:section1];
    [self.hs_dataArry addObject:section2];
    
    
    [self.hs_tableView reloadData];
    
    
    

    
   
    

}

- (void)test
{
    // 测试下拉刷新
    
    //    self.hs_tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            [self.hs_tableView.mj_header endRefreshing];
    //        });
    //    }];
    
    //    self.hs_tableView.mj_header = [ZQRefreshGifHeader headerWithRefreshingBlock:^{
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            [self.hs_tableView.mj_header endRefreshing];
    //        });
    //    }];
    
    
    ////    self.hs_tableView.ly_emptyView = [ZQDIYEmpty diyNoNetworkEmptyWithTarget:self action:@selector(clickAction)];
    //    self.hs_tableView.ly_emptyView = [ZQDIYEmpty diyNoNetworkEmptyWithTarget:self action:nil];
    //    // 禁止一开始就显示
    //    [self.hs_tableView ly_startLoading];
    //
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        [self.hs_dataArry removeAllObjects];
    //        [self.hs_tableView reloadData];
    //
    //        // 刷新完调用
    //        [self.hs_tableView ly_endLoading];
    //    });
    //
    //    // emptyView内容上的点击事件监听
    //    [self.hs_tableView.ly_emptyView setTapContentViewBlock:^(){
    ////        [weakSelf requestData];
    //    }];
    
    
    // 手动调用
    //    //1.先设置样式
    //    self.tableView.ly_emptyView = [MyDIYEmpty diyNoDataEmpty];
    //    //2.关闭自动显隐（此步可封装进自定义类中，相关调用就可省去这步）
    //    self.tableView.ly_emptyView.autoShowEmptyView = NO;
    //    //3.显示emptyView
    //    [self.tableView ly_showEmptyView];
    //    //4.隐藏emptyView
    //    [self.tableView ly_hideEmptyView];
    
    
    
    //    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    //
    //    [ZQHTTPTool GET:URL_main params:param success:^(id json, int code) {
    //        if (code == 200) {
    //            [MBProgressHUD showSuccess:@"请求成功"];
    //        }
    //    } failure:^(NSError *error) {
    //        [MBProgressHUD showError:@"网络请求失败,请稍后再试"];
    //    } hudInView:self.view];
    
}

#pragma mark- 清除缓存相关
// 获取缓存大小后转化为格式化字符
- (NSString *)getCacheSize {
    
    // 1.获取缓存文件夹路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    // 2.1计算缓存大小(沙箱下)
    NSUInteger totalSize = (NSUInteger)[NSFileManager fileSizeOfPath:cachePath];
    // 2.2计算缓存大小(SDWebImage 图片缓存)
    NSUInteger imageSize = [[SDImageCache sharedImageCache] getSize];
    totalSize += imageSize;
    
    // 3.缓存大小格式转换
    NSString *sizeStr = [NSFileManager stringWithFileSize:totalSize];
    
    return sizeStr;
    
}

#pragma mark -UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {  // 点击了取消按钮
        return;
    } else {  // 点击了确定按钮,清理缓存
        
        // 1.清理沙箱缓存
        [self clearFile];
        
        // 2.清理图片缓存
        [[SDImageCache sharedImageCache] cleanDisk];
        
        // 3.更新界面
        self.cleanCacheModel.detailText = [self getCacheSize];
        [self updateCellModel:_cleanCacheModel];
        
        // 4.提示
        [MBProgressHUD showSuccess:@"清除缓存成功"];
    }
    
    
}


// 清理缓存
- (void)clearFile
{
    //Caches
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSArray *files = [fileMgr subpathsAtPath:cachePath];
    for (NSString *subFile in files) {
        // 拼接路径
        NSString *fullPath = [cachePath stringByAppendingPathComponent:subFile];
        NSError *error = nil;
        if ([fileMgr fileExistsAtPath:fullPath]) {
            [fileMgr removeItemAtPath:fullPath error:&error];
        }
    }
    
}

#pragma mark- 选取照片相关

-(void)takePicture:(NSInteger)index{
    [self goPhotoPickerVCType:index];
}

//跳转至选择相片
-(void)goPhotoPickerVCType:(NSInteger)index{
    self.pickerVC = [[SDImagePickVC alloc]init];
    self.pickerVC.direction = YIMIImagePickerDirectionPortrait;
    if (index == 0) {
        self.pickerVC.sourceType =UIImagePickerControllerSourceTypeCamera;
    }
    else if (index == 1) {
        self.pickerVC.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
    }
    self.pickerVC.delegate = self;
    self.pickerVC.allowsEditing = YES;
    [self presentViewController:self.pickerVC animated:YES completion:^{
    }];
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage* editImage;
    editImage = info[@"UIImagePickerControllerEditedImage"];
    self.header.headImg = editImage;
    [self updateCellModel:self.header];
//    [self uploadPicture:editImage];
    //    [self compressImage:editImage toMaxFileSize:50*1024];
    [self.pickerVC dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark- 根据分享内容弹窗分享.
- (void)shareWithShareTitle:(NSString *)shareTitle shareContext:(NSString *)shareContext shareUrl:(NSString *)shareUrl shareImageUrl:(NSString *)shareImageUrl
{
    BOOL hadInstalledWeixin = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]];
    BOOL hadInstalledQQ = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]];
    
    NSMutableArray *titlearr = [NSMutableArray arrayWithCapacity:5];
    NSMutableArray *imageArr = [NSMutableArray arrayWithCapacity:5];
    
    int startIndex = 0;
    
    if (hadInstalledWeixin) {
        [titlearr addObjectsFromArray:@[@"朋友圈", @"微信"]];
        [imageArr addObjectsFromArray:@[@"pengyou",@"wechat"]];
    } else {
        startIndex += 2;
    }
    
    if (hadInstalledQQ) {
        [titlearr addObjectsFromArray:@[@"QQ", @"QQ空间"]];
        [imageArr addObjectsFromArray:@[@"penghyouquan",@"qqspace"]];
    } else {
        startIndex += 2;
    }
    //    [titlearr addObjectsFromArray:@[@"朋友圈",@"微信",@"QQ",@"QQ空间",@"新浪微博"]];
    //    [imageArr addObjectsFromArray:@[@"pengyou",@"wechat",@"penghyouquan",@"qqspace",@"sina"]];
    
    [titlearr addObjectsFromArray:@[@"新浪微博"]];
    [imageArr addObjectsFromArray:@[@"sina"]];
    
    // 初始化分享面板
    ZQShareView *shareView = [[ZQShareView alloc] initWithShareHeadOprationWith:titlearr andImageArry:imageArr andProTitle:@"分享到"];
    shareView.proFont = 18;
    shareView.cancelBtnFont = 18;
    
    __block NSString* shareType = @"";// 课后分享的类型
    // 初始化分享管理者
    WEAKSELF;
    GLShareManager * shareManger = [[GLShareManager alloc] init];
//    if (![NSString isBlank:self.shareLessonID]) {
//        shareManger.isHideAlert = YES;
//    }
    [shareManger setShareResultBlock:^(NSString *shareResult){
        
        NSLog(@"block传递分享结果为:%@",shareResult);
        
//        NSString *js = [NSString stringWithFormat:@"yimiNative.shareState('%@')",shareResult];
//        if (![NSString isBlank:weakself.shareLessonID]&&![NSString isBlank:shareType]) {
//            js = [NSString stringWithFormat:@"yimiNative.shareState('%@','%@','%@')",shareResult,shareType,weakself.shareLessonID];
//            ZQLog(@"分享js:%@",js);
//        }
//        [self evaluateJS:js];
    }];
    
    
    [shareView setBtnClick:^(NSInteger btnTag) {
        //NSLog(@"\n点击第几个====%d\n当前选中的按钮title====%@",(int)btnTag,titlearr[btnTag]);
        switch (btnTag + startIndex) {
            case 0: {
                // 朋友圈
                ZQLog(@"朋友圈");
                [shareManger UMShareToWeiChatTimelineWithTitle:shareTitle shareUrl:shareUrl imageUrl:shareImageUrl describe:shareContext presentedController:self];
//                [weakself insertShareWithShareChannel:@"FRIEND"];
                shareType = @"WEIXIN_CIRCLE";
            }
                break;
            case 1: {
                // 微信
                ZQLog(@"微信");
                [shareManger UMShareToWeiChatSessionWithTitle:shareTitle shareUrl:shareUrl imageUrl:shareImageUrl describe:shareContext presentedController:self];
//                [weakself insertShareWithShareChannel:@"WECHAT"];
                shareType = @"WEIXIN";
            }
                break;
            case 2: {
                // QQ
                ZQLog(@"QQ");
                [shareManger UMShareToQQWithTitle:shareTitle shareUrl:shareUrl imageUrl:shareImageUrl describe:shareContext presentedController:self];
//                [weakself insertShareWithShareChannel:@"QQ"];
                shareType = @"QQ";
                
            }
                break;
            case 3: {
                // QQ空间
                ZQLog(@"QQ空间");
                [shareManger UMShareToQQZoneWithTitle:shareTitle shareUrl:shareUrl imageUrl:shareImageUrl describe:shareContext presentedController:self];
//                [weakself insertShareWithShareChannel:@"QZONE"];
                shareType = @"QZONE";
            }
                break;
            case 4: {
                // 微博
                ZQLog(@"微博");
                [shareManger UMShareToSinaWithTitle:shareTitle shareUrl:shareUrl imageUrl:shareImageUrl describe:shareContext presentedController:self];
//                [weakself insertShareWithShareChannel:@"SINA"];
                shareType = @"SINA";
            }
                break;
            default:
                break;
                
        }
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:shareView];
}



@end
