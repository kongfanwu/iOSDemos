//
//  OrderRightSectionHeader.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/12.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLPresModel.h"
@interface OrderRightSectionHeader : UIView
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UILabel *lb;
@property (nonatomic,assign) BOOL selectMore;
@property(nonatomic,copy) void (^clickXuan)(BOOL select);
@property(nonatomic,copy) void (^clickWeiXuan)(BOOL select);

-(void)freshOrderRightSectionHeard:(SLPresListModel *)model;

@end
