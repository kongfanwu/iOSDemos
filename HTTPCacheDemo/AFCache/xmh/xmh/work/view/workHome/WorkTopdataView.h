//
//  WorkTopdataView.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/9/28.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkTopdataView : UIView
- (WorkTopdataView *)initWithDataFram:(CGRect)frame withTitleOne:(NSString *)oneTitle anOneTxt:(NSString *)oneText withTitleTwo:(NSString *)twoTtile andTwoText:(NSString *)twoText andRole:(NSInteger)role andImage:(NSString *)imageStr withDayBiaoZhu:(NSString *)dayBiao andMonthBiaoZhu:(NSString*)monthBiao;
-(void)updateViewOnetext:(NSString*)oneText andTwoText:(NSString *)twoText wihtDay:(NSString*)day andMonth:(NSString*)month;
@end
