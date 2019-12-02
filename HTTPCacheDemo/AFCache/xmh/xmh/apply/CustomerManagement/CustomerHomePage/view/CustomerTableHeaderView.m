//
//  CustomerTableHeaderView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/27.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "CustomerTableHeaderView.h"
#import "DateHeaderView.h"
#import "JobSelector.h"

#import "DatePickerView.h"
#import "LDatePickView.h"

@implementation CustomerTableHeaderView

{
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    if ( self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
    }
    return self;
}
-(void)setDateTap:(DateTap)dateTap{
    _dateTap = dateTap;
    [self initSubViews];
}
- (void)initSubViews
{
    if (_dateHeaderView == nil) {
        _dateHeaderView = [[LDatePickView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44) dateBlock:^(NSString *start, NSString *end) {
            self.dateTap(start, end);
        }];
        _dateHeaderView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_dateHeaderView];
    }

    if (!_organizationHeader) {
        _organizationHeader = [[organizationalStructureView alloc]initWithFrame:CGRectMake(0, 54, SCREEN_WIDTH, 49)];
        [self addSubview:_organizationHeader];
    }
    
    if (_jobSelector == nil) {
        _jobSelector = [[[NSBundle mainBundle] loadNibNamed:@"JobSelector" owner:nil options:nil] firstObject];
        _jobSelector.left = 0;
        _jobSelector.top = 103;
        _jobSelector.width = SCREEN_WIDTH;
        [self addSubview:_jobSelector];
    }

}
- (void)setOrganizationalStructureViewBlock:(void (^)(NSString *, NSString *, NSString *, NSString *, NSString *,NSInteger,NSInteger,List*))organizationalStructureViewBlock{
    _organizationalStructureViewBlock = organizationalStructureViewBlock;
    _organizationHeader.organizationalStructureViewBlock = _organizationalStructureViewBlock;
}



@end
