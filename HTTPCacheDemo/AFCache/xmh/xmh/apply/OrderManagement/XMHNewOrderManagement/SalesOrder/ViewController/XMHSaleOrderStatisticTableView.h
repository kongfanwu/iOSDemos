//
//  XMHSaleOrderStatisticTableView.h
//  xmh
//
//  Created by 杜彩艳 on 2019/3/31.
//  Copyright © 2019年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomerModel;
@class SaleModel;
@class XMHSaleOrderStatisticTableView;
@class MzzStoreModel;
@class SLManagerModel;
@class MLJiShiModel;
@class XMHComputeOrderAchievementModel;
NS_ASSUME_NONNULL_BEGIN
@protocol XMHSaleOrderStatisticTableViewDelegate <NSObject>

@optional
/**
 归属回调
 @param tag 1 业绩 2 门店 3 店长
 */
- (void)guiShutableView:(XMHSaleOrderStatisticTableView *)tableView tag:(NSInteger)tag;

/**
 添加技师
 */
- (void)addJiShiTableView:(XMHSaleOrderStatisticTableView *)tableView indexPath:(NSIndexPath *)indexPath;


@end

@interface XMHSaleOrderStatisticTableView : UITableView
/** <##> */
@property (nonatomic, strong) NSMutableArray<SaleModel *> *saleData;

@property (nonatomic, strong) NSMutableArray <SaleModel *>*awardData;

/** 选择用户model */
@property (nonatomic, strong) CustomerModel *selectUserModel;
/** <##> */
@property (nonatomic, weak) id <XMHSaleOrderStatisticTableViewDelegate> aDelegate;

/** 备注信息 */
@property (nonatomic, strong, readonly) UITextView *remarkTextView;
/** 备注内容 */
@property (nonatomic, copy) NSString *remarkText;
/** 是否可编辑 默认YES */
@property (nonatomic) BOOL remarkTextViewUserInteractionEnabled;

/** YES 展示业绩视图  */
@property (nonatomic) BOOL isYeJi;

@property (nonatomic, copy)void(^addAwardClick)();
/** 备注信息内容  */
@property (nonatomic, copy)void(^textViewContent)(NSString *text);

@property (nonatomic, copy) NSString *yingfuPrice;// 补齐项目(逆向开单)应付金额

//业绩划分数据
@property (nonatomic, strong) XMHComputeOrderAchievementModel *computeOrderAchievementModel;


@end

NS_ASSUME_NONNULL_END
