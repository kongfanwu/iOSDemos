//
//  XMHServiceGoodsModel.h
//  xmh
//
//  Created by KFW on 2019/3/26.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 产品

#import "XMHServiceBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHServiceGoodsModel : XMHServiceBaseModel
/** 产品code */
@property (nonatomic, copy) NSString *goods_code;
/** 产品剩余次数 */
//@property (nonatomic, copy) NSString *num;
/** 产品名称 */
@property (nonatomic, copy) NSString *name;
/** 产品价格 */
@property (nonatomic, copy) NSString *price;
/** 产品时长 */
@property (nonatomic) NSInteger shichang;
@end

NS_ASSUME_NONNULL_END
