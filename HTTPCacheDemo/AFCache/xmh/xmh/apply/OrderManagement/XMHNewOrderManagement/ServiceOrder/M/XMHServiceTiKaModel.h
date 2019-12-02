//
//  XMHServiceTiKaModel.h
//  xmh
//
//  Created by KFW on 2019/3/26.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 提卡

#import "XMHServiceBaseModel.h"
#import "XMHServiceGoodsModel.h"
#import "XMHServiceProjectModel.h"
@class XMHStoredCard, XMHNumCard, XMHTimeCard;

NS_ASSUME_NONNULL_BEGIN

@interface XMHServiceTiKaModel : XMHServiceBaseModel
/** 储值卡 */
@property (nonatomic, strong) NSArray <XMHStoredCard *> *stored_cardList;
/** 任选卡 */
@property (nonatomic, strong) NSArray <XMHNumCard *> *card_numList;
/** 时间卡 */
@property (nonatomic, strong) NSArray <XMHTimeCard *> *card_timeList;
@end

// 储值卡
@interface XMHStoredCard : XMHServiceBaseModel
/** 储值卡余额 */
@property (nonatomic, copy) NSString *money;
/** 储值卡编码 */
@property (nonatomic, copy) NSString *stored_code;
/** 储值卡名称 */
@property (nonatomic, copy) NSString *name;
/** 储值卡提项目 */
@property (nonatomic, strong) NSArray <XMHServiceProjectModel *>*pro_list;
/** 储值卡提产品 */
@property (nonatomic, strong) NSArray <XMHServiceGoodsModel *>*goods_list;
@end

// 任选卡
@interface XMHNumCard : XMHServiceBaseModel
/** 任选卡编码 */
@property (nonatomic, copy) NSString *card_num_code;
/** 任选卡剩余次数 */
//@property (nonatomic, copy) NSString *num;
/** 任选卡名称 */
@property (nonatomic, copy) NSString *name;
/** 储值卡提项目 */
@property (nonatomic, strong) NSArray <XMHServiceProjectModel *>*pro_list;
/** 储值卡提产品 */
@property (nonatomic, strong) NSArray <XMHServiceGoodsModel *>*goods_list;
@end

// 时间卡
@interface XMHTimeCard : XMHServiceBaseModel
/** 编码 */
@property (nonatomic, copy) NSString *card_time_code;
/** 时间卡结束时间 */
@property (nonatomic, copy) NSString *end_time;
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 时间卡单次消耗价值 */
@property (nonatomic, copy) NSString *price;
/** 储值卡提项目 */
@property (nonatomic, strong) NSArray <XMHServiceProjectModel *>*pro_list;
/** 储值卡提产品 */
@property (nonatomic, strong) NSArray <XMHServiceGoodsModel *>*goods_list;
@end
NS_ASSUME_NONNULL_END
