//
//  DatePickerView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/23.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DateView;
@interface DatePickerView : UIView
@property (strong, nonatomic)UIButton * btnCancel;
@property (strong, nonatomic)UIButton * btnSure;
@property (strong, nonatomic)DateView * dateLeft;
@property (strong, nonatomic)DateView * dateRight;
@property (nonatomic, copy)void(^DatePickerViewBlcok)(NSString * start, NSString * end);
@property (nonatomic ,assign)BOOL simple;
- (void)showDatePickerView;
- (void)hidenDatePickerView;
@end
