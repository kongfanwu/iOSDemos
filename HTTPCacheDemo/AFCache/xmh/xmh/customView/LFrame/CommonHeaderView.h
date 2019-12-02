//
//  CommonHeaderView.h
//  xmh
//
//  Created by ald_ios on 2018/10/15.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "COrganizeModel.h"

@interface CommonHeaderView : UIView


/** 日期回调Block */
@property (nonatomic, copy) void (^CommonHeaderViewDateBlock)(NSString * startTime,NSString * endTime);
/** 组织架构日期回调Block */
@property (nonatomic, copy) void(^CommonHeaderViewBlock)(COrganizeModel * organizeModel,BOOL isShow);

/**
 *初始化CommonHeaderView
 *
 *@param frame frame
 *
 *@param module 模块字符串简写 预约管理(YYGL)  顾客管理(GKGL)  美丽定制(MLDZ)  订单管理(DDGL)
 *
 *@return CommonHeaderView
 */
- (instancetype)initWithFrame:(CGRect)frame module:(NSString *)module;
@end
