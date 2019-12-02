//
//  LanternPlanSetionHeardView.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/12/25.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MzzTags.h"
@class LanternPlanInfoModel;
@interface LanternPlanSetionHeardView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UILabel *sectionTitle;
@property (weak, nonatomic) IBOutlet UILabel *recommendedTitle;

@property (nonatomic, copy) void (^LanternPlanAddButtonBlock)(MzzSectionTags *model);
@property (nonatomic, copy) void (^LanternPlanSelectButtonBlock)(MzzSectionTags *model);
@property (nonatomic, copy) void (^LanternPlanSetionHeardViewSelectBlock)(LanternPlanInfoModel *model);
@property (nonatomic, copy) void (^LanternPlanSetionHeardViewAddBlock)(LanternPlanInfoModel *model);
-(void)updateSectionModel:(MzzSectionTags *)model;
- (void)updateLanternPlanSetionHeardViewModel:(LanternPlanInfoModel *)model;
@end
