//
//  LanternMProHeaderView.m
//  xmh
//
//  Created by ald_ios on 2019/2/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternMProHeaderView.h"
@interface LanternMProHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UIButton *btnMore;
//@property (weak, nonatomic) IBOutlet UIView *bottomLine;
//@property (weak, nonatomic) IBOutlet UIView *topLine;

@end
@implementation LanternMProHeaderView
{
    BOOL _selected;
    
    NSMutableDictionary * _param;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDowm:)];
    [self addGestureRecognizer:tap];
}

- (void)updateViewParam:(NSMutableDictionary *)param
{
    _param = param;
    _lbName.text = param[@"name"];
    if ([param.allKeys containsObject:@"show"]) {
        _btnMore.selected = NO;
    }else{
        if ([param[@"selected"] integerValue] == 0) {
            _btnMore.selected = NO;
        }else{
            _btnMore.selected = YES;
        }
    }
}
- (void)updateViewParam:(NSMutableDictionary *)param module:(NSInteger)module
{
    _param = param;
    _lbName.text = param[@"name"];
    if (module == 0) {
        if ([param.allKeys containsObject:@"show"]) {
            _btnMore.selected = NO;
            _btnMore.hidden = NO;
        }else{
            _btnMore.hidden = YES;
        }
    }else{
        _btnMore.hidden = NO;
        if ([param[@"selected"] integerValue] == 0) {
            _btnMore.selected = NO;
        }else{
            _btnMore.selected = YES;
        }
    }
    if (module == 0) {
        _lbName.textColor = kColor9;
        _lbName.font = FONT_SIZE(14);
        _lbName.text = param[@"name"];
    }
}
- (void)tapDowm:(UITapGestureRecognizer *)tap
{
    if ([_param.allKeys containsObject:@"show"]) {
        if (_LanternMProHeaderViewMoreBlock) {
            _LanternMProHeaderViewMoreBlock(_param);
        }
    }else{
        if ([_param[@"selected"] integerValue] == 0) {
            _param[@"selected"] = @"1";
        }else{
            _param[@"selected"] = @"0";
        }
        if (_LanternMProHeaderViewTapBlock) {
            _LanternMProHeaderViewTapBlock(0);
        }
        if (_LanternMProHeaderViewClickBlock) {
            _LanternMProHeaderViewClickBlock(_param);
        }
    }
}
- (void)updateViewParam:(NSMutableDictionary *)param section:(NSInteger)section module:(NSInteger)module
{
    _param = param;
    if (module == 0) {
        _bottomLine.hidden = _topLine.hidden = YES;
    }
    if (section != 0) {
        _btnMore.hidden = YES;
        self.userInteractionEnabled = NO;
    }else{
        _btnMore.hidden = NO;
    }
    _lbName.textColor = kColor9;
    _lbName.font = FONT_SIZE(14);
    _lbName.text = param[@"name"];
}
@end
