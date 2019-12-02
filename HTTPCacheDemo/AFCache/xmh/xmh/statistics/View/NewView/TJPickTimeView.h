//
//  TJPickTimeView.h
//  xmh
//
//  Created by ald_ios on 2018/12/5.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJPickTimeView : UIView
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
