//
//  BookStaffCalenderCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/27.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BookStaffCalenderCell.h"
#import "BookReachView.h"
#import "LXCalender.h"
#import "CountView.h"
@implementation BookStaffCalenderCell{
    
    CountView * _count;
//    LXCalendarView * _calender;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)initSubViews{
    
    BookReachView * reach = [[BookReachView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    [self addSubview:reach];
    
    LXCalendarView * calender = [[LXCalendarView alloc] initWithFrame:CGRectMake(0, reach.bottom, SCREEN_WIDTH, 320)];
    calender.currentMonthTitleColor = [ColorTools colorWithHexString:@"#2c2c2c"];
    calender.lastMonthTitleColor = kLabelText_Commen_Color_9;
    calender.nextMonthTitleColor = kLabelText_Commen_Color_9;
    calender.isHaveAnimation = YES;
    calender.isCanScroll = NO;
    calender.isShowLastAndNextBtn = YES;
    calender.isShowLastAndNextDate = NO;
    calender.todayTitleColor = [UIColor purpleColor];
    calender.selectBackColor = [ColorTools colorWithHexString:@"e5e5e5"];;
    calender.backgroundColor = [UIColor whiteColor];
    _calender = calender;
//    calender.selectBlock = ^(NSInteger year, NSInteger month, NSInteger day) {
//        NSLog(@"%ld-%ld-%ld",year,month,day);
//        _count.lb4.hidden = YES;
//        _count.lb6.hidden = YES;
//    };
    _count.lb4.hidden = NO;
    _count.lb6.hidden = NO;
    [self addSubview:calender];
    
    CountView * count = [[CountView alloc] init];
    _count = count;
    count.frame = CGRectMake(0, calender.bottom - 40, SCREEN_WIDTH, 64);
    [count updateCountView];
//    UIView *line = [[UIView alloc] init];
//    line.frame = CGRectMake(0, calender.bottom - 40 +54, SCREEN_WIDTH, 10);
//    line.backgroundColor = kBackgroundColor;
    [self addSubview:count];
//    [self addSubview:line];
    
}
- (void)updateBookStaffCalenderCellCalendarModel:(LolCalendarModelList *)model{
    
    [_count updateCountViewCalendarModelList:model];
    [_calender dealData:model];
    
}
- (void)updateBookStaffCalenderCellCalendarModel:(LolCalendarModelList *)model date:(NSDate *)date{
    [_count updateCountViewCalendarModelList:model];
    [_calender dealData:model];
}
@end
