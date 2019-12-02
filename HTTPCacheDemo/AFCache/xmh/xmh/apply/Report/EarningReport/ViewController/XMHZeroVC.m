//
//  XMHZeroVC.m
//  xmh
//
//  Created by shendengmeiye on 2019/7/4.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHZeroVC.h"
#import "XMHBaseTableView.h"
#import "XMHZeroTableViewCell.h"
#import "XMHZeroListModel.h"
#import "XMHMonthAndWeekModel.h"
@interface XMHZeroVC ()<UITableViewDelegate,UITableViewDataSource>
{
    /** 加载更多 */
    BOOL _isMore;
    NSInteger _page;
}
/**  */
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray * dataSource;
/** 门店: XMHZeroTypeStore 员工:XMHZeroTypeEmployee */
@property (nonatomic, assign) XMHZeroType zeroType;
/** 时间类型 day week month */
@property (nonatomic, copy) NSString *timeType;
/** 时间段 */
@property (nonatomic, strong) NSArray *dateArr;
@end

@implementation XMHZeroVC
- (instancetype)initWithDateArr:(NSArray *)dateArr timeType:(NSString *)timeType zeroType:(XMHZeroType)type
{
    if (self = [super init]) {
        _dateArr = dateArr;
        _timeType = timeType;
        _zeroType = type;
        _dataSource = [NSMutableArray array];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (_zeroType == XMHZeroTypeStore) {
         [self.navView setNavViewTitle:@"挂零门店" backBtnShow:YES];
    }else{
        [self.navView setNavViewTitle:@"挂零员工" backBtnShow:YES];
    }
    [self createTableView];
    
    _isMore = NO;
    _page = 1;
    [self requestHomeMsgListData];
    
}
- (void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KNaviBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - KNaviBarHeight) style:UITableViewStylePlain];
    _tableView.backgroundColor = kBackgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 100.f;
    [self.view addSubview:_tableView];
    __weak typeof(self) _self = self;
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        __strong typeof(_self) self = _self;
        [self requestMoreData];
    }];
}

#pragma mark -- UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString * kZeroTableViewCell = @"XMHZeroTableViewCell";
    XMHZeroTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kZeroTableViewCell];
    if (!cell) {
        cell = loadNibName(@"XMHZeroTableViewCell");
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    XMHZeroModel *model = [_dataSource safeObjectAtIndex:indexPath.row];
    [cell configureWithModel:model];
    return cell;
}

#pragma mark -- request
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
    if (_zeroType == XMHZeroTypeStore) {
        url = kREPORT_ZERO_STORETOR_URL;
    }else{
        url = kREPORT_ZERO_ACCPUNTLIST_URL;
    }

    NSString * page = [NSString stringWithFormat:@"%ld",(long)_page];
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];

    [param setValue:page?page:@"1" forKey:@"page"];
    [param setValue:_timeType?_timeType:@"" forKey:@"type"];
    [param setValue:_dateArr.jsonData?_dateArr.jsonData:@"" forKey:@"date"];
    [param setValue:[NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id] forKey:@"fram_id"];
    
    [YQNetworking postWithUrl:[XMHHostUrlManager urlWithModuleType:XMHModuleTypeReport subUrl:url] refreshRequest:YES cache:YES params:param progressBlock:nil resultBlock:^(BaseModel *obj, BOOL isSuccess, NSError *error) {
        [XMHProgressHUD dismiss];
        if (isSuccess) {
           
            XMHZeroListModel *model = [XMHZeroListModel yy_modelWithDictionary:obj.data];
            if (!_isMore) {
                [_dataSource removeAllObjects];
            }
            [_dataSource addObjectsFromArray:model.list];
            [self endRefreshing];
            if (model.list.count == 0) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [self.tableView reloadData];
        }else{}
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
