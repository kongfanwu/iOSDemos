//
//  XMHSmartGuanJiaVC.m
//  xmh
//
//  Created by ald_ios on 2019/6/4.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHSmartGuanJiaVC.h"
#import "XMHSmartGuanJiaCell.h"
#import "XMHSmartGuanJiaDetail.h"
#import "XMHRefreshGifHeader.h"
#import "XMHSmartGuanJiaListModel.h"
@interface XMHSmartGuanJiaVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)XMHBaseTableView *tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, assign)BOOL isMore;
@property (nonatomic, assign)NSInteger page;
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
@end

@implementation XMHSmartGuanJiaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _isMore = NO;
    _page = 1;
    _dataSource = [[NSMutableArray alloc] init];
    [self initSubViews];
    [self requestListData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshTbData];
}
- (void)initSubViews
{
    [self.navView setNavViewTitle:@"智能管家设置" backBtnShow:YES];
    self.navView.backgroundColor = kBtn_Commen_Color;
    [self.view addSubview:self.tbView];
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[XMHBaseTableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav) style:UITableViewStylePlain];
        _tbView.emptyEnable = YES;
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.backgroundColor = [UIColor clearColor];;
//        _tbView.mj_header = self.gifHeader;
//        [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            [self refreshTbData];
//        }];
//        _tbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//            [self requestMoreData];
//        }];
    }
    return _tbView;
}
- (XMHRefreshGifHeader *)gifHeader {
    if (!_gifHeader) {
        _gifHeader = [XMHRefreshGifHeader headerWithRefreshingBlock:^{
            [self refreshTbData];
        }];
    }
    return _gifHeader;
}
- (void)requestMoreData
{
    _isMore = YES;
    _page ++;
    [self requestListData];
}
- (void)refreshTbData
{
    _isMore = NO;
    _page = 1;
    [self requestListData];
}
- (void)endRefreshing{
    [_tbView.mj_header endRefreshing];
    [_tbView.mj_footer endRefreshing];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellName = @"XMHSmartGuanJiaCell";
    XMHSmartGuanJiaCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
         cell = loadNibName(@"XMHSmartGuanJiaCell");
    }
    [cell updateCellModel:_dataSource[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 10;
    return _dataSource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMHSmartGuanJiaDetail * next = [[XMHSmartGuanJiaDetail alloc] init];
    next.paramModel = _dataSource[indexPath.row];
    [self.navigationController pushViewController:next animated:NO];
}
#pragma mark ------网络请求------
/** 列表数据 */
- (void)requestListData
{
    [XMHProgressHUD showGifImage];
    
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * account = [NSString stringWithFormat:@"%@",infomodel.data.account];
    NSString * accountID = [NSString stringWithFormat:@"%ld",(long)infomodel.data.ID];
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:@(_page) forKey:@"page"];
    /** 技师账号 */
    [param setValue:account?account:@"" forKey:@"account"];
    /** 员工id */
    [param setValue:accountID?accountID:@"" forKey:@"account_id"];
    [YQNetworking postWithUrl:[XMHHostUrlManager url:kSMARTHELPER_GUANJIASETLIST_URL] refreshRequest:YES cache:YES params:param progressBlock:nil resultBlock:^(BaseModel * obj, BOOL isSuccess, NSError *error) {
        [XMHProgressHUD dismiss];
        if (isSuccess) {
            XMHSmartGuanJiaListModel *model = [XMHSmartGuanJiaListModel yy_modelWithDictionary:obj.data];
            if (!_isMore) {
                [_dataSource removeAllObjects];
            }
            [_dataSource addObjectsFromArray:model.list];
            if (model.list.count == 0) {
                [_tbView.mj_footer endRefreshingWithNoMoreData];
            }
            [_tbView reloadData];
        }else{
            
        }
    }];
}
@end
