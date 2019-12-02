//
//  XMHMarketSelectView.m
//  xmh
//
//  Created by ald_ios on 2019/5/21.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHMarketSelectView.h"
@interface XMHMarketSelectView ()
@property (weak, nonatomic) IBOutlet UILabel *lb;

@end
@implementation XMHMarketSelectView
- (void)awakeFromNib
{
    [super awakeFromNib];
    _lb.font = FONT_SIZE(15);
    _lb.textColor = kColor3;
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}
- (void)updateViewTitle:(NSString *)title
{
    _lb.text = title;
}
@end
