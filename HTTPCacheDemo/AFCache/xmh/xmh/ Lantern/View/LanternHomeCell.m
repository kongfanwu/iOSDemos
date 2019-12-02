//
//  LanternHomeCell.m
//  xmh
//
//  Created by ald_ios on 2019/1/3.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternHomeCell.h"
#import "MineCellModel.h"
@interface LanternHomeCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
@implementation LanternHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _bgView.layer.cornerRadius = 5;
    _bgView.layer.masksToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)updateLanternHomeCellModel:(MineCellModel *)model
{
    _icon.image = UIImageName(model.iconStr);
//    _icon.image = [UIImage imageNamed:@"aidengshen_zhinengzhuizong"];
    _lbName.text = model.title;
}
@end
