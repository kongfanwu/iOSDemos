//
//  MessageVC.m
//  xmh
//
//  Created by ald_ios on 2018/12/19.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "MessageVC.h"
#import "MessageCommonCell.h"
#import "MsgRequest.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "MsgHomeListModel.h"
#import "MessageViewController.h"
#import "MessageNextC.h"
#import "XMHRefreshGifHeader.h"
#import "XMHSmartMessageVC.h"
@interface MessageVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, strong)MsgHomeListModel * msgHomeListModel;
/** 刷新 */
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
@end

@implementation MessageVC
{
    /** 加载更多 */
    BOOL _isMore;
    NSInteger _page;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    _dataSource = [[NSMutableArray alloc] init];
    _isMore = NO;
    _page = 1;
    [self initSubViews];
    
    [self requestHomeMsgListData];
}
- (void)initSubViews
{
    [self.navView setNavViewTitle:@"消息" backBtnShow:NO];
    self.navView.backgroundColor = kBtn_Commen_Color;
    [self.view addSubview:self.tbView];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestHomeMsgListData];
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.backgroundColor = kColorF5F5F5;
        _tbView.mj_header = self.gifHeader;
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
    [self requestHomeMsgListData];
}
- (void)refreshTbData
{
    _isMore = NO;
    _page = 1;
    [self requestHomeMsgListData];
}
- (void)endRefreshing{
    [_tbView.mj_header endRefreshing];
    [_tbView.mj_footer endRefreshing];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kMessageCommonCell = @"kMessageCommonCell";
    MessageCommonCell * messageCommonCell = [tableView dequeueReusableCellWithIdentifier:kMessageCommonCell];
    if (!messageCommonCell) {
        messageCommonCell = loadNibName(@"MessageCommonCell");
    }
    [messageCommonCell updateMessageCommonCellModel:_dataSource[indexPath.row]];
    return messageCommonCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MsgHomeModel *model = _dataSource[indexPath.row];
//    if ([model.state isEqualToString:@"7"]) { // 智能助手
//        XMHSmartMessageVC *smartMessageVC = [[XMHSmartMessageVC alloc]init];
//        [self.navigationController pushViewController:smartMessageVC animated:NO];
//        return;
//    }
    MessageNextC * messageNextC = [[MessageNextC alloc] init];
    messageNextC.msgHomeModel = model;
    [self.navigationController pushViewController:messageNextC animated:NO];
}
#pragma mark ------网络请求------
- (void)requestHomeMsgListData
{
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * accountId = [NSString stringWithFormat:@"%ld",infomodel.data.ID];
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:accountId?accountId:@"" forKey:@"account_id"];
    [MsgRequest requestNewHomeMsgListParam:param resultBlock:^(MsgHomeListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        [self endRefreshing];
        if (isSuccess) {
            if (!_isMore) {
                [_dataSource removeAllObjects];
            }
            [_dataSource addObjectsFromArray:model.list];
            if (model.list.count == 0) {
                [_tbView.mj_footer endRefreshingWithNoMoreData];
            }
            [_tbView reloadData];
        }else{}
    }];
}
@end
