//
//  XMHSmartGuanJiaCell.m
//  xmh
//
//  Created by ald_ios on 2019/6/5.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHSmartGuanJiaCell.h"
#import "XMHSmartGuanJiaListModel.h"
@interface XMHSmartGuanJiaCell ()
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIView *bg;

@end
@implementation XMHSmartGuanJiaCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _bg.layer.cornerRadius = 5;
    _bg.layer.masksToBounds = YES;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _lbTitle.font = FONT_SIZE(16);
    _lbTitle.textColor = kColor3;
}
- (void)updateCellModel:(XMHSmartGuanJiaModel *)model
{
    _lbTitle.text = model.name;
}
@end
