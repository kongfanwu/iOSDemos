//
//  XMHRankContentDetailVC.m
//  xmh
//
//  Created by shendengmeiye on 2019/7/6.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHRankContentDetailVC.h"
#import "XMHRankContentHeaderView.h"
#import "XMHRankSaleCell.h"
#import "XMHRankExpendCell.h"
#import "XMHRankModel.h"
#import "XMHRankSalesListModel.h"
#import "XMHEarningSourceListModel.h"
@interface XMHRankContentDetailVC ()<UITableViewDelegate,UITableViewDataSource>

/** 数据源 */
@property(nonatomic, strong) NSMutableArray *dataArr;

@property(nonatomic, strong) UITableView *tableView;
/** XMHRankContentHeaderView */
@property(nonatomic, strong) XMHRankContentHeaderView *headerView;
/** tableView header */
@property(nonatomic, strong) UIView *headerBgView;
/** 请求参数 */
@property (nonatomic, strong)NSDictionary * param;
/** 加载更多 */
@property(nonatomic, assign) BOOL isMore;
/**  */
@property (nonatomic, assign)NSInteger page;
@end

@implementation XMHRankContentDetailVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    _dataArr = [NSMutableArray array];
    _page = 1;
}
- (void)setContentType:(XMHRankContentType)contentType
{
    _contentType = contentType;
    [self requestDateListWithParams:_param];
}
-(UITableView *)tableView
{
   
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , SCREEN_HEIGHT - KNaviBarHeight - 44) style:UITableViewStylePlain];
        _tableView.backgroundColor = kBackgroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.tableHeaderView = self.headerBgView;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 132;
        __weak typeof(self) _self = self;
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            __strong typeof(_self) self = _self;
            self.page++;
            self.isMore = YES;
            [self requestDateListWithParams:_param];
        }];
    }
    return _tableView;
}

- (XMHRankContentHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[XMHRankContentHeaderView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 70)];
         _headerView.layer.cornerRadius = 5;
        _headerView.backgroundColor = UIColor.whiteColor;
    }
    return _headerView;
}
- (UIView *)headerBgView
{
    if (!_headerBgView) {
        _headerBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 80)];
        [_headerBgView addSubview:self.headerView];
       
    }
    return _headerBgView;
}
#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    if (self.contentType == XMHRankContentTypeSale) {
        static NSString *cellId = @"XMHRankSaleCellID";
        XMHRankSaleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[XMHRankSaleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        XMHRankSalesModel *model = [_dataArr safeObjectAtIndex:indexPath.row];
        [cell configureWithModel:model];
        return cell;
    }else{
        static NSString *cellId = @"XMHRankExpendCellID";
        XMHRankExpendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[XMHRankExpendCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        XMHXiaohaoYeJiModel *model = [_dataArr safeObjectAtIndex:indexPath.row];
        [cell updateCellWithModel:model rank:indexPath.row + 1];
        
        return cell;
    }
  return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    if (self.contentType == XMHRankContentTypExpend) {
        XMHXiaohaoYeJiModel *model = [_dataArr safeObjectAtIndex:indexPath.row];
        if (![model.type isEqualToString:@"goods"]) {
            model.isExpand = !model.isExpand;
        }else{
            model.isExpand = NO;
        }
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:row inSection:0];
       [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    }
}
#pragma mark -- request
- (void)requestRankDataWithParams:(NSDictionary *)params
{
    WeakSelf
     _param = params;
    NSMutableDictionary *param = [[NSMutableDictionary alloc]initWithDictionary:params];
//    if (self.contentType == XMHRankContentTypeSale) {
//        [param setValue:@"1" forKey:@"p_type"];
//    }else{
//        [param setValue:@"2" forKey:@"p_type"];
//    }
   
    [YQNetworking postWithUrl:[XMHHostUrlManager urlWithModuleType:XMHModuleTypeReport subUrl:kREPORT_EMPLOYEES_RANKING] refreshRequest:YES cache:YES params:param progressBlock:nil resultBlock:^(BaseModel *obj, BOOL isSuccess, NSError *error) {
        if (isSuccess) {
            XMHRankModel *model = [XMHRankModel yy_modelWithDictionary:obj.data];
            [weakSelf.headerView updateHeaderViewhWithType:weakSelf.contentType model:model];
        }
    }];
    [self requestDateListWithParams:params];
}
/** 网络请求 */
- (void)requestDateListWithParams:(NSDictionary *)params
{
    if (_page == 0) {
        _page++;
    }
    WeakSelf
    [XMHProgressHUD showGifImage];
     NSMutableDictionary *param = [[NSMutableDictionary alloc]initWithDictionary:params];
     [param setValue:@(_page)?@(_page):@"1" forKey:@"page"];
    if (self.contentType == XMHRankContentTypeSale) {
        [YQNetworking postWithUrl:[XMHHostUrlManager urlWithModuleType:XMHModuleTypeReport subUrl:kREPORT_EMPLOYEES_SALES_LIST] refreshRequest:YES cache:YES params:param progressBlock:nil resultBlock:^(BaseModel *obj, BOOL isSuccess, NSError *error) {
            [XMHProgressHUD dismiss];
            if (isSuccess) {
                
                XMHRankSalesListModel *model = [XMHRankSalesListModel yy_modelWithDictionary:obj.data];
                if (!weakSelf.isMore) {
                    [weakSelf.dataArr removeAllObjects];
                }
                [weakSelf.dataArr addObjectsFromArray:model.list];
                [weakSelf.tableView.mj_footer endRefreshing];
                if (model.list.count == 0) {
                    [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                }
                [weakSelf.tableView reloadData];
            }
        }];
    }else{
        [YQNetworking postWithUrl:[XMHHostUrlManager urlWithModuleType:XMHModuleTypeReport subUrl:kREPORT_EMPLOYEES_SERV_LIST] refreshRequest:YES cache:YES params:param progressBlock:nil resultBlock:^(BaseModel *obj, BOOL isSuccess, NSError *error) {
            [XMHProgressHUD dismiss];
            if (isSuccess) {
                XMHXiaohaoYeJiListModel *model = [XMHXiaohaoYeJiListModel yy_modelWithDictionary:obj.data];
                if (!weakSelf.isMore) {
                    [weakSelf.dataArr removeAllObjects];
                }
                [weakSelf.dataArr addObjectsFromArray:model.list];
                [weakSelf.tableView.mj_footer endRefreshing];
                if (model.list.count == 0) {
                    [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                }
                [weakSelf.tableView reloadData];
            }
        }];
    }
    
}

- (void)dealloc
{
    NSLog(@"-----------dealloc----");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
