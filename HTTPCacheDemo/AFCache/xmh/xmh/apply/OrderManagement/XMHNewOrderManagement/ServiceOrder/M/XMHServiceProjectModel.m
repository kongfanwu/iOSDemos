//
//  XMHServiceProjectModel.m
//  xmh
//
//  Created by KFW on 2019/3/26.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHServiceProjectModel.h"

@implementation XMHServiceProjectModel

+ (NSDictionary *)modelCustomPropertyMapper {
    NSMutableDictionary *dic = NSMutableDictionary.new;
    if ([super respondsToSelector:@selector(modelCustomPropertyMapper)]) {
        [dic addEntriesFromDictionary:[super modelCustomPropertyMapper]];
    }
    [dic addEntriesFromDictionary:@{@"ID"  : @"id",
                                    @"name": @[@"name", @"pro_name"],
                                    @"code" : @"pro_code",
                                    }];
    return dic;
}

/**
 计算总价格
 单价 * 购买数量 - 礼品卷（如果有）
 */
- (CGFloat)computeTotalPrice {
    return [self.price floatValue] * self.selectCount;
}

@end
