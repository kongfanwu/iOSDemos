//
//  XMHEarningSourceVC.m
//  xmh
//
//  Created by shendengmeiye on 2019/7/6.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHEarningSourceVC.h"
#import "XMHEarningSourceCell.h"
#import "XMHRankExpendCell.h"
#import "XMHEarningSourceListModel.h"
#import "XMHXiaohaoYeJiListModel.h"
#import "XMHMonthAndWeekModel.h"
@interface XMHEarningSourceVC ()<UITableViewDelegate,UITableViewDataSource>
{
    /** 加载更多 */
    BOOL _isMore;
    NSInteger _page;
}
/**  */
@property(nonatomic, strong) XMHBaseTableView *tableView;
/** 时间类型 day week month */
@property (nonatomic, copy) NSString *timeType;
/** 时间段 */
@property (nonatomic, strong) NSArray *dateArr;
/** 数据源 */
@property(nonatomic, strong) NSMutableArray * dataSource;
/** 报表类型 */
@property(nonatomic, assign) XMHBaseReportVCType reportType;

@end

@implementation XMHEarningSourceVC
- (instancetype)initWithDateArr:(NSArray *)dateArr timeType:(NSString *)timeType reportType:(XMHBaseReportVCType)reportType;
{
    if (self = [super init]) {
        
        _dateArr = dateArr;
        _timeType = timeType;
        _reportType = reportType;
        _dataSource = [NSMutableArray array];
       
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navView setNavViewTitle:@"业绩来源" backBtnShow:YES];
    [self.view addSubview:self.tableView];
    _isMore = NO;
    _page = 1;
    [self requestHomeMsgListData];
}
#pragma mark - <UITableViewDataSource>


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_reportType == XMHBaseReportVCTypeXiaoHao) {
        static NSString *cellID = @"XMHRankExpendCell";
        XMHRankExpendCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[XMHRankExpendCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        XMHXiaohaoYeJiModel *model = [_dataSource safeObjectAtIndex:indexPath.row];
        [cell updateCellWithModel:model rank:indexPath.row + 1];
        return cell;
    }
    static NSString * cellID = @"XMHEarningSourceCell";
    XMHEarningSourceCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[XMHEarningSourceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    XMHEarningSourceModel *model = [_dataSource safeObjectAtIndex:indexPath.row];
    [cell configureWithModel:model rank:indexPath.row + 1];
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_reportType == XMHBaseReportVCTypeXiaoHao) {
        XMHXiaohaoYeJiModel *model = [_dataSource safeObjectAtIndex:indexPath.row];
//        if (![model.type isEqualToString:@"goods"]) {
            model.isExpand = !model.isExpand;
//        }else{
//            model.isExpand = NO;
//        }
        [self.tableView reloadData];
    }
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[XMHBaseTableView alloc]initWithFrame:CGRectMake(0, KNaviBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - KNaviBarHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = kBackgroundColor;
        _tableView.emptyEnable = YES;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 132.f;
            __weak typeof(self) _self = self;
            _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                __strong typeof(_self) self = _self;
                [self requestMoreData];
            }];
    }
    return _tableView;
}

#pragma mark ------网络请求------

- (void)requestMoreData
{
    _isMore = YES;
    _page ++;
    [self requestHomeMsgListData];
}

- (void)endRefreshing{
    [self.tableView.mj_footer endRefreshing];
}
- (void)requestHomeMsgListData
{
    [XMHProgressHUD showGifImage];
    
    NSString *url;
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    if (_reportType == XMHBaseReportVCTypeYeJi) {
        url = kREPORT_GETSALESPROLIST_URL;
        [param setValue:[ShareWorkInstance shareInstance].share_join_code.store_code forKey:@"store_code"];
    }else {
         url = kREPORT_CONSUMPTION_REPORT_SERV_PRO_URL;
    }

    [param setValue:[NSString stringWithFormat:@"%ld",(long)_page]?[NSString stringWithFormat:@"%ld",(long)_page]:@"1" forKey:@"page"];
    [param setValue:_timeType?_timeType:@"" forKey:@"type"];
    [param setValue:_dateArr.jsonData forKey:@"date"];
    [param setValue:_framID?_framID:@"" forKey:@"fram_id"];
    
    [YQNetworking postWithUrl:[XMHHostUrlManager urlWithModuleType:XMHModuleTypeReport subUrl:url] refreshRequest:YES cache:YES params:param progressBlock:nil resultBlock:^(BaseModel *obj, BOOL isSuccess, NSError *error) {
        [XMHProgressHUD dismiss];
        if (isSuccess) {
    
            if (_reportType == XMHBaseReportVCTypeYeJi) {
              XMHEarningSourceListModel *model = [XMHEarningSourceListModel yy_modelWithDictionary:obj.data];
                if (!_isMore) {
                    [_dataSource removeAllObjects];
                }
                [_dataSource addObjectsFromArray:model.list];
                [self endRefreshing];
                if (model.list.count == 0) {
//                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                     self.tableView.mj_footer.hidden = YES;
                }
            }else{
               XMHXiaohaoYeJiListModel *model = [XMHXiaohaoYeJiListModel yy_modelWithDictionary:obj.data];
                if (!_isMore) {
                    [_dataSource removeAllObjects];
                }
                [_dataSource addObjectsFromArray:model.list];
                [self endRefreshing];
                if (model.list.count == 0) {
//                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    self.tableView.mj_footer.hidden = YES;
                }
            }
            
            [self.tableView reloadData];
        }else{
             self.tableView.mj_footer.hidden = YES;
        }
    }];
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
