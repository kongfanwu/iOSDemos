//
//  LanternPlanSetionHeardView.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/12/25.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternPlanSetionHeardView.h"
#import "LanternPlanInfoListModel.h"
#import "NSString+Costom.h"
@implementation LanternPlanSetionHeardView
{
    __weak IBOutlet NSLayoutConstraint *recommendW;
    MzzSectionTags *selectModel;
    BOOL isSelect;
    __weak IBOutlet NSLayoutConstraint *recommendH;
    
    LanternPlanInfoModel * _model;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)updateSectionModel:(MzzSectionTags *)model{
    
    selectModel = model;
    self.sectionTitle.text = model.name;
    self.recommendedTitle.text = model.rate;
    if ([selectModel.select isEqualToString:@"0"]) {
        [self.selectButton setImage:[UIImage imageNamed:@"styygl_duoxuanweixuan"] forState:UIControlStateNormal];
    }else{
        [self.selectButton setImage:[UIImage imageNamed:@"styygl_duoxuanyixuan"] forState:UIControlStateNormal];
    }
}
//添加按钮点击事件
- (IBAction)addButtonAction:(id)sender {
//    if (_LanternPlanAddButtonBlock) {
//        _LanternPlanAddButtonBlock(selectModel);
//    }
    if (_LanternPlanSetionHeardViewAddBlock) {
        _LanternPlanSetionHeardViewAddBlock(_model);
    }
}
//选中按钮点击事件
- (IBAction)selectButtonAction:(id)sender {
    _model.selected = !_model.selected;
    if (_LanternPlanSetionHeardViewSelectBlock) {
        _LanternPlanSetionHeardViewSelectBlock(_model);
    }
//    if ([selectModel.select isEqualToString:@"0"]) {
//        selectModel.select = @"1";
//        isSelect = NO;
//    }else{
//        selectModel.select = @"0";
//        isSelect = YES;
//    }
//    if (_LanternPlanSelectButtonBlock) {
//        _LanternPlanSelectButtonBlock(selectModel);
//    }
}

- (void)updateLanternPlanSetionHeardViewModel:(LanternPlanInfoModel *)model
{
    _model = model;
    _sectionTitle.text = model.name;
    CGFloat w = [model.rate stringWidthWithFont:FONT_SIZE(11)];
    recommendW.constant = w + 15;
    recommendH.constant = 14;
    _recommendedTitle.text = model.rate;
    _recommendedTitle.layer.cornerRadius = 3;
    if ([model.rate isEqual:[NSNull class]]|| model.rate.length == 0) {
        _recommendedTitle.hidden = YES;
    }
    if (model.selected) {
        [_selectButton setImage:[UIImage imageNamed:@"styygl_duoxuanyixuan"] forState:UIControlStateNormal];
    }else{
        [_selectButton setImage:[UIImage imageNamed:@"styygl_duoxuanweixuan"] forState:UIControlStateNormal];
    }
}
@end
