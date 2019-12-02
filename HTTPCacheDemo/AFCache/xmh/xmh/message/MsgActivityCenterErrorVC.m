//
//  MsgActivityCenterErrorVC.m
//  xmh
//
//  Created by ald_ios on 2019/5/9.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "MsgActivityCenterErrorVC.h"
#import "XMHRefreshGifHeader.h"
#import "MsgActivityCenterErrorCell.h"
#import "XMHActionCenterRequest.h"
@interface MsgActivityCenterErrorVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)XMHBaseTableView *tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
/** 刷新 */
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
@property (nonatomic, assign)BOOL isMore;
@property (nonatomic, assign)NSInteger page;
@end

@implementation MsgActivityCenterErrorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;
    [self initSubViews];
    [self requestErrorCustomerData];
}
- (void)initSubViews
{
    [self.navView setNavViewTitle:@"失败顾客" backBtnShow:YES];
    self.navView.backgroundColor = kBtn_Commen_Color;
    [self.view addSubview:self.tbView];
}

- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[XMHBaseTableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.emptyEnable = YES;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.backgroundColor = kColorF5F5F5;
    }
    return _tbView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kMsgActivityCenterErrorCell = @"kMsgActivityCenterErrorCell";
    MsgActivityCenterErrorCell * cell = [tableView dequeueReusableCellWithIdentifier:kMsgActivityCenterErrorCell];
    if (!cell) {
        cell = loadNibName(@"MsgActivityCenterErrorCell");
    }
    [cell updateCellModel:_dataSource[indexPath.row] cellFrom:CellFromMsg];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 97.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}
#pragma mark ------网络请求------
- (void)requestErrorCustomerData
{
    NSString * activity_id = _activity_id?_activity_id:@"";
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:activity_id forKey:@"b_activity_id"];
    [XMHActionCenterRequest requestCommonUrl:kCOUPON_ERRORCUSTOMER_URL Param:param resultBlock:^(NSDictionary * _Nonnull resultDic, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
        if (isSuccess) {
            XMHCouponSendCustomerListModel *model = [XMHCouponSendCustomerListModel yy_modelWithDictionary:resultDic];
            _dataSource = [[NSMutableArray alloc] initWithArray:model.list];
            [_tbView reloadData];
        }
    }];
}
@end
