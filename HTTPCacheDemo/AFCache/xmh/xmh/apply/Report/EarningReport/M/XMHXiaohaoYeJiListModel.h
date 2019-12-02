//
//  XMHXiaohaoYeJiListModel.h
//  xmh
//
//  Created by shendengmeiye on 2019/7/11.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XMHXiaohaoYeJiModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHXiaohaoYeJiListModel : NSObject
@property(nonatomic, strong)NSMutableArray<XMHXiaohaoYeJiModel *> *list;

@end

@interface XMHXiaohaoYeJiModel : NSObject
/** 类型：pro项目，goods产品 */
@property (nonatomic, copy) NSString *type;
/** 项目或者产品的编码 */
@property (nonatomic, copy) NSString *code;
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 消耗人数 */
@property (nonatomic, copy) NSString *total_num;
/** 消耗业绩 */
@property (nonatomic, copy) NSString *total_price;
/** 业绩占比 */
@property (nonatomic, copy) NSString *total_bfb;
/** 储值卡消耗---消耗人数 ==========只有项目有============= */
@property (nonatomic, copy) NSString *ti_num;
/** 储值卡消耗---消耗业绩 */
@property (nonatomic, copy) NSString *ti_price;
/** 储值卡消耗---业绩占比 */
@property (nonatomic, copy) NSString *ti_bfb;
/** 疗程消耗---消耗人数 */
@property (nonatomic, copy) NSString *liao_num;
/** 疗程消耗---消耗业绩 */
@property (nonatomic, copy) NSString *liao_price;
/** 疗程消耗---业绩占比 ===========只有项目有============ */
@property (nonatomic, copy) NSString *liao_bfb;
/** 排名 */
@property (nonatomic, copy) NSString *rank;
/** 展开收起 */
@property (nonatomic, assign) BOOL isExpand;
@end

NS_ASSUME_NONNULL_END
