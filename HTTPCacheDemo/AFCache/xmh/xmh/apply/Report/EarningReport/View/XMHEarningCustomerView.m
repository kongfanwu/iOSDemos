//
//  XMHEarningCustomerView.m
//  xmh
//
//  Created by shendengmeiye on 2019/7/3.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHEarningCustomerView.h"
@interface XMHEarningCustomerView ()
@property (weak, nonatomic) IBOutlet UILabel *retainLab;
@property (weak, nonatomic) IBOutlet UILabel *retainNumLab;
@property (weak, nonatomic) IBOutlet UILabel *activeLab;
@property (weak, nonatomic) IBOutlet UILabel *activeNumLab;
@property (weak, nonatomic) IBOutlet UILabel *monthLab;
@property (weak, nonatomic) IBOutlet UILabel *monthNumLab;
@property (weak, nonatomic) IBOutlet UILabel *todayLab;
@property (weak, nonatomic) IBOutlet UILabel *todayNumLab;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLayoutConstraint;

@end

@implementation XMHEarningCustomerView
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor =  kColorF5F5F5;
    self.bgView.backgroundColor = UIColor.whiteColor;
    self.bgView.layer.cornerRadius = 5;
    CGFloat x = (SCREEN_WIDTH - 20) * 0.5 + 40;
    self.leftLayoutConstraint.constant = x;
}

@end
