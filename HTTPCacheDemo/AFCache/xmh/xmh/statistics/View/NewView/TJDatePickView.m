//
//  TJDatePickView.m
//  xmh
//
//  Created by ald_ios on 2018/12/5.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "TJDatePickView.h"
#import "TJDatePickHeaderView.h"
#import "TJPickTimeView.h"
#import "DateTools.h"
@interface TJDatePickView ()
@property (nonatomic, strong)UIView *containerView;
@property (nonatomic, strong)UIView *bgView;
@property (nonatomic, strong)TJDatePickHeaderView *pickHeaderView;
@property (nonatomic, strong)TJPickTimeView *leftPickTimeView;
@property (nonatomic, strong)TJPickTimeView *rightPickTimeView;
@end
@implementation TJDatePickView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.bgView];
        [self addSubview:self.containerView];
        [self.containerView addSubview:self.pickHeaderView];
        [self.containerView addSubview:self.leftPickTimeView];
        [self.containerView addSubview:self.rightPickTimeView];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame cornerRadius:(CGFloat)cornerRadius
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.bgView];
        [self addSubview:self.containerView];
        [self.containerView addSubview:self.pickHeaderView];
        _pickHeaderView.lb.hidden = YES;
        _pickHeaderView.btnCancel.hidden = YES;
        _pickHeaderView.btnleft.hidden = NO;
        [self.containerView addSubview:self.leftPickTimeView];
        [self.containerView addSubview:self.rightPickTimeView];
        _containerView.layer.cornerRadius = cornerRadius;
        _containerView.layer.masksToBounds = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
- (TJPickTimeView *)leftPickTimeView
{
    if (!_leftPickTimeView) {
        _leftPickTimeView = [[TJPickTimeView alloc] initWithFrame:CGRectMake(0, _pickHeaderView.bottom,SCREEN_WIDTH/2, _containerView.height - 50) title:@"起始时间"];
        _leftPickTimeView.backgroundColor = [UIColor whiteColor];
    }
    return _leftPickTimeView;
}
- (TJPickTimeView *)rightPickTimeView
{
    if (!_rightPickTimeView) {
        _rightPickTimeView = [[TJPickTimeView alloc] initWithFrame:CGRectMake(_leftPickTimeView.right, _pickHeaderView.bottom,SCREEN_WIDTH/2, _containerView.height - 50) title:@"结束时间"];
        _rightPickTimeView.backgroundColor = [UIColor whiteColor];
    }
    return _rightPickTimeView;
}
- (TJDatePickHeaderView *)pickHeaderView
{
    if (!_pickHeaderView) {
        _pickHeaderView = loadNibName(@"TJDatePickHeaderView");
        _pickHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
        [_pickHeaderView.btnCancel addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [_pickHeaderView.btnSure addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [_pickHeaderView.btnleft addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pickHeaderView;
}
- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0.4;
    }
    return _bgView;
}
- (UIView *)containerView
{
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 320, SCREEN_WIDTH, 320)];
        [_containerView addSubview:self.pickHeaderView];
    }
    return _containerView;
}
- (void)click:(UIButton *)btn
{
    if (btn.tag == 100) {
        [self removeFromSuperview];
    }
    if (btn.tag == 101) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString * endTime = [DateTools getMonthLastDayWith:_rightPickTimeView.selectDateStr];
        NSString * startTime = [DateTools getMonthFirstDayWith:_leftPickTimeView.selectDateStr];
        NSDate *endDate = [dateFormatter dateFromString:endTime];
        NSDate *startDate = [dateFormatter dateFromString:startTime];
        NSComparisonResult result = [startDate compare:endDate];
        if (result == NSOrderedDescending) {
            [XMHProgressHUD showOnlyText:@"开始时间不能大于结束时间"];
        }else{
            if (_TJDatePickView) {
                _TJDatePickView(startTime,endTime);
            }
            [self removeFromSuperview];
        }
        
    }
}
- (void)tap:(UITapGestureRecognizer *)tap
{
    [self removeFromSuperview];
}
@end
