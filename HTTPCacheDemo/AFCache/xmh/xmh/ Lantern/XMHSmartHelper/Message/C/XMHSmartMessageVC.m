//
//  XMHSmartMessageVC.m
//  xmh
//
//  Created by shendengmeiye on 2019/6/12.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHSmartMessageVC.h"
#import "XMHBaseTableView.h"
#import "XMHSmartMessageCell.h"
#import "LMsgListModel.h"
#import "XMHOutComeFactory.h"
#import "MsgRequest.h"

@interface XMHSmartMessageVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)XMHBaseTableView *tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;

@end

@implementation XMHSmartMessageVC
{
    /** 加载更多 */
    BOOL _isMore;
    NSInteger _page;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [[NSMutableArray alloc] init];
    _isMore = NO;
    _page = 0;
    [self initSubViews];
    [self requestHomeMsgListData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_dataSource.count) {
        [self.tbView reloadData];
    }
}
- (void)initSubViews
{
    [self.navView setNavViewTitle:@"智能助手" backBtnShow:YES];
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
        _tbView.backgroundColor = kColorF5F5F5;
     
        __weak typeof(self) _self = self;
        _tbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            __strong typeof(_self) self = _self;
            [self requestMoreData];
        }];
    }
    return _tbView;
}

#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * ksmartMessageCell = @"XMHSmartMessageCell";
    XMHSmartMessageCell * smartMessageCell = [tableView dequeueReusableCellWithIdentifier:ksmartMessageCell];
    if (!smartMessageCell) {
        smartMessageCell = loadNibName(@"XMHSmartMessageCell");
    }
    LMsgModel *msgModel = [_dataSource safeObjectAtIndex:indexPath.row];
  
    [smartMessageCell updateSmartMessageCellModel:msgModel];
    return smartMessageCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _tbView.rowHeight = UITableViewAutomaticDimension;
    _tbView.estimatedRowHeight = 240;
    return _tbView.rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

    LMsgModel *msgModel = [_dataSource safeObjectAtIndex:indexPath.row];

    id<XMHOutComeProtocol> vc =  [XMHOutComeFactory createOutComeVCMsgModel:msgModel pushUserInfo:nil isUMPush:NO];
    [self.navigationController pushViewController:(BaseCommonViewController *)vc animated:YES];
}

#pragma mark ------网络请求------

- (void)requestMoreData
{
    _isMore = YES;
    _page ++;
    [self requestHomeMsgListData];
}
- (void)refreshTbData
{
    _isMore = NO;
    _page = 0;
    [self requestHomeMsgListData];
}
- (void)endRefreshing{
    [_tbView.mj_footer endRefreshing];
}
- (void)requestHomeMsgListData
{
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * page = [NSString stringWithFormat:@"%ld",(long)_page];
    NSString * accountId = [NSString stringWithFormat:@"%ld",(long)infomodel.data.ID];
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:accountId?accountId:@"" forKey:@"account_id"];
    [param setValue:page?page:@"0" forKey:@"page"];
    [param setValue:@"7" forKey:@"type"];
    [MsgRequest requestMsgListParam:param resultBlock:^(LMsgListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        [self endRefreshing];
        if (isSuccess) {
            if (!_isMore) {
                [_dataSource removeAllObjects];
            }
            [_dataSource addObjectsFromArray:model.list];
            [_tbView.mj_footer setHidden:NO];
            if (model.list.count == 0) {
                [_tbView.mj_footer endRefreshingWithNoMoreData];
                if (_page == 0) {
                   [_tbView.mj_footer setHidden:YES];
                }
            }
            
            [_tbView reloadData];
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
