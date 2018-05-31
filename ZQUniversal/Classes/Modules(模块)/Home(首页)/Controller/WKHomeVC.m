//
//  WKHomeVC.m
//  ZQUniversal
//
//  Created by CoderZQ on 2018/5/22.
//  Copyright © 2018年 CoderZQ. All rights reserved.
//

#import "WKHomeVC.h"
#import "WKHomeCell.h"
#import "WKHomeCellHeadView.h"

#import "WKHomeTabController.h"

#import "WKEvaluateController.h"


#import "WKAllCourseVC.h"

#define headViewH 178.0

@interface WKHomeVC () <UITableViewDelegate,UITableViewDataSource>

///** tableView */
//@property(nonatomic, strong) UITableView *tableView;
/** 轮播View */
@property(nonatomic, strong) XRCarouselView *carouseView;
/** cell上面的headView */
@property(nonatomic, strong) WKHomeCellHeadView *homeCellHeadView;



@end

static NSString *const WKHomeCellID = @"WKHomeCellID";

@implementation WKHomeVC

#pragma mark - 懒加载区
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.backgroundColor = KClearColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 200;
        [_tableView registerNib:[UINib nibWithNibName:@"WKHomeCell" bundle:nil] forCellReuseIdentifier:WKHomeCellID];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
    }
    return _tableView;
    
}

- (XRCarouselView *)carouseView
{
    if (!_carouseView) {
//        _carouseView = [[XRCarouselView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 150 * Iphone6ScaleWidth)];
        _carouseView = [[XRCarouselView alloc] initWithFrame:CGRectMake(15, 15, KScreenW - 30, headViewH * Iphone6ScaleWidth - 15)];
    }
    return _carouseView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = KViewBgColor;
    self.title = @"VIPZQUniversal";
    
    // 1.设置导航项
    [self initNavigationBar];
    
    // 2.布局轮播图
    [self initHeadView];
    
    // 3.设置TableView
    [self initTableView];

    // 4.先读取缓存
//    [self headerRefreshFailed:nil];
    // 5.开始请求
    [self headerRefresh];
    
    
    self.tableView.mj_header = [ZQRefreshGifHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self headerRefresh];
        });
    }];
    
    // 显示悬浮按钮
//    WKFloatBtn *floatBtn = [WKFloatBtn floatBtn];
//    [floatBtn show];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [floatBtn hide];
//    });

}






- (void)initNavigationBar
{
    
}

- (void)initHeadView
{
    NSTimeInterval showTime = 2.0;
    NSArray *imgArr = @[[UIImage imageNamed:@"image.jpg"],@"http://img.zcool.cn/community/015cca59841b24a801215603ef250f.jpg@1280w_1l_2o_100sh.jpg",@"http://img.zcool.cn/community/01d9a759841b4500000021290846be.jpg@2o.jpg",@"http://img.zcool.cn/community/01474d59841b950000002129ab8676.jpg@2o.jpg"];
    //设置占位图片,须在设置图片数组之前设置,不设置则为默认占位图
    self.carouseView.placeholderImage = [UIImage imageNamed:@"index_loading"];
    //设置图片数组及图片描述文字
    _carouseView.imageArray = imgArr;
    //设置每张图片的停留时间，默认值为5s，最少为2s
    _carouseView.time = showTime;
    _carouseView.contentMode = UIViewContentModeScaleToFill;
    //设置分页控件的图片,不设置则为系统默认
//    [_carouseView setPageImage:[UIImage imageNamed:@"banner_btn_dot_defult"] andCurrentPageImage:[UIImage imageNamed:@"banner_btn_dot_selected"]];
    //设置分页控件的位置，默认为PositionBottomCenter
    _carouseView.pagePosition = PositionBottomCenter;
    //用block处理图片点击事件
    _carouseView.imageClickBlock = ^(NSInteger index){
        ZQLog(@"点击了第%zd张图片",index);
    };
    [_carouseView.layer setCornerRadius:3.0];
    _carouseView.layer.masksToBounds = YES;
    
    
    // 设置白色背景View
    UIView *headBgView = [[UIView alloc] init];
    headBgView.backgroundColor = [UIColor whiteColor];
    headBgView.frame = CGRectMake(0, 0, KScreenW, headViewH * Iphone6ScaleWidth);
    [headBgView addSubview:_carouseView];
    self.tableView.tableHeaderView = headBgView;
    
}

- (void)initTableView
{
//    self.tableView.tableHeaderView = self.carouseView;
}

- (void)headerRefresh
{
    [MBProgressHUD showMessage:@""];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        [self.tableView.mj_header endRefreshing];
    });
}

#pragma mark- UITableView 数据源代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    } else {
        return 4;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WKHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:WKHomeCellID];
    if (!cell) {
        cell = [WKHomeCell homeCell];
    }
    return cell;
}


// 点击跳转详情页。
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZQLog(@"点击了第%ld个cell",indexPath.row);
    WKHomeTabController *homeTabVC = [[WKHomeTabController alloc] init];
    [self.navigationController pushViewController:homeTabVC animated:YES];
}


// 取消组头悬停效果.
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat sectionHeaderHeight = 45;
//    if (scrollView.contentOffset.y <= sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//        
//    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
//}


// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
    
}

// 组头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}

// 组尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

// 组头View
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    _homeCellHeadView = [WKHomeCellHeadView homeCellHeadView];
    WEAKSELF;
    [_homeCellHeadView setAllBtnAction:^{
        ZQLog(@"查看全部按钮点击");
        
//        // 我要评价页面VC
//        WKEvaluateController *evaluateVC = [[WKEvaluateController alloc] initWithNibName:@"WKEvaluateController" bundle:nil];
//        [weakSelf.navigationController pushViewController:evaluateVC animated:YES];
        
        // 查看全部VC
        WKAllCourseVC *courseVC = [[WKAllCourseVC alloc] init];
        [weakSelf.navigationController pushViewController:courseVC animated:YES];
        
        
    }];
    return _homeCellHeadView;
}

// 取消组尾的默认间距
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 1)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

@end
