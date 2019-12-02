//
//  XMHTraceSelectDiscountCouponSubVC.m
//  xmh
//
//  Created by ald_ios on 2019/6/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHTraceSelectDiscountCouponSubVC.h"
#import "XMHRefreshGifHeader.h"
#import "MzzCustomerRequest.h"
#import "XMHTraceDiscountCouponCell.h"
#import "XMHSHDiscountCouponListModel.h"
#import "XMHCouponListModel.h"
#import "XMHFormVC.h"
#import "XMHCouponRequest.h"
#import "XMHServiceGoodsModel.h"
#import "XMHFormDataCreate.h"
@interface XMHTraceSelectDiscountCouponSubVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)XMHBaseTableView * tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, strong)NSMutableArray * selectSource;
@property (nonatomic, assign)NSInteger page;
@property (nonatomic, assign)NSInteger isMore;
/** 刷新 */
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
@end

@implementation XMHTraceSelectDiscountCouponSubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _isMore = NO;
    [self.view addSubview:self.tbView];
    _dataSource = [[NSMutableArray alloc] init];
    _selectSource = [[NSMutableArray alloc] init];
    [self requestServerBillsData];
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[XMHBaseTableView alloc] initWithFrame:self.view.bounds];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.backgroundColor = kColorE;
//        _tbView.mj_header = self.gifHeader;
        //        [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //            [self refreshTbData];
        //        }];
        __weak typeof(self) _self = self;
        _tbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            __strong typeof(_self) self = _self;
            [self requestMoreData];
        }];
//        [_tbView.mj_header beginRefreshing];
    }
    return _tbView;
}
- (XMHRefreshGifHeader *)gifHeader {
    if (!_gifHeader) {
        __weak typeof(self) _self = self;
        _gifHeader = [XMHRefreshGifHeader headerWithRefreshingBlock:^{
            __strong typeof(_self) self = _self;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self refreshTbData];
            });
        }];
    }
    return _gifHeader;
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tbView.frame = self.view.bounds;
}

- (void)requestMoreData
{
    _isMore = YES;
    _page ++;
    [self requestServerBillsData];
}
- (void)refreshTbData
{
    _isMore = NO;
    _page = 1;
    [self requestServerBillsData];
}
- (void)endRefreshing{
    [_tbView.mj_header endRefreshing];
    [_tbView.mj_footer endRefreshing];
}
#pragma mark ------UITableView------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellName = @"XMHTraceDiscountCouponCell";
    XMHTraceDiscountCouponCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = loadNibName(@"XMHTraceDiscountCouponCell");
    }
    [cell updateCellModel:_dataSource[indexPath.row]];
    [cell updateCellType:_cellType];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
    return 10;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /** 查看优惠券详情 */
    if (_cellType == XMHTaskManagerCellLook) {
        XMHCouponModel *couponModel = [_dataSource safeObjectAtIndex:indexPath.row];
        
        [self getCpuponDataCouponModel:couponModel complete:^(XMHCouponModel *newCouponModel) {
            XMHFormVC *formVc = XMHFormVC.new;
            formVc.edit = NO;
            formVc.couponModel = newCouponModel;
            formVc.couponType = [newCouponModel.type integerValue];
            formVc.createType = XMHActionCreateTypeChaKan;
            [self.navigationController pushViewController:formVc animated:YES];
        }];
        return;
    }else{ /** 选择优惠券 */
        XMHCouponModel * model = _dataSource[indexPath.row];
        model.selected = !model.selected;
        if (![_selectSource containsObject:model]) {
            [_selectSource addObject:model];
        }else{
            [_selectSource removeObject:model];
        }
        if (_XMHTraceSelectDiscountCouponSubVCBlock) {
            _XMHTraceSelectDiscountCouponSubVCBlock(_selectSource,_tag);
        }
        [_tbView reloadData];
    }
}
/**
获取优惠券详情

@param couponModel 优惠券model
@param complete 回调
*/
- (void)getCpuponDataCouponModel:(XMHCouponModel *)couponModel complete:(void(^)(XMHCouponModel *couponModel))complete {
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSMutableDictionary *param = NSMutableDictionary.new;
    param[@"id"] = couponModel.uid;
    param[@"account"] = model.data.account;
    param[@"account_id"] = @(model.data.ID).stringValue;
    [XMHCouponRequest requestCouponEditParams:param resultBlock:^(BaseModel * _Nonnull model, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
        if (!isSuccess) return;
        XMHCouponModel *newCouponModel = [XMHCouponModel yy_modelWithJSON:model.data];
        
        //------- 会员等级 -------
        // type 0 会员等级 1 订单商品 2 使用渠道 3 支付使用
        NSDictionary *vipDic = [XMHCouponModel getRulesType:0 rules:model.data[@"rules"]];
        newCouponModel.vipLevel = vipDic[@"condition1"];
        // 不是全部 && 选择了部分等级
        if ([newCouponModel.vipLevel isKindOfClass:[NSArray class]]) {
            newCouponModel.vipDataArray = [NSArray yy_modelArrayWithClass:[XMHItemModel class] json:vipDic[@"condition1"]];
            NSMutableString *str = NSMutableString.new;
            for (int i = 0; i < newCouponModel.vipDataArray.count; i++) {
                XMHItemModel *itemMdoel = newCouponModel.vipDataArray[i];
                if (i == newCouponModel.vipDataArray.count - 1) {
                    [str appendFormat:@"%@", itemMdoel.title];
                } else {
                    [str appendFormat:@"%@,", itemMdoel.title];
                }
            }
            newCouponModel.vipLevel = str;
        }
        
        //------- 订单商品 -------
        NSDictionary *orderDic = [XMHCouponModel getRulesType:1 rules:model.data[@"rules"]];
        newCouponModel.orderGoods = orderDic[@"condition1"];
        if ([newCouponModel.orderGoods isKindOfClass:[NSArray class]]) {
            newCouponModel.orderDataArray = [NSArray yy_modelArrayWithClass:[XMHServiceGoodsModel class] json:orderDic[@"condition1"]];
            newCouponModel.orderGoods = [NSString stringWithFormat:@"订单商品（已选%lu）", (unsigned long)newCouponModel.orderDataArray.count];
        }
        
        //------- 使用渠道 -------
        NSDictionary *platformDic = [XMHCouponModel getRulesType:2 rules:model.data[@"rules"]];
        newCouponModel.platform = IsEmpty(platformDic[@"condition1"]) ? nil : platformDic[@"condition1"];
        
        NSArray *allPlatformList = [XMHFormDataCreate platformList];
        if ([newCouponModel.platform isKindOfClass:[NSString class]] && [newCouponModel.platform isEqualToString:@"*"] ) { // 全部
            newCouponModel.platformDataArray = allPlatformList;
            newCouponModel.platform = @"全部渠道";
        } else { // 部分渠道
            // 获取选择的平台
            NSMutableArray *newAllPlatformList = NSMutableArray.new;
            newCouponModel.platformDataArray = newAllPlatformList;
            NSArray *platformIds = [newCouponModel.platform componentsSeparatedByString:@","];
            for (NSString *platformId in platformIds) {
                [allPlatformList enumerateObjectsUsingBlock:^(XMHItemModel * _Nonnull itemModel, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([itemModel.idStr isEqualToString:platformId]) {
                        [newAllPlatformList addObject:itemModel];
                    }
                }];
            }
            
            // 拼接平台名称
            NSMutableString *str = NSMutableString.new;
            for (int i = 0; i < newCouponModel.platformDataArray.count; i++) {
                XMHItemModel *itemMdoel = newCouponModel.platformDataArray[i];
                if (i == newCouponModel.platformDataArray.count - 1) {
                    [str appendFormat:@"%@", itemMdoel.title];
                } else {
                    [str appendFormat:@"%@,", itemMdoel.title];
                }
            }
            newCouponModel.platform = str;
        }
        
        //------- 支付使用 -------
        NSDictionary *payDic = [XMHCouponModel getRulesType:5 rules:model.data[@"rules"]];
        NSString *payInfo = payDic[@"condition1"];
        newCouponModel.payModel = [XMHCouponPayInfoModel yy_modelWithJSON:payInfo];
        
        if (complete) complete(newCouponModel);
    }];
}

#pragma mark ------网络请求------
/** 优惠券数据 */
- (void)requestServerBillsData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString * joinCode = [ShareWorkInstance shareInstance].join_code;
    [params setValue:joinCode forKey:@"join_code"];
    [params setValue:@(_tag + 3) forKey:@"type"];
    [params setValue:@"" forKey:@"name"];
    [params setValue:@"4" forKey:@"status"];
    [params setValue:@"asc" forKey:@"sore"];
    [params setValue:@(1) forKey:@"page"];
    [params setValue:@(1) forKey:@"cute_hand"];
//    [params setValue:@(20) forKey:@"page_size"];
    [YQNetworking postWithUrl:[XMHHostUrlManager url:@"v5.Ticket_coupon/getList"] refreshRequest:NO cache:YES params:params progressBlock:nil resultBlock:^(BaseModel * obj, BOOL isSuccess, NSError *error) {
        if (isSuccess) {
            XMHCouponListModel *model = [XMHCouponListModel yy_modelWithDictionary:obj.data];
            if (!_isMore) {
                [_dataSource removeAllObjects];
            }
            [_dataSource addObjectsFromArray:model.list];
            if (_paramArr.count > 0) {
                [self comparisonData];
            }
            if (model.list) {
                [_tbView.mj_footer endRefreshingWithNoMoreData];
            }
            [_tbView reloadData];
        }else{
            
        }
    }];
}
- (void)setCellType:(XMHTraceDiscountCouponCellType)cellType
{
    _cellType = cellType;
    [_tbView reloadData];
}
/** 回显 比对数据 已选择的 勾选 */
- (void)comparisonData
{
    [_paramArr enumerateObjectsUsingBlock:^(NSString * uid, NSUInteger idx, BOOL * _Nonnull stop) {
        [_dataSource enumerateObjectsUsingBlock:^(XMHCouponModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([uid isEqualToString:model.uid]) {
                model.selected = YES;
                [_selectSource addObject:model];
            }
        }];
    }];
}
@end
