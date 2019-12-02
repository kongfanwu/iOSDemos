//
//  LanternAddGoodsVC.m
//  xmh
//
//  Created by ald_ios on 2018/12/29.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternAddGoodsVC.h"
#import "RefundLeftCellModel.h"
#import "RefundLeftCell.h"
#import "RefundCommonCell.h"
#import "LanternAddGoodsTopView.h"
#import "CommonSubmitView.h"
#import "LanternAddGoodsSectionHeaderView.h"
#import "LanternAddGoodsCell.h"
#import "LanternAddServiceCell.h"
#import "SaleListRequest.h"
#import "LanternPlanInfoListModel.h"
#import "SASaleListModel.h"
#import "SLRequest.h"
#import "LanternPlanInfoListModel.h"
#import "SLPresModel.h"
#import "SLServPro.h"
#import "SLGoodsModel.h"
#import "SLTi_CardModel.h"
@interface LanternAddGoodsVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView * leftTbView;
@property (nonatomic, strong)UITableView * rightTbView;
@property (nonatomic, strong)LanternAddGoodsTopView *goodsTopView;
@property (nonatomic,strong)CommonSubmitView *commonSubmitView;
@property (nonatomic,strong)LanternAddGoodsSectionHeaderView *lanternAddGoodsSectionHeaderView;
/** 搜索关键字 */
@property (nonatomic,strong)NSString *key;
/** 选中的数组 */
@property (nonatomic,strong)NSMutableArray * selectArr;
@end
#define kSubmitHEIGHT 70
@implementation LanternAddGoodsVC
{
    /** 左侧数据源 */
    NSArray * _leftDataSource;
    /** 右侧数据源 */
    NSMutableArray * _rightDataSource;
    /** 检索关键字 */
    NSString * _keyWord;
    
    RefundLeftCellModel * _leftModel;
    
    /** 右侧数据源 备份 */
    
    NSMutableArray * _rightDataSourceCopy;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kColorE;
    _rightDataSource = [[NSMutableArray alloc] init];
    _selectArr = [[NSMutableArray alloc] init];
    
    /** 初始化左侧数据栏数据 */
    [self initLeftDateSource];
    [self initSubViews];
    
    if (_type == 1) {
        _leftModel = _leftDataSource[0];
        [self requestGoodsData];
    }
    if (_type == 2) {
        [self requestServiceData];
    }
}
- (void)initLeftDateSource
{
    if (_type == 1) {
       _leftDataSource = @[[RefundLeftCellModel createModelTitle:@"项目疗程" type:@"pro" selected:YES],[RefundLeftCellModel createModelTitle:@"产品" type:@"goods" selected:NO],[RefundLeftCellModel createModelTitle:@"特惠卡" type:@"card_course" selected:NO],[RefundLeftCellModel createModelTitle:@"任选卡" type:@"card_num" selected:NO],[RefundLeftCellModel createModelTitle:@"时间卡" type:@"card_time" selected:NO],[RefundLeftCellModel createModelTitle:@"储值卡" type:@"stored_card" selected:NO]];
    }
    if (_type == 2) {
        _leftDataSource = @[[RefundLeftCellModel createModelTitle:@"处方服务" type:@"pres" selected:YES],[RefundLeftCellModel createModelTitle:@"提卡服务" type:@"ti_card" selected:NO],[RefundLeftCellModel createModelTitle:@"项目服务" type:@"pro" selected:NO],[RefundLeftCellModel createModelTitle:@"产品服务" type:@"goods" selected:NO]];
    }
    
}
- (void)initSubViews
{
    /** nav */
    if (_type == 1) {
        [self.navView setNavViewTitle:@"销售商品" backBtnShow:YES];
    }
    if (_type == 2) {
        [self.navView setNavViewTitle:@"服务商品" backBtnShow:YES];
    }
    self.navView.backgroundColor = kBtn_Commen_Color;
    
    [self.view addSubview:self.goodsTopView];
    [self.view addSubview:self.leftTbView];
    [_leftTbView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self.view addSubview:self.rightTbView];
    [self.view addSubview:self.commonSubmitView];

}
- (CommonSubmitView *)commonSubmitView
{
    WeakSelf
    if (!_commonSubmitView) {
        _commonSubmitView = loadNibName(@"CommonSubmitView");
        _commonSubmitView.frame = CGRectMake(0, SCREEN_HEIGHT - kSubmitHEIGHT, SCREEN_WIDTH, kSubmitHEIGHT);
        [_commonSubmitView updateCommonSubmitViewTitle:@"确认"];
        _commonSubmitView.CommonSubmitViewBlock = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
            if (weakSelf.LanternAddGoodsVCBlock) {
                weakSelf.LanternAddGoodsVCBlock(weakSelf.selectArr);
            }
        };
    }
    return _commonSubmitView;
}
- (LanternAddGoodsTopView *)goodsTopView
{
    WeakSelf
    if (!_goodsTopView) {
        _goodsTopView = [[LanternAddGoodsTopView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 49)];
        _goodsTopView.LanternAddGoodsTopViewSearchBlock = ^(NSString *key) {
            [weakSelf filtrateDataWithKey:key];
        };
        [_goodsTopView updateLanternAddGoodsTopViewModel:_lanternPlanInfoModel];
    }
    return _goodsTopView;
}
- (void)filtrateDataWithKey:(NSString *)keyStr
{
    if (keyStr.length > 0) {
        NSMutableArray * filterArr = [[NSMutableArray alloc] init];
        for (int i = 0; i < _rightDataSource.count; i++) {
            LanternPlanProModel * model = _rightDataSource[i];
            if ([model.name containsString:keyStr]) {
                [filterArr addObject:model];
            }
        }
        _rightDataSource = filterArr;
    }else{
        _rightDataSource = _rightDataSourceCopy;
    }
    [_rightTbView reloadData];
}
- (LanternAddGoodsSectionHeaderView *)lanternAddGoodsSectionHeaderView
{
    if (!_lanternAddGoodsSectionHeaderView) {
        _lanternAddGoodsSectionHeaderView = loadNibName(@"LanternAddGoodsSectionHeaderView");
        [_lanternAddGoodsSectionHeaderView updateLanternAddGoodsSectionHeaderViewModel:_leftDataSource[0]];
    }
    return _lanternAddGoodsSectionHeaderView;
}
/** 左侧Tb */
- (UITableView *)leftTbView
{
    if (!_leftTbView) {
        _leftTbView = [[UITableView alloc] initWithFrame:CGRectMake(0, _goodsTopView.bottom, 94, SCREEN_HEIGHT - _goodsTopView.bottom - kSubmitHEIGHT) style:UITableViewStylePlain];
        _leftTbView.delegate = self;
        _leftTbView.dataSource = self;
        _leftTbView.backgroundColor = kColorF5F5F5;
        //        _leftTbView.scrollEnabled = NO;
        _leftTbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _leftTbView;
}
/** 右侧Tb */
- (UITableView *)rightTbView
{
    if (!_rightTbView) {
        _rightTbView = [[UITableView alloc] initWithFrame:CGRectMake(_leftTbView.right, _goodsTopView.bottom, SCREEN_WIDTH - _leftTbView.width, SCREEN_HEIGHT - _goodsTopView.bottom - kSubmitHEIGHT) style:UITableViewStylePlain];
        _rightTbView.backgroundColor = [UIColor whiteColor];
        _rightTbView.delegate = self;
        _rightTbView.dataSource = self;
        _rightTbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _rightTbView.tableFooterView = [[UIView alloc] init];
//        _rightTbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//            
//        }];
        
    }
    return _rightTbView;
}
#pragma mark ------UITableViewDelegate------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kLeftCell = @"kLeftCell";
    static NSString * kLanternAddGoodsCell = @"kLanternAddGoodsCell";
    static NSString * kLanternAddServiceCell = @"kLanternAddServiceCell";
    if ([tableView isEqual:_leftTbView]) {
        RefundLeftCell * cell = [tableView dequeueReusableCellWithIdentifier:kLeftCell];
        if (!cell) {
            cell = loadNibName(@"RefundLeftCell");
        }
        [cell updateRefundLeftCellModel:_leftDataSource[indexPath.row]];
        return cell;
    }
    if ([tableView isEqual:_rightTbView]) {
        if (_type == 1) {
            LanternAddGoodsCell * lanternAddGoodsCell = [tableView dequeueReusableCellWithIdentifier:kLanternAddGoodsCell];
            if (!lanternAddGoodsCell) {
                lanternAddGoodsCell = loadNibName(@"LanternAddGoodsCell");
                __weak typeof(self) _self = self;
                lanternAddGoodsCell.LanternAddGoodsCellAddBlock = ^(LanternPlanProModel *model) {
                    __strong typeof(_self) self = _self;
                    model.selected = YES;
                    model.isAdd = YES;
//                    model.isEdit = _isEdit;
                    if (![self.selectArr containsObject:model]) {
                        [self.selectArr addObject:model];
                    }
                };
                lanternAddGoodsCell.LanternAddGoodsCellReduceBlock = ^(LanternPlanProModel *model) {
                    __strong typeof(_self) self = _self;
                    if ([self.selectArr containsObject:model]) {
                        [self.selectArr removeObject:model];
                    }
                };
            }
            [lanternAddGoodsCell updateLanternAddGoodsCellModel:_rightDataSource[indexPath.row]];
            return lanternAddGoodsCell;
        }
        if (_type == 2) {
            LanternAddServiceCell * lanternAddServiceCell = [tableView dequeueReusableCellWithIdentifier:kLanternAddServiceCell];
            if (!lanternAddServiceCell) {
                lanternAddServiceCell = loadNibName(@"LanternAddServiceCell");
            }
            [lanternAddServiceCell updateLanternAddServiceCellModel:_rightDataSource[indexPath.row]];
            return lanternAddServiceCell;
        }
        
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_leftTbView]) {
        return 50.0f;
    }
    if ([tableView isEqual:_rightTbView]) {
        if (_type == 1) {
            return 70.0f;
        }
        if (_type == 2) {
            return 44.0f;
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
                _leftModel = model;
                [_lanternAddGoodsSectionHeaderView updateLanternAddGoodsSectionHeaderViewModel:model];
                if (_type == 1) {
                    [self requestGoodsData];
                }
                if (_type == 2) {
                    [self requestServiceData];
                }
            }else{
                model.selected = NO;
            }
        }
        /** 切换左侧 清空右侧列表选中的项目 */
        [_selectArr removeAllObjects];
        [_leftTbView reloadData];
    }
    if ([tableView isEqual:_rightTbView]) {
        if (_type == 1) {
            
        }
        if (_type == 2) {
            LanternPlanProModel * proModel = _rightDataSource[indexPath.row];
            proModel.selected = !proModel.selected;
           [_rightTbView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            if (proModel.selected) {
                [_selectArr addObject:proModel];
            }else{
                [_selectArr removeObject:proModel];
            }
        }
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:_rightTbView]) {
       return  self.lanternAddGoodsSectionHeaderView;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:_rightTbView]) {
        return 44.0f;
    }
    return 0;
}
#pragma mark ------网络请求------
/** 获取销售商品 */
- (void)requestGoodsData
{
    [_rightDataSource removeAllObjects];
    /** 储值卡 价格取 pro_12   其余价格取 pro_11  */
    [SaleListRequest requestSaleListJoinCode:_lanternPlanInfoModel.join_code?_lanternPlanInfoModel.join_code:@"" store_code:_lanternPlanInfoModel.store_code?_lanternPlanInfoModel.store_code:@"" type:_leftModel.type?_leftModel.type:@"pro" user_id:_lanternPlanInfoModel.user_id.integerValue resultBlock:^(SASaleListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            if (model.list.count == 0) {
                [_rightTbView.mj_footer endRefreshingWithNoMoreData];
            }
            for (int i = 0; i < model.list.count; i ++) {
                SaleModel * saleModel = model.list[i];
                LanternPlanProModel * proModel = [[LanternPlanProModel alloc] init];
                proModel.code = saleModel.code;
                proModel.name = saleModel.name;
                proModel.type = _leftModel.type;
                if ([_leftModel.type isEqualToString:@"stored_card"]) {
                    proModel.price = saleModel.price_list.pro_10.price;
                    proModel.num = saleModel.price_list.pro_10.num;
                }else{
                    proModel.price = saleModel.price_list.pro_11.price;
                    proModel.num = saleModel.price_list.pro_11.num;
                }
                [_rightDataSource addObject:proModel];
            }
            _rightDataSourceCopy = [[NSMutableArray alloc] init];
            [_rightDataSourceCopy addObjectsFromArray:_rightDataSource];
            [_rightTbView reloadData];
        }else{}
    }];
}
/** 获取服务产品 */
- (void)requestServiceData
{
    [_rightDataSource removeAllObjects];
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:_lanternPlanInfoModel.user_id?_lanternPlanInfoModel.user_id:@"" forKey:@"user_id"];
    /** 处方 */
    if ([_leftModel.type isEqualToString:@"pres"] || !_leftModel) {
        [SLRequest requestPresParams:param resultBlock:^(SLPresModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            if (isSuccess) {
                if (model.list.count == 0) {
                    [_rightTbView.mj_footer endRefreshingWithNoMoreData];
                }
                for (int i = 0; i < model.list.count; i++) {
                    SLPresListModel * presListModel = model.list[i];
                    LanternPlanProModel * proModel = [[LanternPlanProModel alloc] init];
                    proModel.name = presListModel.name;
                    proModel.type = @"pres";
                    proModel.isXH = @"1";
                    [_rightDataSource addObject:proModel];
                    /** 2018.1.17 只取处方名称  不取下级数组内数据 */
//                    for (int j = 0; j< presListModel.pro_list.count; j++) {
//                        Pro_List * pro = presListModel.pro_list[j];
//                        LanternPlanProModel * proModel = [[LanternPlanProModel alloc] init];
//                        proModel.price = pro.price;
//                        proModel.code = pro.pro_code;
//                        proModel.name = pro.pro_name;
//                        proModel.num = [NSString stringWithFormat:@"%ld",pro.num];
//                        proModel.type = @"pres";
//                        [_rightDataSource addObject:proModel];
//                    }
                }
            }
            _rightDataSourceCopy = [[NSMutableArray alloc] init];
            [_rightDataSourceCopy addObjectsFromArray:_rightDataSource];
            [_rightTbView reloadData];
        }];
    }
    /** 提卡 */
    if ([_leftModel.type isEqualToString:@"ti_card"]) {
        [SLRequest requesTtiCardParams:param resultBlock:^(SLTi_CardModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            if (isSuccess) {
                if (model.stored_card.count == 0) {
                    [_rightTbView.mj_footer endRefreshingWithNoMoreData];
                }
                for (int i = 0; i < model.stored_card.count; i++) {
                    SLStored_Card * pro = model.stored_card[i];
                    LanternPlanProModel * proModel = [[LanternPlanProModel alloc] init];
                    proModel.name = pro.name;
                    proModel.code = pro.stored_code;
                    proModel.price = pro.money;
                    proModel.type = @"ti_card";
                    proModel.isXH = @"1";
                    [_rightDataSource addObject:proModel];
                }
                _rightDataSourceCopy = [[NSMutableArray alloc] init];
                [_rightDataSourceCopy addObjectsFromArray:_rightDataSource];
                [_rightTbView reloadData];
            }else{}
        }];
    }
    /** 项目 */
    if ([_leftModel.type isEqualToString:@"pro"]) {
        [SLRequest requestServProParams:param resultBlock:^(SLServPro *model, BOOL isSuccess, NSDictionary *errorDic) {
            if (isSuccess) {
                if (model.list.count == 0) {
                    [_rightTbView.mj_footer endRefreshingWithNoMoreData];
                }
                for (int i = 0; i < model.list.count; i++) {
                    SLProModel * pro = model.list[i];
                    LanternPlanProModel * proModel = [[LanternPlanProModel alloc] init];
                    proModel.name = pro.name;
                    proModel.code = pro.pro_code;
                    proModel.price = [NSString stringWithFormat:@"%ld",pro.price];
                    proModel.num = [NSString stringWithFormat:@"%ld",pro.num];
                    proModel.type = @"pro";
                    proModel.isXH = @"1";
                    [_rightDataSource addObject:proModel];
                }
                _rightDataSourceCopy = [[NSMutableArray alloc] init];
                [_rightDataSourceCopy addObjectsFromArray:_rightDataSource];
                [_rightTbView reloadData];
            }else{}
            
        }];
    }
    /** 产品 */
    if ([_leftModel.type isEqualToString:@"goods"]) {
        [SLRequest requestServGoodsParams:param resultBlock:^(SLGoodsModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            if (isSuccess) {
                if (model.list.count == 0) {
                    [_rightTbView.mj_footer endRefreshingWithNoMoreData];
                }
                for (int i = 0; i < model.list.count; i++) {
                    SLGood * pro = model.list[i];
                    LanternPlanProModel * proModel = [[LanternPlanProModel alloc] init];
                    proModel.name = pro.name;
                    proModel.code = pro.goods_code;
                    proModel.price = [NSString stringWithFormat:@"%ld",pro.price];
                    proModel.num = [NSString stringWithFormat:@"%ld",pro.s_num];
                    proModel.type = @"goods";
                    proModel.isXH = @"1";
                    [_rightDataSource addObject:proModel];
                }
                _rightDataSourceCopy = [[NSMutableArray alloc] init];
                [_rightDataSourceCopy addObjectsFromArray:_rightDataSource];
                [_rightTbView reloadData];
                
            }else{}
        }];
    }
}
@end
