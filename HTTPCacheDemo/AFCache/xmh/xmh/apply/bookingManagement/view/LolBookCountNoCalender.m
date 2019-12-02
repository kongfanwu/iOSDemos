//
//  LolBookCountNoCalender.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/27.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LolBookCountNoCalender.h"
#import "CountView.h"
#import "LolCalendarModelList.h"
#import "LolGuKeListModel.h"
@implementation LolBookCountNoCalender
{
    UILabel * _lb1;
    CountView * _count;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self initSubViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)initSubViews
{
//    UILabel * lb1 = [[UILabel alloc] init];
//    lb1.backgroundColor = kBackgroundColor;
//    _lb1 = lb1;
//    [self addSubview:lb1];
    
    _count = [[CountView alloc] init];
    [self addSubview:_count];
    
}
- (void)updateLolBookCountNoCalender
{
//    _lb1.frame = CGRectMake(0, 0, SCREEN_WIDTH, 10);
    _count.frame = CGRectMake(0, 10, SCREEN_WIDTH, self.height - 10);
    [_count updateCountView];
}
- (void)setGuKeListModel:(LolGuKeListModel *)guKeListModel{
    LolCalendarModelList * model = [[LolCalendarModelList alloc] init];
    model.num = guKeListModel.num;
    model.pro_num = guKeListModel.pro_num;
    model.probability = guKeListModel.probability;
    model.serv_num = guKeListModel.serv_num;
    model.standard = guKeListModel.standard;
    model.isShowProbability = guKeListModel.isShow;
    model.date = guKeListModel.date;
    [_count updateCountViewCalendarModelList:model];
}
@end
