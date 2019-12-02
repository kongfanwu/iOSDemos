//
//  DateView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/24.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateView : UIView
@property (nonatomic,strong)UIPickerView * pickerView;
@property (nonatomic,strong)NSCalendar *calendar;
@property (nonatomic,strong)NSDate *startDate; //其实时间
@property (nonatomic,strong)NSDate *endDate;  //结束时间
@property (nonatomic,strong)NSDate *selectDate;
@property (nonatomic,strong)NSDateComponents * selectedDateComponets;
@property (nonatomic,strong)UILabel *lb;
@property (nonatomic,copy)NSString * selectDateStr;
@property (nonatomic,copy)NSDate * setDate;
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;
- (void)initSubViews;
@end
