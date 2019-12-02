//
//  XMHDataReportVC.m
//  xmh
//
//  Created by shendengmeiye on 2019/6/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHDataReportVC.h"
#import "XMHBaseTableView.h"
#import "XMHDataReportCell.h"
#import "XMHDataReportResultVC.h"
#import "MsgRequest.h"
#import "XMHDataReportListModel.h"
@interface XMHDataReportVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) XMHBaseTableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, assign) NSInteger nextPage;
/** 加载更多 */
@property (nonatomic, assign) BOOL isMore;
@end

@implementation XMHDataReportVC
/**
 *  下面这句话会自动生成实现的协议的属性对应的成员变量。
 */
@synthesize cute_hand_rec_id = _cute_hand_rec_id;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navView setNavViewTitle:@"数据报告" backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
   
    _tableView = [[XMHBaseTableView alloc]initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav) style:UITableViewStylePlain];
    _tableView.emptyEnable = YES;
    _tableView.backgroundColor = [ColorTools colorWithHexString:@"#F5F5F5"];
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
        self.nextPage++;
        self.isMore = YES;
        [self requestListData];
    }];
    self.nextPage = 1;
    _dataArr = [NSMutableArray array];
    [self requestListData];
    
}

#pragma mark -- UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 79;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"XMHDataReportCell";
     XMHDataReportCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = loadNibName(@"XMHDataReportCell");
    }
    [cell refreshCellWithModel:_dataArr[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XMHDataReportResultVC *next = [[XMHDataReportResultVC alloc]init];
    XMHDataReportModel *model = [_dataArr safeObjectAtIndex:indexPath.row];
    next.model = model;
    next.cute_hand_rec_id = model.uid;
    
    [self.navigationController pushViewController:next animated:YES];
}
#pragma mark -- request
- (void)endRefreshing{
    [_tableView.mj_footer endRefreshing];
}
-(void)requestListData{
    
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * account = [NSString stringWithFormat:@"%@",infomodel.data.account];
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:account ?account:@"" forKey:@"account"];
    [param setValue:@(_nextPage) ?@(_nextPage):@"1" forKey:@"page"];
    [param setValue:@"5" forKey:@"pageSize"];
    [YQNetworking postWithUrl:[XMHHostUrlManager url:kSMARTHELPER_REMIND_REPORT_LIST_URL] refreshRequest:YES cache:YES params:param progressBlock:nil resultBlock:^(BaseModel *obj, BOOL isSuccess, NSError *error) {
        [XMHProgressHUD dismiss];
        if (isSuccess){
             [self endRefreshing];
            XMHDataReportListModel * model = [XMHDataReportListModel yy_modelWithDictionary:obj.data];
            if (!_isMore) {
                [_dataArr removeAllObjects];
            }
            if (model.list.count) {
                [_dataArr safeAddObjectsFromArray:model.list];
                [_tableView.mj_footer setHidden:NO];
            }else{
                _nextPage --;
                [_tableView.mj_footer endRefreshingWithNoMoreData];
                if (_nextPage == 1) {
                    [_tableView.mj_footer setHidden:YES];
                }
            }
            [_tableView reloadData];
        }else{
            [_tableView.mj_footer setHidden:YES];
            
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
