//
//  RefundVC.m
//  xmh
//
//  Created by ald_ios on 2018/11/7.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "RefundVC.h"
/** View */
#import "RefundCustomerInfoView.h"
#import "RefundBottomView.h"
#import "RefundSearchView.h"
#import "RefundGWCView.h"
/** Cell */
#import "RefundLeftCell.h"
#import "RefundCommonCell.h"
/** 通用 */
#import "ShareWorkInstance.h"
/** 网络 */
#import "ApproveRequest.h"
/** Model */
#import "RefundLeftCellModel.h"
#import "RefundInfoModel.h"
#import "RefundListModel.h"
/** VC */
#import "RefundDetailVC.h"
#define kCustomerInfoHEIGHT 98
#define kSubmitHEIGHT 49
@interface RefundVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)RefundCustomerInfoView * customerInfoView;
@property (nonatomic, strong)UITableView * leftTbView;
@property (nonatomic, strong)UITableView * rightTbView;
@property (nonatomic, strong)RefundBottomView * refundBottomView;
@property (nonatomic, strong)RefundSearchView * searchView;
@property (nonatomic, strong)UIView * coverView;
@property (nonatomic, strong)RefundInfoModel * refundInfoModel;
@property (nonatomic, strong)RefundListModel * refundListModel;
@property (nonatomic, strong)RefundGWCView * refundGWCView;
@property (nonatomic, strong)NSMutableArray * paramDataSoucre;
/** 是否选择全部清卡 */
@property (nonatomic, assign)BOOL isAll;
@end

@implementation RefundVC
{
    /** 左侧数据源 */
    NSArray * _leftDataSource;
    /** 右侧数据源 */
    NSMutableArray * _rightDataSource;
    /** 检索关键字 */
    NSString * _keyWord;
//    /** 顾客信息模型 */
//    RefundInfoModel * _refundInfoModel;
//    /** 商品列表模型 */
//    RefundListModel * _refundListModel;
    /** 左侧类型 */
    NSString * _type;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 初始设置 */
    self.view.backgroundColor = kBackgroundColor;
    /** 购物车数组  跳转下界面数组 */
    _paramDataSoucre = [[NSMutableArray alloc] init];
    _type = @"pro";
    /** 初始化左侧数据栏数据 */
    [self initLeftDateSource];
    
    [self initSubViews];
    
    /** 获取顾客信息 */
    [self requestRefundCustomerInfo];
//    /** 获取顾客所有购买商品 */
//    [self requestAllData];
   
}
- (void)initLeftDateSource
{
    _leftDataSource = @[[RefundLeftCellModel createModelTitle:@"项目" type:@"pro" selected:YES],[RefundLeftCellModel createModelTitle:@"任选卡" type:@"card_num" selected:NO],[RefundLeftCellModel createModelTitle:@"储值卡" type:@"stored_card" selected:NO],[RefundLeftCellModel createModelTitle:@"时间卡" type:@"card_time" selected:NO],[RefundLeftCellModel createModelTitle:@"产品" type:@"goods" selected:NO],[RefundLeftCellModel createModelTitle:@"票券" type:@"ticket" selected:NO],[RefundLeftCellModel createModelTitle:@"账户" type:@"bank" selected:NO]];
}
- (void)initSubViews
{
    /** nav */
    [self.navView setNavViewTitle:@"退款审批" backBtnShow:YES];
    self.navView.backgroundColor = kBtn_Commen_Color;
   
    
    [self.view addSubview:self.customerInfoView];
    [self.view addSubview:self.leftTbView];
    /** 暂时不做搜索 */
//    [self.view addSubview:self.searchView];
    [self.view addSubview:self.rightTbView];
    /** 蒙层 */
    [self.view addSubview:self.coverView];
    [self.view addSubview:self.refundGWCView];
    [self.view addSubview:self.refundBottomView];
    
   
}
/** 顾客信息View */
- (RefundCustomerInfoView *)customerInfoView
{
    WeakSelf
    if (!_customerInfoView) {
        _customerInfoView = loadNibName(@"RefundCustomerInfoView");
        _customerInfoView.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, kCustomerInfoHEIGHT);
        _customerInfoView.RefundCustomerInfoViewBlock = ^(BOOL isAll) {
            // 未补齐业绩，不可清卡
            if (isAll && weakSelf.refundListModel.yeji > 0) {
                [[[MzzHud alloc]initWithTitle:@"提示" message:@"您还有未补齐业绩的订单" centerButtonTitle:@"是" click:^(NSInteger index) {}]show];
                [weakSelf.customerInfoView updateRefundCustomerInfoViewSwitchState:NO];
                return;
            }
            weakSelf.isAll = isAll;
            if (isAll) {
                /** 判断是否有冻结的商品 */
                if (_refundListModel.nums.integerValue == 0) {
                    weakSelf.coverView.hidden = NO;
                }else{
                  [weakSelf showNotice];
                }
            }else{
                weakSelf.coverView.hidden = YES;
            }
        };
    }
    return _customerInfoView;
}
/** 弹窗提示 */
- (void)showNotice
{
    NSString * message = [NSString stringWithFormat:@"顾客有%@个商品被冻结请问是都要解冻",_refundListModel.nums];
    [[[MzzHud alloc]initWithTitle:@"" message:message leftButtonTitle:@"否" rightButtonTitle:@"是" click:^(NSInteger index) {
        /** 点选是 */
        if (index== 1) {
            _coverView.hidden = NO;
            RefundDetailVC * refundDetailVC = [[RefundDetailVC alloc] init];
            refundDetailVC.refundInfoModel = _refundInfoModel;
            refundDetailVC.dataSource = _paramDataSoucre;
            [self.navigationController pushViewController:refundDetailVC animated:NO];
        }
        if (index ==0) {
            [_customerInfoView updateRefundCustomerInfoViewSwitchState:NO];
        }
    } hiddenCancelBtn:YES] show];
    
    
}
/** 搜索View */
- (RefundSearchView *)searchView
{
    if (!_searchView) {
        _searchView = [[RefundSearchView alloc] initWithFrame:CGRectMake(_leftTbView.width, _customerInfoView.bottom, SCREEN_WIDTH - _leftTbView.width, 70)];
        _searchView.RefundSearchViewBlock = ^(NSString *keyword) {
            
        };
    }
    return _searchView;
}
/** 右侧Tb */
- (UITableView *)rightTbView
{
    if (!_rightTbView) {
        _rightTbView = [[UITableView alloc] initWithFrame:CGRectMake(_leftTbView.right, _customerInfoView.bottom, SCREEN_WIDTH - _leftTbView.width, SCREEN_HEIGHT - _customerInfoView.bottom - kSubmitHEIGHT) style:UITableViewStylePlain];
        _rightTbView.backgroundColor = kColorE;
        _rightTbView.delegate = self;
        _rightTbView.dataSource = self;
        _rightTbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _rightTbView.tableFooterView = [[UIView alloc] init];
        
    }
    return _rightTbView;
}
/** 蒙层 */
- (UIView *)coverView
{
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:CGRectMake(0, _customerInfoView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - _customerInfoView.bottom - _refundBottomView.height)];
        _coverView.backgroundColor = kColor3;
        _coverView.alpha = 0.4;
        _coverView.hidden = YES;
    }
    return _coverView;
}
/** 左侧Tb */
- (UITableView *)leftTbView
{
    if (!_leftTbView) {
        _leftTbView = [[UITableView alloc] initWithFrame:CGRectMake(0, _customerInfoView.bottom, 94, SCREEN_HEIGHT - _customerInfoView.bottom - kSubmitHEIGHT) style:UITableViewStylePlain];
        _leftTbView.delegate = self;
        _leftTbView.dataSource = self;
        [_leftTbView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        _leftTbView.backgroundColor = kColorF5F5F5;
//        _leftTbView.scrollEnabled = NO;
        _leftTbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _leftTbView;
}
/** 底部View */
- (RefundBottomView *)refundBottomView
{
    WeakSelf
    if (!_refundBottomView) {
        _refundBottomView = loadNibName(@"RefundBottomView");
        _refundBottomView.frame = CGRectMake(0, SCREEN_HEIGHT - kSubmitHEIGHT, SCREEN_WIDTH, kSubmitHEIGHT);
        /** 购物车回调 */
        _refundBottomView.RefundBottomViewGWCBlock = ^{
            weakSelf.refundGWCView.hidden = NO;
        };
        /** 下一步回调 */
        _refundBottomView.RefundBottomViewNextBlock = ^{
            [weakSelf pushNextVC];
        };
    }
    return _refundBottomView;
}
/** 购物车View */
- (RefundGWCView *)refundGWCView
{
    WeakSelf
    if (!_refundGWCView) {
        _refundGWCView = [[RefundGWCView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 50)];
        _refundGWCView.RefundGWCViewClearBlock = ^{
           [weakSelf.refundBottomView updateRefundBottomViewNum:@"0"];
        };
        _refundGWCView.hidden = YES;
    }
    return _refundGWCView;
}
#pragma mark ------UITableViewDelegate------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf
    static NSString * kLeftCell = @"kLeftCell";
    static NSString * kRefundCommonCell = @"kRefundCommonCell";
    if ([tableView isEqual:_leftTbView]) {
        RefundLeftCell * cell = [tableView dequeueReusableCellWithIdentifier:kLeftCell];
        if (!cell) {
            cell = loadNibName(@"RefundLeftCell");
        }
        [cell updateRefundLeftCellModel:_leftDataSource[indexPath.row]];
        return cell;
    }
    if ([tableView isEqual:_rightTbView]) {
        RefundCommonCell * cell = [tableView dequeueReusableCellWithIdentifier:kRefundCommonCell];
        if (!cell) {
            cell = loadNibName(@"RefundCommonCell");
        }
        RefundModel * model = _rightDataSource[indexPath.row];
        [cell updateRefundCommonCellModel:model];
        cell.RefundCommonCellShowBlock = ^(RefundModel *model) {
            NSInteger index = [_rightDataSource indexOfObject:model];
            [_rightTbView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        };
        cell.RefundCommonCellAllBlock = ^(RefundModel *model) {
            if ([weakSelf.paramDataSoucre containsObject:model]) {
                [weakSelf.paramDataSoucre removeObject:model];
            }
            [weakSelf.paramDataSoucre addObject:model];
            [weakSelf.refundBottomView updateRefundBottomViewNum:[NSString stringWithFormat:@"%ld",weakSelf.paramDataSoucre.count]];
            weakSelf.refundGWCView.dataSource = weakSelf.paramDataSoucre;
        };
        cell.RefundCommonCellAddGWCBlock = ^(RefundModel *model) {
            if ([weakSelf.paramDataSoucre containsObject:model]) {
                [weakSelf.paramDataSoucre removeObject:model];
            }
            [weakSelf.paramDataSoucre addObject:model];
            [weakSelf.refundBottomView updateRefundBottomViewNum:[NSString stringWithFormat:@"%ld",weakSelf.paramDataSoucre.count]];
            weakSelf.refundGWCView.dataSource = weakSelf.paramDataSoucre;
        };
        return cell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_leftTbView]) {
        return 50.0f;
    }
    if ([tableView isEqual:_rightTbView]) {
        RefundModel * model = _rightDataSource[indexPath.row];
        if (model.showed) {
            if ([_type isEqualToString:@"pro"] || [_type isEqualToString:@"card_num"]||[_type isEqualToString:@"goods"]||[_type isEqualToString:@"ticket"]) {
                return 135;
            }
            if ([_type isEqualToString:@"card_time"]||[_type isEqualToString:@"bank"]||[_type isEqualToString:@"stored_card"]) {
                return 150;
            }
            if ([_type isEqualToString:@"sales"]) {
                return 210;
            }
        }else{
            return 70;
        }
    }
    return 0.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:_leftTbView]) {
        return _leftDataSource.count;
    }
    if ([tableView isEqual:_rightTbView]) {
        return _rightDataSource.count;
        return 10;
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_leftTbView]) {
        for (int i = 0; i < _leftDataSource.count; i ++) {
            RefundLeftCellModel * model = _leftDataSource[i];
            if (i == indexPath.row) {
                model.selected = YES;
                _type = model.type;
                if ([model.type isEqualToString:@"pro"]) {
                    _rightDataSource = [[NSMutableArray alloc] initWithArray:_refundListModel.pro];
                }
                if ([model.type isEqualToString:@"goods"]) {
                    _rightDataSource = [[NSMutableArray alloc] initWithArray:_refundListModel.goods];
                }
                if ([model.type isEqualToString:@"card_num"]) {
                    _rightDataSource = [[NSMutableArray alloc] initWithArray:_refundListModel.card_num];
                }
                if ([model.type isEqualToString:@"card_time"]) {
                    _rightDataSource = [[NSMutableArray alloc] initWithArray:_refundListModel.card_time];
                }
                if ([model.type isEqualToString:@"ticket"]) {
                    _rightDataSource = [[NSMutableArray alloc] initWithArray:_refundListModel.ticket];
                }
                if ([model.type isEqualToString:@"bank"]) {
                    _rightDataSource = [[NSMutableArray alloc] initWithArray:_refundListModel.bank];
                }
                if ([model.type isEqualToString:@"stored_card"]) {
                    _rightDataSource = [[NSMutableArray alloc] initWithArray:_refundListModel.stored_card];
                }
                if ([model.type isEqualToString:@"sales"]) {
                    _rightDataSource = [[NSMutableArray alloc] initWithArray:_refundListModel.sales];
                }
                [_rightTbView reloadData];
            }else{
                model.selected = NO;
            }
        }
        [_leftTbView reloadData];
    }
    if ([tableView isEqual:_rightTbView]) {
        
    }
}
#pragma mark ------网络请求------
/** 获取顾客所有购买的东西 */
- (void)requestAllData
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:_refundInfoModel.user_id?_refundInfoModel.user_id:@"" forKey:@"user_id"];
//    [param setValue:@"22359" forKey:@"user_id"];
    [ApproveRequest requestClearCardAll:param resultBlock:^(RefundListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _refundListModel = model;
            _rightDataSource = [[NSMutableArray alloc] initWithArray:_refundListModel.pro];
            [_rightTbView reloadData];
        }else{}
    }];
}
/** 获取退款顾客信息 */
- (void)requestRefundCustomerInfo
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    NSString * framId = [NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    [param setValue:_mobile?_mobile:@"" forKey:@"mobile"];
//    [param setValue:@"16666666622" forKey:@"mobile"];
    [param setValue:framId?framId:@"" forKey:@"fram_id"];
    [ApproveRequest requestRefundCustomerInfo:param resultBlock:^(RefundInfoModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _refundInfoModel = model;
            [_customerInfoView updateRefundCustomerInfoViewModel:model];
            [self requestAllData];
        }else{}
    }];
}
#pragma mark ------页面跳转------
/** 跳转业绩分配界面 */
- (void)pushNextVC
{
    if (!_isAll) {
        if (_paramDataSoucre.count == 0) {
            [XMHProgressHUD showOnlyText:@"您还没有选择需要退款的商品"];
            return;
        }
    }
    RefundDetailVC * refundDetailVC = [[RefundDetailVC alloc] init];
    refundDetailVC.refundInfoModel = _refundInfoModel;
    refundDetailVC.dataSource = _paramDataSoucre;
    [self.navigationController pushViewController:refundDetailVC animated:NO];
}

@end
