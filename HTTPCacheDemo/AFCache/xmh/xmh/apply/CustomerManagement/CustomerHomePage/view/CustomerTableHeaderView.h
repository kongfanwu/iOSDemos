//
//  CustomerTableHeaderView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/27.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobSelector.h"
#import "organizationalStructureView.h"
#import "ZhuzhiModel.h"
#import "CjView.h"
@class DateHeaderView,CustomerTableHeaderView,LDatePickView;
typedef void(^DateTap)(NSString *start ,NSString *end);

@interface CustomerTableHeaderView : UIView
@property (nonatomic ,strong)JobSelector *jobSelector;
@property (nonatomic ,copy)DateTap dateTap;
 @property (nonatomic ,strong) LDatePickView *dateHeaderView;
@property (nonatomic ,strong)organizationalStructureView *organizationHeader;
@property (nonatomic ,strong)CjView *cjView;

@property (nonatomic, copy)void(^organizationalStructureViewBlock)(NSString *join_code,NSString *oneClick,NSString *twoClick,NSString * twoListId,NSString *inId,NSInteger level,NSInteger mainrole,List*listInfo);


@end
