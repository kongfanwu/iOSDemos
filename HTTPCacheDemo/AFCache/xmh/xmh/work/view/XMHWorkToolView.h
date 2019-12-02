//
//  XMHWorkToolView.h
//  xmh
//
//  Created by KFW on 2019/4/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, XMHWorkToolViewType) {
    XMHWorkToolViewTypeSales, // 销售制单
    XMHWorkToolViewTypeService, // 服务制单
    XMHWorkToolViewTypeYuYue, // 一键预约
    XMHWorkToolViewTypeAddUser, // 添加顾客
    XMHWorkToolViewTypeShenPi, // 审批应用
    XMHWorkToolViewTypeTiaoDian, // 会员调店
    XMHWorkToolViewTypeShouKuan, // 快速收款
};


@interface XMHWorkToolViewItemModel : NSObject
/** <##> */
@property (nonatomic) XMHWorkToolViewType type;
/** <##> */
@property (nonatomic, copy) NSString *title;
/** <##> */
@property (nonatomic, copy) NSString *imageName;

+ (instancetype)createTitle:(NSString *)title imageName:(NSString *)imageName type:(XMHWorkToolViewType)type;
@end


@interface XMHWorkToolView : UIView
/** 角色 */
@property (nonatomic) NSInteger role;
/** <#type#> */
@property (nonatomic, copy) void (^didSelectBlock)(XMHWorkToolViewItemModel *model);
@end

NS_ASSUME_NONNULL_END
