//
//  LanternRecommendCell.m
//  xmh
//
//  Created by ald_ios on 2018/12/24.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternRecommendCell.h"
#import "LanternRecommedListModel.h"
#import <YYWebImage/YYWebImage.h>
@interface LanternRecommendCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbGrade;
@property (weak, nonatomic) IBOutlet UIButton *btnXFProperty;
@property (weak, nonatomic) IBOutlet UIButton *btnXHProperty;
@property (weak, nonatomic) IBOutlet UIButton *btnXFRecommend;
@property (weak, nonatomic) IBOutlet UIButton *btnXHRecommend;
@property (weak, nonatomic) IBOutlet UIButton *btnXFSuccess;
@property (weak, nonatomic) IBOutlet UIButton *btnXHSuccess;

@end
@implementation LanternRecommendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _lbName.textColor = kColor3;
    _lbGrade.textColor = kColor9;
    
    _btnXFSuccess.layer.cornerRadius = _btnXHSuccess.layer.cornerRadius = _btnXFProperty.layer.cornerRadius = _btnXHProperty.layer.cornerRadius = _btnXFRecommend.layer.cornerRadius = _btnXHRecommend.layer.cornerRadius = 3;;
    _btnXFSuccess.layer.masksToBounds = _btnXHSuccess.layer.masksToBounds = _btnXFProperty.layer.masksToBounds = _btnXHProperty.layer.masksToBounds = _btnXFRecommend.layer.masksToBounds = _btnXHRecommend.layer.masksToBounds = YES;
    
    _btnXFSuccess.backgroundColor = _btnXHSuccess.backgroundColor = _btnXFProperty.backgroundColor = _btnXHProperty.backgroundColor = _btnXFRecommend.backgroundColor = _btnXHRecommend.backgroundColor = [ColorTools colorWithHexString:@"#FEF2EF"];
    
    UIColor * btnTextColor = [ColorTools colorWithHexString:@"#FF9072"];
    [_btnXFRecommend setTitleColor:btnTextColor forState:UIControlStateNormal];
    [_btnXHRecommend setTitleColor:btnTextColor forState:UIControlStateNormal];
    [_btnXFProperty setTitleColor:btnTextColor forState:UIControlStateNormal];
    [_btnXHProperty setTitleColor:btnTextColor forState:UIControlStateNormal];
    [_btnXFSuccess setTitleColor:btnTextColor forState:UIControlStateNormal];
    [_btnXHSuccess setTitleColor:btnTextColor forState:UIControlStateNormal];
    
    _icon.layer.masksToBounds = YES;
    _icon.layer.cornerRadius = _icon.height/2;
    _icon.image = kDefaultCustomerImage;
}
- (void)updateLanternRecommendCellModel:(LanternRecommedModel *)model
{
    [_icon yy_setImageWithURL:URLSTR(model.img) placeholder:kDefaultCustomerImage];
    _lbName.text = model.name;
    _lbGrade.text = model.grade;
    [_btnXFProperty setTitle:model.consumeAttr forState:UIControlStateNormal];
    [_btnXHProperty setTitle:model.expendAttr forState:UIControlStateNormal];
    [_btnXFRecommend setTitle:model.consumeReco forState:UIControlStateNormal];
    [_btnXHRecommend setTitle:model.expendReco forState:UIControlStateNormal];
    [_btnXFSuccess setTitle:model.consumeRate forState:UIControlStateNormal];
    [_btnXHSuccess setTitle:model.expendRate forState:UIControlStateNormal];
    
    if ([model.consumeRate isEqualToString:@"不推荐销售"]) {
        _btnXFSuccess.backgroundColor = [ColorTools colorWithHexString:@"#F3F3F3"];
        [_btnXFSuccess setTitleColor:kColor9 forState:UIControlStateNormal];
    }
    if ([model.expendRate isEqualToString:@"不推荐消耗"]) {
        _btnXHSuccess.backgroundColor = [ColorTools colorWithHexString:@"#F3F3F3"];
        [_btnXHSuccess setTitleColor:kColor9 forState:UIControlStateNormal];
    }
    if ([model.grade isEqual:[NSNull class]] || model.grade.length == 0) {
        _lbGrade.hidden = YES;
    }
}

@end
