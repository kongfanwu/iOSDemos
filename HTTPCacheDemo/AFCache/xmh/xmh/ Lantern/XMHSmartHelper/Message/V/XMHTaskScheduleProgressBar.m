//
//  XMHTaskScheduleProgressBar.m
//  xmh
//
//  Created by shendengmeiye on 2019/6/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHTaskScheduleProgressBar.h"
@interface XMHTaskScheduleProgressBar ()

@property(strong,nonatomic)UIView *bgView;
@property(strong,nonatomic)UIView *progressView;

@end


@implementation XMHTaskScheduleProgressBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 30, 15)];
        self.bgView.backgroundColor = [ColorTools colorWithHexString:@"#F5F5F5"];
        self.bgView.layer.cornerRadius = 7.5;
        self.bgView.layer.masksToBounds = YES;
        
        self.progressView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 15)];
        self.progressView.backgroundColor = [ColorTools colorWithHexString:@"#FF9072"];
        self.progressView.layer.cornerRadius = 7.5;
        self.progressView.layer.masksToBounds = YES;
        [self.bgView addSubview:self.progressView];
        [self addSubview:self.bgView];
    }
    return self;
}

- (void)setPercent:(CGFloat)percent
{
    if (percent > 0) {
        CGRect changeFrame = self.progressView.frame;
        changeFrame.size.width = self.bgView.frame.size.width * percent;
        self.progressView.frame=changeFrame;
    }
}
@end
