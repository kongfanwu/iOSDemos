//
//  XMHSelectDateView.m
//  xmh
//
//  Created by KFW on 2019/4/3.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHSelectDateView.h"
#import "NSDate-Helper.h"

@interface XMHSelectDateView()
/** <##> */
@property (nonatomic, strong) UIView *dateBgView;
/** <##> */
@property (nonatomic, strong) UIButton *dateButton;
/** <##> */
@property (nonatomic, strong) NSMutableArray *buttons;
@end

@implementation XMHSelectDateView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        
        self.dateBgView = UIView.new;
        _dateBgView.layer.cornerRadius = 5;
        _dateBgView.layer.masksToBounds = YES;
        _dateBgView.backgroundColor = UIColor.whiteColor;
        [self addSubview:_dateBgView];
        [_dateBgView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.left.mas_equalTo(10);
            make.height.mas_equalTo(44);
            make.width.mas_equalTo(127);
        }];
        
        UIImageView *dateLogoImageView = [[UIImageView alloc] initWithImage:UIImageName(@"rili")];
        [_dateBgView addSubview:dateLogoImageView];
        [dateLogoImageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.size.mas_equalTo(CGSizeMake(21, 21));
            make.centerY.equalTo(_dateBgView);
            make.left.mas_equalTo(10);
        }];

        self.dateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_dateButton setTitle:@"请选择时间 " forState:UIControlStateNormal];
        [_dateButton setTitleColor:kColor9 forState:UIControlStateNormal];
        [_dateButton setImage:UIImageName(@"shouye-xiaojiantou-min") forState:UIControlStateNormal];
        _dateButton.titleLabel.font = FONT_SIZE(14);
        _dateButton.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft; // 左右翻转
        _dateButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight; // 内容靠右
        _dateButton.titleLabel.textAlignment = NSTextAlignmentLeft; // 靠左，以显示label后边的空格间距
        _dateButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_dateButton addTarget:self action:@selector(selectDateButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_dateBgView addSubview:_dateButton];
        [_dateButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(dateLogoImageView.mas_right);
            make.top.bottom.equalTo(_dateBgView);
            make.right.mas_equalTo(-5);
        }];
        
        UIView *rightView = UIView.new;
        [self addSubview:rightView];
        [rightView mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(_dateBgView.mas_right);
            make.right.mas_equalTo(0);
            make.top.height.equalTo(_dateBgView);
        }];

        
        self.buttons = NSMutableArray.new;
        NSArray *titles = @[@"今日", @"近7天", @"本月"];
        for (int i = 0; i < titles.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundImage:[UIImage imageWithColor:UIColor.whiteColor size:CGSizeMake(10, 10)] forState:UIControlStateNormal];
            [button setTitle:titles[i] forState:UIControlStateNormal];
            [button setTitleColor:kColor6 forState:UIControlStateNormal];
            [button setTitleColor:kBtn_Commen_Color forState:UIControlStateSelected];
            button.titleLabel.font = FONT_SIZE(14);
            button.layer.cornerRadius = 5;
            button.layer.masksToBounds = YES;
            [button addTarget:self action:@selector(dateButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [rightView addSubview:button];
            button.tag = 1000 + i;
            [_buttons addObject:button];
        }
        
        [self.buttons mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(44);
            make.bottom.equalTo(rightView);
        }];
        [self.buttons mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:10 tailSpacing:10];
        
//        [self dateButtonClick:self.buttons.firstObject];
        
    }
    return self;
}

/**
 选择日期
 */
- (void)selectDateButtonClick:(UIButton *)sender {
    if (self.selectDateBlock) self.selectDateBlock(self);
}

/**
 @"今日", @"近7天", @"本月"
 */
- (void)dateButtonClick:(UIButton *)sender {
    [self.buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = NO;
    }];
    sender.selected = YES;
    self.selectButton = sender;
    
    NSString *endDate = [NSDate.new dateStringForYearMonthDay];
    NSString *startDate;
    // 今日
    if (sender.tag == 1000) {
        startDate = endDate;
    }
    // 近7天
    else if (sender.tag == 1001) {
        startDate = [[NSDate.new dateAfterDay:-8] stringWithFormat:@"yyyy-MM-dd"];
    }
    // 本月
    else if (sender.tag == 1002) {
        NSDate *date = NSDate.new;
        int dayCount = (int)[date getDayNumOfMonth];
        startDate = [[NSDate.new dateAfterDay:-dayCount] stringWithFormat:@"yyyy-MM-dd"];
    }
    
    if (self.dateBlock && startDate && endDate) {
        self.dateBlock(self, startDate, endDate);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
