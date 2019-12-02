//
//  XMHServiceOrderVC.m
//  xmh
//
//  Created by KFW on 2019/3/26.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHServiceOrderVC.h"
#import "XMHCustomerInfoView.h"
#import "XMHShoppingCartView.h"
#import "XMHSegmentVCManager.h"
#import "XMHSegmentVCModel.h"
#import "XMHExperienceOrderContentVC.h"
#import "XMHExperienceOrderRequest.h"
#import "XMHExperienceOrderContentVC.h"
#import "XMHOrderSearchCustomerVC.h"
#import "CustomerListModel.h"
#import "SLSCourseExper.h"
#import "SLS_ProModel.h"
#import "SLGoodListModel.h"
#import "SLSCourseExper.h"
#import "XMHShoppingCartManager.h"
#import "XMHServiceOrderListVC.h"
#import "XMHExperienceOrderRecordVC.h"
#import "Networking.h"
#import "XMHServiceRequest.h"
#import "XMHServiceChuFangModel.h"
#import "XMHServiceGoodsModel.h"
#import "XMHServiceTiKaModel.h"
#import "XMHServiceOrderChuFangContentVC.h"
#import "XMHServiceOrderStoredCarContentVC.h"
#import "XMHServiceOrderNumCarContentVC.h"
#import "XMHServiceOrderTimeCarContentVC.h"
#import "XMHServiceOrderProjectGoodsContentVC.h"

@interface XMHServiceOrderVC ()
/** <##> */
@property (nonatomic, strong) XMHCustomerInfoView *customerInfoView;
/** <##> */
@property (nonatomic, strong) UIView *contentView;
/** <##> */
@property (nonatomic, strong) XMHShoppingCartView *shoppingCart;
/** <##> */
@property (nonatomic, strong) XMHSegmentVCManager *segmentVCManager;
/** 选择用户model */
@property (nonatomic, strong) CustomerModel *selectUserModel;
/** 搜索数据源 */
@property (nonatomic, strong) NSMutableArray *searchDataArray;
/** <##> */
@property (nonatomic, strong) NSArray *chufangList, *projectList, *goodsList;
/** 处方，项目，产品集合 体验卡里项目*/
@property (nonatomic, strong) NSMutableArray *allDataArray;
@end

@implementation XMHServiceOrderVC

- (void)dealloc
{
    [XMHShoppingCartManager.sharedInstance clear];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shoppingCartUpdateNotification:) name:kXMHShoppingCartUpdateNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;
    
    [self.navView setNavViewTitle:@"服务制单" backBtnShow:YES];
    self.navView.backgroundColor = kBtn_Commen_Color;
    
    self.customerInfoView = [[XMHCustomerInfoView alloc] init];
    [self.view addSubview:_customerInfoView];
    [_customerInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(KNaviBarHeight);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(63);
    }];
    
    WeakSelf
    [_customerInfoView setSearchBlock:^(XMHCustomerInfoView * _Nonnull customerInfoView) {
        // 搜索顾客
        XMHOrderSearchCustomerVC *orderSearchCustomerVC = XMHOrderSearchCustomerVC.new;
        [weakSelf presentViewController:orderSearchCustomerVC animated:YES completion:nil];
        [orderSearchCustomerVC setSelectedCustomer:^(CustomerModel * _Nonnull model) {
            weakSelf.selectUserModel = model;
            [customerInfoView configUserName:[NSString stringWithFormat:@"%@ (%@)", model.uname, [model safeMobile]]];
            [weakSelf loadData];
        }];
    }];
    
    [_customerInfoView setDeleteUserBlock:^(XMHCustomerInfoView * _Nonnull customerInfoView) {
        weakSelf.selectUserModel = nil;
        [weakSelf configDataChuFangList:nil projectList:nil goodsList:nil tiKaModel:nil];
        [XMHShoppingCartManager.sharedInstance clear];
    }];
    
    // 购物车
    self.shoppingCart = [[XMHShoppingCartView alloc] init];
    [self.view addSubview:_shoppingCart];
    [_shoppingCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(49);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
    }];
    // 支付
    [_shoppingCart setShoppingCart:^(NSMutableArray * _Nonnull modelArr) {
        // 服务制单
        XMHServiceOrderListVC *vc = XMHServiceOrderListVC.new;
        vc.createOrderType = XMHCreateOrderTypeService;
        vc.selectUserModel = weakSelf.selectUserModel;
        // 取与购物相同指针对象的集合
        vc.modelArray = XMHShoppingCartManager.sharedInstance.dataArray;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    // 服务内容
    self.contentView = [[UIView alloc] init];
    _contentView.backgroundColor = UIColor.whiteColor;
    [self.view insertSubview:_contentView belowSubview:_shoppingCart];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_customerInfoView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(_shoppingCart.mas_top);
    }];
    
    self.segmentVCManager = XMHSegmentVCManager.new;
    [self addChildViewController:_segmentVCManager];
    _segmentVCManager.view.frame = _contentView.bounds;
    [_contentView addSubview:_segmentVCManager.view];
    
    [self configDataChuFangList:nil projectList:nil goodsList:nil tiKaModel:nil];
    
    if (self.selectUserModel) {
        [_customerInfoView configUserName:[NSString stringWithFormat:@"%@ (%@)", self.selectUserModel.uname, [self.selectUserModel safeMobile]]];
        [self loadData];
    }
}

- (void)loadData {
    [XMHServiceRequest requestServiceListWithUserId:@(_selectUserModel.uid).stringValue resultBlock:^(BOOL isSuccess, BaseModel * _Nonnull chuFangModel, BaseModel * _Nonnull tiKaModel, BaseModel * _Nonnull goodsModel, BaseModel * _Nonnull projectModel) {
        NSLog(@"%@", chuFangModel);
        NSArray *chufangList = [NSArray yy_modelArrayWithClass:[XMHServiceChuFangModel class] json:chuFangModel.data[@"list"]];
        self.chufangList = chufangList;
        NSArray *projectList = [NSArray yy_modelArrayWithClass:[XMHServiceProjectModel class] json:projectModel.data[@"list"]];
        self.projectList = projectList;
        NSArray *goodsList = [NSArray yy_modelArrayWithClass:[XMHServiceGoodsModel class] json:goodsModel.data[@"list"]];
        self.goodsList = goodsList;
        XMHServiceTiKaModel *atiKaModel = [XMHServiceTiKaModel yy_modelWithJSON:tiKaModel.data];
        
        [self configDataChuFangList:chufangList projectList:projectList goodsList:goodsList tiKaModel:atiKaModel];
        
        // 保留所有项目model
        self.allDataArray = NSMutableArray.new;
        for (XMHServiceChuFangModel *serviceChuFangModel in chufangList) {
            [_allDataArray addObjectsFromArray:serviceChuFangModel.pro_list];
        }
        [_allDataArray addObjectsFromArray:projectList];
        [_allDataArray addObjectsFromArray:goodsList];
    }];
}

- (void)configDataChuFangList:(NSArray *)chufangList projectList:(NSArray *)projectList goodsList:(NSArray *)goodsList tiKaModel:(XMHServiceTiKaModel *)tiKaModel {
    // 收集搜索数据源
    self.searchDataArray = NSMutableArray.new;
    
    // model绑定类型
    [chufangList enumerateObjectsUsingBlock:^(XMHServiceChuFangModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.type = XMHServiceOrderTypeChuFang;
        [obj.pro_list enumerateObjectsUsingBlock:^(XMHServiceProjectModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.createOrderType = XMHCreateOrderTypeService;
            obj.type = XMHServiceOrderTypeChuFang;
            obj.numUpdate = obj.num - [obj.num1 integerValue];
        }];
        
        // 处方
        if (obj.pro_list.count) [self.searchDataArray addObjectsFromArray:obj.pro_list];
    }];
    
    [projectList enumerateObjectsUsingBlock:^(XMHServiceProjectModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.createOrderType = XMHCreateOrderTypeService;
        obj.type = XMHServiceOrderTypeProject;
        obj.numUpdate = obj.num;
    }];
    // 项目服务
    if (projectList.count) [_searchDataArray addObjectsFromArray:projectList];
    
    [goodsList enumerateObjectsUsingBlock:^(XMHServiceGoodsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.createOrderType = XMHCreateOrderTypeService;
        obj.type = XMHServiceOrderTypeGoods;
        obj.numUpdate = obj.num;
    }];
    // 产品服务
    if (goodsList.count) [_searchDataArray addObjectsFromArray:goodsList];
    
    NSMutableArray *dataArray = NSMutableArray.new;

    // 选择用户后可编辑
    BOOL edit = NO;
    if (chufangList.count || projectList.count || goodsList.count || tiKaModel) {
        edit = YES;
    }
    // 购物车是否可编辑
    _shoppingCart.isEdit = edit;
    
    // 1 获取提卡服务组织后的集合tiKaArray  2 获取提卡服务下所有项目 产品，搜索用
    __block NSUInteger allProGoodsListCount = 0;
    NSArray *tiKaArray = [self childListTiKaModel:tiKaModel block:^(NSMutableArray *allProGoodsList) {
        allProGoodsListCount = allProGoodsList.count;
        [self.searchDataArray addObjectsFromArray:allProGoodsList];
    }];
    
   // if (chufangList.count) {
        XMHSegmentVCModel *model1 = XMHSegmentVCModel.new;
        [dataArray addObject:model1];
        model1.text = @"处方服务";
        model1.select = YES;
        model1.edit = edit;
        //model.badge = chufangList.count;
        
        XMHServiceOrderChuFangContentVC *vc1 = XMHServiceOrderChuFangContentVC.new;
        vc1.type = XMHServiceOrderTypeChuFang;
        vc1.modelArray = chufangList;
        vc1.edit = edit;
        vc1.searchDataArray = self.searchDataArray;
        model1.contentVC = vc1;
   // }
    
   // if (tiKaArray.count) {
        XMHSegmentVCModel *model2 = XMHSegmentVCModel.new;
        model2.text = @"提卡服务";
        model2.edit = edit;
        model2.childList = tiKaArray;
        model2.contentVC = XMHSegmentVCManagerEmptyDataVC.new;
    
       // model.badge = allProGoodsListCount;
        [dataArray addObject:model2];
   // }
    
  //  if (projectList.count) {
        XMHSegmentVCModel *model3 = XMHSegmentVCModel.new;
        [dataArray addObject:model3];
        model3.text = @"项目服务";
        model3.edit = edit;
       // model.badge = projectList.count;
        XMHServiceOrderProjectGoodsContentVC *vc3 = XMHServiceOrderProjectGoodsContentVC.new;
        vc3.type = XMHServiceOrderTypeProject;
        vc3.projectList = projectList;
        vc3.searchDataArray = self.searchDataArray;
        model3.contentVC = vc3;
   // }
    
    //if (goodsList.count) {
        XMHSegmentVCModel *model4 = XMHSegmentVCModel.new;
        [dataArray addObject:model4];
        model4.text = @"产品服务";
        model4.edit = edit;
       // model.badge = goodsList.count;
        XMHServiceOrderProjectGoodsContentVC *vc4 = XMHServiceOrderProjectGoodsContentVC.new;
        vc4.type = XMHServiceOrderTypeGoods;
        vc4.goodsList = goodsList;
        vc4.searchDataArray = self.searchDataArray;
        model4.contentVC = vc4;
    //}
    
    // 默认选中第一个
    ((XMHSegmentVCModel *)dataArray.firstObject).select = YES;
    
    _segmentVCManager.dataArray = dataArray;
}

/**
 配置体验服务子集数据
 @param block allProGoodsList 提卡下所有项目 产品集合，用于搜索
 */
- (NSArray *)childListTiKaModel:(XMHServiceTiKaModel *)tiKaModel block:(void(^)(NSMutableArray *allProGoodsList))block {
    NSMutableArray *dataArray = NSMutableArray.new;
    NSMutableArray *allProGoodsList = NSMutableArray.new;
    XMHSegmentVCModel *model;
    
    // 储值卡
    for (int i = 0; i < tiKaModel.stored_cardList.count; i++) {
        XMHStoredCard *storedCardModel = tiKaModel.stored_cardList[i];
        
        model = XMHSegmentVCModel.new;
        [dataArray addObject:model];
        model.text = storedCardModel.name;
        model.badge = storedCardModel.pro_list.count + storedCardModel.goods_list.count;
        
        XMHServiceOrderStoredCarContentVC *vc = XMHServiceOrderStoredCarContentVC.new;
        vc.type = XMHServiceOrderTypeTiKaStordeCar;
        vc.storedCardModel = storedCardModel;
        vc.searchDataArray = self.searchDataArray; // 先赋值，后添加，引用类型。
        model.contentVC = vc;
        
        // model绑定类型
        [storedCardModel.pro_list enumerateObjectsUsingBlock:^(XMHServiceProjectModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.createOrderType = XMHCreateOrderTypeService;
            obj.type = XMHServiceOrderTypeTiKaStordeCar;
            obj.ID = storedCardModel.ID; // 储值卡id赋值给具体项目id
        }];
        [storedCardModel.goods_list enumerateObjectsUsingBlock:^(XMHServiceGoodsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.createOrderType = XMHCreateOrderTypeService;
            obj.type = XMHServiceOrderTypeTiKaStordeCar;
            obj.ID = storedCardModel.ID; // 储值卡id赋值给具体项目id
        }];
        
        [allProGoodsList addObjectsFromArray:storedCardModel.pro_list];
        [allProGoodsList addObjectsFromArray:storedCardModel.goods_list];
    }
    
    // 任选卡
    for (int i = 0; i < tiKaModel.card_numList.count; i++) {
        XMHNumCard *numCarModel = tiKaModel.card_numList[i];
        numCarModel.numUpdate = numCarModel.num; // 变动值保留
        
        model = XMHSegmentVCModel.new;
        [dataArray addObject:model];
        model.text = numCarModel.name;
        model.badge = numCarModel.pro_list.count + numCarModel.goods_list.count;
        
        XMHServiceOrderNumCarContentVC *vc = XMHServiceOrderNumCarContentVC.new;
        vc.type = XMHServiceOrderTypeTiKaNumCar;
        vc.numCarModel = numCarModel;
        vc.searchDataArray = self.searchDataArray;
        model.contentVC = vc;
        
        // model绑定类型
        [numCarModel.pro_list enumerateObjectsUsingBlock:^(XMHServiceProjectModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.createOrderType = XMHCreateOrderTypeService;
            obj.type = XMHServiceOrderTypeTiKaNumCar;
            obj.ID = numCarModel.ID; // 储值卡id赋值给具体项目id
        }];
        [numCarModel.goods_list enumerateObjectsUsingBlock:^(XMHServiceGoodsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.createOrderType = XMHCreateOrderTypeService;
            obj.type = XMHServiceOrderTypeTiKaNumCar;
            obj.ID = numCarModel.ID; // 储值卡id赋值给具体项目id
        }];
        
        [allProGoodsList addObjectsFromArray:numCarModel.pro_list];
        [allProGoodsList addObjectsFromArray:numCarModel.goods_list];
    }
    
    // 时间卡
    for (int i = 0; i < tiKaModel.card_timeList.count; i++) {
        XMHTimeCard *timeCarModel = tiKaModel.card_timeList[i];
        
        model = XMHSegmentVCModel.new;
        [dataArray addObject:model];
        model.text = timeCarModel.name;
        model.badge = timeCarModel.pro_list.count + timeCarModel.goods_list.count;
        
        XMHServiceOrderTimeCarContentVC *vc = XMHServiceOrderTimeCarContentVC.new;
        vc.type = XMHServiceOrderTypeTiKaTimeCar;
        vc.timeCarModel = timeCarModel;
        vc.searchDataArray = self.searchDataArray;
        model.contentVC = vc;
        
        // model绑定类型
        [timeCarModel.pro_list enumerateObjectsUsingBlock:^(XMHServiceProjectModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.createOrderType = XMHCreateOrderTypeService;
            obj.type = XMHServiceOrderTypeTiKaTimeCar;
            obj.ID = timeCarModel.ID; // 储值卡id赋值给具体项目id
        }];
        [timeCarModel.goods_list enumerateObjectsUsingBlock:^(XMHServiceGoodsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.createOrderType = XMHCreateOrderTypeService;
            obj.type = XMHServiceOrderTypeTiKaTimeCar;
            obj.ID = timeCarModel.ID; // 储值卡id赋值给具体项目id
        }];
        
        [allProGoodsList addObjectsFromArray:timeCarModel.pro_list];
        [allProGoodsList addObjectsFromArray:timeCarModel.goods_list];
    }
    
    // 默认选中第一个
    ((XMHSegmentVCModel *)dataArray.firstObject).select = YES;
    
    if (block) block(allProGoodsList);
    
    return dataArray;
}

/**
 配置用户并搜索数据
 */
- (void)confitSelectUserModel:(CustomerModel *)selectUserModel {
    self.selectUserModel = selectUserModel;
}

#pragma mark - Notification

- (void)shoppingCartUpdateNotification:(NSNotification *)not {
    /**
     购物车移除项目或更改购买数量。改变列表model 的购买数量 selectCount 和剩余数量 numUpdate
     并发送刷新通知
     */
    
    // 购物车已经移除的项目，恢复默认值。由于不知那个项目移除了。所以全部恢复默认
    for (XMHServiceProjectModel *listModel in _searchDataArray) {
        listModel.numUpdate = listModel.num;
//        [listModel reset]; //
        listModel.selectCount = listModel.defaultNum;
    }
    
    NSArray *dataArray = not.userInfo[@"data"];
    // 寻找购物车相同的项目。累加项目购买的数量 selectCount
    NSMutableDictionary *shoppingDic = NSMutableDictionary.new;
    for (id model in dataArray) {
        if ([model isKindOfClass:[XMHServiceProjectModel class]] || [model isKindOfClass:[XMHServiceGoodsModel class]] || [model isKindOfClass:[XMHServiceChuFangModel class]]) {
            XMHServiceProjectModel *shoppingModel = (XMHServiceProjectModel *)model;
            NSString *shoppingId = shoppingModel.id_code;//[NSString stringWithFormat:@"%@%@", shoppingModel.ID, shoppingModel.code];
            
            if (shoppingDic[shoppingId] == nil) {
                shoppingDic[shoppingId] = @(shoppingModel.selectCount);
            } else {
                NSInteger selectCount = [shoppingDic[shoppingId] integerValue] + shoppingModel.selectCount;
                shoppingDic[shoppingId] = @(selectCount);
            }
        }
    }
    
    // 设置cell剩余购买数量
    [shoppingDic enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull shoppingId, NSNumber * _Nonnull selectCount, BOOL * _Nonnull stop) {
        for (XMHServiceProjectModel *listModel in _searchDataArray) {
            NSString *listId = listModel.id_code;// [NSString stringWithFormat:@"%@%@", listModel.ID, listModel.code];
            // 购物车里有此项目，只是修改了购买数量。修改列表商品的总数
            if ([shoppingId isEqualToString:listId]) {
                // 剩余数量 = 总数 - 购物车相同项目购买数量之和
                listModel.numUpdate = listModel.num - selectCount.integerValue;
                // 将购物车购买数量selectCount赋值给列表相同model selectCount。需求： 购物车更新selectCount数量，列表也要更新。
                listModel.selectCount = selectCount.integerValue;
            }
        }
    }];
    
    // 更新当前显示的vc tableView
    [[NSNotificationCenter defaultCenter] postNotificationName:XMHReloadDataNotification object:nil];
}

@end
