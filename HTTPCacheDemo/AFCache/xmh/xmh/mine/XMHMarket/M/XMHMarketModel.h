//
//  XMHMarketModel.h
//  xmh
//
//  Created by ald_ios on 2019/5/22.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XMHMarketSubModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHMarketModel : NSObject
@property (nonatomic, copy)NSString * img;
@property (nonatomic, strong)XMHMarketSubModel *info;
@end
@interface XMHMarketSubModel : NSObject
/** 权益包类型 1:普通 2:金卡 3:钻石 4:至尊 */
@property (nonatomic, copy)NSString * type;
/** 权益包名称 */
@property (nonatomic, copy)NSString * name;
/** 有效期 1：1年， 2： 2年 */
@property (nonatomic, copy)NSString * validity;
/** 销售价格 */
@property (nonatomic, copy)NSString * sale_price;
/** 权益包说明 */
@property (nonatomic, copy)NSString * title;
/** 详情页banner图 */
@property (nonatomic, copy)NSString * pic1;
/** 价值 */
@property (nonatomic, copy)NSString * price;
/** 详情页banner图 */
@property (nonatomic, copy)NSString * pic_banner;
/** 原价 */
@property (nonatomic, copy)NSString * original_price;
/** 现价 */
@property (nonatomic, copy)NSString * present_price;
/** 原价 */
@property (nonatomic, copy)NSString * price_y;
/** 拼团价格 */
@property (nonatomic, copy)NSString * join_price;
/** VIP 活动简述 */
@property (nonatomic, copy)NSString *des;
/** VIP详情页banner图 */
@property (nonatomic, copy)NSString *share_pic;
@end
NS_ASSUME_NONNULL_END
