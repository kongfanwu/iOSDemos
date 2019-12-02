//
//  SalePerformanceChoiceView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/10.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SalePerformanceChoiceView.h"

@implementation SalePerformanceChoiceView{
    NSString * _oneStr;
    NSString * _twoStr;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self btnEvent:_btn1];
}
- (IBAction)btnEvent:(UIButton *)sender {
    for (UIView *tempView in self.subviews) {
        if ([tempView isKindOfClass:[UIButton class]]) {
            if (tempView.tag == sender.tag) {
                sender.selected = YES;
//                _redLine.center = CGPointMake(sender.center.x, _redLine.center.y);
                if (sender.tag == 1000) {
                    _oneStr = @"销售单数（个）：";
                    _twoStr = @"总金额（元）：";
                }else if (sender.tag == 1001){
                    _oneStr = @"分期单数（个）：";
                    _twoStr = @"总金额（元）：";
                }else{
                    _oneStr = @"销售服务单数（个）：";
                    _twoStr = @"总金额（元）：";
                }
            } else {
                UIButton *temp = (UIButton *)tempView;
                temp.selected = NO;
            }
        }
    }
    if (_SalePerformanceChoiceViewBlock) {
       NSString * str =  [NSString stringWithFormat:@"%ld",sender.tag - 1000];
        _SalePerformanceChoiceViewBlock(str);
    }
}
- (void)setYejiListModel:(LOrderYejiListModel *)yejiListModel
{
    _lb1.text = [NSString stringWithFormat:@"%ld",yejiListModel.sales_num];
    _lb2.text = [NSString stringWithFormat:@"%@",yejiListModel.sales_amount];
    _lbOneTitle.text = [NSString stringWithFormat:@"%@",_oneStr];
    _lbTwotitle.text = [NSString stringWithFormat:@"%@",_twoStr];
}
@end
