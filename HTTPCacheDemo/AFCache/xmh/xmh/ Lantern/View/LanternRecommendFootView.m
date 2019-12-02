//
//  LanternRecommendFootView.m
//  xmh
//
//  Created by ald_ios on 2018/12/27.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternRecommendFootView.h"
@interface LanternRecommendFootView ()
@property (weak, nonatomic) IBOutlet UIButton *btnLeft;
@property (weak, nonatomic) IBOutlet UIButton *btnRight;

@end
@implementation LanternRecommendFootView
- (void)awakeFromNib
{
    [super awakeFromNib];
    _btnLeft.backgroundColor = _btnRight.backgroundColor = [ColorTools colorWithHexString:@"#EA007E"];
    _btnLeft.layer.cornerRadius = _btnRight.layer.cornerRadius = 3;
    _btnLeft.titleLabel.font = _btnRight.titleLabel.font = FONT_SIZE(14);
        
}
- (IBAction)btnLeftClick:(id)sender {
    if (_LanternRecommendFootViewBlock) {
        _LanternRecommendFootViewBlock(@"1");
    }
}
- (IBAction)btnRightClick:(id)sender {
    if (_LanternRecommendFootViewBlock) {
        _LanternRecommendFootViewBlock(@"2");
    }
}
- (void)updateLanternRecommendFootViewLeftEnable:(NSString *)leftenable rightEnable:(NSString *)rightenable
{
    if (leftenable.integerValue == 0) {
        _btnLeft.backgroundColor = [ColorTools colorWithHexString:@"#EA007E"];
        _btnLeft.enabled = YES;
    }
    if (leftenable.integerValue == 1) {
        _btnLeft.backgroundColor = kColor9;
        _btnLeft.enabled = NO;
    }
    if (rightenable.integerValue == 0) {
        _btnRight.backgroundColor = [ColorTools colorWithHexString:@"#EA007E"];
        _btnRight.enabled = YES;
    }
    if (rightenable.integerValue == 1) {
        _btnRight.backgroundColor = kColor9;
        _btnRight.enabled = NO;
    }
}
- (void)updateLanternRecommendFootViewMonth:(NSString *)month
{
    NSString * tempMonth = [month substringWithRange:NSMakeRange(month.length-2, 2)];
    NSMutableString * show = [NSMutableString stringWithFormat:@"%@",tempMonth];
    if ([show containsString:@"0"]) {
        NSRange range = [show rangeOfString:@"0"];
        [show replaceCharactersInRange:range withString:@""];
    }
    [_btnLeft setTitle:[NSString stringWithFormat:@"生成%@月销售目标",show] forState:UIControlStateNormal];
    [_btnRight setTitle:[NSString stringWithFormat:@"生成%@月消耗目标",show] forState:UIControlStateNormal];
}
@end
