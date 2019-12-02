//
//  BookTimeWeekView.m
//  xmh
//
//  Created by ald_ios on 2018/10/22.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookTimeWeekView.h"
#import "BookTimeWeekModel.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@interface BookTimeWeekView ()
@property (weak, nonatomic) IBOutlet UILabel *lbWeek1;
@property (weak, nonatomic) IBOutlet UILabel *lbDate1;
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *container1;

@property (weak, nonatomic) IBOutlet UILabel *lbWeek2;
@property (weak, nonatomic) IBOutlet UILabel *lbDate2;
@property (weak, nonatomic) IBOutlet UIView *line2;
@property (weak, nonatomic) IBOutlet UIView *container2;

@property (weak, nonatomic) IBOutlet UILabel *lbWeek3;
@property (weak, nonatomic) IBOutlet UILabel *lbDate3;
@property (weak, nonatomic) IBOutlet UIView *line3;
@property (weak, nonatomic) IBOutlet UIView *container3;

@property (weak, nonatomic) IBOutlet UILabel *lbWeek4;
@property (weak, nonatomic) IBOutlet UILabel *lbDate4;
@property (weak, nonatomic) IBOutlet UIView *line4;
@property (weak, nonatomic) IBOutlet UIView *container4;
@end
@implementation BookTimeWeekView
{
    NSMutableArray *_weekArr;;
    NSString * _selectYear;

}
- (void)awakeFromNib
{
    [super awakeFromNib];
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(weekClick:)];
    [_container1 addGestureRecognizer:tap1];
    
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(weekClick:)];
    [_container2 addGestureRecognizer:tap2];
    
    UITapGestureRecognizer * tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(weekClick:)];
    [_container3 addGestureRecognizer:tap3];
    
    UITapGestureRecognizer * tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(weekClick:)];
    [_container4 addGestureRecognizer:tap4];
    
    [self weekClick:tap1];
    
    [self updateBookTimeWeekViewDate:[self dateToString:[NSDate date] withDateFormat:@"yyyy-MM-dd"]];
    
    
}
- (NSMutableArray *)getweeksFromDate:(NSDate *)date
{
    NSMutableArray *weekArr = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 4; i ++) {
        //从现在开始的24小时
        NSTimeInterval secondsPerDay = i * 24*60*60;
//        [NSDate dateWithTimeInterval:secondsPerDay sinceDate:date];
        NSDate *curDate = [NSDate dateWithTimeInterval:secondsPerDay sinceDate:date];;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd"];
        NSString *dateStr = [dateFormatter stringFromDate:curDate];//几月几号
        //        NSString *dateStr = @"5月31日";
        NSDateFormatter *weekFormatter = [[NSDateFormatter alloc] init];
        [weekFormatter setDateFormat:@"EEEE"];//星期几 @"HH:mm 'on' EEEE MMMM d"];
        NSString *weekStr = [weekFormatter stringFromDate:curDate];
        //组合时间
        if (i==0) {
            if ([self isSameDay:curDate date2:[NSDate date]]) {
                weekStr = @"今天";
            }
        }
        BookTimeWeekModel * model = [[BookTimeWeekModel alloc] init];
        model.week = weekStr;
        model.date = dateStr;
        [weekArr addObject:model];
    }
    return weekArr;
}
// 判断是否是同一天

- (BOOL)isSameDay:(NSDate *)date1 date2:(NSDate *)date2
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlag = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *comp1 = [calendar components:unitFlag fromDate:date1];
    NSDateComponents *comp2 = [calendar components:unitFlag fromDate:date2];
    return (([comp1 day] == [comp2 day]) && ([comp1 month] == [comp2 month]) && ([comp1 year] == [comp2 year]));
}
- (void)updateBookTimeWeekViewDate:(NSString *)date
{
    NSDate *newdate = [self stringToDate:date withDateFormat:@"yyyy-MM-dd"];
    _selectYear = [date substringWithRange:NSMakeRange(0, 5)];
    NSMutableArray * weekArr = [self getweeksFromDate:newdate];
    _weekArr = weekArr;
    BookTimeWeekModel * model0 = weekArr[0];
    _lbWeek1.text = model0.week;
    _lbDate1.text = model0.date;
    
    BookTimeWeekModel * model1 = weekArr[1];
    _lbWeek2.text = model1.week;
    _lbDate2.text = model1.date;
    
    BookTimeWeekModel * model2 = weekArr[2];
    _lbWeek3.text = model2.week;
    _lbDate3.text = model2.date;
    
    BookTimeWeekModel * model3 = weekArr[3];
    _lbWeek4.text = model3.week;
    _lbDate4.text = model3.date;
    
}
- (IBAction)more:(UIButton *)sender
{
    if (_BookTimeWeekViewMoreBlock) {
        _BookTimeWeekViewMoreBlock();
    }
}
- (void)weekClick:(UITapGestureRecognizer *)tap
{
    if (_weekArr.count > 0) {
        BookTimeWeekModel * model = _weekArr[tap.view.tag -100];
        if (_BookTimeWeekViewDateBlock) {
            _BookTimeWeekViewDateBlock([NSString stringWithFormat:@"%@%@",_selectYear,model.date]);
        }
    }
    
    for (UIView * containView in self.subviews) {
        if (tap.view.tag == containView.tag) {
            for (UIView * subView in containView.subviews) {
                if ([subView isKindOfClass:[UILabel class]]) {
                    UILabel * lb = (UILabel *)subView;
                    lb.textColor = kBtn_Commen_Color;
                }
                if ([subView isKindOfClass:[UIView class]]) {
                    if (subView.tag == 12) {
                        subView.hidden = NO;
                    }
                }
            }
        }else{
            for (UIView * subView in containView.subviews) {
                if ([subView isKindOfClass:[UILabel class]]) {
                    UILabel * lb = (UILabel *)subView;
                    if (lb.tag == 10) {
                        lb.textColor = kLabelText_Commen_Color_3;
                    }
                    if (lb.tag == 11) {
                        lb.textColor = kLabelText_Commen_Color_9;
                    }
                }
                if ([subView isKindOfClass:[UIView class]]) {
                    if (subView.tag == 12) {
                        subView.hidden = YES;
                    }
                }
            }
        }
        
    }
}
//将世界时间转化为中国区时间
- (NSDate *)worldTimeToChinaTime:(NSDate *)date
{
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSInteger interval = [timeZone secondsFromGMTForDate:date];
    NSDate *localeDate = [date  dateByAddingTimeInterval:interval];
    return localeDate;
}
//日期格式转字符串
- (NSString *)dateToString:(NSDate *)date withDateFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}

//字符串转日期格式
- (NSDate *)stringToDate:(NSString *)dateString withDateFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    
    NSDate *date = [dateFormatter dateFromString:dateString];
    return [self worldTimeToChinaTime:date];
}
@end
#pragma clang diagnostic pop
