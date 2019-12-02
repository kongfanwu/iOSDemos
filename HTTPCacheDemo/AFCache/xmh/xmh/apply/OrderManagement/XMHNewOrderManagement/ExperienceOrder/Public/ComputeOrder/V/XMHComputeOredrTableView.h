//
//  XMHComputeOredrTableView.h
//  xmh
//
//  Created by KFW on 2019/3/21.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMHBaseTableView.h"
#import "CustomerListModel.h"
@class XMHComputeOredrTableView;

NS_ASSUME_NONNULL_BEGIN

@protocol XMHComputeOredrTableViewDelegate <NSObject>

@optional
/**
 归属回调
 @param tag 1 业绩 2 门店 3 店长
 */
- (void)guiShutableView:(XMHComputeOredrTableView *)tableView tag:(NSInteger)tag;


@end


@interface XMHComputeOredrTableView : XMHBaseTableView
/** <##> */
@property (nonatomic, strong) NSArray *dataArray;

/** 选择用户model */
@property (nonatomic, strong) CustomerModel *selectUserModel;
/** <##> */
@property (nonatomic, weak) id <XMHComputeOredrTableViewDelegate> aDelegate;

/** 备注信息 */
@property (nonatomic, strong, readonly) UITextView *remarkTextView;
/** 是否可编辑 默认YES */
@property (nonatomic) BOOL remarkTextViewUserInteractionEnabled;
/** 备注内容 */
@property (nonatomic, copy) NSString *remarkText;

/** YES 展示业绩视图  */
@property (nonatomic) BOOL isYeJi;

/** 是否补业绩 */
@property (nonatomic) BOOL isBuYeJi;
/** 创建订单类型 默认 XMHCreateOrderTypeExperience */
@property (nonatomic) XMHCreateOrderType createOrderType;
@end

NS_ASSUME_NONNULL_END
