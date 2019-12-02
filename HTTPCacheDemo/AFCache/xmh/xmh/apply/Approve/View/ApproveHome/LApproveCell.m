//
//  LApproveCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/13.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LApproveCell.h"
#import "LApproveBtnView.h"
#import "LApproveModel.h"
@interface LApproveCell()
/** <##> */
@property (nonatomic, strong) UIView *bgView;
/** <##> */
@property (nonatomic, strong) CAShapeLayer *cornerRadiusLayer;
@end

@implementation LApproveCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColor.clearColor;
        self.contentView.backgroundColor = UIColor.clearColor;

        self.bgView = UIView.new;
        _bgView.backgroundColor = UIColor.whiteColor;
        [self.contentView addSubview:_bgView];
        
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _bgView.frame = self.contentView.bounds;
    
    if (IsEmpty(_cornerRadiusLayer)) {
        // 左上和右上为圆角
        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:_bgView.bounds byRoundingCorners:UIRectCornerBottomRight | UIRectCornerBottomLeft cornerRadii:CGSizeMake(5, 5)];
        
        CAShapeLayer *cornerRadiusLayer = [[CAShapeLayer alloc ] init];
        self.cornerRadiusLayer = cornerRadiusLayer;
        cornerRadiusLayer.frame = _bgView.bounds;
        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
        _bgView.layer.mask = cornerRadiusLayer;
    }
}

- (void)setArrs:(NSMutableArray *)arrs
{
    NSInteger count = arrs.count;
    CGFloat margin = (SCREEN_WIDTH -20 - 35 * 2 - 60 * 3)/2;
    for (int i = 0; i < count; i ++) {
        LApproveModel * model = arrs[i];
//        LApproveBtnView * view = [[LApproveBtnView alloc] initWithFrame:CGRectMake(35 + (60 + margin)* (i%3),(70 + 30)*(i/3) + 15, 60, 70) title:model.title imgName:model.imgName];
        LApproveBtnView * view = [[LApproveBtnView alloc] initWithFrame:CGRectMake(35 + (60 + margin)* (i%3),(70 + 30)*(i/3) + 15, 60, 70) title:model.title imgName:model.imgName];
        view.lbTitle.textColor = kColor3;
        view.btn1.tag = i;
        [view.btn1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:view];
    }
}
- (void)click:(UIButton *)btn
{
    if (_LApproveCellBlock) {
        _LApproveCellBlock(btn.tag);
    }
}
@end
