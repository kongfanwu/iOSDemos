//
//  GKGLBillVerifySectionHeaderView.m
//  xmh
//
//  Created by ald_ios on 2019/1/22.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLBillVerifySectionHeaderView.h"
@interface GKGLBillVerifySectionHeaderView ()
@property (weak, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *lbName;

@end
@implementation GKGLBillVerifySectionHeaderView
- (void)awakeFromNib
{
    [super awakeFromNib];
    _view.layer.cornerRadius = 5;
    _view.layer.masksToBounds = YES;
    self.layer.masksToBounds = YES;
    _lbName.textColor = kColorTheme;
}
- (void)updateTitle:(NSString *)title index:(NSInteger)index
{
    if (index == 0) {
        _lbName.text = @"储值卡";
    }else if (index == 1){
        _lbName.text = @"时间卡";
    }else if (index == 2){
        _lbName.text = @"任选卡";
    }else if (index == 3){
        _lbName.text = @"项目";
    }else if (index == 4){
        _lbName.text = @"产品";
    }else if (index == 5){
        _lbName.text = @"票券";
    }
}
@end
