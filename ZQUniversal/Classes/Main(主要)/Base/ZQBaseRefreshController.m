//
//  ZQBaseRefreshController.m
//  ZQUniversal
//
//  Created by CoderZQ on 2018/5/21.
//  Copyright © 2018年 CoderZQ. All rights reserved.
//

#import "ZQBaseRefreshController.h"
#import "XYZTableViewCell.h"

@interface ZQBaseRefreshController ()
@property(nonatomic, assign) BOOL isRect;
@end

@implementation ZQBaseRefreshController

@synthesize parmaDic = _parmaDic;


- (void)setParmaDic:(NSMutableDictionary *)parmaDic
{
    _parmaDic = [NSMutableDictionary dictionaryWithDictionary:parmaDic];
}

- (NSMutableDictionary *)parmaDic
{
    if (!_parmaDic) {
        _parmaDic = [NSMutableDictionary dictionary];
    }
    return _parmaDic;
}

- (NSMutableArray *)ModelRect
{
    if (!_ModelRect) {
        _ModelRect = [NSMutableArray array];
    }
    return _ModelRect;
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor = [UIColor clearColor];
        [self bindTableViewRefreshHeader:_tableView];
        [self bindTableViewRefreshFooter:_tableView];
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset: UIEdgeInsetsZero];
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins: UIEdgeInsetsZero];
        }
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.bottom.equalTo(self.mas_bottomLayoutGuide);
            
        }];
    }
    return _tableView;
}

-(void)bindTableViewRefreshHeader:(UITableView*)tableview{
    //    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在刷新中" forState:MJRefreshStateRefreshing];
    tableview.mj_header = header;
    
    if (_tableView != tableview) {
        _tableView = tableview;
    }
}
-(void)bindTableViewRefreshFooter:(UITableView*)tableview{
    MJRefreshAutoNormalFooter* footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    tableview.mj_footer = footer;
    footer.refreshingTitleHidden = YES;
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"暂无更多内容" forState:MJRefreshStateNoMoreData];
    [footer setTitle:@"" forState:MJRefreshStatePulling];
    [footer setTitle:@"" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"" forState:MJRefreshStateWillRefresh];
    //footer.stateLabel.hidden = YES;
    if (_tableView != tableview) {
        _tableView = tableview;
    }
}
-(void)bindTableView:(UITableView*)tableview{
    tableview.tableFooterView = [[UIView alloc] init];
    tableview.delegate=self;
    tableview.dataSource=self;
    _tableView = tableview;
    _tableView.backgroundColor = [UIColor clearColor];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset: UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins: UIEdgeInsetsZero];
    }
}


-(void)headerRefresh{
    self.currentPage=1;
    if (self.parmaDic[@"pageIndex"]) {
        self.parmaDic[@"pageIndex"]=@(1);
    }
    
    [ZQHTTPTool POST:self.url params:self.parmaDic success:^(id json, int code) {
        [self endRefreshing];
        code = [json[@"code"] intValue];
        if (code == 200) {
            //NSLog(@"response:%@",response);
            [self.ModelRect removeAllObjects];
            [self resetModelsContainer];
            [self processData:json];
            
        }else{
            [self.ModelRect removeAllObjects];
            [self.tableView reloadData];
//            [NetWorkMessage returnFailed:json[@"reason"]];
//            [OMGToast showWithText:json[@"reason"]];
            
//            [MBProgressHUD showError:json[@"message"]];
            
            [ZQNetWorkMessage returnFailed:json[@"message"]];
            
            [self headerRefreshFailed:json];
        }
    } failure:^(NSError *error) {
        [self.ModelRect removeAllObjects];
        [self.tableView reloadData];
        [self endRefreshing];
        //        [NetWorkMessage netfailed];
        
        [ZQNetWorkMessage netfailedTextTip];
        
//        [MBProgressHUD showError:@"网络请求失败,请稍后再试"];
        [self headerRefreshFailed:nil];
    }];

    
}
-(void)headerRefreshFailed:(_Nullable id)msg{
    
}
-(void)endRefreshing{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
-(void)processData:(NSDictionary*)jsondata{
    self.jsonData=jsondata;
    
    
    [self DataToModel:jsondata];
    
    self.isRect = NO;
    if (self.ModelRect.count>0) {
        if ([self.ModelRect.firstObject isKindOfClass:[NSDictionary class]] && self.ModelRect.firstObject[keySectionRows]) {
            self.isRect = YES;
        }
    }
    
    [self.tableView reloadData];
    [self afterTableViewReload];
}
-(void)processDataForLoadMore:(NSDictionary*)jsondata{
    self.jsonData=jsondata;
    
    
    [self DataToModelForLoadMore:jsondata];
    
    
    [self.tableView reloadData];
    [self afterTableViewReload];
}
-(void)DataToModel:(NSDictionary*)response{
    NSAssert(NO, @"必须重写");
    
}
-(void)DataToModelForLoadMore:(NSDictionary*)response{
    [self DataToModel:response];
}
-(void)afterTableViewReload{
    
}
-(void)resetModelsContainer{
    
}
-(void)removeLastLoadMore{
    [self.ModelRect removeLastObject];
}

/**
 *  加载更多时走缓存有问题 不能走缓存
 */
-(void)loadMore{
    NSArray* dataNumarray = self.jsonData[@"data"][@"items"];
    NSInteger num = dataNumarray.count;
    NSInteger pageNum = [self.parmaDic[@"pageSize"] integerValue];
    NSInteger currentPage = (NSInteger)((self.ModelRect.count)/pageNum);
    self.currentPage = currentPage+1;
    
    if (self.parmaDic[@"pageIndex"]) {
        self.parmaDic[@"pageIndex"]=@(self.currentPage);
    }
    
    [self endRefreshing];
    [ZQHTTPTool POST:self.url params:self.parmaDic success:^(id json, int code) {
        
        code = [json[@"code"] intValue];
        if (code == 200) {
            if (num<pageNum) {
                for (int i=0; i<num; i++) {
                    [self removeLastLoadMore];
                }
            }
            [self processDataForLoadMore:json];
        }else{
            [self loadMoreFailed:json];
        }
        [self endRefreshing];
        
    } failure:^(NSError *error) {
        [self endRefreshing];
        [self loadMoreFailed:nil];
    }];
}
-(void)loadMoreFailed:(_Nullable id)msg{
    
}
-(void)XYZResponse:(UIView *)view{
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.isRect?self.ModelRect.count:1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.isRect?((NSArray*)self.ModelRect[section][keySectionRows]).count:self.ModelRect.count;
}
-(XYZTableViewCell*)cellForKey:(id)key{
    __block XYZTableViewCell*cell=nil;
    
    NSException* except = nil;
    @try {
        NSString*classStr=nil;
        if ([key isKindOfClass:[NSDictionary class]]) {
            classStr = key[keyCellClass];
        }else{
            classStr = @"XYZTableViewCell";
            //        NSAssert(NO, @"必须传Class");
        }
        
        Class aclass = NSClassFromString(classStr);
        cell = [[aclass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:classStr];
    } @catch (NSException *exception) {
        except = exception;
        //        [except reportIn:location];
    } @finally {
        if (except) {
            cell = [[XYZTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XYZTableViewCell"];
        }
    }
    return cell;
}
-(UITableViewHeaderFooterView*)headerFooterForClass:(NSString*)class{
    NSString*classStr=class;
    UITableViewHeaderFooterView*cell=nil;
    Class aclass = NSClassFromString(classStr);
    cell = [[aclass alloc] initWithReuseIdentifier:classStr];
    return cell;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary*data = self.isRect?((NSArray*)self.ModelRect[indexPath.section][keySectionRows])[indexPath.row]:self.ModelRect[indexPath.row];
    XYZTableViewCell* cell = [self getReuseCellWithModel:data tableview:tableView];
    cell.indexPath = indexPath;
    return cell;
}







-(XYZTableViewCell* _Nonnull)getReuseCellWithModel:(NSDictionary* _Nonnull)data tableview:(UITableView* _Nonnull)tableView{
    NSString* identi = nil;
    if (data[keyCellHeight] || (!data[keyCellClass])) {
        identi = NSStringFromClass([XYZTableViewCell class]);
    }else{
        identi = [data[keyCellClass] stringByReplacingOccurrencesOfString:@"student." withString:@""];
    }
    XYZTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identi];
    
    if (!cell) {
        //        NSLog(@"getReuseCellWithModel\n%@",data);
        cell                = [self cellForKey:data];
    }
    cell.xyzDelegate    = self;
    cell.selectionStyle = NO;
    cell.xyzMessage        = data;
    
    return cell;
}
-(CGFloat)getReuseCellHeightWithModel:(NSDictionary* _Nonnull)data tableview:(UITableView* _Nonnull)tableView{
    __block CGFloat height = 0;
    @try {
        if (data[keyCellHeight]) {
            height = [data[keyCellHeight] floatValue];
        }else if (data[keyCellClass]){
            Class clas = NSClassFromString(data[keyCellClass]);
            height=[clas xyzCellHeight:data width:tableView.width];
        }else{
            height = 100;
        }
    } @catch (NSException *exception) {
        
    } @finally {
        height = 100;
    }
    return height;
}





-(UITableViewHeaderFooterView* _Nonnull)getReuseHeaderWithModel:(NSDictionary* _Nonnull)data tableview:(UITableView* _Nonnull)tableView{
    NSString* identi = nil;
    if (data[keySectionHeaderHeight] || (!data[keySectionHeaderClass])) {
        identi = NSStringFromClass([UITableViewHeaderFooterView class]);
    }else{
        [data[keySectionHeaderClass] stringByReplacingOccurrencesOfString:@"student." withString:@""];
    }
    UITableViewHeaderFooterView* cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identi];
    
    if (!cell) {
        //NSLog(@"getReuseHeaderWithModel\n%@",data);
        cell                = [self headerFooterForClass:data[keySectionHeaderClass]];
    }
    cell.xyzDelegate    = self;
    cell.xyzMessage        = data;
    return cell;
}
-(CGFloat)getReuseHeaderHeightWithModel:(NSDictionary* _Nonnull)data tableview:(UITableView* _Nonnull)tableView{
    __block CGFloat height = 0.01;
    if (!data) {
        return height;
    }

    @try {
        if (data[keySectionHeaderHeight]) {
            height = [data[keySectionHeaderHeight] floatValue];
        }else if (data[keySectionHeaderClass]){
            Class clas = NSClassFromString(data[keySectionHeaderClass]);
            height=[clas xyzCellHeight:data width:tableView.width];
        }else{
            height = 100;
        }
    } @catch (NSException *exception) {

    } @finally {
        height = 100;
    }
    
    return height;
}






-(UITableViewHeaderFooterView* _Nonnull)getReuseFooterWithModel:(NSDictionary* _Nonnull)data tableview:(UITableView* _Nonnull)tableView{
    NSString* identi = nil;
    if (data[keySectionFooterHeight] || (!data[keySectionFooterClass])) {
        identi = NSStringFromClass([UITableViewHeaderFooterView class]);
    }else{
        [data[keySectionFooterClass] stringByReplacingOccurrencesOfString:@"student." withString:@""];
    }
    
    UITableViewHeaderFooterView* cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identi];
    
    if (!cell) {
        //NSLog(@"getReuseFooterWithModel\n%@",data);
        cell                = [self headerFooterForClass:data[keySectionFooterClass]];
    }
    cell.xyzDelegate    = self;
    cell.xyzMessage        = data;
    return cell;
}
-(CGFloat)getReuseFooterHeightWithModel:(NSDictionary* _Nonnull)data tableview:(UITableView* _Nonnull)tableView{
    __block CGFloat height = 0.01;
    if (!data) {
        return height;
    }

    @try {
        if (data[keySectionFooterHeight]) {
            height = [data[keySectionFooterHeight] floatValue];
        }else if (data[keySectionFooterClass]){
            Class clas = NSClassFromString(data[keySectionFooterClass]);
            height=[clas xyzCellHeight:data width:tableView.width];
        }else{
            height = 100;
        }
    } @catch (NSException *exception) {
        
    } @finally {
        height = 100;
    }
    
    return height;
}







-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary*data = self.isRect?((NSArray*)self.ModelRect[indexPath.section][keySectionRows])[indexPath.row]:self.ModelRect[indexPath.row];
    Class clas = NSClassFromString(data[keyCellClass]);
    CGFloat height=[clas xyzCellHeight:data width:tableView.width];
    return height;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSDictionary*data = self.isRect?self.ModelRect[section]:nil;
    if (data) {
        return [self getReuseHeaderHeightWithModel:data tableview:tableView];
    }
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    NSDictionary*data = self.isRect?self.ModelRect[section]:nil;
    if (data) {
        return [self getReuseFooterHeightWithModel:data tableview:tableView];
    }
    return 0.01;
}
-(UIView* )tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    NSDictionary*data = self.isRect?self.ModelRect[section]:nil;
    if (data) {
        return [self getReuseFooterWithModel:data tableview:tableView];
    }
    return [[UIView alloc] init];
}
-(UIView* )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSDictionary*data = self.isRect?self.ModelRect[section]:nil;
    if (data) {
        return [self getReuseHeaderWithModel:data tableview:tableView];
    }
    return [[UIView alloc] init];
}


@end
