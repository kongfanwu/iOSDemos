//
//  LanternRecommendSwtichView.m
//  xmh
//
//  Created by ald_ios on 2018/12/24.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternRecommendSwtichView.h"
@interface LanternRecommendSwtichView ()
@property (weak, nonatomic) IBOutlet UIButton *btnLeft;
@property (weak, nonatomic) IBOutlet UIButton *btnRight;
@property (weak, nonatomic) IBOutlet UILabel *line;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineX;

@end
@implementation LanternRecommendSwtichView
{
    UIButton * _selectBtn;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self btnClick:_btnLeft];
}
- (IBAction)btnClick:(UIButton *)sender {
    
    [sender setTitleColor:[ColorTools colorWithHexString:@"#EA007E"] forState:UIControlStateNormal];
    [_selectBtn setTitleColor:kColor6 forState:UIControlStateNormal];
    _selectBtn = sender;
    if (sender.tag == 100) {//设定下月计划
        _lineX.constant = _btnLeft.width * 0.75 -_line.width;
    }
    if (sender.tag == 101) {//补签本月计划
        _lineX.constant = _btnLeft.width *1.25;
        
    }
    if (_LanternRecommendSwtichViewBlock) {
        _LanternRecommendSwtichViewBlock(sender.tag);
    }
}
@end
