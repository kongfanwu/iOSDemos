//
//  GKGLCardPopularHeaderView.m
//  xmh
//
//  Created by ald_ios on 2019/1/8.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLCardPopularHeaderView.h"
@interface GKGLCardPopularHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UIButton *btnMore;

@end
@implementation GKGLCardPopularHeaderView
{
    NSInteger _index;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)tapDwon:(UIButton *)sender
{
    if (_GKGLCardPopularHeaderViewTapBlock) {
        _GKGLCardPopularHeaderViewTapBlock(_index);
    }
}
- (void)updateGKGLCardPopularHeaderViewTitleIndex:(NSInteger)index
{
    _index = index;
    if (index == 0) {
        _lbName.text = @"卡类普及";
    }
    if (index == 1) {
        _lbName.text = @"项目普及";
    }
    if (index == 2) {
        _lbName.text = @"产品普及";
    }
}
- (void)updateGKGLCardPopularHeaderViewFromHealthInquiryTitle:(NSDictionary *)param
{
    _btnMore.hidden = YES;
    _lbName.textColor = kColor3;
    _lbName.font = FONT_NUM_SIZE(15);
    _lbName.text = param[@"category"];
}
@end
