//
//  LanternMResultTbHeaderView.m
//  xmh
//
//  Created by ald_ios on 2019/2/15.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternMResultTbHeaderView.h"
@interface LanternMResultTbHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *lbResult;
@property (weak, nonatomic) IBOutlet UILabel *lbNum;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet UILabel *lbPercent;

@end
@implementation LanternMResultTbHeaderView
- (void)updateViewParam:(NSDictionary *)param
{
    _lbNum.text = [NSString stringWithFormat:@"数量：%@个",param[@"num"]];
    _lbPercent.text = [NSString stringWithFormat:@"占比：%@%@",param[@"zhanbi"]?param[@"zhanbi"]:@"0",@"%"];
}
- (IBAction)saveTap:(UIButton *)sender {
    if (_LanternMResultTbHeaderViewBlock) {
        _LanternMResultTbHeaderViewBlock();
    }
}
@end
