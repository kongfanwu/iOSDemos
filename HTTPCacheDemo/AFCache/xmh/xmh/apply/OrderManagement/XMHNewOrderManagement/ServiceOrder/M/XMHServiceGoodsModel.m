//
//  XMHServiceGoodsModel.m
//  xmh
//
//  Created by KFW on 2019/3/26.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHServiceGoodsModel.h"

@implementation XMHServiceGoodsModel

+ (NSDictionary *)modelCustomPropertyMapper {
    NSMutableDictionary *dic = NSMutableDictionary.new;
    if ([super respondsToSelector:@selector(modelCustomPropertyMapper)]) {
        [dic addEntriesFromDictionary:[super modelCustomPropertyMapper]];
    }
    [dic addEntriesFromDictionary:@{@"num" : @[@"num", @"s_num"], @"code" : @[@"code", @"goods_code"]}];
    return dic;
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
//    if ([super respondsToSelector:@selector(modelCustomTransformFromDictionary:)]) {
//        [super performSelector:@selector(modelCustomTransformFromDictionary:) withObject:dic];
//    }
    // 处理技师list
    NSArray *jisList = dic[@"jis_list"];
    for (int i = 0; i < jisList.count; i++) {
        NSString *name = jisList[i];
        MLJiShiModel *model = MLJiShiModel.new;
        model.name = name;
        model.ID = i + 1;
        
        [self.jiShiList addObject:model];
    }
 
    return YES;
}

/**
 计算总价格
 单价 * 购买数量 - 礼品卷（如果有）
 */
- (CGFloat)computeTotalPrice {
    return [self.price floatValue] * self.selectCount;
}

@end
