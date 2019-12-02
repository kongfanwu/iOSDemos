//
//  XMHActionCenterSendVC.m
//  xmh
//
//  Created by ald_ios on 2019/5/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHActionCenterSendVC.h"
#import "XMHACSendView.h"
#import "XMHACSendTimeSelectView.h"
#import "XHMACSendHomeCell.h"
#import "XMHActionCenterDataVC.h"
#import "XMHActionCenterRequest.h"
#import "XMHCouponSendHomeListModel.h"
#import "XMHSendCouponVC.h"
@interface XMHActionCenterSendVC ()<UITableViewDelegate,UITableViewDataSource>
/** 发放优惠券 */
@property (nonatomic, strong) XMHACSendView *sendView;
/** 选择时间 */
@property (nonatomic, strong)XMHACSendTimeSelectView * timeSelectView;
@property (nonatomic, strong)UITableView *tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, copy)NSString * type;
@property (nonatomic, copy)NSString * sort;
@end

@implementation XMHActionCenterSendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;
    [self createSubViews];
    [self requestListData];
}
- (void)createSubViews
{
    [self.navView setNavViewTitle:@"发放优惠券" backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
    __weak typeof(self) _self = self;
    self.navView.NavViewBackBlock = ^{
        __strong typeof(_self) self = _self;
        if (self.navigationBackBlock) {
            self.navigationBackBlock();
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    };
    
    [self.view addSubview:self.sendView];
    [self.view addSubview:self.timeSelectView];
    [self.view addSubview:self.tbView];
}
- (XMHACSendView *)sendView
{
    WeakSelf
    if (!_sendView) {
        _sendView = loadNibName(@"XMHACSendView");
        _sendView.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 90);
        _sendView.XMHACSendViewBlock = ^{
            XMHSendCouponVC *vc = XMHSendCouponVC.new;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
    }
    return _sendView;
}
- (XMHACSendTimeSelectView *)timeSelectView
{
    WeakSelf
    if (!_timeSelectView) {
        _timeSelectView = loadNibName(@"XMHACSendTimeSelectView");
        _timeSelectView.frame = CGRectMake(0, _sendView.bottom + 10, SCREEN_WIDTH, 63);
        _timeSelectView.XMHACSendTimeSelectViewBlock = ^(NSString * _Nonnull time, NSString * _Nonnull order) {
            weakSelf.type = time;
            weakSelf.sort = order;
            [weakSelf requestListData];
        };
    }
    return _timeSelectView;
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, _timeSelectView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - _timeSelectView.bottom) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.backgroundColor = kColorE;
    }
    return _tbView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kXHMACSendHomeCell = @"kXHMACSendHomeCell";
    XHMACSendHomeCell * cell = [tableView dequeueReusableCellWithIdentifier:kXHMACSendHomeCell];
    if (!cell) {
        cell = loadNibName(@"XHMACSendHomeCell");
    }
    [cell updateCellModel:_dataSource[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 10;
    return _dataSource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMHActionCenterDataVC * next = [[XMHActionCenterDataVC alloc] init];
    next.activityid = [_dataSource[indexPath.row] activityid];
    [self.navigationController pushViewController:next animated:NO];
}

#pragma mark ---网络请求
/** 列表数据 */
- (void)requestListData
{
    NSString * sort = _sort?_sort:@"desc";
    NSString * type = _type?_type:@"1";
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:sort forKey:@"sort"];
    [param setValue:type forKey:@"type"];
    [XMHActionCenterRequest requestCommonUrl:kCOUPON_SEND_HOME_URL Param:param resultBlock:^(NSDictionary * _Nonnull resultDic, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
        if (isSuccess) {
            XMHCouponSendHomeListModel *model = [XMHCouponSendHomeListModel yy_modelWithDictionary:resultDic];
            _dataSource = [[NSMutableArray alloc] initWithArray:model.list];
            [_tbView reloadData];
        }
    }];
    
}
@end
