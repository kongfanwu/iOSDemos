//
//  CheckPlanCell.m
//  xmh
//
//  Created by ald_ios on 2018/12/24.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "CheckPlanCell.h"
#import "LanternHistoryPlanListModel.h"
@interface CheckPlanCell ()
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnXS;
@property (weak, nonatomic) IBOutlet UIButton *btnXH;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation CheckPlanCell
{
    LanternHistoryPlanModel * _model;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _btnXH.layer.cornerRadius = 3;
    _btnXH.layer.borderWidth = 0.5;
    _btnXH.layer.borderColor = kColorTheme.CGColor;
    [_btnXH setTitleColor:kColorTheme forState:UIControlStateNormal];
    
    _btnXS.layer.cornerRadius = 3;
    _btnXS.layer.borderWidth = 0.5;
    _btnXS.layer.borderColor = kColorTheme.CGColor;
    [_btnXS setTitleColor:kColorTheme forState:UIControlStateNormal];
    
    _lbTitle.textColor = kColor3;
    
    _containerView.layer.cornerRadius = 5;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}
- (void)updateCheckPlanCellModel:(LanternHistoryPlanModel *)model
{
    _model = model;
    _lbTitle.text = [NSString stringWithFormat:@"%@月计划",model.month];
    if (model.consume.integerValue == 0) {
        _btnXS.layer.borderColor = kColor9.CGColor;
        [_btnXS setTitleColor:kColor9 forState:UIControlStateNormal];
    }
    if (model.consume.integerValue == 1) {
        _btnXS.layer.borderColor = kColorTheme.CGColor;
        [_btnXS setTitleColor:kColorTheme forState:UIControlStateNormal];
    }
    if (model.expend.integerValue == 0) {
        _btnXH.layer.borderColor = kColor9.CGColor;
        [_btnXH setTitleColor:kColor9 forState:UIControlStateNormal];
    }
    if (model.expend.integerValue == 1) {
        _btnXH.layer.borderColor = kColorTheme.CGColor;
        [_btnXH setTitleColor:kColorTheme forState:UIControlStateNormal];
    }
}
- (IBAction)xsClick:(UIButton *)sender {
    if (_CheckPlanCellXSBlock) {
        _CheckPlanCellXSBlock(_model);
    }
}
- (IBAction)xhClick:(UIButton *)sender {
    if (_CheckPlanCellXHBlock) {
        _CheckPlanCellXHBlock(_model);
    }
}

@end
