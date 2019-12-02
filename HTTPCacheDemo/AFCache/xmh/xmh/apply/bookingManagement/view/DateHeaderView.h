//
//  DateHeaderView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/20.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  时间选择View

#import <UIKit/UIKit.h>

@interface DateHeaderView : UIView
@property (strong, nonatomic)UIButton * btn;            //选择日期
@property (copy, nonatomic)NSString * startDate;
@property (copy, nonatomic)NSString * endDate;
//@property (nonatomic, copy)void(^dateHeaderViewBlock)();
- (void)updateDateHeaderViewStartDate:(NSString *)start end:(NSString *)end;
- (void)updateDateHeaderView;

@end
