//
//  LanternPlanToAddTheGoodsVC.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/12/26.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BaseCommonViewController.h"
#import "MzzTags.h"

@interface LanternPlanToAddTheGoodsVC : BaseCommonViewController
@property(nonatomic ,strong)NSString *titleStr;
@property(nonatomic ,strong)MzzSectionTags *model;
@property (nonatomic, copy) void (^LanternPlanAddModelBlock)(NSArray *modelArray);

@end
