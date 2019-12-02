//
//  MzzMessageTwoSectionCell.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/11/21.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MzzPortraitModel.h"

@interface MzzMessageTwoSectionCell : UITableViewCell
@property (copy, nonatomic) void (^changeTitle)(NSInteger select);
@property (copy, nonatomic) void (^toIndicatorsVC)(NSString *title,NSString *reference,NSString *suggest,NSInteger ID);

-(void)cellWithModel:(MzzPortraitModel *)user_PortraitModel andWithBtnSelect:(NSInteger)btnSelect andWithViewHeight:(NSInteger)viewHeight;

@end
