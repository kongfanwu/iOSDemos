//
//  XMHShoppingCartManager.m
//  xmh
//
//  Created by KFW on 2019/3/18.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHShoppingCartManager.h"
#import "SLS_ProModel.h"
#import "SLGoodListModel.h"
#import "SLSCourseExper.h"
#import "SLSCourseExper.h"
#import "XMHServiceProjectModel.h"
#import "XMHServiceGoodsModel.h"

#import "XMHShoppingCartBaseModel.h"
#import "XMHBillReListModel.h"
#import "SASaleListModel.h"

NSString * const kXMHShoppingCartUpdateNotification = @"kXMHShoppingCartUpdateNotification";

@interface XMHShoppingCartManager()
/** 数据源 */
@property (nonatomic, strong) NSMutableArray *dataArray;
/** 购物车中优惠券 */
@property (nonatomic, strong) NSMutableArray *ticketArray;

@end

@implementation XMHShoppingCartManager

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataArray = NSMutableArray.new;
        self.ticketArray = NSMutableArray.new;
    }
    return self;
}

#pragma mark - Public

/**
 添加购物车商品model

 @param model 特指4种类型。项目 SLS_Pro 产品 SLGoodModel 体验服务-项目 SLPro_ListM 体验服务-产品 SLGoods_ListM
 */
- (void)addModel:(id)model {
    if (!model) return;
    
    // 商品model 保留礼品卷model
    if ([model respondsToSelector:@selector(setTicketModel:)]) {
        if (((XMHExperienceOrderBaseModel *)model).ticketModel) {
            [self.ticketArray addObject:((XMHExperienceOrderBaseModel *)model).ticketModel];            
        }
    }
    
    // 服务单类型
    if ([model respondsToSelector:@selector(createOrderType)] && ((XMHShoppingCartBaseModel *)model).createOrderType == XMHCreateOrderTypeService) {
        // 深拷贝
        XMHShoppingCartBaseModel *newModel = [model mutableCopy];
        XMHShoppingCartBaseModel *oldModel = [self getOldModelShoppingModel:newModel];
        // 存在相同model
        if (oldModel) {
            // 只更新购买数量
            oldModel.selectCount = newModel.selectCount;
        }
        // 不存在相同model
        else {
            [_dataArray addObject:newModel];
        }
        [self computePrice];
    } else {
        // 深拷贝
        id newModel = [model mutableCopy];
        
        // 此方法如果 model 集合里是自定义对象，json->model 需要设置 YYModel 协议。考虑有些对象没采用此协议，或者以后添加有遗漏。故不采用此方法。
        //    NSDictionary *jsonModel = [model yy_modelToJSONObject];
        //    id newModel = [[model class] yy_modelWithJSON:jsonModel];
        
        // 恢复原始值
        [self resetModel:model];
        
        // 更新购物车id，用于区分重复添加的商品model
        if ([newModel isKindOfClass:[XMHShoppingCartBaseModel class]]) {
            [(XMHShoppingCartBaseModel *)newModel updateShoppingId];
        }
        
        [_dataArray addObject:newModel];
        [self computePrice];
    }
}

- (XMHShoppingCartBaseModel *)getOldModelShoppingModel:(XMHShoppingCartBaseModel *)newModel {
    __block XMHShoppingCartBaseModel *oldModel;
    [_dataArray enumerateObjectsUsingBlock:^(XMHShoppingCartBaseModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.id_code isEqualToString:newModel.id_code]) {
            oldModel = obj;
            *stop = YES;
        }
    }];
    return oldModel;
}

/**
 移除商品

 @param model 特指4种类型。项目 SLS_Pro 产品 SLGoodModel 体验服务-项目 SLPro_ListM 体验服务-产品 SLGoods_ListM
 */
- (void)deleteModel:(id)model {
    if (!model) return;
    if ([_dataArray containsObject:model]) {
        
        // 移除礼品卷model
        if ([model respondsToSelector:@selector(setTicketModel:)]) {
            if ([self.ticketArray containsObject:((XMHExperienceOrderBaseModel *)model).ticketModel]) {
                [self.ticketArray removeObject:((XMHExperienceOrderBaseModel *)model).ticketModel];
            }
        }
        
        [_dataArray removeObject:model];
        [self computePrice];
    }
}

/**
 移除所有
 */
- (void)clear {
    [_dataArray removeAllObjects];
    [self.ticketArray removeAllObjects];
    [self computePrice];
}

/**
 购物车更新发送通知
 */
- (void)postNotification {
    NSDictionary *userInfo = @{@"data" : _dataArray,
                               @"allPrice" : @(_allPrice).stringValue};
    [[NSNotificationCenter defaultCenter] postNotificationName:kXMHShoppingCartUpdateNotification object:self userInfo:userInfo];
}

/**
 计算价格
 */
- (void)computePrice {
    __block CGFloat allPrice = 0;
    __block CGFloat tikaPrice = 0;
    __block CGFloat originPrice = 0;
    
    // 计算体验订单，服务单价格
    [self computeExperienceServicePriceComplete:^(CGFloat aallPrice, CGFloat atikaPrice, CGFloat aoriginPrice) {
        allPrice = aallPrice;
        tikaPrice = atikaPrice;
        originPrice = aoriginPrice;
    }];
    // 计算回收置换价格
    allPrice += [self computeBillRecoverPrice];
    // 计算销售单价格
    allPrice += [self computeSalePrice];
    
    self.allPrice = allPrice;
    self.tiKaPrice = tikaPrice;
    self.originPrice = originPrice;
    
    [self postNotification];
}

/**
 返回最大可购买数量
 根据shoppingCartBaseModel code。获取购物车相同code 商品model。 selectCount 累加。 减去累加后的商品数量。返回最大可购买数量
 
 @param shoppingCartBaseModel 要购买商品model
 @return 返回最大可购买数量 NSIntegerMax：不存在最大购买数量 0:购买数量大于等于最大购买量
 */
- (NSInteger)maxNumShoppingCartBaseModel:(XMHShoppingCartBaseModel *)shoppingCartBaseModel {
    // NSIntegerMax：不存在最大购买数量
    if (shoppingCartBaseModel.num <= 0) {
        return NSIntegerMax;
    }
    
    NSInteger selectCount = 0;
    for (XMHShoppingCartBaseModel *model in self.dataArray) {
        // 过滤未继承 XMHShoppingCartBaseModel model
        if (![model isKindOfClass:[XMHShoppingCartBaseModel class]]) continue;
        // 相同产品 && 不包含要添加的产品
        if ([model.code isEqualToString:shoppingCartBaseModel.code] &&
            [model.ID isEqualToString:shoppingCartBaseModel.ID] &&
            model.shoppingId != shoppingCartBaseModel.shoppingId) {
            selectCount += model.selectCount;
        }
    }
    
    // 0:购买数量大于等于最大购买量
    if (selectCount >= shoppingCartBaseModel.num) {
        return 0;
    }
    
    return shoppingCartBaseModel.num - selectCount;
}
/**
 返回已选的优惠券,用于过滤
 
 @param saleModel SaleModel description
 @return 返回已选的优惠券数组
 */
- (NSMutableArray *)selectedTicketArrsBaseModel:(SaleModel *)saleModel
{
    NSMutableArray *ticketArrs = [NSMutableArray array];
    for (SaleModel *model in self.dataArray) {
        // 过滤未继承 XMHShoppingCartBaseModel model
        if (![model isKindOfClass:[SaleModel class]]) continue;
        // 相同产品 && 不包含要添加的产品
        if ([model.code isEqualToString:saleModel.code] &&
            [model.ID isEqualToString:saleModel.ID] ) {
            [ticketArrs safeAddObject:model.staicketModel];
        }
    }
    return ticketArrs;
}

- (NSInteger)maxNumShoppingCartBillRecoverBaseModel:(XMHShoppingCartBaseModel *)shoppingCartBaseModel
{
    if (shoppingCartBaseModel.num <= 0) {
        return 0;
    }
    
    NSInteger selectCount = 0;
    for (XMHShoppingCartBaseModel *model in self.dataArray) {
        // 过滤未继承 XMHShoppingCartBaseModel model
        if (![model isKindOfClass:[XMHShoppingCartBaseModel class]]) continue;
        // 相同产品 && 不包含要添加的商品
        if ([model.code isEqualToString:shoppingCartBaseModel.code] &&
            [model.ID isEqualToString:shoppingCartBaseModel.ID] &&
            model.shoppingId != shoppingCartBaseModel.shoppingId) {
            selectCount += model.selectCount;
        }
    }
    
    // 0:购买数量大于等于最大购买量
    if (selectCount >= shoppingCartBaseModel.num) {
        return 0;
    }
    
    return shoppingCartBaseModel.num - selectCount;
}
/**
 返回回收的金额
 根据shoppingCartBaseModel code。获取购物车相同code 商品model
 
 @param shoppingCartBaseModel 要购买商品model
 @return 返回回收的金额
 */
- (CGFloat)recoverPriceShoppingCartBaseModel:(XMHShoppingCartBaseModel *)shoppingCartBaseModel
{
    CGFloat recoverPrice= 0;
    for (XMHShoppingCartBaseModel *model in self.dataArray) {
        // 过滤未继承 XMHShoppingCartBaseModel model
        if (![model isKindOfClass:[XMHShoppingCartBaseModel class]]) continue;
        // 相同产品 && 不包含要添加的商品
        if ([model.code isEqualToString:shoppingCartBaseModel.code] &&
            [model.ID isEqualToString:shoppingCartBaseModel.ID] &&
            model.shoppingId != shoppingCartBaseModel.shoppingId) {
            if ([model isKindOfClass:[XMHBillReTimeModel class]]) {//时间卡
                XMHBillReTimeModel *timeModel = (XMHBillReTimeModel *)model;
                recoverPrice += [timeModel.inputPrice floatValue];
         
            }else if ([model isKindOfClass:[XMHBillReProModel class]]){//项目
                 XMHBillReProModel *proModel = (XMHBillReProModel *)model;
                recoverPrice += proModel.recoverPrice;
              
            }else if ([model isKindOfClass:[XMHBillReGoodsModel class]]){//产品
                XMHBillReGoodsModel *proModel = (XMHBillReGoodsModel *)model;
                recoverPrice += proModel.recoverPrice;

            }else if ([model isKindOfClass:[XMHBillReNumCardModel class]]){//任选卡
                XMHBillReNumCardModel *proModel = (XMHBillReNumCardModel *)model;
                recoverPrice += proModel.recoverPrice;//[proModel computeTotalPrice];

            }else if ([model isKindOfClass:[XMHBillReCardModel class]]){//储值卡
                XMHBillReCardModel *proModel = (XMHBillReCardModel *)model;
                recoverPrice += [proModel computeTotalPrice];
           
            }else if ([model isKindOfClass:[XMHBillReTicketModel class]]){//票券
                XMHBillReTicketModel *proModel = (XMHBillReTicketModel *)model;
                recoverPrice += proModel.recoverPrice;
                
            }
        }
    }
    return recoverPrice;
    
}
#pragma mark - Private

/**
 计算体验订单，服务单价格
 */
- (void)computeExperienceServicePriceComplete:(void(^)(CGFloat allPrice, CGFloat tikaPrice, CGFloat originPrice))cpmplete {
    CGFloat allPrice = 0;
    CGFloat tikaPrice = 0;
    CGFloat originPrice = 0;
    for (int i = 0; i < _dataArray.count; i++) {
        id model = _dataArray[i];
        /* 体验单 */
        // 项目
        if ([model isKindOfClass:[SLS_Pro class]]) {
            SLS_Pro *projectModel = (SLS_Pro *)model;
            allPrice += [projectModel computeTotalPrice];
            originPrice += [projectModel computeOriginPrice];
        }
        // 产品
        else if ([model isKindOfClass:[SLGoodModel class]]) {
            SLGoodModel *goodModel = (SLGoodModel *)model;
            allPrice += [goodModel computeTotalPrice];
            originPrice += [goodModel computeOriginPrice];
        }
        // SLPro_ListM SLGoods_ListM
        // 体验服务-项目
        else if ([model isKindOfClass:[SLPro_ListM class]]) {
            SLPro_ListM *projectModel = (SLPro_ListM *)model;
            CGFloat price = [projectModel computeTotalPrice];
            allPrice += price;
            tikaPrice += price;
            originPrice += [projectModel computeOriginPrice];
        }
        // 体验服务-产品
        else if ([model isKindOfClass:[SLGoods_ListM class]]) {
            SLGoods_ListM *goodModel = (SLGoods_ListM *)model;
            CGFloat price = [goodModel computeTotalPrice];
            allPrice += price;
            tikaPrice += price;
            originPrice += [goodModel computeOriginPrice];
        }
        
        /* 服务单 */
        // 项目
        else if ([model isKindOfClass:[XMHServiceProjectModel class]]) {
            XMHServiceProjectModel *projectModel = (XMHServiceProjectModel *)model;
            CGFloat price = [projectModel computeTotalPrice];
            allPrice += price;
            originPrice += price;
            
            // 提卡金额
            if (projectModel.type == XMHServiceOrderTypeTiKaStordeCar || projectModel.type == XMHServiceOrderTypeTiKaNumCar || projectModel.type == XMHServiceOrderTypeTiKaTimeCar) {
                tikaPrice += price;
            }
        }
        // 产品
        else if ([model isKindOfClass:[XMHServiceGoodsModel class]]) {
            XMHServiceGoodsModel *projectModel = (XMHServiceGoodsModel *)model;
            CGFloat price = [projectModel computeTotalPrice];
            allPrice += price;
            originPrice += price;
            
            // 提卡金额
            if (projectModel.type == XMHServiceOrderTypeTiKaStordeCar || projectModel.type == XMHServiceOrderTypeTiKaNumCar || projectModel.type == XMHServiceOrderTypeTiKaTimeCar) {
                tikaPrice += price;
            }
        }
    }
    
    if (cpmplete) cpmplete(allPrice, tikaPrice, originPrice);
}

/**
 计算回收置换价格
 */
- (CGFloat)computeBillRecoverPrice
{
    CGFloat allPrice = 0;
    for (int i = 0; i < self.dataArray.count; i++) {
        id model = self.dataArray[i];
        if ([model isKindOfClass:[XMHBillReProModel class]]) {
            XMHBillReProModel *pro = (XMHBillReProModel *)model;
            allPrice += pro.recoverPrice;//[pro computeTotalPrice];
        }
        if ([model isKindOfClass:[XMHBillReGoodsModel class]]) {//产品
            XMHBillReGoodsModel *pro = (XMHBillReGoodsModel *)model;

            allPrice += pro.recoverPrice;//[pro computeTotalPrice];

        }else if ([model isKindOfClass:[XMHBillReCardModel class]]){//储值卡
            XMHBillReCardModel *pro = (XMHBillReCardModel *)model;
            allPrice += [pro computeTotalPrice];
        }
        else if ([model isKindOfClass:[XMHBillReTimeModel class]]){//时间卡
            XMHBillReTimeModel *pro = (XMHBillReTimeModel *)model;
            allPrice += [pro computeTotalPrice];

        }
        else if ([model isKindOfClass:[XMHBillReNumCardModel class]]){//任选卡
            XMHBillReNumCardModel *pro = (XMHBillReNumCardModel *)model;
            allPrice += pro.recoverPrice;//[pro computeTotalPrice];

        }
        else if ([model isKindOfClass:[XMHBillReTicketModel class]]){//票券
            XMHBillReTicketModel *pro = (XMHBillReTicketModel *)model;
            allPrice += pro.recoverPrice;//[pro computeTotalPrice];

        }
    }
    return allPrice;
}

/**
 计算销售单价格
 */
- (CGFloat)computeSalePrice {
    CGFloat allPrice = 0;
    for (int i = 0; i < self.dataArray.count; i++) {
         SaleModel *model = self.dataArray[i];
        if ([model isKindOfClass:[SaleModel class]]) {
            allPrice += [model computeTotalPrice];
        }
    }
    return allPrice;
}

/**
 重置model 选责数量
 */
- (void)resetModel:(id)model {
    // 服务单 SLS_Pro SLPro_ListM SLGoodModel SLGoods_ListM XMHServiceProjectModel XMHServiceGoodsModel 重置
    if ([model respondsToSelector:@selector(reset)]) {
        [model reset];
    }
}

@end
