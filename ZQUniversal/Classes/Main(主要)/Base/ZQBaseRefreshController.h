//
//  ZQBaseRefreshController.h
//  ZQUniversal
//
//  Created by CoderZQ on 2018/5/21.
//  Copyright © 2018年 CoderZQ. All rights reserved.
//  这个类封装上拉下拉刷新

#import "ZQBaseViewController.h"

static NSString *keyCellClass             = @"class";
static NSString *keyCellMessage           = @"message";
static NSString *keyCellSelect            = @"isSelected";
static NSString *keyCellHeight            = @"CellHeight";

static NSString *keySectionRows           = @"sectionrow";
static NSString *keySectionMessage        = @"sectionmessage";

static NSString *keySectionHeaderClass    = @"HeaderClass";
static NSString *keySectionHeaderHeight   = @"HeaderHeight";
static NSString *keySectionHeaderSelect   = @"HeaderSelect";
static NSString *keySectionHeaderMessage  = @"HeaderMessage";

static NSString *keySectionFooterClass    = @"footerClass";
static NSString *keySectionFooterHeight   = @"FooterHeight";
static NSString *keySectionFooterSelect   = @"FooterSelect";
static NSString *keySectionFooterMessage  = @"FooterMessage";


@interface ZQBaseRefreshController : ZQBaseViewController <UITableViewDataSource,UITableViewDelegate,XYZDelegate>

/** url */
@property (nonatomic, copy) NSString *url;
/** 参数 */
@property (nonatomic, strong, setter = setParmaDic:) NSMutableDictionary *parmaDic;
/** 数据源 是一个二维数组，数组里面是数组 */
@property(nonatomic, strong) NSMutableArray *ModelRect;
/** 每一次请求的json字典 */
@property(nonatomic, strong) NSDictionary *jsonData;
/** 当前页码 */
@property(nonatomic, assign) NSInteger currentPage;
/** tableView */
@property(nonatomic, strong) UITableView *tableView;

-(void)bindTableView:(UITableView *)tableView;
-(void)bindTableViewRefreshHeader:(UITableView*)tableview;
-(void)bindTableViewRefreshFooter:(UITableView*)tableview;


-(void)DataToModel:(NSDictionary<NSString *,id>*)response;
-(void)afterTableViewReload;
-(void)DataToModelForLoadMore:(NSDictionary<NSString *,id>*)response;

-(void)loadMore;
-(void)processDataForLoadMore:(NSDictionary *)jsondata;
-(void)loadMoreFailed:(_Nullable id)msg;

-(void)headerRefresh;
-(void)headerRefreshFailed:(_Nullable id)msg;
-(void)endRefreshing;

-(void)resetModelsContainer;
-(void)removeLastLoadMore;

@end
