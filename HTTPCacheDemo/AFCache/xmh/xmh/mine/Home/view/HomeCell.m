//
//  HomeCell.m
//  xmh
//
//  Created by ald_ios on 2018/9/10.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "HomeCell.h"
#import "MineCellModel.h"

@interface HomeCell()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation HomeCell
{
    NSInteger _index;
    NSInteger _count;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _lbTitle.textColor = kLabelText_Commen_Color_3;
    _lbTitle.font = [UIFont systemFontOfSize:14];
}
- (void)updateHomeCellModel:(MineCellModel *)model index:(NSInteger)index count:(NSInteger)count
{
    _index = index ;
    _count = count;
    [self layoutIfNeeded];
    
    _icon.image =  UIImageName(model.iconStr);
    _lbTitle.text = model.title;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self layoutIfNeeded];
    if (_index == 0) {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.frame = self.bounds;
        maskLayer.path = maskPath.CGPath;
        self.layer.mask = maskLayer;
        self.layer.masksToBounds = YES;
    }else if (_index == _count - 1){
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.frame = self.bounds;
        maskLayer.path = maskPath.CGPath;
        self.layer.mask = maskLayer;
        self.layer.masksToBounds = YES;
    }else{
        
    }
}
@end
