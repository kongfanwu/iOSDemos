//
//  XMHSaleOrderBaseDetailView.h
//  xmh
//
//  Created by shendengmeiye on 2019/6/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMHNumberView;
@class XMHVipDiscountView;
@class XMHCouponView;
@class ZheKouStored_Card;
@class SATicketModel;
@class SaleModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHSaleOrderBaseDetailView : UIView<UITextFieldDelegate>

/** ------------------------基本控件------------- */
/** 加减号 */
@property (nonatomic, strong)XMHNumberView *numberView;
/** 项目、产品会员优惠 */
@property (nonatomic, strong)XMHVipDiscountView *discountView;
/** 项目、产品优惠券 */
@property (nonatomic, strong)XMHCouponView *couponView;
/** 输入框 */
@property (nonatomic, strong)UITextField *field;
/** 确认按钮 */
@property (nonatomic, strong)UIButton *sureBtn;
/** 关闭按钮 */
@property (nonatomic, strong)UIButton *closeBtn;
/** 商品名 */
@property (nonatomic, strong)UILabel *nameLab;
/** 疗程次数标题 */
@property (nonatomic, strong)UILabel *countLab;
/** 会员优惠标题 */
@property (nonatomic, strong)UILabel *vipLab;
/** 优惠券标题 */
@property (nonatomic, strong)UILabel *vipTicketLab;
/** 零售价标题 */
@property (nonatomic, strong)UILabel *priceLab;
/** 数量标题 */
@property (nonatomic, strong)UILabel *numLab;
/** 有效期 */
@property (nonatomic, strong)UILabel *limitLab;
/** 续卡金额 */
@property (nonatomic, strong)UILabel *xukaLab;
/** 购买内容选择 */
@property (nonatomic, strong)XMHCouponView *contentView;
/** 总价 */
@property (nonatomic, strong)UILabel *totalPriceLab;
/** 购买内容选择标题 */
@property (nonatomic, strong)UILabel *contentLab;

/**-----------------------网络请求相关参数---------*/
/** 顾客Id */
@property (nonatomic, copy)NSString *userId;
/** 商家编码 */
@property (nonatomic, copy)NSString *storeCode;
/** type 类型 （pro、goods...） */
@property (nonatomic, copy)NSString *type;
/** 选中的vip会员优惠 (产品、项目使用)*/
@property (nonatomic, strong) ZheKouStored_Card *__nullable zhekouModel;
/** 选中的优惠券 (产品、项目使用)*/
@property (nonatomic, strong) SATicketModel *__nullable couponModel;
/** 商品model*/
@property (nonatomic,strong) SaleModel *detailModel;

/**-----------------------回调---------*/
/** 关闭 */
@property (nonatomic, copy)void(^closeDetailView)();
/** 确定 */
@property (nonatomic, copy)void(^selectedFinishBlock)(SaleModel *model);

/** 任选卡(卡项次数)、时间卡(使用期限) */
@property (nonatomic, copy)NSString *infoStr;
/** 储值卡 */
@property (nonatomic, assign)BOOL storeCardFlag;

/**
 初始化

 @param frame frame
 @param userId 顾客Id
 @param storeCode 商家编码
 @param type 类型 （pro、goods...）
 @param detailModel 商品model
 @return instancetype
 */
- (instancetype)initWithFrame:(CGRect)frame userId:(NSString *)userId storeCode:(NSString *)storeCode type:(NSString *)type detailModel:(SaleModel* )detailModel;

/**
 点击确定按钮
 */
-(void)clickSureBtn;
/**
 更新UI, 子类实现
 */
- (void)updateSubviews;
@end

NS_ASSUME_NONNULL_END
