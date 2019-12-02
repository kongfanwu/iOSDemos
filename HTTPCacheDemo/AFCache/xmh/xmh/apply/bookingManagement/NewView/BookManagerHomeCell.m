//
//  BookManagerHomeCell.m
//  xmh
//
//  Created by ald_ios on 2019/3/4.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookManagerHomeCell.h"
#import "MineCellModel.h"
@interface BookManagerHomeCell ()
@property (weak, nonatomic) IBOutlet UIView *bg;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *lb;

@end
@implementation BookManagerHomeCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    _bg.layer.cornerRadius = 5;
    _bg.layer.masksToBounds = YES;
    _icon.layer.cornerRadius = _icon.width/2;
    _icon.layer.masksToBounds = YES;
    _lb.textColor = kColor3;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)updatecellModel:(MineCellModel *)model
{
    _icon.image = UIImageName(model.iconStr);
    _lb.text = model.title;
}
@end
