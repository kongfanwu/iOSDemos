//
//  XMHExperienceOrderBaseModel.m
//  xmh
//
//  Created by KFW on 2019/3/21.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHExperienceOrderBaseModel.h"

@implementation XMHExperienceOrderBaseModel

//@synthesize type = _type;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.is_end = NO;
    }
    return self;
}

/**
 计算总原价格
 单价 * 购买数量
 */
- (CGFloat)computeOriginPrice {
    return 0;
}

/**
 计算总价格
 单价 * 购买数量 - 礼品卷（如果有）
 */
- (CGFloat)computeTotalPrice {
    return 0;
}

/**
 服务类型转字符串
 
 @return 服务类型描述
 */
- (NSString *)stringFromType {
    switch (self.type) {
        case XMHExperienceOrderTypeProject: {
            return @"项目服务";
            break;
        }
        case XMHExperienceOrderTypeGoods: {
            return @"产品服务";
            break;
        }
        case XMHExperienceOrderTypeExperience: {
            return @"体验服务";
            break;
        }
        default:
            return @"";
            break;
    }
    return @"";
}

- (NSMutableArray *)jiShiList {
    if (_jiShiList) return _jiShiList;
    _jiShiList = NSMutableArray.new;
    return _jiShiList;
}

/**
 重置绑定的技师 购买数量
 */
- (void)reset {
    [super reset];
    [self.jiShiList removeAllObjects];
}

@end
