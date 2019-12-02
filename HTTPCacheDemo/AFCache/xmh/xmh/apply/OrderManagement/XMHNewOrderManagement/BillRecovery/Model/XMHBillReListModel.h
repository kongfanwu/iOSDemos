//
//  XMHBillReProListModel.h
//  xmh
//
//  Created by shendengmeiye on 2019/3/15.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMHShoppingCartBaseModel.h"
@class XMHBillReProModel;
@class XMHBillReGoodsModel;
@class XMHBillReCardModel;
@class XMHBillReTimeModel;
@class XMHBillReNumCardModel;
@class XMHBillReTicketModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHBillReListModel : NSObject

@property (nonatomic, strong) NSMutableArray <XMHBillReProModel*>*list;
@end

@interface XMHBillReGoodsListModel : NSObject
@property (nonatomic, strong) NSMutableArray <XMHBillReGoodsModel*>*list;

@end

@interface XMHBillReCardListModel : NSObject

@property (nonatomic, strong) NSMutableArray <XMHBillReCardModel*>*list;
@end

@interface XMHBillReTimeListModel : NSObject

@property (nonatomic, strong) NSMutableArray <XMHBillReTimeModel*>*list;
@end

@interface XMHBillReNumCardListModel : NSObject

@property (nonatomic, strong) NSMutableArray <XMHBillReNumCardModel*>*list;
@end

@interface XMHBillReTicketListModel : NSObject

@property (nonatomic, strong) NSMutableArray <XMHBillReTicketModel*>*list;
@end


@interface XMHBillReProModel : XMHShoppingCartBaseModel

@property (nonatomic,assign) NSInteger uid;//账单中的id
@property (nonatomic,copy) NSString *money; //剩余金额
//@property (nonatomic,copy) NSString *code; //项目code
@property (nonatomic,copy) NSString *price; //项目单价
@property (nonatomic,copy) NSString *nums; //剩余次数
@property (nonatomic,copy) NSString *name; //名称
@property (nonatomic,assign) NSInteger fenqi_zt;//分期
@property (nonatomic,assign) NSInteger cartNum;//添加到购物车的数量
@property (nonatomic,assign) CGFloat recoverPrice;//回收总金额
@property (nonatomic, assign)XMHBillRecoverType recoverType;// 卡片类型
/**
 计算总价格
 单价 * 购买数量
 */
- (CGFloat)computeTotalPrice;

/**
 计算剩余金额

 @return 剩余次数 * 单价
 */
- (CGFloat)computeShengyuPrice;

@end

@interface XMHBillReGoodsModel : XMHShoppingCartBaseModel

@property (nonatomic,assign) NSInteger uid;//账单中的id
@property (nonatomic,copy) NSString *money; //剩余金额
//@property (nonatomic,copy) NSString *code; //项目code
@property (nonatomic,copy) NSString *price; //项目单价
@property (nonatomic,copy) NSString *nums; //剩余次数
@property (nonatomic,copy) NSString *name; //名称
@property (nonatomic,assign) NSInteger fenqi_zt;//分期
@property (nonatomic,assign) NSInteger cartNum;//添加到购物车的数量
@property (nonatomic,assign) CGFloat recoverPrice;//回收总金额
@property (nonatomic, assign)XMHBillRecoverType recoverType;// 卡片类型

/** 用户输入的价格 */
@property (nonatomic, copy) NSString *inputPrice;

/**
 计算总价格
 单价 * 购买数量
 */
- (CGFloat)computeTotalPrice;


/**
 计算剩余金额
 
 @return 剩余次数 * 单价
 */
- (CGFloat)computeShengyuPrice;

@end

// 储值卡
@interface XMHBillReCardModel : XMHShoppingCartBaseModel

@property (nonatomic,assign) NSInteger user_card_id;//账单中的id
@property (nonatomic,copy) NSString *money; //剩余金额
//@property (nonatomic,copy) NSString *code; //项目code
@property (nonatomic,assign) NSInteger fenqi_zt;//分期状态（分期状态 0未分期 1分期 2已还完 3终止还款）
@property (nonatomic,assign) NSInteger card_id;//会员卡id
@property (nonatomic,assign) NSInteger show_jz;//奖赠按钮是否显示，0不显示，1显示
@property (nonatomic,copy) NSString *name; //名称
@property (nonatomic,copy) NSString *nums; //剩余次数
@property (nonatomic,assign) NSInteger cartNum;//添加到购物车的数量
@property (nonatomic,assign) CGFloat recoverPrice;//回收总金额
@property (nonatomic,assign) NSInteger allRecover;
/** 用户输入的价格 */
@property (nonatomic, copy) NSString *inputPrice;
@property (nonatomic, assign)XMHBillRecoverType recoverType;// 卡片类型

/**
 计算总价格
 */
- (CGFloat)computeTotalPrice;

- (CGFloat)computeShengyuPrice;
@end

@interface XMHBillReTimeModel : XMHShoppingCartBaseModel

@property (nonatomic,assign) NSInteger uid;//账单中的id
//@property (nonatomic,copy) NSString *code; //项目code
@property (nonatomic,copy) NSString *name; //名称
@property (nonatomic,copy) NSString *nums; //剩余次数
@property (nonatomic,copy) NSString *end_time; //截止时间
@property (nonatomic,copy) NSString *xiaohao; //消耗金额
@property (nonatomic,copy) NSString *price; //购买金额
@property (nonatomic,assign) NSInteger show_jz;//奖赠按钮是否显示，0不显示，1显示
@property (nonatomic,assign) NSInteger fenqi_zt;
@property (nonatomic,assign) NSInteger cartNum;//添加到购物车的数量
@property (nonatomic,assign) CGFloat recoverPrice;//回收总金额
@property (nonatomic,assign) NSInteger allRecover;
@property (nonatomic, assign)XMHBillRecoverType recoverType;//卡片类型
/** 用户输入的价格 */
@property (nonatomic, copy) NSString *inputPrice;
/**
 计算总价格
 */
- (CGFloat)computeTotalPrice;

- (CGFloat)computeShengyuPrice;
@end

//任选l卡
@interface XMHBillReNumCardModel : XMHShoppingCartBaseModel

@property (nonatomic,assign) NSInteger uid;//账单中的id
@property (nonatomic, copy)NSString *money; //剩余金额
//@property (nonatomic,copy) NSString *code; //项目code
@property (nonatomic,copy) NSString *nums; //剩余次数
@property (nonatomic,copy) NSString *name; //名称
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *y_price;
@property (nonatomic,strong) NSArray *yy_basic;//已用价值-已用内容
@property (nonatomic,assign) NSInteger show_jz;//奖赠按钮是否显示，0不显示，1显示
@property (nonatomic,assign) NSInteger fenqi_zt;//分期状态
@property (nonatomic,assign) NSInteger cartNum;//添加到购物车的数量
@property (nonatomic,assign) CGFloat recoverPrice;//回收总金额
@property (nonatomic,assign) NSInteger allRecover;
@property (nonatomic, assign)XMHBillRecoverType recoverType;//卡片类型

/**
 计算总价格
 */
- (CGFloat)computeTotalPrice;

- (CGFloat)computeShengyuPrice;

@end

@interface XMHBillReTicketModel : XMHShoppingCartBaseModel

@property (nonatomic,assign) NSInteger uid;//账单中的id
@property (nonatomic,copy) NSString *money; //剩余金额
//@property (nonatomic,copy) NSString *code; //项目code
@property (nonatomic,copy) NSString *price; //项目单价
@property (nonatomic,copy) NSString *nums; //剩余次数
@property (nonatomic,copy) NSString *name; //名称
@property (nonatomic,assign) NSInteger fenqi_zt;//分期
@property (nonatomic,copy) NSString *expiry;//有效期
@property (nonatomic,assign) NSInteger cartNum;//添加到购物车的数量
@property (nonatomic,assign) CGFloat recoverPrice;//回收总金额
@property (nonatomic,assign) NSInteger allRecover;
@property (nonatomic, assign)XMHBillRecoverType recoverType;//卡片类型
@property (nonatomic, copy)NSString * inputPrice;

/**
 计算总价格
 */
- (CGFloat)computeTotalPrice;

- (CGFloat)computeShengyuPrice;


@end
NS_ASSUME_NONNULL_END
