//
//  MzzCompleteInfoTbHeaderView.m
//  xmh
//
//  Created by ald_ios on 2018/10/12.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "MzzCompleteInfoTbHeaderView.h"
@interface MzzCompleteInfoTbHeaderView ()
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@end
@implementation MzzCompleteInfoTbHeaderView
- (void)awakeFromNib
{
    [super awakeFromNib];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDown:)];
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDown:)];
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDown:)];
    [_leftView addGestureRecognizer:tap];
    [_middleView addGestureRecognizer:tap1];
    [_rightView addGestureRecognizer:tap2];
}
- (void)tapDown:(UITapGestureRecognizer *)tap
{
    if (_MzzCompleteInfoTbHeaderViewBlock) {
        _MzzCompleteInfoTbHeaderViewBlock(tap.view.tag);
    }
}
@end
