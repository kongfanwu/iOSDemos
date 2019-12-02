//
//  XMHServiceBaseModel.h
//  xmh
//
//  Created by KFW on 2019/3/26.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMHShoppingCartBaseModel.h"
#import "MLJishiSearchModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHServiceBaseModel : XMHShoppingCartBaseModel
/** id */
//@property (nonatomic, copy) NSString *ID;

/** 选中标识 */
@property (nonatomic) BOOL selectType;
/** 已选技师集合 */
@property (nonatomic, strong) NSMutableArray <MLJiShiModel *> *jiShiList;
/** 产品是否用完，1是，0否 */
@property (nonatomic) BOOL is_end;

/** 服务端服务类型字段 */
@property (nonatomic, copy) NSString *serviceType;

/**
 计算总价格
 单价 * 购买数量 - 礼品卷（如果有）
 */
- (CGFloat)computeTotalPrice;

/**
 服务类型转字符串
 
 @return 服务类型描述
 */
- (NSString *)stringFromType;


+ (NSDictionary *)modelCustomPropertyMapper;
@end

NS_ASSUME_NONNULL_END
