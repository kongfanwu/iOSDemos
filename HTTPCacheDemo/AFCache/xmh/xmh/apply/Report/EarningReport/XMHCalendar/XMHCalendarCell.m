//
//  XMHCalendarCell.m
//  xmh
//
//  Created by shendengmeiye on 2019/7/2.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCalendarCell.h"
#import "FSCalendarExtensions.h"

@implementation XMHCalendarCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
   
        CAShapeLayer *selectionLayer = [[CAShapeLayer alloc] init];
        selectionLayer.fillColor = kColorE5E5E5.CGColor;
        selectionLayer.actions = @{@"hidden":[NSNull null]};
        [self.contentView.layer insertSublayer:selectionLayer below:self.titleLabel.layer];
        self.selectionLayer = selectionLayer;
        
        self.shapeLayer.hidden = YES;
    
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.selectionLayer.frame =  self.titleLabel.frame;
    self.selectionLayer.fillColor = kColorE5E5E5.CGColor;
    if (self.selectionType == SelectionTypeMiddle) {
        
        self.selectionLayer.path = [UIBezierPath bezierPathWithRect:CGRectMake(self.titleLabel.fs_left, self.shapeLayer.fs_top, self.titleLabel.fs_width, self.shapeLayer.fs_height)].CGPath;
        self.selectionLayer.fillColor = kColorE5E5E5.CGColor;
    } else if (self.selectionType == SelectionTypeLeftBorder) {
        
        self.selectionLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(self.shapeLayer.fs_left, self.shapeLayer.fs_top, self.titleLabel.fs_width - self.shapeLayer.fs_left, self.shapeLayer.fs_height) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft cornerRadii:CGSizeMake(self.selectionLayer.fs_width/2, self.selectionLayer.fs_width/2)].CGPath;
        self.selectionLayer.fillColor = kColorE5E5E5.CGColor;
    } else if (self.selectionType == SelectionTypeRightBorder) {
        
        self.selectionLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(self.titleLabel.fs_left, self.shapeLayer.fs_top, self.shapeLayer.fs_right, self.shapeLayer.fs_height) byRoundingCorners:UIRectCornerTopRight|UIRectCornerBottomRight cornerRadii:CGSizeMake(self.selectionLayer.fs_width/2, self.selectionLayer.fs_width/2)].CGPath;
        self.selectionLayer.fillColor = kColorE5E5E5.CGColor;
    } else if (self.selectionType == SelectionTypeSingle) {
        self.titleLabel.textColor = UIColor.blackColor;
        self.selectionLayer.path = [UIBezierPath bezierPathWithOvalInRect:self.shapeLayer.frame].CGPath;
        self.selectionLayer.fillColor = kColorE5E5E5.CGColor;
    }else if (self.selectionType == SelectionTypeToday){
        
        self.selectionLayer.path = [UIBezierPath bezierPathWithOvalInRect:self.shapeLayer.frame].CGPath;
        self.selectionLayer.fillColor =  [ColorTools colorWithHexString:@"#FF9072"].CGColor;
    
    }
    
}

- (void)setSelectionType:(SelectionType)selectionType
{
    self.eventIndicator.color = UIColor.whiteColor;
    _selectionType = selectionType;
    [self setNeedsLayout];

}
@end
