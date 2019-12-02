//
//  XMHComputeOrderAchievementModel.m
//  xmh
//
//  Created by KFW on 2019/3/21.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHComputeOrderAchievementModel.h"
#import "SLS_ProModel.h"
#import "XMHShoppingCartManager.h"

@implementation XMHComputeOrderAchievementModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _xiaohao = YES;
    }
    return self;
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
 检查是否分配了员工归属
 // 1 商品单价为0元的。YES
 // 2 分配技师总价大于0 YES
 
 @return YES 分配了。 NO 未分配
 */
- (BOOL)checkInputGuiShu {
    NSInteger allprice = XMHShoppingCartManager.sharedInstance.allPrice;
    if (allprice == 0) {
        return YES;
    }
    
    CGFloat price = 0;
    for (MLJiShiModel *jishiModel in self.jiShiList) {
        price += [jishiModel.inputPrice floatValue];
    }
    return price > 0 ? YES : NO;
}

/**
 检查技师分配价格是否等于总价格

 @return YES 合法 NO 不合法
 */
- (BOOL)checkJiShiPrice {
    CGFloat allprice = XMHShoppingCartManager.sharedInstance.allPrice;
    return [self checkJiShiPriceAllPrice:allprice];
}

/**
 检查技师分配价格是否等于总价格
 
 @param allPrice 总价格
 @return YES 合法 NO 不合法
 */
- (BOOL)checkJiShiPriceAllPrice:(CGFloat)allPrice {
    NSArray *jishiList = [self jiShiList];
    
    CGFloat price = 0.f;
    for (MLJiShiModel *jishiModel in jishiList) {
        price += [jishiModel.inputPrice floatValue];
    }
    
    // 判断2个浮点数是否相等
    CGFloat result = ABS(allPrice - price);
    // 最大误差 0.009。误差在0.01范围内就通过
    if (result <= 0.009) {
        return YES;
    }
    return NO;
}

/**
 拼接开单接口 员工归属字段（guishu）所需参数

 @return 归属后的集合
 */
- (NSMutableArray *)guiShuArray {
    NSMutableArray *guiShuList = NSMutableArray.new;
    for (MLJiShiModel *jishiModel in self.jiShiList) {
        NSMutableDictionary *param = NSMutableDictionary.new;
        param[@"acc"] = jishiModel.account;
        param[@"bfb"] = @([jishiModel.inputPrice floatValue]);
        [guiShuList addObject:param];
    }
    return guiShuList;
}



@end
