//
//  XMHComputeOredrModel.m
//  xmh
//
//  Created by KFW on 2019/3/21.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHComputeOredrModel.h"
#import "SLS_ProModel.h"
#import "SLGoodListModel.h"
#import "SLSCourseExper.h"
#import "XMHServiceProjectModel.h"
#import "XMHServiceGoodsModel.h"

@interface XMHComputeOredrModel()
/** 项目列表 */
@property (nonatomic, strong) NSMutableArray *projectList;
/** 产品列表 */
@property (nonatomic, strong) NSMutableArray *goodsList;
/** 体验 项目产品列表 */
@property (nonatomic, strong) NSMutableArray *experienceList;

/** 处方 */
@property (nonatomic, strong) NSMutableArray *chufangList;
/** 储存卡 */
@property (nonatomic, strong) NSMutableArray *stordeCarList;
/** 任选卡 */
@property (nonatomic, strong) NSMutableArray *numCarList;
/** 时间卡 */
@property (nonatomic, strong) NSMutableArray *timeCarList;
@end

@implementation XMHComputeOredrModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.projectList = NSMutableArray.new;
        self.goodsList = NSMutableArray.new;
        self.experienceList = NSMutableArray.new;
        
        self.chufangList = NSMutableArray.new;
        self.stordeCarList = NSMutableArray.new;
        self.numCarList = NSMutableArray.new;
        self.timeCarList = NSMutableArray.new;
    }
    return self;
}

- (void)setModelArray:(NSMutableArray *)modelArray {
    _modelArray = modelArray;
    
    // 根据商品类型分类
    [_projectList removeAllObjects];
    [_goodsList removeAllObjects];
    [_experienceList removeAllObjects];
    
    [_chufangList removeAllObjects];
    [_stordeCarList removeAllObjects];
    [_numCarList removeAllObjects];
    [_timeCarList removeAllObjects];
    
    for (id model in _modelArray) {
        if ([model respondsToSelector:@selector(type)]) {
            NSInteger type = ((SLS_Pro *)model).type;
            // 体验服务
            if (type == XMHExperienceOrderTypeProject) {
                [_projectList addObject:model];
            } else if (type == XMHExperienceOrderTypeGoods) {
                [_goodsList addObject:model];
            } else if (type == XMHExperienceOrderTypeExperience) {
                [_experienceList addObject:model];
            }
            
            // 服务单
            else if (type == XMHServiceOrderTypeChuFang) {
                [_chufangList addObject:model];
            } else if (type == XMHServiceOrderTypeTiKaStordeCar) {
                [_stordeCarList addObject:model];
            } else if (type == XMHServiceOrderTypeTiKaNumCar) {
                [_numCarList addObject:model];
            } else if (type == XMHServiceOrderTypeTiKaTimeCar) {
                [_timeCarList addObject:model];
            } else if (type == XMHServiceOrderTypeProject) {
                [_projectList addObject:model];
            } else if (type == XMHServiceOrderTypeGoods) {
                [_goodsList addObject:model];
            }
        }
    }
}

/**
 获取技师列表。剔除不同产品一个技师服务情况
 
 @return 技师集合
 */
- (NSMutableArray *)jiShiList {
    if (_jiShiList) {
        return _jiShiList;
    }
    NSMutableArray *allJiShiList = NSMutableArray.new;
    for (SLS_Pro *model in self.modelArray) {
        [allJiShiList addObjectsFromArray:model.jiShiList];
    }
    
    NSMutableArray *jiShiList = NSMutableArray.new;
    for (MLJiShiModel *jishiModel in allJiShiList) {
        if (![self isExistJiShiModel:jishiModel jiShiList:jiShiList]) {
            [jiShiList addObject:jishiModel];
        }
    }
    return jiShiList;
}

/**
 技师集合是否存在技师model
 
 @param jishiModel 技师mdoel
 @param jiShiList 集合
 @return YES 存在，
 */
- (BOOL)isExistJiShiModel:(MLJiShiModel *)jishiModel jiShiList:(NSArray *)jiShiList {
    __block BOOL exist = NO;
    for (MLJiShiModel *obj in jiShiList) {
        if (obj.ID == jishiModel.ID) {
            exist = YES;
        }
        if (exist) return exist;
    }
    return exist;
}

/**
 获取项目参数集合

 @return 项目参数
 */
- (NSMutableArray *)getProjectParamList {
    NSMutableArray *list = NSMutableArray.new;
    for (SLS_Pro *model in _projectList) {
        NSMutableDictionary *param = NSMutableDictionary.new;
        [list addObject:param];
        param[@"id"] = model.ID; // 项目id
        param[@"num"] = @(model.selectCount); // 数量
        param[@"price"] = @([model.inputPrice floatValue]); // 项目的单价
        param[@"pro_code"] = model.pro_code; // 项目编码
        param[@"ticket_coupon_id"] = model.ticketModel.ID; // 礼品券购买id
        
        NSMutableArray *jishiPhoneList = NSMutableArray.new;
        for (MLJiShiModel *jishiModel in model.jiShiList) {
            [jishiPhoneList addObject:jishiModel.account];
        }
        param[@"jis"] = jishiPhoneList; // 搜索技师的账号
    }
    return list.count ? list : nil;
}

/**
 获取产品参数集合
 
 @return 项目参数
 */
- (NSMutableArray *)getGoodsParamList {
    NSMutableArray *list = NSMutableArray.new;
    for (SLGoodModel *model in _goodsList) {
        NSMutableDictionary *param = NSMutableDictionary.new;
        [list addObject:param];
        param[@"id"] = model.ID; // 项目id
        param[@"num"] = @(model.selectCount); // 数量
        param[@"price"] = model.inputPrice; // 项目的单价
        param[@"goods_code"] = model.goods_code; // 项目编码
        param[@"is_end"] = @(model.is_end); // 产品是否用完，1是，0否
        param[@"ticket_coupon_id"] = model.ticketModel.ID; // 礼品券购买id
        
        NSMutableArray *jishiPhoneList = NSMutableArray.new;
        for (MLJiShiModel *jishiModel in model.jiShiList) {
            [jishiPhoneList addObject:jishiModel.account];
        }
        param[@"jis"] = jishiPhoneList; // 搜索技师的账号
    }
    return list.count ? list : nil;
}

/**
 获取体现卡 项目 产品 参数集合
 
 @return 项目 产品 参数集合
 */
- (NSMutableArray *)getExperienceParamList {
    NSMutableArray *list = NSMutableArray.new;
    for (id model in _experienceList) {
        // 项目
        if ([model isKindOfClass:[SLPro_ListM class]]) {
            SLPro_ListM *aModel = (SLPro_ListM *)model;
            NSMutableDictionary *param = NSMutableDictionary.new;
            [list addObject:param];
//            param[@"id"] = @(aModel.ID); // 项目id
            param[@"num"] = @(aModel.selectCount); // 数量
            param[@"price"] = @([aModel.inputPrice floatValue]); // 项目的单价
            param[@"pro_code"] = aModel.pro_code; // 项目编码
            param[@"course_exper_code"] = aModel.course_code; // 特惠卡code
            param[@"course_exper_id"] = aModel.ID; // 特惠卡 id
            
            NSMutableArray *jishiPhoneList = NSMutableArray.new;
            for (MLJiShiModel *jishiModel in aModel.jiShiList) {
                [jishiPhoneList addObject:jishiModel.account];
            }
            param[@"jis"] = jishiPhoneList; // 搜索技师的账号
        }
        // 产品
        else if ([model isKindOfClass:[SLGoods_ListM class]]) {
            SLGoods_ListM *aModel = (SLGoods_ListM *)model;
            NSMutableDictionary *param = NSMutableDictionary.new;
            [list addObject:param];
//            param[@"id"] = @(aModel.ID); // 项目id
            param[@"num"] = @(aModel.selectCount); // 数量
            param[@"price"] = aModel.inputPrice; // 项目的单价
            param[@"goods_code"] = aModel.goods_code; // 项目编码
            param[@"is_end"] = @(aModel.is_end); // 产品是否用完，1是，0否
            param[@"course_exper_code"] = aModel.course_code; // 特惠卡code
            param[@"course_exper_id"] = aModel.ID; // 特惠卡 id
            
            NSMutableArray *jishiPhoneList = NSMutableArray.new;
            for (MLJiShiModel *jishiModel in aModel.jiShiList) {
                [jishiPhoneList addObject:jishiModel.account];
            }
            param[@"jis"] = jishiPhoneList; // 搜索技师的账号
        }
    }
    return list.count ? list : nil;
}

/**
 获取处方参数集合
 
 @return 项目参数
 */
- (NSMutableArray *)getChuFangParamList {
    NSMutableArray *list = NSMutableArray.new;
    for (XMHServiceProjectModel *model in _chufangList) {
        NSMutableDictionary *param = NSMutableDictionary.new;
        [list addObject:param];
        param[@"id"] = model.ID; // 项目id
        param[@"num"] = @(model.selectCount); // 数量
        param[@"price"] = @([model.price floatValue]); // 项目的单价
        param[@"pro_code"] = model.pro_code; // 项目编码
        
        NSMutableArray *jishiPhoneList = NSMutableArray.new;
        for (MLJiShiModel *jishiModel in model.jiShiList) {
            [jishiPhoneList addObject:jishiModel.account];
        }
        param[@"jis"] = jishiPhoneList; // 搜索技师的账号
    }
    return list.count ? list : nil;
}

/**
 获取提卡-储值卡参数集合
 
 @return 项目参数
 */
- (NSMutableArray *)getStoredCardParamList {
    return [self getTiKaParamList:_stordeCarList];
}

/**
 获取提卡-任选卡参数集合
 
 @return 项目参数
 */
- (NSMutableArray *)getNumCardParamList {
    return [self getTiKaParamList:_numCarList];
}

/**
 获取提卡-时间卡参数集合
 
 @return 项目参数
 */
- (NSMutableArray *)getTimeCardParamList {
    return [self getTiKaParamList:_timeCarList];
}

/**
 拼接提卡总参数
 */
- (NSMutableArray *)getTiKaParamList:(NSArray *)array {
    NSMutableArray *list = NSMutableArray.new;
    for (XMHServiceProjectModel *model in array) {
        NSMutableDictionary *param = NSMutableDictionary.new;
        [list addObject:param];
        param[@"id"] = model.ID; // 项目id
        param[@"num"] = @(model.selectCount); // 数量
        param[@"price"] = @([model.price floatValue]); // 项目的单价
        if ([model isKindOfClass:[XMHServiceProjectModel class]]) {
            param[@"pro_code"] = model.pro_code; // 项目编码
        } else if ([model isKindOfClass:[XMHServiceGoodsModel class]]) {
            param[@"goods_code"] = ((XMHServiceGoodsModel *)model).goods_code; // 产品编码
        }
        
        NSMutableArray *jishiPhoneList = NSMutableArray.new;
        for (MLJiShiModel *jishiModel in model.jiShiList) {
            [jishiPhoneList addObject:jishiModel.account];
        }
        param[@"jis"] = jishiPhoneList; // 搜索技师的账号
    }
    return list.count ? list : nil;
}

/**
 获取服务单项目参数集合
 
 @return 项目参数
 */
- (NSMutableArray *)getServiceProjectParamList {
    NSMutableArray *list = NSMutableArray.new;
    for (XMHServiceProjectModel *model in _projectList) {
        NSMutableDictionary *param = NSMutableDictionary.new;
        [list addObject:param];
        param[@"id"] = model.ID; // 项目id
        param[@"num"] = @(model.selectCount); // 数量
        param[@"price"] = model.price; // 项目的单价
        
        if ([model isKindOfClass:[XMHServiceProjectModel class]]) {
            param[@"pro_code"] = model.pro_code; // 项目编码
        } else if ([model isKindOfClass:[XMHServiceGoodsModel class]]) {
            param[@"goods_code"] = ((XMHServiceGoodsModel *)model).goods_code; // 产品编码
        }
        
        NSMutableArray *jishiPhoneList = NSMutableArray.new;
        for (MLJiShiModel *jishiModel in model.jiShiList) {
            [jishiPhoneList addObject:jishiModel.account];
        }
        param[@"jis"] = jishiPhoneList; // 搜索技师的账号
    }
    return list.count ? list : nil;
}

/**
 获取服务单产品参数集合
 
 @return 项目参数
 */
- (NSMutableArray *)getServiceGoodsParamList {
    NSMutableArray *list = NSMutableArray.new;
    for (XMHServiceProjectModel *model in _goodsList) {
        NSMutableDictionary *param = NSMutableDictionary.new;
        [list addObject:param];
        param[@"id"] = model.ID; // 项目id
        param[@"num"] = @(model.selectCount); // 数量
        param[@"price"] = model.price; // 项目的单价
        param[@"is_end"] = @(model.is_end); // 产品是否用完，1是，0否
        if ([model isKindOfClass:[XMHServiceProjectModel class]]) {
            param[@"pro_code"] = model.pro_code; // 项目编码
        } else if ([model isKindOfClass:[XMHServiceGoodsModel class]]) {
            param[@"goods_code"] = ((XMHServiceGoodsModel *)model).goods_code; // 产品编码
        }
        NSMutableArray *jishiPhoneList = NSMutableArray.new;
        for (MLJiShiModel *jishiModel in model.jiShiList) {
            [jishiPhoneList addObject:jishiModel.account];
        }
        param[@"jis"] = jishiPhoneList; // 搜索技师的账号
    }
    return list.count ? list : nil;
}

@end
