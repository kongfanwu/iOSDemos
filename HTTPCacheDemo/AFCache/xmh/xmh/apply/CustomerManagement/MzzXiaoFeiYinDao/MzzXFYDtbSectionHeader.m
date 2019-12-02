//
//  MzzXFYDtbSectionHeader.m
//  xmh
//
//  Created by ald_ios on 2018/10/13.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "MzzXFYDtbSectionHeader.h"
#import "XFYDtbSectionHeaderModel.h"
@interface MzzXFYDtbSectionHeader ()
@property (weak, nonatomic) IBOutlet UILabel *lbLeft;

@property (weak, nonatomic) IBOutlet UILabel *lbMiddle;
@property (weak, nonatomic) IBOutlet UILabel *lbRight;
@property (weak, nonatomic) IBOutlet UIView *containerView;


@end
@implementation MzzXFYDtbSectionHeader
- (void)awakeFromNib
{
    [super awakeFromNib];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_containerView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = _containerView.bounds;
    maskLayer.path = maskPath.CGPath;
    _containerView.layer.mask = maskLayer;
    _containerView.layer.masksToBounds = YES;
}
- (void)updateSectionHeaderModel:(XFYDtbSectionHeaderModel *)model
{
    _lbLeft.text = model.leftName;
    _lbMiddle.text = model.middleName;
    _lbRight.text = model.rightName;
}
@end
