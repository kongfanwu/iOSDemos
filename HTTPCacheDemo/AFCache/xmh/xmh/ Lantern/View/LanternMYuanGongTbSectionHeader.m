//
//  LanternMYuanGongTbSectionHeader.m
//  xmh
//
//  Created by ald_ios on 2019/2/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternMYuanGongTbSectionHeader.h"
@interface LanternMYuanGongTbSectionHeader ()
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UIButton *btnMore;
@property (nonatomic, assign)NSInteger section;
@end
@implementation LanternMYuanGongTbSectionHeader
{
    NSMutableDictionary * _param;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDowm:)];
    [self addGestureRecognizer:tap];
}
- (void)tapDowm:(UITapGestureRecognizer *)tap
{
    if ([_param[@"selected"] integerValue] == 0) {
        _param[@"selected"] = @"1";
    }else{
        _param[@"selected"] = @"0";
    }
    if (_LanternMYuanGongTbSectionHeaderBlock) {
        _LanternMYuanGongTbSectionHeaderBlock(_section);
    }
    if (_LanternMYuanGongTbSectionHeaderTapBlock) {
        _LanternMYuanGongTbSectionHeaderTapBlock(_param);
    }
}
- (void)updateViewTitle:(NSString *)title
{
    _lbName.text = title;
}
- (void)updateViewTitle:(NSString *)title section:(NSInteger)section
{
    _lbName.text = title;
    _section = section;
}
- (void)updateViewParam:(NSMutableDictionary *)param
{
    _param = param;
    _lbName.text = param[@"name"];
    if ([param[@"selected"] integerValue] == 0) {
        _btnMore.selected = NO;
    }else{
        _btnMore.selected = YES;
    }
}
@end
