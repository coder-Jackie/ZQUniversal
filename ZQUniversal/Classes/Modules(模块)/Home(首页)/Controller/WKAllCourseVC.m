//
//  WKAllCourseVC.m
//  ZQUniversal
//
//  Created by CoderZQ on 2018/5/30.
//  Copyright © 2018年 CoderZQ. All rights reserved.
//

#import "WKAllCourseVC.h"
#import "WKHomeCell.h"

@interface WKAllCourseVC ()

@end

static NSString * const WKAllCourseHomeCellID = @"WKAllCourseHomeCellID";

@implementation WKAllCourseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 1.初始设置
    [self initSetting];
    
    // 2.设置请求参数
    [self initParma];
    
    // 3.自动刷新.
    [self headerRefresh];
}



- (void)initSetting
{
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.view.backgroundColor = KWhiteColor;
//    self.tableView.backgroundColor = KColorHex(@"e3e6e9");
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = KClearColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.rowHeight =
    
    //暂时隐藏掉footer
    self.tableView.mj_footer = nil;
}

- (void)initParma
{
    // 初始传参
    self.url = @"http://api.yimifudao.com/v2.4/pli/findevaluation";
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    self.parmaDic = param;
}


- (void)DataToModel:(NSDictionary<NSString *,id> *)response
{
    
//    // 刷新badge
//    if (self.refreshBadgeBlock) {
//        self.refreshBadgeBlock(evaluation);
//    }
//
//
//    //    NSArray *dataArr = [response objectForKey:@"data"][@"leaveList"];
//    //    for (int i= 0; i < dataArr.count; i++) {
//    //        SDEvaluationModel *evaluation = [SDEvaluationModel mj_objectWithKeyValues:dataArr[i]];
//    //        [self.ModelRect addObject:evaluation];
//    //    }
//    self.ModelRect.count = 0;
    if (self.ModelRect.count == 0) {
        [ZQBlankErrorView showBlankErrorView:self.view image:[UIImage imageNamed:@"ic_不存在"] text:@"抱歉！您查看的内容已经不存在请点击下方按钮返回VIPZQUniversal首页" btnTitle:@"返回首页" tapBlock:^(UIButton *sender) {
            [ZQBlankErrorView hideBlankErrorView:self.view];
            [self headerRefresh];
        }];

    }else {
        [ZQBlankErrorView hideBlankErrorView:self.view];
    }
    
}

-(void)headerRefreshFailed:(_Nullable id)msg
{
//        [ZQBlankErrorView showBlankErrorView:self.view image:[UIImage imageNamed:@"ic_出错"] text:@"啊哦，加载出错了，请重试." btnTitle:@"重新加载" tapBlock:^(UIButton *sender) {
//            ZQLog(@"%@",sender.currentTitle);
//            [ZQBlankErrorView hideBlankErrorView:self.view];
//            [self headerRefresh];
//        }];
}

#pragma mark- 数据源代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.ModelRect.count;
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    SDLeaveListModel *model = self.ModelRect[indexPath.row];
    WKHomeCell *cell = (WKHomeCell *)[tableView dequeueReusableCellWithIdentifier:WKAllCourseHomeCellID];
    if (cell == nil) {
        cell = [WKHomeCell homeCell];
        
    }
//    cell.backgroundColor = KColorHex(@"e3e6e9");
//    cell.model = model;
    return cell;
}

// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
    
}


@end
