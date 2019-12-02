//
//  OneStepTableSectionHeader.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/1.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  预约详情 tableViewSection view

#import <UIKit/UIKit.h>

@interface OneStepTableSectionHeader : UIView
@property (weak, nonatomic) IBOutlet UILabel *lb;
@property (nonatomic, copy)void(^oneStepTableSectionHeaderBlock)(NSString * text);
@end
