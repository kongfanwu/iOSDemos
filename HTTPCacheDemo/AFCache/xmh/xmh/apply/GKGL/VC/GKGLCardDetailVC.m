//
//  GKGLCardDetailVC.m
//  xmh
//
//  Created by ald_ios on 2019/1/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLCardDetailVC.h"
#import "GKGLCardDetailTopView.h"
#import "GKGLCardDetailCell.h"
#import "GKGLCardDetailTbSectionHeaderView.h"
#import "MzzCustomerRequest.h"
#import "MzzBillDetailController.h"
#import "MzzBillInfoListModel.h"
#import "XMHRefreshGifHeader.h"
@interface GKGLCardDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)GKGLCardDetailTopView *detailTopView;
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
/** 刷新 */
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
@end

@implementation GKGLCardDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _dataSource = [[NSMutableArray alloc] init];
    [self initSubViews];
}
- (void)initSubViews
{
    [self.navView setNavViewTitle:@"卡项详情" backBtnShow:YES];
    //设置头部底图
    self.logoView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 140);
    self.logoView.backgroundColor = kColorTheme;
    self.logoView.image = nil;
    [self.view addSubview:self.detailTopView];
    [self.view addSubview:self.tbView];
}
- (GKGLCardDetailTopView *)detailTopView
{
   
    WeakSelf
    if (!_detailTopView) {
        _detailTopView = loadNibName(@"GKGLCardDetailTopView");
        [_detailTopView updateGKGLCardDetailTopViewParam:_param cardType:_cardType];
        if ([_cardType isEqualToString:@"ticket"]||[_cardType isEqualToString:@"goods"]||[_cardType isEqualToString:@"card_time"]||[_cardType isEqualToString:@"stored_card"]) {
            _detailTopView.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 140);
        }
        if ([_cardType isEqualToString:@"bank"]) {
            _detailTopView.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 95);
        }
        if ([_cardType isEqualToString:@"pro"]||[_cardType isEqualToString:@"card_num"]) {
            _detailTopView.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 160);
        }
        _detailTopView.GKGLCardDetailTopViewEndServiceBlock = ^{
            [[[MzzHud alloc]initWithTitle:@"" message:@"你确定终止服务吗" leftButtonTitle:@"取消" rightButtonTitle:@"确定" click:^(NSInteger index) {
                if (index == 1) {
                    [weakSelf requestEndService];
                }
            }]show];
        };
        _detailTopView.GKGLCardDetailTopViewCancelTicketBlock = ^{
            [weakSelf requestCancelTicket];
        };
//        _detailTopView.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 160);
        
    }
    return _detailTopView;
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, _detailTopView.bottom + 15, SCREEN_WIDTH, SCREEN_HEIGHT - _detailTopView.bottom - 15)];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.backgroundColor = kColorE;
        _tbView.mj_header = self.gifHeader;
//        [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            [self requestCardDetailData];
//        }];
        [_tbView.mj_header beginRefreshing];
    }
    return _tbView;
}
- (XMHRefreshGifHeader *)gifHeader {
    if (!_gifHeader) {
        _gifHeader = [XMHRefreshGifHeader headerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self requestCardDetailData];
            });
        }];
    }
    return _gifHeader;
}
- (void)endRefreshing{
    [_tbView.mj_header endRefreshing];
    [_tbView.mj_footer endRefreshing];
}
#pragma mark ------UITableView------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kGKGLCardDetailCell = @"kGKGLCardDetailCell";
    GKGLCardDetailCell * cardDetailCell = [tableView dequeueReusableCellWithIdentifier:kGKGLCardDetailCell];
    if (!cardDetailCell) {
        cardDetailCell =  loadNibName(@"GKGLCardDetailCell");
    }
    [cardDetailCell updateCellParam:_dataSource[indexPath.row]];
    return cardDetailCell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 10;
    return _dataSource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MzzBillDetailController * detailVC = [[MzzBillDetailController alloc] init];
    detailVC.user_id = _userid;
    MzzBillInfoModel * billInfoModel = [[MzzBillInfoModel alloc]init];
    billInfoModel.rec_id = [_dataSource[indexPath.row][@"rec_id"] integerValue];
    billInfoModel.content = _dataSource[indexPath.row][@"rec_id"];
    billInfoModel.operation = [_dataSource[indexPath.row][@"operation"] integerValue];
    billInfoModel.ID = [_dataSource[indexPath.row][@"ID"] integerValue];
    billInfoModel.current = _dataSource[indexPath.row][@"current"];
    billInfoModel.ly_id = _dataSource[indexPath.row][@"ly_id"];
    billInfoModel.ly_name = _dataSource[indexPath.row][@"ly_name"];
    billInfoModel.count = _dataSource[indexPath.row][@"count"];
    billInfoModel.ly_type = _dataSource[indexPath.row][@"ly_type"];
    billInfoModel.alter_num = [_dataSource[indexPath.row][@"alter_num"] integerValue];
    billInfoModel.insert_time = _dataSource[indexPath.row][@"insert_time"];
    billInfoModel.num = [_dataSource[indexPath.row][@"num"] integerValue];
    billInfoModel.name = _dataSource[indexPath.row][@"name"];
    billInfoModel.type = _dataSource[indexPath.row][@"type"];
    billInfoModel.show = _dataSource[indexPath.row][@"show"];
    billInfoModel.ordernum = _dataSource[indexPath.row][@"ordernum"];
    billInfoModel.frozen = _dataSource[indexPath.row][@"frozen"];
    NSString * cardName = @"";
    if ([_cardType isEqualToString:@"bank"]) {
        cardName = @"账户";
    }else if ([_cardType isEqualToString:@"stored_card"]){
        cardName = _param[@"stored_card_name"];
    }else{
        cardName = _param[@"name"];
    }
    [detailVC setupModel:billInfoModel andType:_cardType andCardName:cardName];
    [self.navigationController pushViewController:detailVC animated:NO];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    GKGLCardDetailTbSectionHeaderView * sectionHeaderView = loadNibName(@"GKGLCardDetailTbSectionHeaderView");
    sectionHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    return sectionHeaderView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0f;
}
#pragma mark ------网络请求------
/** 卡项详情数据 */
- (void)requestCardDetailData
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:_userid?_userid:@"" forKey:@"user_id"];
    [param setValue:_cardType?_cardType:@"" forKey:@"type"];
    NSString * type_id = @"";
    if ([_cardType isEqualToString:@"stored_card"]||[_cardType isEqualToString:@"card_num"]) {
        type_id = _param[@"user_card_id"];
    }
    if ([_cardType isEqualToString:@"card_time"]||[_cardType isEqualToString:@"ticket"]||[_cardType isEqualToString:@"bank"]) {
        type_id = _param[@"id"];
    }
    if ([_cardType isEqualToString:@"pro"]) {
        type_id = _param[@"pro_id"];
    }
    if ([_cardType isEqualToString:@"goods"]) {
        type_id = _param[@"goods_id"];
    }
    [param setValue:type_id?type_id:@"" forKey:@"type_id"];
    [MzzCustomerRequest requestGKGLCustomerCommonUrl:kGKGL_CARD_DETAIL_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        [self endRefreshing];
        if (isSuccess) {
            [_dataSource removeAllObjects];
            [_dataSource addObjectsFromArray:resultDic[@"list"]];
            [_tbView reloadData];
        }else{}
    }];
}
/** 消票 */
- (void)requestCancelTicket
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:_userid?_userid:@"" forKey:@"user_id"];
    [param setValue:_param[@"id"]?_param[@"id"]:@"" forKey:@"ticket_id"];
    [MzzCustomerRequest requestGKGLCustomerCommonUrl:kGKGL_CUSTOMERBILLDETAI_CANCELTICKET_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:_param];
            [dic setValue:@"已用完" forKey:@"state"];
            [dic setValue:@"0" forKey:@"isShow"];
            [_detailTopView updateGKGLCardDetailTopViewParam:dic cardType:_cardType];
        }else{}
    }];
}
/** 终止服务 */
- (void)requestEndService
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:_userid?_userid:@"" forKey:@"user_id"];
    [param setValue:_param[@"goods_id"]?_param[@"goods_id"]:@"" forKey:@"goods_id"];
    [MzzCustomerRequest requestGKGLCustomerCommonUrl:kGKGL_CUSTOMERBILLLDETAIL_ENDSERVICE_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:_param];
            [dic setValue:@"已用完" forKey:@"state"];
            [dic setValue:@"0" forKey:@"isShow"];
            [_detailTopView updateGKGLCardDetailTopViewParam:dic cardType:_cardType];
        }else{}
    }];
}
@end
